Imports System.Net.Http
Imports System.IO
Imports System.Text
Imports Newtonsoft.Json.Linq

Public Class ExportadorCSV


    ' ── Punt d'entrada ───────────────────────────────────────
    Public Shared Async Function ExportarAsync(nomGrup As String,
                                               client As HttpClient) As Task
        Dim url = BaseUrl.ExpAlumnos.expCsv()

        Try
            ' 1. Obtenim les dades del servidor
            Dim json As String = Await client.GetStringAsync(
                $"{url}?nom_grup={Uri.EscapeDataString(nomGrup)}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show(obj.Value(Of String)("error"), "Error",
                                MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return
            End If

            ' 2. Triar on desar
            Dim sfd As New SaveFileDialog() With {
                .Title = "Exportar classe a CSV",
                .Filter = "CSV (*.csv)|*.csv",
                .FileName = $"Alumnes_{nomGrup}_{Date.Now:yyyyMMdd}.csv",
                .InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop)
            }
            If sfd.ShowDialog() <> DialogResult.OK Then Return

            ' 3. Construïm el CSV
            Dim sb As New StringBuilder()
            ' Capçalera amb BOM per a Excel (codificació correcta de caràcters)
            sb.AppendLine("Nom,Cognoms,DNI,Grup,Cicle")

            For Each alum As JToken In obj("alumnes")
                Dim nom As String = EscCsv(alum.Value(Of String)("nom"))
                Dim cognom As String = EscCsv(alum.Value(Of String)("cognom"))
                Dim dni As String = EscCsv(alum.Value(Of String)("dni"))
                Dim grup As String = EscCsv(alum.Value(Of String)("nom_grup"))
                Dim cicle As String = EscCsv(alum.Value(Of String)("nom_cicle"))
                sb.AppendLine($"{nom},{cognom},{dni},{grup},{cicle}")
            Next

            ' 4. Desar amb BOM UTF-8 per a compatibilitat amb Excel
            File.WriteAllText(sfd.FileName, sb.ToString(), New UTF8Encoding(True))

            Dim total As Integer = obj("alumnes").Count()
            MessageBox.Show(
                $"CSV exportat correctament.{Environment.NewLine}" &
                $"{total} alumnes del grup {nomGrup}.{Environment.NewLine}" &
                $"Fitxer: {sfd.FileName}",
                "Exportació completada", MessageBoxButtons.OK, MessageBoxIcon.Information)

            ' Obrir la carpeta
            Process.Start("explorer.exe", $"/select,""{sfd.FileName}""")

        Catch ex As Exception
            MessageBox.Show("Error en exportar: " & ex.Message,
                            "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try
    End Function

    ' ── Escapa un valor per a CSV ─────────────────────────────
    Private Shared Function EscCsv(val As String) As String
        If String.IsNullOrEmpty(val) Then Return ""
        ' Si conté comes, cometes o salts de línia, embolcalla amb cometes
        If val.Contains(",") OrElse val.Contains("""") OrElse val.Contains(vbLf) Then
            Return $"""{val.Replace("""", """""")}"""
        End If
        Return val
    End Function

End Class