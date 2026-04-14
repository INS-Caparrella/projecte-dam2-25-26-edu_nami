Imports Habanero.Base
Imports Org.BouncyCastle.Crypto.Paddings

Public Class FormPrincipal
    Private ReadOnly dni As String
    Private ReadOnly _nomProf As String
    Public Sub New(result As LoginResult)
        InitializeComponent()
        _nomProf = $"{result.name} {result.surname}"
        lblRol.Text = $"{result.rol}"
        lblName.Text = _nomProf

        Me.dni = result.dni
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
        ''enviar nombre de asignatura a la que quiere añadir notas
        Dim sel As New SeleccionarAsignatura(dni)

        If sel.ShowDialog = DialogResult.OK Then
            Dim f As New FormNotas(Me, dni, sel.asignaturaId, sel.asignaturaNom, _nomProf, lblRol.Text)
            Me.Hide()
            f.Show()
        End If
    End Sub
End Class