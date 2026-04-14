Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class FormNotas
    Private Sub FormNotas_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub
    ''falta imágen, que funcione para volver a inicio,
    ''y que salga en estado si el periodo de evaluación está abierto o cerrado
    Private Const BASE_URL = "https://192.168.1.134/notes.php"
        Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()
        Private ReadOnly _parent As FormPrincipal

        Private ReadOnly _dni As String
        Private ReadOnly _idAssignatura As String
        Private ReadOnly _nomAssignatura As String
    Private ReadOnly _nomProf As String
    Private ReadOnly _rol As String

    ''lista de ras
    Private _ras As New List(Of (id As Integer, ra As Integer))

        Private nies As New List(Of Integer)
        Private ended As Boolean = False

    Public Sub New(parent As FormPrincipal, dni As String, idAssignatura As String, nomAssignatura As String, nomProf As String, rol As String)
        InitializeComponent()
        _parent = parent
        _dni = dni
        _idAssignatura = idAssignatura
        _nomAssignatura = nomAssignatura
        _nomProf = nomProf
        _rol = rol
    End Sub

    Private Async Sub IntroducirNotas_Load(sender As Object, e As EventArgs) Handles MyBase.Load
            lblName.Text = _nomProf
            lblAsig.Text = _nomAssignatura

            Await loadPeriodAsync()
        Await loadStudentsAsync()

        ''??
        If _rol <> "tutor" AndAlso _rol <> "director" Then
            For Each col As DataGridViewColumn In dgvEstudiants.Columns
                If col.Name.StartsWith("RA_") Then
                    col.ReadOnly = True
                End If
            Next
            btnSave.Enabled = False
            btnClose.Enabled = False
            lblStatus.Text &= " · Modo lectura. No tiene permisos para modificar las notas. ·"
        End If
    End Sub

        ''comprobar si el periodo de evaluación está abierto
        Private Async Function loadPeriodAsync() As Task
            Try
                Dim json As String = Await _client.GetStringAsync($"https://192.168.1.134/periode.php?curs={Date.Now.Year}-{Date.Now.Year + 1}")
                Dim obj As JObject = JObject.Parse(json)
                Dim obert As Boolean = False

                For Each p As JToken In obj("periodes")
                    If p.Value(Of Boolean)("obert") Then obert = True
                    lblStatus.Text = "Estado: Periodo de evaluación abierto - puede introducir notas."
                Next

                If Not obert Then
                    lblStatus.Text = "Estado: Periodo de evaluación cerrado - no se pueden introducir notas."
                    btnSave.Enabled = False
                End If

            Catch ex As Exception
                MessageBox.Show("error: " & ex.Message)
            End Try
        End Function

        Private Async Function loadStudentsAsync() As Task
            lblStatus.Text = "Estado: Cargando..."

            Try
                Dim json As String = Await _client.GetStringAsync($"{BASE_URL}?accio=vista_notes_all&id_assignatura={_idAssignatura}")
                Dim obj As JObject = JObject.Parse(json)

                If Not obj.Value(Of Boolean)("ok") Then
                    lblStatus.Text = "Error: " & obj.Value(Of String)("error")
                    Return
                End If

                ''poner las columnas de todos los ras
                columnsRa(obj("ras"))

                dgvEstudiants.Rows.Clear()
                nies.Clear()

                Dim totalStudents As Integer = 0
                Dim notesComplete As Integer = 0

                For Each est As JToken In obj("estudiants")
                    Dim fil As New List(Of Object)
                    fil.Add(est.Value(Of Integer)("nia"))
                    fil.Add($"{est.Value(Of String)("cognom")}, {est.Value(Of String)("nom")}")

                    Dim notesValue As New List(Of Double)
                    Dim complete As Boolean = True

                    For Each raInfo In _ras
                        Dim key As String = $"ra_{raInfo.id}"
                        Dim token As JToken = est(key)
                        Dim note As String = If(token IsNot Nothing AndAlso token.Type <> JTokenType.Null, token.ToString(), "")

                        fil.Add(note)
                        If note <> "" Then
                            notesValue.Add(Double.Parse(note))
                        Else
                            complete = False
                        End If
                    Next

                    ''media y estado
                    Dim avg As String = ""
                    Dim statusTxt As String = ""
                    If notesValue.Count > 0 Then
                        Dim m As Double = Math.Round(notesValue.Sum() / notesValue.Count, 2)
                        avg = m.ToString("F2")
                        statusTxt = If(m >= 5, "Aprob.", "Pend.")
                    End If

                    fil.Add(avg)
                    fil.Add(statusTxt)
                    fil.Add("")

                    Dim idx As Integer = dgvEstudiants.Rows.Add(fil.ToArray())

                    ''si la nota ya está introducida la celda es readonly
                    For Each raInfo In _ras
                        Dim col As String = $"RA_{raInfo.id}"
                        Dim cell As DataGridViewCell = dgvEstudiants.Rows(idx).Cells(col)
                        If cell.Value?.ToString() <> "" Then
                            cell.ReadOnly = True
                        End If
                    Next

                    colorStatus(dgvEstudiants.Rows(idx).Cells("Estado"), statusTxt)

                    If complete Then notesComplete += 1
                    nies.Add(est.Value(Of Integer)("nia"))
                    totalStudents += 1
                Next

                Dim pend As Integer = totalStudents - notesComplete
                Dim stStatus As String = If(pend = 0, "Completado", "Borrador")
                lblStatus.Text = $"Estado: {stStatus}  ·  {totalStudents} alumnos  ·  {pend} pendientes"

                If Not ended Then
                    btnSave.Enabled = (pend > 0)
                    btnClose.Enabled = (pend = 0)
                End If
            Catch ex As Exception
                lblStatus.Text = "Error de conexión: " & ex.Message
            End Try
        End Function

        ''columnas ra
        Private Sub columnsRa(rasToken As JToken)
            'eliminar columnas RA existentes
            For i = dgvEstudiants.Columns.Count - 1 To 0 Step -1
                If dgvEstudiants.Columns(i).Name.StartsWith("RA_") Then
                    dgvEstudiants.Columns.RemoveAt(i)
                End If
            Next

            _ras.Clear()

            Dim insertId As Integer = dgvEstudiants.Columns("Alumno").Index + 1

            For Each r As JToken In rasToken
                Dim idRa As Integer = r.Value(Of Integer)("id")
                Dim numRa As Integer = r.Value(Of Integer)("ra")
                _ras.Add((idRa, numRa))

                Dim col As New DataGridViewTextBoxColumn With {
                .Name = $"RA_{idRa}",
                .HeaderText = $"RA{numRa}",
                .FillWeight = 70
                }

                dgvEstudiants.Columns.Insert(insertId, col)
                insertId += 1
            Next
        End Sub

        Private Shared Function NullToStr(token As JToken, key As String) As String
            Dim v As JToken = token(key)
            Return If(v Is Nothing OrElse v.Type = JTokenType.Null, "", v.ToString())
        End Function

        ''recalcular la media
        Private Sub dgvEstudiants_CellValueChanged(sender As Object, e As DataGridViewCellEventArgs) Handles dgvEstudiants.CellValueChanged
            If e.RowIndex < 0 Then Return

            Dim row As DataGridViewRow = dgvEstudiants.Rows(e.RowIndex)

            ''comprobar que sea un RA
            Dim colName As String = dgvEstudiants.Columns(e.ColumnIndex).Name
            If Not colName.StartsWith("RA_") Then Return

            Dim notes As New List(Of Double)
            For Each raInfo In _ras
                Dim val As String = row.Cells($"RA_{raInfo.id}").Value?.ToString().Trim()
                Dim n As Double
                If Not String.IsNullOrEmpty(val) AndAlso Double.TryParse(val.Replace(".", ","), n) Then
                    notes.Add(n)
                End If
            Next

            If notes.Count > 0 Then
                Dim m As Double = Math.Round(notes.Sum() / notes.Count, 2)
                row.Cells("Media").Value = m.ToString("F2")
                Dim aprob As Boolean = m >= 5
                row.Cells("Estado").Value = If(aprob, "Aprob.", "Pend.")
                colorStatus(row.Cells("Estado"), row.Cells("Estado").Value.ToString())
            Else
                row.Cells("Media").Value = ""
                row.Cells("Estado").Value = ""
            End If
        End Sub

        ''validar nota
        Private Sub dgvEstudiants_CellValidating(sender As Object, e As DataGridViewCellValidatingEventArgs) Handles dgvEstudiants.CellValidating
            Dim colName As String = dgvEstudiants.Columns(e.ColumnIndex).Name
            If Not colName.StartsWith("RA_") Then Return

            Dim text As String = e.FormattedValue?.ToString().Trim()
            If String.IsNullOrEmpty(text) Then Return

            Dim nota As Double
            If Not Double.TryParse(text.Replace(".", ","), nota) OrElse nota < 0 OrElse nota > 10 Then
                MessageBox.Show("La nota introducida debe ser entre 0 y 10.", "Validación", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                e.Cancel = True
            End If
        End Sub

        Private Async Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
            Dim filToSave As New List(Of (nia As Integer, idRa As Integer, nota As Double))

            For Each row As DataGridViewRow In dgvEstudiants.Rows
                Dim nia As Integer = CInt(row.Cells("NIA").Value)
                For Each raInfo In _ras
                    Dim cel As DataGridViewCell = row.Cells($"RA_{raInfo.id}")
                    If cel.ReadOnly Then Continue For
                    Dim text As String = cel.Value?.ToString().Trim()
                    If String.IsNullOrEmpty(text) Then Continue For
                    Dim nota As Double
                    If Double.TryParse(text.Replace(".", ","), nota) Then
                        filToSave.Add((nia, raInfo.id, nota))
                    End If
                Next
            Next

            If filToSave.Count = 0 Then
                MessageBox.Show("No hay notas nuevas para guardar.", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information)
                Return
            End If

            btnSave.Enabled = False
            lblStatus.Text = "Guardando..."
            Dim errors As New List(Of String)

            For Each entry In filToSave
                Try
                    Dim data As New FormUrlEncodedContent(New Dictionary(Of String, String) From {
                                                          {"accio", "guardar"},
                                                          {"id_ra", entry.idRa.ToString()},
                                                          {"nia", entry.nia.ToString()},
                                                          {"nota", entry.nota.ToString("F1", Globalization.CultureInfo.InvariantCulture)}
                                                          })
                    Dim res As HttpResponseMessage = Await _client.PostAsync(BASE_URL, data)
                    res.EnsureSuccessStatusCode()

                    Dim obj As JObject = JObject.Parse(Await res.Content.ReadAsStringAsync())

                    If Not obj.Value(Of Boolean)("ok") Then
                        errors.Add($"NIA {entry.nia} RA{entry.idRa}: {obj.Value(Of String)("error")}")
                    End If
                Catch ex As Exception
                    errors.Add($"NIA {entry.nia}: {ex.Message}")
                End Try
            Next

            If errors.Count > 0 Then
                MessageBox.Show(String.Join(Environment.NewLine, errors), "Errores", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Else
                MessageBox.Show($"{filToSave.Count} notas guardadas correctamente.", "Hecho", MessageBoxButtons.OK, MessageBoxIcon.Information)
            End If

            Await loadStudentsAsync()
        End Sub

        Private Async Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
            Dim confirm = MessageBox.Show("Si abandona el proceso ahora no se podrán modificar las notas." & Environment.NewLine & "¿Desea continuar?", "Abandonar proceso", MessageBoxButtons.YesNo, MessageBoxIcon.Warning)

            If confirm <> DialogResult.Yes Then Return

            Try
                btnClose.Enabled = False
                Dim data As New FormUrlEncodedContent(New Dictionary(Of String, String) From {
                                                      {"accio", "tancar_proces"},
                                                      {"id_assignatura", _idAssignatura},
                                                      {"dni", _dni}
                                                      })

                Dim res As HttpResponseMessage = Await _client.PostAsync(BASE_URL, data)
                Dim obj As JObject = JObject.Parse(Await res.Content.ReadAsStringAsync())

                If obj.Value(Of Boolean)("ok") Then
                    ended = True
                    btnSave.Enabled = False
                    btnClose.Enabled = False
                    lblStatus.Text = "Estado: Finalizado - proceso terminado."

                    For Each row As DataGridViewRow In dgvEstudiants.Rows
                        row.ReadOnly = True
                    Next

                    MessageBox.Show("Proceso terminado. Las notas están registradas.", "Finalizado", MessageBoxButtons.OK, MessageBoxIcon.Information)

                Else
                    MessageBox.Show(obj.Value(Of String)("error"), "No se puede cerrar.", MessageBoxButtons.OK, MessageBoxIcon.Error)
                    btnClose.Enabled = True
                End If
            Catch ex As Exception
                MessageBox.Show("Error: " & ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                btnClose.Enabled = True
            End Try
        End Sub

        Private Sub lblLogOut_Click(sender As Object, e As EventArgs) Handles lblLogOut.Click
            Dim confirm = MessageBox.Show("¿Quiere cerrar la sesión?", "Cerrar sesión", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
            If confirm = DialogResult.Yes Then Application.Restart()
        End Sub

        Private Shared Sub colorStatus(cel As DataGridViewCell, status As String)
            Select Case status
                Case "Aprob."
                    cel.Style.ForeColor = Color.FromArgb(22, 101, 52)
                Case "Pend."
                    cel.Style.ForeColor = Color.FromArgb(185, 28, 28)
                Case Else
                    cel.Style.ForeColor = Color.FromArgb(40, 40, 40)
            End Select
        End Sub

    Private Sub lblHome_Click(sender As Object, e As EventArgs) Handles lblHome.Click
        Dim result As LoginResult

        Dim confirm = MessageBox.Show("Si vuelve al inicio se perderán los datos que no haya guardado." & Environment.NewLine & "¿Seguro que desea volver?", "Volver a inicio", MessageBoxButtons.YesNo, MessageBoxIcon.Question)
        If confirm = DialogResult.Yes Then
            _parent.Show()
            Me.Close()
        End If
    End Sub
End Class