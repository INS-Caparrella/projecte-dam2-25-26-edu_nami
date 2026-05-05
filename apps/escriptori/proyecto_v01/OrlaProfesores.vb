Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class OrlaProfesores
    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()

    Private Async Sub OrlaProfesores_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Await loadOrlaAsync()
    End Sub

    Private Async Function loadOrlaAsync() As Task
        Dim url = BaseUrl.OrlaProf.orla()
        Try
            Dim json As String = Await _client.GetStringAsync(url)
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show("error: " & obj.Value(Of String)("error"), "Error.",
                                MessageBoxButtons.OK, MessageBoxIcon.Error)
                Return
            End If

            flpOrla.Controls.Clear()

            For Each prof As JToken In obj("professors")
                Dim card As Panel = createCard(prof)
                flpOrla.Controls.Add(card)

                Dim pb As PictureBox = TryCast(card.Controls.Find("pbFoto", False).FirstOrDefault(), PictureBox)
                If pb IsNot Nothing Then
                    Dim ruta As String = prof("ruta_foto")?.ToString()
                    Await CargarFotos.loadAsync(_client, ruta, pb)
                End If
            Next

        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message)
        End Try
    End Function

    Private Function createCard(prof As JToken) As Panel
        Dim card As New Panel With {
            .Width = 200,
            .Height = 290,
            .BackColor = Color.White,
            .Margin = New Padding(10)
        }

        Dim pic As New PictureBox With {
            .Name = "pbFoto",
            .Width = 180,
            .Height = 180,
            .Top = 10,
            .Left = 10,
            .SizeMode = PictureBoxSizeMode.Zoom,
            .BackColor = Color.FromArgb(230, 235, 245)
        }

        Dim lblName As New Label With {
            .Text = $"{prof("nom")} {prof("cognom")}",
            .Top = 196,
            .Left = 10,
            .Width = 180,
            .Height = 20,
            .Font = New Font("Segoe UI", 9, FontStyle.Bold),
            .TextAlign = ContentAlignment.MiddleCenter
        }

        Dim lblJob As New Label With {
            .Text = prof("carrec")?.ToString(),
            .Top = 218,
            .Left = 10,
            .Width = 180,
            .Height = 20,
            .ForeColor = Color.DarkBlue,
            .TextAlign = ContentAlignment.MiddleCenter
        }

        Dim lblEmail As New Label With {
            .Text = prof("email")?.ToString(),
            .Top = 240,
            .Left = 10,
            .Width = 180,
            .Height = 20,
            .ForeColor = Color.DarkGray,
            .TextAlign = ContentAlignment.MiddleCenter
        }

        Dim lblDept As New Label With {
            .Text = prof("departament")?.ToString(),
            .Top = 262,
            .Left = 10,
            .Width = 180,
            .Height = 20,
            .ForeColor = Color.DarkGray,
            .TextAlign = ContentAlignment.MiddleCenter
        }

        card.Controls.Add(pic)
        card.Controls.Add(lblName)
        card.Controls.Add(lblJob)
        card.Controls.Add(lblEmail)
        card.Controls.Add(lblDept)

        Return card
    End Function
End Class