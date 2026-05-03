Imports System.Diagnostics.CodeAnalysis
Imports System.IO
Imports System.Net.Http
Imports Newtonsoft.Json.Linq

Public Class FormFicha
    Dim urlFicha = BaseUrl.FichaProfesores.fichaProf()
    Dim urlList = BaseUrl.FichaProfesores.listaProf()

    Private ReadOnly _dniConsultor As String
    Private ReadOnly _client As HttpClient

    Private _professors As New List(Of (dni As String, nom As String))
    Private _dniSeleccionat As String = ""

    Public Sub New(dniConsultor As String, client As HttpClient)
        InitializeComponent()

        _dniConsultor = dniConsultor
        _client = client
    End Sub
    Private Async Sub FormFicha_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        Await loadListAsync()
    End Sub

    Private Async Function loadListAsync() As Task
        Try
            Dim json As String = Await _client.GetStringAsync($"{urlList}?dni_consultor={_dniConsultor}")

            MessageBox.Show(json.Substring(0, Math.Min(500, json.Length)), "Raw")

            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show(obj.Value(Of String)("error"))
                Return
            End If

            _professors.Clear()
            lstProfessors.Items.Clear()

            lstProfessors.DisplayMember = "nom"
            lstProfessors.ValueMember = "dni"
            For Each p As JToken In obj("professors")
                Dim dni As String = p.Value(Of String)("dni")
                Dim nom As String = $"{p.Value(Of String)("cognom")}, {p.Value(Of String)("nom")}"

                _professors.Add((dni, nom))

                lstProfessors.Items.Add(New With {
                                        .dni = dni,
                                        .nom = nom
                                        })
            Next

        Catch ex As Exception
            MessageBox.Show("ERROR: " & ex.Message)
        End Try
    End Function

    'filtrar búsqueda
    Private Sub txtCerca_TextChanged(sender As Object, e As EventArgs) Handles txtCerca.TextChanged
        Dim filter As String = txtCerca.Text.ToLower().Trim()
        lstProfessors.Items.Clear()

        For Each p In _professors
            If p.nom.ToLower().Contains(filter) Then
                lstProfessors.Items.Add(p.nom)
            End If
        Next
    End Sub

    'selección de profesor
    Private Async Sub lstProfessors_SelectedIndexChanged(sender As Object, e As EventArgs) Handles lstProfessors.SelectedIndexChanged
        If lstProfessors.SelectedIndex < 0 Then Return

        Dim item = lstProfessors.SelectedItem
        Dim dni As String = item.dni

        _dniSeleccionat = dni
        Await loadFitxaAsync(dni)
    End Sub

    'cargar ficha de profesor
    Private Async Function loadFitxaAsync(dniProf As String) As Task
        Try
            Dim json As String = Await _client.GetStringAsync($"{urlFicha}?dni_consultor={_dniConsultor}&dni_professor={dniProf}")
            Dim obj As JObject = JObject.Parse(json)

            If Not obj.Value(Of Boolean)("ok") Then
                MessageBox.Show(obj.Value(Of String)("error"))
                Return
            End If

            Dim nivell As Integer = obj.Value(Of Integer)("nivell")

            lblNom.Text = $"{obj.Value(Of String)("nom")} {obj.Value(Of String)("cognom")}"
            lblEmail.Text = $"Email: {obj.Value(Of String)("email")}"
            lblDedicacio.Text = obj.Value(Of String)("dedicacio")

            Dim rolDir As String = obj.Value(Of String)("rol_directiva")
            lblRol.Text = If(rolDir <> "", rolDir, "Profesor/a")

            'foto
            Dim ruta As String = obj.Value(Of String)("ruta_foto")
            Try
                If Not String.IsNullOrEmpty(ruta) AndAlso File.Exists(ruta) Then
                    pbFoto.Image = Image.FromFile(ruta)
                Else
                    pbFoto.Image = Nothing
                End If
            Catch ex As Exception
                MessageBox.Show("Error al cargar la foto: " & ex.Message)
                pbFoto.Image = Nothing
            End Try

            'asignaturas
            dgvAssignatures.Rows.Clear()
            For Each a As JToken In obj("assignatures")
                dgvAssignatures.Rows.Add(
                    a.Value(Of String)("codi"),
                    a.Value(Of String)("nom"))
            Next

            'datos adicionales
            Dim showExtra As Boolean = (nivell >= 2)

            lblDni.Visible = showExtra
            lblTelf.Visible = showExtra
            lblNaix.Visible = showExtra
            lblPoblacio.Visible = showExtra
            lblContractesTitle.Visible = showExtra
            dgvContractes.Visible = showExtra
            lblAbsenciesTitle.Visible = showExtra
            dgvAbsencies.Visible = showExtra

            If showExtra Then
                lblDni.Text = $"DNI: {obj.Value(Of String)("dni")}"
                lblTelf.Text = $"Teléfono: {obj.Value(Of String)("telf_mob")}"
                lblNaix.Text = $"Nacimiento: {obj.Value(Of String)("data_naix")}"
                lblPoblacio.Text = $"Población: {obj.Value(Of String)("poblacio")}"

                'contratos
                dgvContractes.Rows.Clear()
                For Each c As JToken In obj("contractes")
                    dgvContractes.Rows.Add(
                        c.Value(Of String)("nom_centre"),
                        c.Value(Of String)("vinculacio_laboral"),
                        c.Value(Of String)("data_alta"),
                        If(c("data_baix").Type = JTokenType.Null, "Activo", c.Value(Of String)("data_baix")))
                Next

                'ausencias
                dgvAbsencies.Rows.Clear()
                For Each a As JToken In obj("absencies")
                    Dim just As String = If(a.Value(Of Boolean)("justificat"), "Sí", "No")
                    dgvAbsencies.Rows.Add(
                        a.Value(Of String)("tipus"),
                        a.Value(Of String)("motius"),
                        just,
                        a.Value(Of String)("justificant"))
                Next
            End If

        Catch ex As Exception
            MessageBox.Show("ERROR: " & ex.Message)
        End Try
    End Function


End Class