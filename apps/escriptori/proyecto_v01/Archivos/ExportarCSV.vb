Imports System.Net.Http
Imports System.IO
Imports System.Text
Imports Newtonsoft.Json.Linq

Public Class ExportadorCSV
    Public Shared Async Function ExportarAsync(nomGrup As String,
                                               client As HttpClient) As Task
        Dim url = BaseUrl.ExpAlumnos.expCsv()

        Try
            Dim json As String = Await client.GetStringAsync(
                $"{url}?nom_grup={Uri.EscapeDataString(nomGrup)}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show(obj.Value(Of String)("error"), "Error",
                                MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return
            End If

            Dim sfd As New SaveFileDialog() With {
                .Title = "Exportar clase a CSV",
                .Filter = "CSV (*.csv)|*.csv",
                .FileName = $"alumnos_{nomGrup}_{Date.Now:yyyyMMdd}.csv",
                .InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop)
            }
            If sfd.ShowDialog() <> DialogResult.OK Then Return

            Dim sb As New StringBuilder()
            sb.AppendLine("Nombre,Apellidos,DNI,Grupo,Ciclo")

            For Each alum As JToken In obj("alumnes")
                Dim nom As String = EscCsv(alum.Value(Of String)("nom"))
                Dim cognom As String = EscCsv(alum.Value(Of String)("cognom"))
                Dim dni As String = EscCsv(alum.Value(Of String)("dni"))
                Dim grup As String = EscCsv(alum.Value(Of String)("nom_grup"))
                Dim cicle As String = EscCsv(alum.Value(Of String)("nom_cicle"))
                sb.AppendLine($"{nom},{cognom},{dni},{grup},{cicle}")
            Next

            File.WriteAllText(sfd.FileName, sb.ToString(), New UTF8Encoding(True))

            Dim total As Integer = obj("alumnes").Count()
            MessageBox.Show(
                $"CSV exportado correctamente.{Environment.NewLine}" &
                $"{total} alumnos del grupo {nomGrup}.{Environment.NewLine}" &
                $"Archivo: {sfd.FileName}",
                "Exportación completada", MessageBoxButtons.OK, MessageBoxIcon.Information)

            Process.Start("explorer.exe", $"/select,""{sfd.FileName}""")

        Catch ex As Exception
            MessageBox.Show("Error en exportar: " & ex.Message,
                            "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try
    End Function

    Private Shared Function EscCsv(val As String) As String
        If String.IsNullOrEmpty(val) Then Return ""
        If val.Contains(",") OrElse val.Contains("""") OrElse val.Contains(vbLf) Then
            Return $"""{val.Replace("""", """""")}"""
        End If
        Return val
    End Function

End Class