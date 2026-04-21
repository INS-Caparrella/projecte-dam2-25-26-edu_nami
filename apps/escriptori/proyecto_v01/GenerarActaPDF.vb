Imports System.IO
Imports System.Net.Http
Imports Newtonsoft.Json.Linq
Imports PuppeteerSharp
Imports PuppeteerSharp.Media

Public Class GenerarActaPDF
    Private ReadOnly _dni As String
    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()
    Private Const DADES_URL = "https://192.168.1.134/dades_acta.php"

    Public Sub New(dni As String)
        _dni = dni
    End Sub

    Public Async Function generarAsync(idActa As Integer, Optional rutaDest As String = "") As Task(Of String)
        Dim json As String = Await _client.GetStringAsync($"{DADES_URL}?id_acta={idActa}&dni={_dni}")
        Dim obj As JObject = JObject.Parse(json)

        If Not obj.Value(Of Boolean)("ok") Then
            Throw New Exception("Error: " & obj.Value(Of String)("error"))
        End If

        'construir html
        Dim html As String = BuildHtml(obj)

        'generar pdf
        Dim pdfBytes As Byte() = Await htmlToPdfAsync(html)

        'guardar
        If String.IsNullOrEmpty(rutaDest) Then
            rutaDest = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop),
                                    $"Acta_{obj("acta").Value(Of String)("nom_grup")}_T{obj("acta").Value(Of String)("trimestre")}.pdf")
        End If

        File.WriteAllBytes(rutaDest, pdfBytes)
        Return rutaDest
    End Function

    'convertir html a pdf
    Private Shared Async Function htmlToPdfAsync(html As String) As Task(Of Byte())
        Dim browserFetch As New BrowserFetcher()
        Await browserFetch.DownloadAsync()

        Using browser As IBrowser = Await Puppeteer.LaunchAsync(
        New LaunchOptions With {
        .Headless = True,
        .Args = {"--no-sandbox", "--disable-setuid-sandbox"}
        })

            Using page As IPage = Await browser.NewPageAsync()
                Await page.SetContentAsync(html, New NavigationOptions With {
                                           .WaitUntil = {WaitUntilNavigation.Networkidle0}
                                           })

                Dim pdfOptions As New PdfOptions With {
                    .Format = PaperFormat.A4,
                    .PrintBackground = True,
                    .MarginOptions = New MarginOptions With {
                    .Top = "15mm",
                    .Bottom = "15mm",
                    .Left = "15mm",
                    .Right = "15mm"
                }}

                Return Await page.PdfDataAsync(pdfOptions)
            End Using
        End Using
    End Function

    'contruir html de acta
    Private Shared Function buildHtml(obj As JObject) As String
        Dim acta As JObject = CType(obj("acta"), JObject)
        Dim ras As JArray = CType(obj("ras"), JArray)
        Dim alumnes As JArray = CType("alumnes", JArray)
        Dim profs As JArray = CType("professors", JArray)
        Dim corr As JArray = CType("correccions", JArray)

        Dim grup As String = acta.Value(Of String)("nom_grup")
        Dim trimestre As String = acta.Value(Of String)("trimestre")
        Dim curs As String = acta.Value(Of String)("curs")
        Dim assignatura As String = acta.Value(Of String)("nom_assignatura")
        Dim departament As String = acta.Value(Of String)("departament")
        Dim aula As String = acta.Value(Of String)("aula")
        Dim dataTanc As String = acta.Value(Of String)("data_tancament")
        Dim corregida As Boolean = acta.Value(Of Boolean)("corregida")

        Dim sb As New System.Text.StringBuilder()

        Dim raHeaders As New System.Text.StringBuilder()
        For Each ra As JToken In ras
            raHeaders.Append($"<th>RA{ra.Value(Of String)("ra")}</th>")
        Next

        'filas de alumnos
        Dim alumnRows As New System.Text.StringBuilder()
        Dim i As Integer = 1
        For Each alumn As JToken In alumnes
            Dim nom As String = $"{alumn.Value(Of String)("cognom")}, {alumn.Value(Of String)("nom")}"
            Dim notaFinal As String = alumn("nota_final")?.ToString()
            Dim aprovat As Boolean = False
            Dim notaVal As Double
            If Double.TryParse(notaFinal, notaVal) Then aprovat = notaVal >= 5

            Dim statusClass As String = If(aprovat, "Aprobado", "Suspenso")
            Dim statusText As String = If(aprovat, "AP", "NA")

            'celda para cda RA
            Dim raCells As New System.Text.StringBuilder()
            For Each ra As JToken In ras
                Dim key As String = $"ra_{ra.Value(Of Integer)("id")}"
                Dim nota As String = alumn(key)?.ToString()
            Next

            alumnRows.Append($"
                <tr>
                    <td class='num'>{i}</td>
                    <td class='alumne'>{escHtml(nom)}</td>
                    {raCells}
                    <td class='nota-final'>{notaFinal}</td>
                    <td class='estat {statusClass}'> {statusText}</td>
                </tr>")
            i += 1
        Next

        'filas de profesores
        Dim profRows As New System.Text.StringBuilder()
        For Each prof As JToken In profs
            Dim nomProf As String = $"{prof.Value(Of String)("cognom")}, {prof.Value(Of String)("nom")}"
            Dim dedicacio As String = prof.Value(Of String)("dedicacio")
            Dim rolDir As String = prof.Value(Of String)("rol_directiva")
            Dim rol As String = If(rolDir <> "", rolDir, dedicacio)

            profRows.Append($"
                <tr>
                    <td>{escHtml(nomProf)}</td>
                    <td>{escHtml(rol)}</td>
                    <td class='signatura-cel'></td>
                </tr>")
        Next

        'correcciones 
        Dim corrSection As String = ""
        If corr.Count > 0 Then
            Dim corrRows As New System.Text.StringBuilder()
            For Each c As JToken In corr
                corrRows.Append($"
                    <tr>
                        <td>{escHtml(c.Value(Of String)("data_mod"))}</td>
                        <td>{escHtml(c.Value(Of String)("modificat_per"))}</td>
                        <td>{c.Value(Of String)("valor_anterior")}</td>
                        <td>{c.Value(Of String)("valor_nou")}</td>
                        <td>{escHtml(c.Value(Of String)("motio"))}</td>
                    </tr>")
            Next

            corrSection = $"
            <div class='seccio'>
                <h3>Correcciones posteriores al cierre de evaluación</h3>
                <table class='taula-correccions'>
                    <thead>
                        <tr>
                            <th>Fecha</th>
                            <th>Autorizado por</th>
                            <th>Nota anterior</th>
                            <th>Nueva nota</th>
                            <th>Motivo</th>
                        </tr>
                    </thead>
                    <tbody>{corrRows}</tbody>
                 </table>
                </div>"
        End If

        'html

    End Function

    Private Shared Function escHtml(s As String) As String
        If String.IsNullOrEmpty(s) Then Return ""
        Return s.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace("""", "&quot;")
    End Function
End Class
