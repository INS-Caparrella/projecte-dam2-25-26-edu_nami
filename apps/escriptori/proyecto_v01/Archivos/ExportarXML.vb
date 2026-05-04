Imports System.Net.Http
Imports System.Xml
Imports Newtonsoft.Json.Linq

Public Class ExportarXML
    Public Shared Async Function ExportLogsAsync(dniConsultor As String, client As HttpClient) As Task
        Dim url = BaseUrl.ExpXML.exp()

        Try
            Dim json As String = Await client.GetStringAsync($"{url}?dni_consultor={dniConsultor}&limit=500")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show(obj.Value(Of String)("error"))
                Return
            End If

            Dim logs As JArray = CType(obj("logs"), JArray)

            If logs.Count = 0 Then
                MessageBox.Show("No hay registros de login para exportar.", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Return
            End If

            Dim sfd As New SaveFileDialog() With {
            .Title = "Exportar registro de logins a XML",
            .Filter = "XML (*.xml)|*.xml",
            .FileName = $"logs_login_{Date.Now:yyyyMMdd_HHmm}.xml",
            .InitialDirectory = Environment.GetFolderPath(Environment.SpecialFolder.Desktop)
            }

            If sfd.ShowDialog() <> DialogResult.OK Then Return

            Dim settings As New XmlWriterSettings() With {
                .Indent = True,
                .IndentChars = " ",
                .Encoding = New System.Text.UTF8Encoding(False),
                .NewLineOnAttributes = False
                }

            Using writer As XmlWriter = XmlWriter.Create(sfd.FileName, settings)
                writer.WriteStartDocument()

                'arrel
                writer.WriteStartElement("registro_logins")
                writer.WriteAttributeString("exportado_el", Date.Now.ToString("yyyy-MM-dd HH:mm:ss"))

                writer.WriteAttributeString("total", logs.Count().ToString())
                writer.WriteAttributeString("exportado_por", dniConsultor)

                For Each log As JToken In logs
                    writer.WriteStartElement("login")

                    writer.WriteAttributeString("id", log.Value(Of String)("id"))

                    writer.WriteElementString("dni_usuari", Val(log, "dni_user"))
                    writer.WriteElementString("nombre_usuario", Val(log, "nom_usuari"))
                    writer.WriteElementString("username", Val(log, "username"))
                    writer.WriteElementString("ip", Val(log, "ip_llegible"))
                    writer.WriteElementString("data", Val(log, "data"))
                    writer.WriteElementString("exit", If(log.Value(Of Integer)("exito") = 1, "Sí", "No"))

                    writer.WriteEndElement() 'login
                Next

                writer.WriteEndElement() 'registre_logins
                writer.WriteEndDocument()

            End Using

            MessageBox.Show($"XML exportado correctamente.{Environment.NewLine}" & $"{logs.Count()} registros exportados.{Environment.NewLine}" & $"Archivo: {sfd.FileName}",
            "Exportación completada", MessageBoxButtons.OK, MessageBoxIcon.Information)

            Process.Start("explorer.exe", $"/select,""{sfd.FileName}""")

        Catch ex As Exception
            MessageBox.Show("ERROR: " & ex.Message)
        End Try
    End Function

    Private Shared Function Val(token As JToken, key As String) As String
        Dim v As JToken = token(key)
        Return If(v Is Nothing OrElse v.Type = JTokenType.Null, "", v.ToString())
    End Function
End Class
