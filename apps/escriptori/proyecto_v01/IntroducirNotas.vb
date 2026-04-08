Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class IntroducirNotas
    Private Const BASE_URL = "https://192.168.1.134/notes.php"
    Private ReadOnly _client As HttpClient = UnsafeSSL.createUnsafeClient()

    Private ReadOnly _dni As String
    Private ReadOnly _idAssignatura As String
    Private ReadOnly _nomAssignatura As String
    Private ReadOnly _nomProf As String

    Private idRA1 As Integer = 0
    Private idRA2 As Integer = 0
    Private idRA3 As Integer = 0

    Private nies As New List(Of Integer)
    Private ended As Boolean = False

    Public Sub New(dni As String, idAssignatura As String, nomAssignatura As String, Optional nomProf As String = "")
        InitializeComponent()
        _dni = dni
        _idAssignatura = idAssignatura
        _nomAssignatura = nomAssignatura
        _nomProf = nomProf
    End Sub

    Private Async Sub IntroducirNotas_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        lblName.Text = _nomProf
        lblAsig.Text = _nomAssignatura

        Await loadPeriodAsync()
        Await loadStudentsAsync()
    End Sub

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
        dgvEstudiants.Rows.Clear()
        nies.Clear()

        Try
            Dim json As String = Await _client.GetStringAsync($"{BASE_URL}?accio=vista_notes_all&id_assignatura={_idAssignatura}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                lblStatus.Text = "Error: " & obj.Value(Of String)("error")
                Return
            End If

            idRA1 = If(obj("id_ra1").Type <> JTokenType.Null, obj.Value(Of Integer)("id_ra1"), 0)
            idRA2 = If(obj("id_ra2").Type <> JTokenType.Null, obj.Value(Of Integer)("id_ra2"), 0)
            idRA3 = If(obj("id_ra3").Type <> JTokenType.Null, obj.Value(Of Integer)("id_ra3"), 0)

            Dim totalStudents As Integer = 0
            Dim notesComplete As Integer = 0

            For Each est As JToken In obj("estudiants")
                Dim ra1St As String = NullToStr(est, "nota_ra1")
                Dim ra2St As String = NullToStr(est, "nota_ra2")
                Dim ra3St As String = NullToStr(est, "nota_ra3")

                Dim avg As String = If(est("mitjana").Type <> JTokenType.Null, est.Value(Of Double)("mitjana").ToString("F2"), "")
                Dim aproved As Object = est("aprobado.")
                Dim statusSt As String = ""
                If aproved.Type <> JTokenType.Null Then
                    statusSt = If(est.Value(Of Boolean)("aprobado"), "Aprob.", "Pend.")
                End If

                Dim idx As Integer = dgvEstudiants.Rows.Add(est.Value(Of String)("nia"),
                                                            $"{est.Value(Of String)("cognom")}, {est.Value(Of String)("nom")}",
                                                            ra1St, ra2St, ra3St, avg, statusSt, "")

                ''pueden escribir si está vacío
                If ra1St = "" Then dgvEstudiants.Rows(idx).Cells("RA1").ReadOnly = False
                If ra2St = "" Then dgvEstudiants.Rows(idx).Cells("RA2").ReadOnly = False
                If ra3St = "" Then dgvEstudiants.Rows(idx).Cells("RA3").ReadOnly = False

                ''si la nota ya se introdujo no se puede cambiar
                If ra1St <> "" Then dgvEstudiants.Rows(idx).Cells("RA1").ReadOnly = True
                If ra2St <> "" Then dgvEstudiants.Rows(idx).Cells("RA2").ReadOnly = True
                If ra3St <> "" Then dgvEstudiants.Rows(idx).Cells("RA3").ReadOnly = True

                ''cambiar color del estado
                If statusSt = "Aprov." Then
                    dgvEstudiants.Rows(idx).Cells("Estado").Style.ForeColor = Color.FromArgb(22, 101, 52)
                ElseIf statusSt = "Pend." Then
                    dgvEstudiants.Rows(idx).Cells("Estado").Style.ForeColor = Color.FromArgb(185, 28, 28)
                End If

                Dim hasTotal As Boolean = (ra1St <> "" OrElse idRA1 = 0) AndAlso
                    (ra2St <> "" OrElse idRA2 = 0) AndAlso
                    (ra3St <> "" OrElse idRA3 = 0)

                If hasTotal Then notesComplete += 1

                nies.Add(est.Value(Of Integer)("nia"))
                totalStudents += 1
            Next

            Dim pend As Integer = totalStudents - notesComplete
            Dim status As String = If(pend = 0, "Completado", "Borrador")
            lblStatus.Text = $"Estado: {Estado} · {totalStudents} alumnos · {pend} pendientes"

            If Not ended Then
                btnSave.Enabled = (pend > 0)
                btnClose.Enabled = (pend = 0)
            End If
        Catch ex As Exception
            lblStatus.Text = "error: " & ex.Message
        End Try
    End Function

    Private Shared Function NullToStr(token As JToken, key As String) As String
        Dim v As JToken = token(key)
        Return If(v Is Nothing OrElse v.Type = JTokenType.Null, "", v.ToString())
    End Function











    Private Sub lblInfoCurs_Click(sender As Object, e As EventArgs)

    End Sub

    Private Sub dgvPeriodes_CellContentClick(sender As Object, e As DataGridViewCellEventArgs)

    End Sub

    Private Sub lblStatus_Click(sender As Object, e As EventArgs) Handles lblStatus.Click

    End Sub
End Class
