Imports System.Configuration
Imports System.Net
Imports System.Net.Http
Imports System.Runtime.InteropServices.JavaScript
Imports System.Security.Cryptography
Imports System.Security.Policy
Imports System.Text
Imports MySqlConnector
Imports Newtonsoft.Json.Linq

Public Class LogIn
    Private Const BASE_URL As String = "https://192.168.1.134/login.php"

    Private Shared ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()


    Private Sub LogIn_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        btnContinue.Enabled = False
        txtPass.PasswordChar = "*"c
    End Sub

    Private Sub updateBtn()
        btnContinue.Enabled = Not String.IsNullOrWhiteSpace(txtUser.Text) AndAlso
            Not String.IsNullOrWhiteSpace(txtPass.Text)
    End Sub

    Private Sub txtPass_TextChanged(sender As Object, e As EventArgs) Handles txtPass.TextChanged
        updateBtn()
    End Sub

    Private Async Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click
        btnContinue.Enabled = False

        Try
            Dim result As LoginResult = Await loginAsync(txtUser.Text, txtPass.Text)


            If result.rol = "alumne" Then
                MessageBox.Show("Los alumnos no pueden acceder a esta aplicación.",
                    "Acceso denegado", MessageBoxButtons.OK, MessageBoxIcon.Stop)
                txtUser.Clear()
                txtPass.Clear()
                btnContinue.Enabled = True
                Return
            End If
            If result.canEnter Then
                MessageBox.Show("inicio de sesión correcto")
                Dim finestraFilla As New FormPrincipal(result)
                finestraFilla.Show()
                Me.Hide()
            Else
                MessageBox.Show("usuario o contraseña incorrectos", "Acceso denegado", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                txtUser.Clear()
                txtPass.Clear()
            End If

        Catch ex As HttpRequestException
            MessageBox.Show("error de red: " & ex.Message)

        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message)

        Finally
            If Not Me.IsDisposed Then
                btnContinue.Enabled = True
            End If
        End Try
    End Sub

    ''POST
    Private Async Function loginAsync(user As String, pass As String) As Task(Of LoginResult)
        Dim data = New FormUrlEncodedContent(New Dictionary(Of String, String) From {
                                             {"username", user},
                                             {"password", pass}
                                             })

        Dim response As HttpResponseMessage = Await _client.PostAsync(BASE_URL, data)
        response.EnsureSuccessStatusCode()

        Dim jsonSt = Await response.Content.ReadAsStringAsync()
        Dim obj = JObject.Parse(jsonSt)

        Return New LoginResult With {
            .canEnter = obj.Value(Of Boolean)("pot_entrar"),
            .rol = obj.Value(Of String)("rol"),
            .dni = obj.Value(Of String)("dni"),
            .name = obj.Value(Of String)("nom"),
            .surname = obj.Value(Of String)("cognom"),
            .typeError = obj.Value(Of String)("tipus_error")
        }
    End Function

End Class

Public Class LoginResult
    Public Property canEnter As Boolean
    Public Property rol As String
    Public Property dni As String
    Public Property typeError As String
    Public Property name As String
    Public Property surname As String
End Class