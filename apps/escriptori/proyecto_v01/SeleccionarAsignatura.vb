Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class SeleccionarAsignatura
    Private Const BASE_URL As String = "https://192.168.1.134/notes.php"
    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()
    Private ReadOnly _dni As String

    Public Property asignaturaId As String = ""
    Public Property asignaturaNom As String = ""

    Public Sub New(dni As String)
        InitializeComponent()

        _dni = dni
    End Sub

    Private Async Sub SeleccionarAsignatura_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Await loadAsigAsync()
    End Sub

    Private Async Function loadAsigAsync() As Task
        Try
            Dim json As String = Await _client.GetStringAsync($"{BASE_URL}?accio=assignatures&dni={_dni}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show("Error en cargar las asignaturas. ", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                Me.DialogResult = DialogResult.Cancel
                Me.Close()
                Return
            End If

            cbAsignaturas.Items.Clear()
            cbAsignaturas.Items.Add(New ComboItem("- Selecciona asignatura -", ""))
            cbAsignaturas.SelectedIndex = 0

            For Each a As JToken In obj("assignatures")
                cbAsignaturas.Items.Add(New ComboItem(a.Value(Of String)("id_assignatura"), a.Value(Of String)("nom")))
            Next

            cbAsignaturas.DisplayMember = "Text"
            cbAsignaturas.ValueMember = "Value"
            cbAsignaturas.SelectedIndex = 0

            If cbAsignaturas.Items.Count = 2 Then
                cbAsignaturas.SelectedIndex = 1
            End If
        Catch ex As Exception
            MessageBox.Show("Error de conexión: " & ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            Me.DialogResult = DialogResult.Cancel
            Me.Close()
        End Try
    End Function

    Private Sub cbAsignaturas_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbAsignaturas.SelectedIndexChanged
        Dim item = TryCast(cbAsignaturas.SelectedItem, ComboItem)
        btnAccept.Enabled = (item IsNot Nothing AndAlso item.Value <> "")
    End Sub

    Private Sub btnAccept_Click(sender As Object, e As EventArgs) Handles btnAccept.Click
        Dim item = TryCast(cbAsignaturas.SelectedItem, ComboItem)
        If item Is Nothing OrElse item.Value = "" Then Return

        asignaturaId = item.Value
        asignaturaNom = item.Text

        Me.DialogResult = DialogResult.OK
        Me.Close()
    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Me.DialogResult = DialogResult.Cancel
        Me.Close()
    End Sub
End Class

Public Class ComboItem
    Public Property Text As String
    Public Property Value As String

    Public Sub New(text As String, value As String)
        Me.Text = text
        Me.Value = value
    End Sub

    Public Overrides Function ToString() As String
        Return Text
    End Function
End Class
