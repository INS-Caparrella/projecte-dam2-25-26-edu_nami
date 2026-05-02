Imports System.Net.Http
Imports Newtonsoft.Json.Linq

''cuando haga click va a la ficha del profesor? alumnos pueden entrar o no?
Public Class OrlaProfesores
    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()

    Dim url = BaseUrl.orlaProf.orla()

    Private Async Sub OrlaProfesores_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Await loadOrlaAsync()
    End Sub

    Private Async Function loadOrlaAsync() As Task
        Try
            Dim json As String = Await _client.GetStringAsync(url)
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show("error: " & obj.Value(Of String)("error"), "Error.", MessageBoxButtons.OK, MessageBoxIcon.Error)
                Return
            End If

            flpOrla.Controls.Clear()

            For Each prof As JToken In obj("professors")
                flpOrla.Controls.Add(createCard(prof))
            Next
        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message)
        End Try
    End Function

    Private Function createCard(prof As JToken) As Control
        Dim card As New Panel With {
        .Width = 200,
        .Height = 280,
        .BackColor = Color.White,
        .Margin = New Padding(10),
        .Top = 60
        }

        Dim pic As New PictureBox With {
            .Width = 180,
            .Height = 180,
            .Top = 10,
            .Left = 10,
            .SizeMode = PictureBoxSizeMode.Zoom,
            .ImageLocation = ""
        }

        Dim lblName As New Label With {
            .Text = prof("nom").ToString() & " " & prof("cognom").ToString(),
            .Top = 195,
            .Left = 10,
            .Width = 180,
            .Height = 20,
            .TextAlign = ContentAlignment.MiddleCenter
        }

        Dim lblJob As New Label With {
            .Text = prof("carrec").ToString(),
            .Top = 220,
            .Left = 10,
            .Width = 180,
            .Height = 20,
            .ForeColor = Color.DarkBlue,
            .TextAlign = ContentAlignment.MiddleCenter
        }

        Dim lblEmail As New Label With {
            .Text = prof("email").ToString(),
            .Top = 240,
            .Left = 10,
            .Width = 180,
            .Height = 20,
            .ForeColor = Color.DarkGray,
            .TextAlign = ContentAlignment.MiddleCenter
        }


        Dim lblDept As New Label With {
            .Text = prof("departament").ToString(),
            .Top = 260,
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

    Private Sub lblGoBack_Click(sender As Object, e As EventArgs) Handles lblGoBack.Click

    End Sub
End Class