Imports System.Configuration
Imports MySqlConnector

Public Class log_in
    Private Sub log_in_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        TestConnexio()
    End Sub

    Private Sub txtUser_TextChanged(sender As Object, e As EventArgs) Handles txtUser.TextChanged
        btnContinue.Enabled = Not String.IsNullOrEmpty(txtUser.Text) AndAlso Not String.IsNullOrEmpty(txtPass.Text)
    End Sub

    Private Sub txtPass_TextChanged(sender As Object, e As EventArgs) Handles txtPass.TextChanged
        txtPass.PasswordChar = "*"

        btnContinue.Enabled = Not String.IsNullOrEmpty(txtUser.Text) AndAlso Not String.IsNullOrEmpty(txtPass.Text)
    End Sub

    Private Sub btnContinue_Click(sender As Object, e As EventArgs) Handles btnContinue.Click

    End Sub
    Sub TestConnexio()
        Dim connString = ConfigurationManager.ConnectionStrings("MySQL").ConnectionString

        Try
            Using conn As New MySqlConnection(connString)
                conn.Open()
                MessageBox.Show("✅ Connexió exitosa!")

            End Using
        Catch ex As MySqlException
            MessageBox.Show($"❌ Error: {ex.Message}")

        End Try
    End Sub


End Class

Friend Class DatabaseConfig
    Public Shared Function GetConnection() As MySqlConnection
        Dim connString = ConfigurationManager.ConnectionStrings("MySQL").ConnectionString
        Return New MySqlConnection(connString)
    End Function
End Class