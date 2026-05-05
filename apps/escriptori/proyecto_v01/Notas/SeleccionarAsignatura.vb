Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class SeleccionarAsignatura
    Dim urlNotas As String = BaseUrl.Notas.notas()
    Dim urlGrups As String = BaseUrl.Notas.notas().Replace("notes.php", "grups_professor.php")

    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()
    Private ReadOnly _dni As String
    Private ReadOnly _esAdmin As Boolean

    Public Property asignaturaId As String = ""
    Public Property asignaturaNom As String = ""
    Public Property grup As String = ""

    Public Sub New(dni As String, Optional esAdmin As Boolean = False)
        InitializeComponent()
        _dni = dni
        _esAdmin = esAdmin
    End Sub

    Private Async Sub SeleccionarAsignatura_Load(sender As Object, e As EventArgs) Handles MyBase.Load

        lblGrup.Visible = _esAdmin
        ComboBox1.Visible = _esAdmin
        btnAccept.Enabled = False

        Await loadAsigAsync()
    End Sub

    Private Async Function loadAsigAsync() As Task
        Try
            Dim endpoint As String = If(_esAdmin,
                $"{urlNotas}?accio=assignatures_all",
                $"{urlNotas}?accio=assignatures&dni={_dni}")

            Dim json As String = Await _client.GetStringAsync(endpoint)
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show("Error en cargar las asignaturas.", "Error",
                                MessageBoxButtons.OK, MessageBoxIcon.Error)
                Me.DialogResult = DialogResult.Cancel
                Me.Close()
                Return
            End If

            cbAsignaturas.Items.Clear()
            cbAsignaturas.Items.Add(New ComboItem("", "— Selecciona asignatura —"))
            cbAsignaturas.SelectedIndex = 0

            For Each a As JToken In obj("assignatures")
                cbAsignaturas.Items.Add(New ComboItem(
                    a.Value(Of String)("id_assignatura"),
                    a.Value(Of String)("nom"),
                    If(a("nom_grup") IsNot Nothing, a.Value(Of String)("nom_grup"), "")))
            Next

            cbAsignaturas.DisplayMember = "Text"
            cbAsignaturas.ValueMember = "Value"
            cbAsignaturas.SelectedIndex = 0

            If Not _esAdmin AndAlso cbAsignaturas.Items.Count = 2 Then
                cbAsignaturas.SelectedIndex = 1
            End If

        Catch ex As Exception
            MessageBox.Show("Error de conexión: " & ex.Message, "Error",
                            MessageBoxButtons.OK, MessageBoxIcon.Error)
            Me.DialogResult = DialogResult.Cancel
            Me.Close()
        End Try
    End Function

    Private Async Sub cbAsignaturas_SelectedIndexChanged(sender As Object, e As EventArgs) _
        Handles cbAsignaturas.SelectedIndexChanged

        Dim item = TryCast(cbAsignaturas.SelectedItem, ComboItem)
        btnAccept.Enabled = False

        If item Is Nothing OrElse item.Value = "" Then
            ComboBox1.Items.Clear()
            Return
        End If

        If Not _esAdmin Then
            btnAccept.Enabled = True
            Return
        End If

        Await CarregarGrupsAsync(item.Value)
    End Sub

    Private Async Function CarregarGrupsAsync(idAssignatura As String) As Task
        Try
            ComboBox1.Items.Clear()
            ComboBox1.Items.Add(New ComboItem("", "— Selecciona grup —"))
            ComboBox1.SelectedIndex = 0

            Dim json As String = Await _client.GetStringAsync(
            $"{urlNotas}?accio=grups_assignatura&id_assignatura={idAssignatura}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then Return

            For Each g As JToken In obj("grups")
                ComboBox1.Items.Add(New ComboItem(
                g.Value(Of String)("nom_grup"),
                g.Value(Of String)("nom_grup")))
            Next

            ComboBox1.DisplayMember = "Text"
            ComboBox1.ValueMember = "Value"

            If ComboBox1.Items.Count = 2 Then ComboBox1.SelectedIndex = 1

        Catch ex As Exception
            MessageBox.Show("Error carregant grups: " & ex.Message)
        End Try
    End Function

    Private Sub cbGrups_SelectedIndexChanged(sender As Object, e As EventArgs) _
    Handles ComboBox1.SelectedIndexChanged

        Dim item = TryCast(ComboBox1.SelectedItem, ComboItem)
        btnAccept.Enabled = (item IsNot Nothing AndAlso item.Value <> "")
    End Sub

    Private Sub btnAccept_Click(sender As Object, e As EventArgs) Handles btnAccept.Click
        Dim itemAsig = TryCast(cbAsignaturas.SelectedItem, ComboItem)
        If itemAsig Is Nothing OrElse itemAsig.Value = "" Then Return

        asignaturaId = itemAsig.Value
        asignaturaNom = itemAsig.Display

        If _esAdmin Then
            Dim itemGrup = TryCast(ComboBox1.SelectedItem, ComboItem)  ' ← era cbGrups
            If itemGrup Is Nothing OrElse itemGrup.Value = "" Then
                MessageBox.Show("Selecciona un grup.", "Avís",
                            MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return
            End If
            grup = itemGrup.Value
        Else
            grup = itemAsig.Grup
        End If

        Me.DialogResult = DialogResult.OK
        Me.Close()
    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Me.DialogResult = DialogResult.Cancel
        Me.Close()
    End Sub

End Class

Public Class ComboItem
    Public Property Value As String
    Public Property Display As String
    Public Property Grup As String

    Public Sub New(value As String, display As String, Optional grup As String = "")
        Me.Value = value
        Me.Display = display
        Me.Grup = grup
    End Sub

    Public Overrides Function ToString() As String
        Return Display
    End Function
End Class