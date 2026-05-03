Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class GestorGraduacion
    Dim url = BaseUrl.NotasExp.grad()
    Private ReadOnly _client As HttpClient
    Private ReadOnly _dni As String

    Public Sub New(client As HttpClient, dni As String)
        _client = client
        _dni = dni
    End Sub

    Public Async Function comprovarIProcessarAsync(nia As Integer) As Task
        Try
            'comprobar si se aprobó todo
            Dim data As New FormUrlEncodedContent(New Dictionary(Of String, String) From {
                                                  {"accio", "comprovar"}, {"nia", nia.ToString()}
                                                  })
            Dim res As HttpResponseMessage = Await _client.PostAsync(url, data)
            Dim obj As JObject = JObject.Parse(Await res.Content.ReadAsStringAsync())

            If Not obj.Value(Of Boolean)("ok") Then Return
            If Not obj.Value(Of Boolean)("graduat") Then Return

            Dim est As JObject = CType(obj("estudiant"), JObject)
            Dim nom As String = $"{est.Value(Of String)("nom")} {est.Value(Of String)("cognom")}"
            Dim nota As String = obj("nota_final")?.ToString()

            Dim msg As String =
                $"El alumno {nom} aprobó todas las asignaturas del ciclo." & Environment.NewLine &
                $"Nota media ponderada: {nota}" & Environment.NewLine &
                $"¿Desea generar el expediente académico y completar la graduación?" & Environment.NewLine &
                "(Si lo hace eliminará los datos de la BD y no podrá recuperarlas)"

            Dim confirm = MessageBox.Show(msg, "Graduación", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            If confirm <> DialogResult.Yes Then Return

            Dim sfd As New SaveFileDialog() With {
                .Title = "Guardar expediente académico",
                .Filter = "PDF (*.pdf)|*.pdf",
                .FileName = $"expediente_{est.Value(Of String)("cognom")}_{est.Value(Of String)("nom")}.pdf",
                .InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments)
            }

            If sfd.ShowDialog() <> DialogResult.OK Then Return

            'Dim html As String buildHtml(obj)
            'Dim pdfBytes As Byte() = Await ConstruirHtml.htmlToPdfAsync(html)



        Catch ex As Exception

        End Try
    End Function
End Class
