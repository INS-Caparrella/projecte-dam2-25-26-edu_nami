Imports System.IO
Imports System.Net.Http
Imports Newtonsoft.Json.Linq
Imports PuppeteerSharp
Imports PuppeteerSharp.Media

Public Class GenerarActaPDF
    Private ReadOnly _dni As String
    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()
    Dim url = BaseUrl.GenActa.dadesActa()

    Public Sub New(dni As String)
        _dni = dni
    End Sub

    Public Async Function generarAsync(idActa As Integer, Optional rutaDest As String = "") As Task(Of String)
        Dim json As String = Await _client.GetStringAsync($"{url}?id_acta={idActa}&dni={_dni}")
        Dim obj As JObject = JObject.Parse(json)

        Dim numAlumnes As Integer = obj("alumnes").Count()

        If Not obj.Value(Of Boolean)("ok") Then
            Throw New Exception("Error: " & obj.Value(Of String)("error"))
        End If

        'construir html
        Dim html As String = buildHtml(obj)

        'generar pdf
        Dim pdfBytes As Byte() = Await ConstruirHtml.htmlToPdfAsync(html)

        'guardar
        If String.IsNullOrEmpty(rutaDest) Then
            rutaDest = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Desktop),
                                    $"Acta_{obj("acta").Value(Of String)("nom_grup")}_T{obj("acta").Value(Of String)("trimestre")}.pdf")
        End If

        File.WriteAllBytes(rutaDest, pdfBytes)
        Return rutaDest
    End Function

    'contruir html de acta
    Private Shared Function buildHtml(obj As JObject) As String
        Dim acta As JObject = CType(obj("acta"), JObject)
        Dim ras As JArray = CType(obj("ras"), JArray)

        Dim alumnesToken = obj("alumnes")
        Dim profsToken = obj("professors")
        Dim corrToken = obj("correccions")

        Dim alumnes As JArray = If(TypeOf alumnesToken Is JArray, CType(alumnesToken, JArray), New JArray())
        Dim profs As JArray = If(TypeOf profsToken Is JArray, CType(profsToken, JArray), New JArray())
        Dim corr As JArray = If(TypeOf corrToken Is JArray, CType(corrToken, JArray), New JArray())


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
            Dim notaFinal As String = If(alumn("nota_final") IsNot Nothing AndAlso alumn("nota_final").Type <> JTokenType.Null,
                alumn("nota_final").ToString(), "-")
            Dim aprovat As Boolean = False
            Dim notaVal As Double
            If Double.TryParse(notaFinal, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, notaVal) Then
                aprovat = notaVal >= 5
            End If

            Dim statusClass As String = If(aprovat, "Aprobado", "Suspenso")
            Dim statusText As String = If(aprovat, "AP", "NA")

            'celda para cda RA
            Dim raCells As New System.Text.StringBuilder()
            For Each ra As JToken In ras
                Dim key As String = $"ra_{ra.Value(Of Integer)("id")}"
                Dim nota As String = alumn(key)?.ToString()

                raCells.Append($"<td>{escHtml(nota)}</td>")
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

        'html completo
        sb.Append($"<!DOCTYPE html>
        <html lang='ca'>
        <head>
        <meta charset='UTF-8'>
        <style>
            * {{ box-sizing:border-box; margin: 0; padding: 0; }}
            body {{ font-family: Arial, sans-serif; font-size: 9pt; color: #000; }}

            .capcalera {{ text-align: center; margin-bottom: 10px; border-bottom: 2px solid #000;
            padding-bottom: 8px; }}
            .capcalera h1 {{ font-size: 13pt; font-weight: bold; }}
            .capcalera h2 {{ font-size: 10pt; font-weight: normal; }}

            .info-grid {{ display: grid; grid-template-columns: 1fr 1fr 1fr; gaf: 4px; margin-bottom: 10 px;
                        border: 1px solid #000; padding: 6px; }}
            .info-grid .camp {{ display: flex; flex-direction: column; }}
            .info-grid .camp label {{ font-weight: bold; font-size: 7.5pt; color: #444; }}
            .info-grid .camp span {{ border-bottom: 1px solid #888; min-height: 14px; padding: 1px 2px; font-size: 9pt; }}
            
            .seccio {{ margin-bottom: 14px; }}
            .seccio h3 {{ font-size: 9pt; background: #e8e8e8; padding: 3px 6px;
                            border-left: 3px solid #333; margin-bottom: 4px }}
            
            table {{ width: 100%; bordeer-collapse: collapse; font-size: 8.5pt; }}
            th {{ background: #333; color: #fff; padding: 4px 3px; text-align: center; border: 1px solid #555; }}
            td {{ padding: 3px; border: 1px solid #bbb; text-align: center; }}
            td.alumne {{ text-align: left; padding-left: 5px; }}
            td.num {{ width: 22px; }}
            td.nota-final {{ font-weight: bold; }}
            td.aprovat {{ color: #155724; font-weight: bold; }}
            td.suspens {{ color: #721c24; font-weight: bold; }}
            tr:nth-child(even) td {{ background: #f9f9f9; }}

            .signatura-grid {{ display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 14px; }}
            .signatura-box {{ border: 1px solid #bbb; padding: 8px 10px; min-height: 70px }}
            .signatura-box .titol {{ font-weight: bold; font-size: 8pt; margin-bottom: 4px; border-bottom: 1px solid #ddd; }}
            .signatura-box .nom {{ font-size: 8pt; color: #333; margin-bottom: 20px; }}
            .signatura-box .linia {{ border-bottom: 1px solid #888; margin-top: 28px; }}
            
            .taula-professors td.signatura-cel {{ min-width: 100px; min-height: 40px; }}

            .taula-correccions th {{ background: #7b1c1c; }}
            .taula-correccions td {{ font-size: 8pt; }}

            .peu {{ margin-top: 10px; font-size: 7.5pt; color: #555; text-align: center; border-top: 1px solid #ccc; padding-top: 4px; }}
            
            .badge-corregida {{ display: inline-block; background: #fff3cd; border: 1px solid #ffc107;
                                color: #856404; padding: 2px 8px; font-size: 8pt; border-radius: 3px; }}
        </style>
    </head>
<body>

    <div class='capcalera'>
        <h1>ACTA DE EVALUACIÓN</h1>
        <h2>Formación Profesional  ·  {escHtml(curs)}</h2>
        {If(corregida, "<span class='badge-corregida'> Acta corregida posteriormente</span>", "")}
    </div>
    
    <div class='info-grid'>
        <div class='camp'><label>Grupo</label><span>{escHtml(grup)}</span></div>
        <div class='camp'><label>Asignatura</label><span>{escHtml(assignatura)}</span></div>
        <div class='camp'><label>Trimestre</label><span>{escHtml(trimestre)}</span></div>
        <div class='camp'><label>Departamento</label><span>{escHtml(departament)}</span></div>
        <div class='camp'><label>Aula</label><span>{escHtml(aula)}</span></div>
        <div class='camp'><label>Fecha de cierre</label><span>{escHtml(dataTanc)}</span></div>
    </div>
    
    <div class='seccio'>
        <h3>Alumnos y notas</h3>
        <table>
            <thead>
                <tr>
                    <th>Nº</th>
                    <th style='text-align: left; padding-left: 5px;'>Apellido, Nombre</th>
                    {raHeaders}
                    <th>Nota final</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                {alumnRows}
            </tbody>
        </table>
        <p style='font-size: 7.5pt; margin-top: 4px; color: #555;'>
                AP = Aprobado (≥5) &nbsp; ·&nbsp; NA = No aprobado (&lt;5)
        </p>
    </div>

    {corrSection}

    <div class='seccio'>
        <h3>Profesores de la asignatura</h3>
        <table class='taula-professors'>
            <thead>
                <tr>
                    <th style='text-align: left; padding-left: 5px;'>Apellido, Nombre</th>
                    <th>Rol / Dedicación</th>
                    <th>Firma</th>
                </tr>
            </thead>
            <tbody>
            {profRows}
            </tbody>
        </table>
    </div>

    <div class='seccio'>
        <h3>Firmas de la dirección</h3>
            <div class='signatura-grid'>
                <div class='signatura-box'>
                    <div class='titol'>Jefe de estudios</div>
                    <div class='nom'>&nbsp;</div>
                    <div class='linia'></div>
                    <div class='font-size: 7pt; color: #777; margin-top: 2px;'> Firma y sello</div>
                </div>
            </div>
        </div>

    <div class='peu'>
            Documento generado el {Date.Now.ToString("dd/MM/yyyy HH:mm")}  · Sistema EVALIS  ·
    </div>
</body>
</html>
    ")

        Return sb.ToString()
    End Function

    Private Shared Function escHtml(s As String) As String
        If String.IsNullOrEmpty(s) Then Return ""
        Return s.Replace("&", "&amp;").Replace("<", "&lt;").Replace(">", "&gt;").Replace("""", "&quot;")
    End Function
End Class
