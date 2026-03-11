Imports System.Configuration
Imports System.Net
Imports System.Net.Http
Imports System.Runtime.InteropServices.JavaScript
Imports System.Security.Cryptography
Imports System.Security.Policy
Imports System.Text
Imports MySqlConnector
Imports Newtonsoft.Json.Linq

Public Class Form1

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
    End Sub

    Private Sub txtPass_TextChanged(sender As Object, e As EventArgs) Handles txtPass.TextChanged
        txtPass.PasswordChar = "*"

        btnContinue.Enabled = Not String.IsNullOrEmpty(txtUser.Text) AndAlso Not String.IsNullOrEmpty(txtPass.Text)

    End Sub

    Private Sub txtUser_TextChanged(sender As Object, e As EventArgs) Handles txtUser.TextChanged
        btnContinue.Enabled = Not String.IsNullOrEmpty(txtUser.Text) AndAlso Not String.IsNullOrEmpty(txtPass.Text)

    End Sub
    Private Async Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click
        Dim user As String = txtUser.Text
        Dim pass As String = txtPass.Text

        Try
            Dim correct As Boolean = Await loginAsync(user, pass)
            If correct Then
                MessageBox.Show("inicio de sesión correcto")
            Else
                MessageBox.Show("usuario o contraseña incorrectos")
            End If
        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message)
        End Try


    End Sub

    ''POST
    Private Async Function loginAsync(user As String, pass As String) As Task(Of Boolean)
        Dim baseUrl As String = "https://192.168.18.157/login.php"

        Dim client As HttpClient = UnsafeSSL.createUnsafeClient()

        Dim data = New FormUrlEncodedContent(New Dictionary(Of String, String) From {
                                             {"username", user},
                                             {"password", pass}
                                             })

        Dim response = Await client.PostAsync(baseUrl, data)
        Dim jsonSt = Await response.Content.ReadAsStringAsync()

        Dim obj = JObject.Parse(jsonSt)
        Dim potEntrar As Boolean = obj.Value(Of Boolean)("pot_entrar")

        Return potEntrar
    End Function

    ''GET
    Public Async Function loginGetAsync(user As String, pass As String) As Task(Of Boolean)
        Dim u = Uri.EscapeDataString(user)
        Dim p = Uri.EscapeDataString(pass)

        Dim url = $"https://192.168.18.157/login.php?username={u}&password={p}"

        Dim client As HttpClient = UnsafeSSL.createUnsafeClient()

        Dim jsonSt = Await client.GetStringAsync(url)
        Dim obj = JObject.Parse(jsonSt)

        Return obj.Value(Of Boolean)("pot_entrar")
    End Function
End Class