Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class AbrirEvaluacion
    Private ReadOnly dni As String
    Private ReadOnly client As HttpClient = UnsafeSSL.createUnsafeClient()
    Private Const BASE_URL As String = "https://192.168.1.134/periode.php"
    Private id As New List(Of Integer)

    Public Sub New(dni As String)
        InitializeComponent()
        Me.dni = dni
    End Sub
    Private Async Sub AbrirEvaluacion_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Await LoadOpenNotesAsync()
    End Sub


    ''carga la tabla de la base de datos en el datagridview
    Private Async Function LoadOpenNotesAsync() As Task
        btnOpen.Enabled = False
        btnClose.Enabled = False
        btnUpdate.Enabled = False

        Try
            Dim curs As String = $"{Date.Now.Year}-{Date.Now.Year + 1}"
            Dim json As String = Await client.GetStringAsync($"{BASE_URL}?curs={curs}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                lblStatus.Text = "Error al cargar los periodos de evaluación."
                Return
            End If

            dgvPeriodes.Rows.Clear()
            id.Clear()

            Dim open As Boolean = False

            For Each p As JToken In obj("periodes")
                Dim obert As Boolean = p.Value(Of Boolean)("obert")
                If obert Then open = True

                id.Add(p.Value(Of Integer)("id"))


                Dim idx As Integer = dgvPeriodes.Rows.Add(
                    $"Trimestre {p.Value(Of String)("trimestre")}", p.Value(Of String)("curs"),
                    If(obert, "ABIERTO", "CERRADO"),
                        ifValue(p, "data_obertura"),
                        ifValue(p, "data_tancament"),
                        ifValue(p, "obert_per"))

                lblStatus.Text = If(open, "Hay un periodo de evaluación abierto. Los profesores pueden introducir notas.",
                    "El periodo de evaluación aún no está abierto. Los profesores no pueden introducir notas.")
                lblStatus.ForeColor = If(open, Color.DarkGreen, Color.DarkRed)

            Next
        Catch ex As Exception
            lblStatus.Text = "error de conexión: " & ex.Message
        Finally
            btnOpen.Enabled = True
            btnClose.Enabled = True
            btnUpdate.Enabled = True
        End Try
    End Function

    Private Shared Function ifValue(p As JToken, camp As String) As String
        Dim v As String = p.Value(Of String)(camp)
        Return If(String.IsNullOrEmpty(v), "-", v)
    End Function

    ''seleccionar fila
    Private Function selectedRow() As Integer
        If dgvPeriodes.CurrentRow Is Nothing Then
            MessageBox.Show("Seleccione un trimestre.", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Return -1
        End If
        Return Me.id(dgvPeriodes.CurrentRow.Index)
    End Function

    Private Async Function sendActionAsync(idPeriode As Integer, action As String) As Task
        btnOpen.Enabled = False
        btnClose.Enabled = False
        btnUpdate.Enabled = False

        Try
            Dim data As New FormUrlEncodedContent(New Dictionary(Of String, String) From {
                                                  {"id_periode", idPeriode.ToString()},
                                                  {"accio", action},
                                                  {"dni", Me.dni}})

            Dim res As HttpResponseMessage = Await client.PostAsync(BASE_URL, data)
            res.EnsureSuccessStatusCode()

            Dim json As String = Await res.Content.ReadAsStringAsync()
            Dim obj As JObject = JObject.Parse(json)

            If obj.Value(Of Boolean)("ok") Then
                Dim msg As String = If(action = "obrir",
                    "Periodo de evaluación abierto. Los profesores ya pueden introducir notas.",
                    "Periodo de evaluación cerrado. Ya no se pueden introducir notas.")
                MessageBox.Show(msg, "Correcto", MessageBoxButtons.OK, MessageBoxIcon.Information)

                Await LoadOpenNotesAsync()

            Else
                MessageBox.Show(obj.Value(Of String)("error"), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        Catch ex As Exception
            MessageBox.Show("Error: " & ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        Finally
            btnOpen.Enabled = True
            btnClose.Enabled = True
            btnUpdate.Enabled = True
        End Try
    End Function

    ''abrir evaluación
    Private Async Sub btnOpen_Click(sender As Object, e As EventArgs) Handles btnOpen.Click
        Dim id As Integer = selectedRow()
        If id = -1 Then Return

        Dim trimStr As String = dgvPeriodes.CurrentRow.Cells("Trimestre").Value.ToString()

        Dim confirm = MessageBox.Show($"¿Quiere abrir el {trimStr}?" & Environment.NewLine &
                                      "Cualquier otro periodo de evaluación abierto se cerrará automáticamente.",
                                      "Confirmar.", MessageBoxButtons.YesNo, MessageBoxIcon.Question)

        If confirm <> DialogResult.Yes Then Return
        Await sendActionAsync(id, "obrir")
    End Sub

    ''cerrar evaluación
    Private Async Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        Dim id As Integer = selectedRow()
        If id = -1 Then Return

        Dim trimStr As String = dgvPeriodes.CurrentRow.Cells("Trimestre").Value.ToString()

        Dim confirm = MessageBox.Show($"¿Quiere cerrar el {trimStr}?" & Environment.NewLine &
                                      "Los profesores ya no podrán introducir notas.",
                                      "Confirmar.", MessageBoxButtons.YesNo, MessageBoxIcon.Warning)

        If confirm <> DialogResult.Yes Then Return
        Await sendActionAsync(id, "tancar")
    End Sub

    ''actualizar
    Private Async Sub btnUpdate_Click(sender As Object, e As EventArgs) Handles btnUpdate.Click
        Await LoadOpenNotesAsync()
    End Sub
End Class
