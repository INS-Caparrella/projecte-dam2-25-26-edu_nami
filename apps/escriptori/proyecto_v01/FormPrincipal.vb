Imports Habanero.Base

Public Class FormPrincipal
    Private ReadOnly dni As String
    Public Sub New(result As LoginResult)
        InitializeComponent()
        lblName.Text = $"{result.name} {result.surname}"
        lblRol.Text = $"{result.rol}"

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

    Private Sub btnGrades_Click(sender As Object, e As EventArgs) Handles btnGrades.Click
        ''enviar nombre de asignatura a la que quiere añadir notas
        Dim sel As New SeleccionarAsignatura(dni)
        If sel.ShowDialog() = DialogResult.OK Then
            LoadOpenNotes(New IntroducirNotas(dni, sel.asignaturaId, sel.asignaturaNom))
        End If
    End Sub
End Class