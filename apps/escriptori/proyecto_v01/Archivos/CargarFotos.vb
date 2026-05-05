
Imports System.IO
Imports System.Net.Http

Public Class CargarFotos
    Private Const BASE_URL As String = BaseUrl.BASE_URL & "/"

    Public Shared Async Function loadAsync(client As HttpClient, ruta As String, pb As PictureBox) As Task
        Try
            pb.Image = Nothing

            If String.IsNullOrEmpty(ruta) OrElse ruta = "-" Then Return

            Dim url As String = BASE_URL & ruta.Replace("\", "/").TrimStart("/"c)

            Dim bytes As Byte() = Await client.GetByteArrayAsync(url)
            Using ms As New MemoryStream(bytes)
                pb.Image = Image.FromStream(ms)
                pb.SizeMode = PictureBoxSizeMode.Zoom
            End Using

        Catch ex As Exception
            pb.Image = Nothing
        End Try
    End Function

    Public Shared Sub loadBackground(client As HttpClient, ruta As String, pb As PictureBox)
        Task.Run(Async Function()
                     Await loadAsync(client, ruta, pb)
                 End Function)
    End Sub
End Class
