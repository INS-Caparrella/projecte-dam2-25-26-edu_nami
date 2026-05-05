Imports System.Net.Http
Imports Habanero.Base
Imports Org.BouncyCastle.Crypto.Paddings

Public Class FormPrincipal
    Private ReadOnly dni As String
    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()
    Private ReadOnly _rol As String
    Private ReadOnly _nomProf As String
    Private ReadOnly _rutaFoto As String

    Public Sub New(result As LoginResult)
        InitializeComponent()
        _nomProf = $"{result.name} {result.surname}"
        _rol = result.rol
        dni = result.dni
        _rutaFoto = If(result.rutaFoto, "")

        Me.dni = result.dni

        lblRol.Text = If(result.rolDirectiva <> "", result.rolDirectiva, result.rol)
        lblName.Text = _nomProf

        permisos(result)

        If Not String.IsNullOrEmpty(result.rutaFoto) Then
            CargarFotos.loadBackground(_client, _rutaFoto, pbPicture)
        End If
    End Sub

    Private Sub permisos(result As LoginResult)
        Dim esAdmin As Boolean = (_rol = "administrador" OrElse _rol = "director")
        Dim esCapEstudis As Boolean = result.rolDirectiva.ToLower().Contains("cap") AndAlso
                                      result.rolDirectiva.ToLower().Contains("estudis")
        Dim teAccesTotal As Boolean = esAdmin OrElse esCapEstudis

        btnCSV.Visible = teAccesTotal
        btnJSON.Visible = teAccesTotal
        btnXML.Visible = teAccesTotal
        btnOpenT.Visible = teAccesTotal

        btnGrades.Visible = True
        btnFicha.Visible = True
        btnOrlas.Visible = True
    End Sub

    Private Sub LoadOpenNotes(uc As UserControl)
        pnlPrincipal.Controls.Clear()
        pnlPrincipal.Controls.Add(uc)
        uc.Dock = DockStyle.Fill
    End Sub
    Private Sub btnOpenT_Click(sender As Object, e As EventArgs) Handles btnOpenT.Click
        LoadOpenNotes(New AbrirEvaluacion(dni))
    End Sub

    Public Sub GoHome()
        pnlPrincipal.Controls.Clear()
    End Sub
    Private Sub btnGrades_Click(sender As Object, e As EventArgs) Handles btnGrades.Click
        Dim esAdmin As Boolean = (_rol = "administrador" OrElse _rol = "director")

        Dim sel As New SeleccionarAsignatura(dni, esAdmin)

        If sel.ShowDialog = DialogResult.OK Then
            Dim f As New FormNotas(Me, dni, sel.asignaturaId, sel.asignaturaNom, _nomProf, lblRol.Text, sel.grup, _rutaFoto)
            f.Show()
        End If
    End Sub

    Private Sub btnOrlas_Click(sender As Object, e As EventArgs) Handles btnOrlas.Click
        Dim f As New OrlaProfesores()
        f.Show()
    End Sub

    Private Sub btnFicha_Click(sender As Object, e As EventArgs) Handles btnFicha.Click
        Dim ficha As New FormFicha(dni, _client)
        ficha.Show()
    End Sub

    Private Async Sub btnCSV_Click(sender As Object, e As EventArgs) Handles btnCSV.Click
        Dim grup As String = InputBox("Introduzca el nombre del grupo (ex: SMX2A):", "Exportar CSV")
        If String.IsNullOrWhiteSpace(grup) Then Return
        Await ExportadorCSV.ExportarAsync(grup.Trim().ToUpper(), _client)
    End Sub

    Private Async Sub btnJSON_Click(sender As Object, e As EventArgs) Handles btnJSON.Click
        Await ExportarJSON.exportarProfessorsAsync(dni, _client)
    End Sub

    Private Async Sub btnXML_Click(sender As Object, e As EventArgs) Handles btnXML.Click
        Await ExportarXML.ExportLogsAsync(dni, _client)
    End Sub

End Class