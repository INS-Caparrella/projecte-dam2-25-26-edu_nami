Imports System.IO
Imports System.Net.Http
Imports System.Text
Imports Newtonsoft.Json.Linq

Public Class ExportarJSON
    Public Shared Async Function exportarProfessorsAsync(dniConsultor As String, client As HttpClient) As Task
        Dim url = BaseUrl.FichaProfesores.listaProf()

        Try
            Dim json As String = Await client.GetStringAsync($"{url}?dni_consultor={dniConsultor}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show(obj.Value(Of String)("error"))
            End If

            Dim professors As JArray = CType(obj("professors"), JArray)

            If professors.Count = 0 Then
                MessageBox.Show("No hay profesores para exportar.", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Return
            End If

            Dim exportObj As New JObject From {
                {"exportado_el", Date.Now.ToString("yyyy-MM-dd HH:mm:ss")},
                {"total", professors.Count},
                {"profesores", professors}
            }

            Dim jsonFormatat As String = exportObj.ToString(Newtonsoft.Json.Formatting.Indented)

            Dim sfd As New SaveFileDialog() With {
                .Title = "Exportar profesores a JSON",
                .Filter = "JSON (*.json)|*.json",
                .FileName = $"profesores_{Date.Now:yyyyMMdd_HHmm}.json",
                .InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop)
            }

            If sfd.ShowDialog() <> DialogResult.OK Then Return

            File.WriteAllText(sfd.FileName, jsonFormatat, New UTF8Encoding(False))

            MessageBox.Show($"JSON exportado correctamente. {Environment.NewLine}" & $"{professors.Count} profesores exportados. {Environment.NewLine}" & $"Archivo: {sfd.FileName}",
                            "Exportación completada", MessageBoxButtons.OK, MessageBoxIcon.Information)

            Process.Start("explorer.exe", $"/select""{sfd.FileName}""")

        Catch ex As Exception
            MessageBox.Show("ERROR: " & ex.Message)
        End Try
    End Function
End Class
