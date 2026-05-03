<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormFicha
    Inherits System.Windows.Forms.Form

    'Form reemplaza a Dispose para limpiar la lista de componentes.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Requerido por el Diseñador de Windows Forms
    Private components As System.ComponentModel.IContainer

    'NOTA: el Diseñador de Windows Forms necesita el siguiente procedimiento
    'Se puede modificar usando el Diseñador de Windows Forms.  
    'No lo modifique con el editor de código.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Dim DataGridViewCellStyle1 As DataGridViewCellStyle = New DataGridViewCellStyle()
        Dim DataGridViewCellStyle2 As DataGridViewCellStyle = New DataGridViewCellStyle()
        Dim DataGridViewCellStyle3 As DataGridViewCellStyle = New DataGridViewCellStyle()
        pnlLeft = New Panel()
        sep = New Panel()
        lstProfessors = New ListBox()
        txtCerca = New TextBox()
        lblCercaTitol = New Label()
        pnlFitxa = New Panel()
        dgvAbsencies = New DataGridView()
        Tipo = New DataGridViewTextBoxColumn()
        Motivo = New DataGridViewTextBoxColumn()
        Justifcado = New DataGridViewTextBoxColumn()
        Justificante = New DataGridViewTextBoxColumn()
        lblAbsenciesTitle = New Label()
        dgvContractes = New DataGridView()
        Centro = New DataGridViewTextBoxColumn()
        Vinculacion = New DataGridViewTextBoxColumn()
        Fecha_alta = New DataGridViewTextBoxColumn()
        Fecha_baja = New DataGridViewTextBoxColumn()
        lblContractesTitle = New Label()
        dgvAssignatures = New DataGridView()
        Codigo = New DataGridViewTextBoxColumn()
        Asignatura = New DataGridViewTextBoxColumn()
        lblAsigTitle = New Label()
        tbpContacte = New TableLayoutPanel()
        lblPoblacio = New Label()
        lblEmail = New Label()
        lblDni = New Label()
        lblTelf = New Label()
        lblNaix = New Label()
        pnlCap = New Panel()
        lblDedicacio = New Label()
        lblRol = New Label()
        lblNom = New Label()
        pbFoto = New PictureBox()
        pnlLeft.SuspendLayout()
        pnlFitxa.SuspendLayout()
        CType(dgvAbsencies, ComponentModel.ISupportInitialize).BeginInit()
        CType(dgvContractes, ComponentModel.ISupportInitialize).BeginInit()
        CType(dgvAssignatures, ComponentModel.ISupportInitialize).BeginInit()
        tbpContacte.SuspendLayout()
        pnlCap.SuspendLayout()
        CType(pbFoto, ComponentModel.ISupportInitialize).BeginInit()
        SuspendLayout()
        ' 
        ' pnlLeft
        ' 
        pnlLeft.BackColor = Color.FromArgb(CByte(245), CByte(247), CByte(250))
        pnlLeft.Controls.Add(sep)
        pnlLeft.Controls.Add(lstProfessors)
        pnlLeft.Controls.Add(txtCerca)
        pnlLeft.Controls.Add(lblCercaTitol)
        pnlLeft.Dock = DockStyle.Left
        pnlLeft.Location = New Point(0, 0)
        pnlLeft.Name = "pnlLeft"
        pnlLeft.Padding = New Padding(8)
        pnlLeft.Size = New Size(230, 633)
        pnlLeft.TabIndex = 0
        ' 
        ' sep
        ' 
        sep.BackColor = Color.Gainsboro
        sep.Dock = DockStyle.Left
        sep.Location = New Point(8, 58)
        sep.Name = "sep"
        sep.Size = New Size(1, 567)
        sep.TabIndex = 3
        ' 
        ' lstProfessors
        ' 
        lstProfessors.BorderStyle = BorderStyle.None
        lstProfessors.Dock = DockStyle.Fill
        lstProfessors.FormattingEnabled = True
        lstProfessors.Location = New Point(8, 58)
        lstProfessors.Name = "lstProfessors"
        lstProfessors.Size = New Size(214, 567)
        lstProfessors.TabIndex = 2
        ' 
        ' txtCerca
        ' 
        txtCerca.Dock = DockStyle.Top
        txtCerca.Location = New Point(8, 31)
        txtCerca.Name = "txtCerca"
        txtCerca.PlaceholderText = "Buscar..."
        txtCerca.Size = New Size(214, 27)
        txtCerca.TabIndex = 1
        ' 
        ' lblCercaTitol
        ' 
        lblCercaTitol.AutoSize = True
        lblCercaTitol.Dock = DockStyle.Top
        lblCercaTitol.Font = New Font("Segoe UI", 10.2F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblCercaTitol.ForeColor = Color.FromArgb(CByte(30), CByte(60), CByte(100))
        lblCercaTitol.Location = New Point(8, 8)
        lblCercaTitol.Name = "lblCercaTitol"
        lblCercaTitol.Size = New Size(93, 23)
        lblCercaTitol.TabIndex = 0
        lblCercaTitol.Text = "Profesores"
        lblCercaTitol.TextAlign = ContentAlignment.MiddleLeft
        ' 
        ' pnlFitxa
        ' 
        pnlFitxa.AutoScroll = True
        pnlFitxa.BackColor = Color.White
        pnlFitxa.Controls.Add(dgvAbsencies)
        pnlFitxa.Controls.Add(lblAbsenciesTitle)
        pnlFitxa.Controls.Add(dgvContractes)
        pnlFitxa.Controls.Add(lblContractesTitle)
        pnlFitxa.Controls.Add(dgvAssignatures)
        pnlFitxa.Controls.Add(lblAsigTitle)
        pnlFitxa.Controls.Add(tbpContacte)
        pnlFitxa.Controls.Add(pnlCap)
        pnlFitxa.Dock = DockStyle.Fill
        pnlFitxa.Location = New Point(230, 0)
        pnlFitxa.Name = "pnlFitxa"
        pnlFitxa.Padding = New Padding(20, 16, 20, 16)
        pnlFitxa.Size = New Size(752, 633)
        pnlFitxa.TabIndex = 1
        ' 
        ' dgvAbsencies
        ' 
        dgvAbsencies.AllowUserToAddRows = False
        dgvAbsencies.AllowUserToDeleteRows = False
        dgvAbsencies.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dgvAbsencies.BackgroundColor = Color.White
        dgvAbsencies.BorderStyle = BorderStyle.None
        DataGridViewCellStyle1.Alignment = DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle1.BackColor = Color.FromArgb(CByte(240), CByte(244), CByte(250))
        DataGridViewCellStyle1.Font = New Font("Segoe UI", 9F)
        DataGridViewCellStyle1.ForeColor = Color.FromArgb(CByte(20), CByte(50), CByte(90))
        DataGridViewCellStyle1.SelectionBackColor = SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = DataGridViewTriState.True
        dgvAbsencies.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        dgvAbsencies.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize
        dgvAbsencies.Columns.AddRange(New DataGridViewColumn() {Tipo, Motivo, Justifcado, Justificante})
        dgvAbsencies.Dock = DockStyle.Top
        dgvAbsencies.EnableHeadersVisualStyles = False
        dgvAbsencies.Location = New Point(20, 466)
        dgvAbsencies.Name = "dgvAbsencies"
        dgvAbsencies.ReadOnly = True
        dgvAbsencies.RowHeadersVisible = False
        dgvAbsencies.RowHeadersWidth = 51
        dgvAbsencies.Size = New Size(712, 110)
        dgvAbsencies.TabIndex = 9
        dgvAbsencies.Visible = False
        ' 
        ' Tipo
        ' 
        Tipo.FillWeight = 20F
        Tipo.HeaderText = ""
        Tipo.MinimumWidth = 6
        Tipo.Name = "Tipo"
        Tipo.ReadOnly = True
        ' 
        ' Motivo
        ' 
        Motivo.FillWeight = 40F
        Motivo.HeaderText = ""
        Motivo.MinimumWidth = 6
        Motivo.Name = "Motivo"
        Motivo.ReadOnly = True
        ' 
        ' Justifcado
        ' 
        Justifcado.FillWeight = 20F
        Justifcado.HeaderText = ""
        Justifcado.MinimumWidth = 6
        Justifcado.Name = "Justifcado"
        Justifcado.ReadOnly = True
        ' 
        ' Justificante
        ' 
        Justificante.FillWeight = 20F
        Justificante.HeaderText = ""
        Justificante.MinimumWidth = 6
        Justificante.Name = "Justificante"
        Justificante.ReadOnly = True
        ' 
        ' lblAbsenciesTitle
        ' 
        lblAbsenciesTitle.AutoSize = True
        lblAbsenciesTitle.BackColor = Color.FromArgb(CByte(240), CByte(244), CByte(250))
        lblAbsenciesTitle.Dock = DockStyle.Top
        lblAbsenciesTitle.Font = New Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblAbsenciesTitle.ForeColor = Color.FromArgb(CByte(30), CByte(60), CByte(100))
        lblAbsenciesTitle.Location = New Point(20, 446)
        lblAbsenciesTitle.Name = "lblAbsenciesTitle"
        lblAbsenciesTitle.Padding = New Padding(4, 0, 0, 0)
        lblAbsenciesTitle.Size = New Size(164, 20)
        lblAbsenciesTitle.TabIndex = 8
        lblAbsenciesTitle.Text = "Historial de ausencias"
        lblAbsenciesTitle.TextAlign = ContentAlignment.MiddleLeft
        lblAbsenciesTitle.Visible = False
        ' 
        ' dgvContractes
        ' 
        dgvContractes.AllowUserToAddRows = False
        dgvContractes.AllowUserToDeleteRows = False
        dgvContractes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dgvContractes.BackgroundColor = Color.White
        dgvContractes.BorderStyle = BorderStyle.None
        DataGridViewCellStyle2.Alignment = DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = Color.FromArgb(CByte(240), CByte(244), CByte(250))
        DataGridViewCellStyle2.Font = New Font("Segoe UI", 9F)
        DataGridViewCellStyle2.ForeColor = Color.FromArgb(CByte(20), CByte(50), CByte(90))
        DataGridViewCellStyle2.SelectionBackColor = SystemColors.Highlight
        DataGridViewCellStyle2.SelectionForeColor = SystemColors.HighlightText
        DataGridViewCellStyle2.WrapMode = DataGridViewTriState.True
        dgvContractes.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle2
        dgvContractes.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize
        dgvContractes.Columns.AddRange(New DataGridViewColumn() {Centro, Vinculacion, Fecha_alta, Fecha_baja})
        dgvContractes.Dock = DockStyle.Top
        dgvContractes.EnableHeadersVisualStyles = False
        dgvContractes.Location = New Point(20, 346)
        dgvContractes.Name = "dgvContractes"
        dgvContractes.ReadOnly = True
        dgvContractes.RowHeadersVisible = False
        dgvContractes.RowHeadersWidth = 51
        dgvContractes.Size = New Size(712, 100)
        dgvContractes.TabIndex = 7
        dgvContractes.Visible = False
        ' 
        ' Centro
        ' 
        Centro.FillWeight = 35F
        Centro.HeaderText = ""
        Centro.MinimumWidth = 6
        Centro.Name = "Centro"
        Centro.ReadOnly = True
        ' 
        ' Vinculacion
        ' 
        Vinculacion.FillWeight = 35F
        Vinculacion.HeaderText = ""
        Vinculacion.MinimumWidth = 6
        Vinculacion.Name = "Vinculacion"
        Vinculacion.ReadOnly = True
        ' 
        ' Fecha_alta
        ' 
        Fecha_alta.FillWeight = 15F
        Fecha_alta.HeaderText = ""
        Fecha_alta.MinimumWidth = 6
        Fecha_alta.Name = "Fecha_alta"
        Fecha_alta.ReadOnly = True
        ' 
        ' Fecha_baja
        ' 
        Fecha_baja.FillWeight = 15F
        Fecha_baja.HeaderText = ""
        Fecha_baja.MinimumWidth = 6
        Fecha_baja.Name = "Fecha_baja"
        Fecha_baja.ReadOnly = True
        ' 
        ' lblContractesTitle
        ' 
        lblContractesTitle.AutoSize = True
        lblContractesTitle.BackColor = Color.FromArgb(CByte(240), CByte(244), CByte(250))
        lblContractesTitle.Dock = DockStyle.Top
        lblContractesTitle.Font = New Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblContractesTitle.ForeColor = Color.FromArgb(CByte(30), CByte(60), CByte(100))
        lblContractesTitle.Location = New Point(20, 326)
        lblContractesTitle.Name = "lblContractesTitle"
        lblContractesTitle.Padding = New Padding(4, 0, 0, 0)
        lblContractesTitle.Size = New Size(82, 20)
        lblContractesTitle.TabIndex = 6
        lblContractesTitle.Text = "Contratos"
        lblContractesTitle.TextAlign = ContentAlignment.MiddleLeft
        lblContractesTitle.Visible = False
        ' 
        ' dgvAssignatures
        ' 
        dgvAssignatures.AllowUserToAddRows = False
        dgvAssignatures.AllowUserToDeleteRows = False
        dgvAssignatures.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dgvAssignatures.BackgroundColor = Color.White
        dgvAssignatures.BorderStyle = BorderStyle.None
        DataGridViewCellStyle3.Alignment = DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle3.BackColor = Color.FromArgb(CByte(240), CByte(244), CByte(250))
        DataGridViewCellStyle3.Font = New Font("Segoe UI", 8.5F, FontStyle.Bold)
        DataGridViewCellStyle3.ForeColor = Color.FromArgb(CByte(20), CByte(50), CByte(90))
        DataGridViewCellStyle3.SelectionBackColor = SystemColors.Highlight
        DataGridViewCellStyle3.SelectionForeColor = SystemColors.HighlightText
        DataGridViewCellStyle3.WrapMode = DataGridViewTriState.True
        dgvAssignatures.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle3
        dgvAssignatures.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize
        dgvAssignatures.Columns.AddRange(New DataGridViewColumn() {Codigo, Asignatura})
        dgvAssignatures.Dock = DockStyle.Top
        dgvAssignatures.EnableHeadersVisualStyles = False
        dgvAssignatures.Location = New Point(20, 216)
        dgvAssignatures.Name = "dgvAssignatures"
        dgvAssignatures.RowHeadersVisible = False
        dgvAssignatures.RowHeadersWidth = 51
        dgvAssignatures.Size = New Size(712, 110)
        dgvAssignatures.TabIndex = 5
        ' 
        ' Codigo
        ' 
        Codigo.FillWeight = 20F
        Codigo.HeaderText = "Codigo"
        Codigo.MinimumWidth = 6
        Codigo.Name = "Codigo"
        ' 
        ' Asignatura
        ' 
        Asignatura.FillWeight = 80F
        Asignatura.HeaderText = "Asignatura"
        Asignatura.MinimumWidth = 6
        Asignatura.Name = "Asignatura"
        ' 
        ' lblAsigTitle
        ' 
        lblAsigTitle.AutoSize = True
        lblAsigTitle.BackColor = Color.FromArgb(CByte(240), CByte(244), CByte(250))
        lblAsigTitle.Dock = DockStyle.Top
        lblAsigTitle.Font = New Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblAsigTitle.ForeColor = Color.FromArgb(CByte(30), CByte(60), CByte(100))
        lblAsigTitle.Location = New Point(20, 196)
        lblAsigTitle.Name = "lblAsigTitle"
        lblAsigTitle.Padding = New Padding(4, 0, 0, 0)
        lblAsigTitle.Size = New Size(97, 20)
        lblAsigTitle.TabIndex = 4
        lblAsigTitle.Text = "Asignaturas"
        lblAsigTitle.TextAlign = ContentAlignment.MiddleLeft
        ' 
        ' tbpContacte
        ' 
        tbpContacte.ColumnCount = 2
        tbpContacte.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 50F))
        tbpContacte.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 50F))
        tbpContacte.Controls.Add(lblPoblacio, 0, 2)
        tbpContacte.Controls.Add(lblEmail, 0, 0)
        tbpContacte.Controls.Add(lblDni, 0, 1)
        tbpContacte.Controls.Add(lblTelf, 1, 0)
        tbpContacte.Controls.Add(lblNaix, 1, 1)
        tbpContacte.Dock = DockStyle.Top
        tbpContacte.Location = New Point(20, 106)
        tbpContacte.Name = "tbpContacte"
        tbpContacte.Padding = New Padding(0, 8, 0, 8)
        tbpContacte.RowCount = 3
        tbpContacte.RowStyles.Add(New RowStyle(SizeType.Percent, 50F))
        tbpContacte.RowStyles.Add(New RowStyle(SizeType.Percent, 50F))
        tbpContacte.RowStyles.Add(New RowStyle(SizeType.Absolute, 20F))
        tbpContacte.Size = New Size(712, 90)
        tbpContacte.TabIndex = 3
        ' 
        ' lblPoblacio
        ' 
        lblPoblacio.AutoSize = True
        lblPoblacio.Location = New Point(3, 62)
        lblPoblacio.Name = "lblPoblacio"
        lblPoblacio.Size = New Size(77, 20)
        lblPoblacio.TabIndex = 8
        lblPoblacio.Text = "Población:"
        ' 
        ' lblEmail
        ' 
        lblEmail.AutoSize = True
        lblEmail.Location = New Point(3, 8)
        lblEmail.Name = "lblEmail"
        lblEmail.Size = New Size(49, 20)
        lblEmail.TabIndex = 4
        lblEmail.Text = "Email:"
        ' 
        ' lblDni
        ' 
        lblDni.AutoSize = True
        lblDni.Location = New Point(3, 35)
        lblDni.Name = "lblDni"
        lblDni.Size = New Size(38, 20)
        lblDni.TabIndex = 5
        lblDni.Text = "DNI:"
        ' 
        ' lblTelf
        ' 
        lblTelf.AutoSize = True
        lblTelf.Location = New Point(359, 8)
        lblTelf.Name = "lblTelf"
        lblTelf.Size = New Size(70, 20)
        lblTelf.TabIndex = 6
        lblTelf.Text = "Teléfono:"
        ' 
        ' lblNaix
        ' 
        lblNaix.AutoSize = True
        lblNaix.Location = New Point(359, 35)
        lblNaix.Name = "lblNaix"
        lblNaix.Size = New Size(89, 20)
        lblNaix.TabIndex = 7
        lblNaix.Text = "Nacimiento:"
        ' 
        ' pnlCap
        ' 
        pnlCap.Controls.Add(lblDedicacio)
        pnlCap.Controls.Add(lblRol)
        pnlCap.Controls.Add(lblNom)
        pnlCap.Controls.Add(pbFoto)
        pnlCap.Dock = DockStyle.Top
        pnlCap.Location = New Point(20, 16)
        pnlCap.Name = "pnlCap"
        pnlCap.Padding = New Padding(0, 0, 0, 10)
        pnlCap.Size = New Size(712, 90)
        pnlCap.TabIndex = 0
        ' 
        ' lblDedicacio
        ' 
        lblDedicacio.AutoSize = True
        lblDedicacio.Font = New Font("Segoe UI", 9F, FontStyle.Italic, GraphicsUnit.Point, CByte(0))
        lblDedicacio.ForeColor = Color.FromArgb(CByte(120), CByte(120), CByte(120))
        lblDedicacio.Location = New Point(88, 60)
        lblDedicacio.Name = "lblDedicacio"
        lblDedicacio.Size = New Size(51, 20)
        lblDedicacio.TabIndex = 1
        lblDedicacio.Text = "Label1"
        ' 
        ' lblRol
        ' 
        lblRol.AutoSize = True
        lblRol.ForeColor = SystemColors.WindowFrame
        lblRol.Location = New Point(88, 38)
        lblRol.Name = "lblRol"
        lblRol.Size = New Size(53, 20)
        lblRol.TabIndex = 2
        lblRol.Text = "Label1"
        ' 
        ' lblNom
        ' 
        lblNom.AutoSize = True
        lblNom.Font = New Font("Segoe UI", 12F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblNom.ForeColor = Color.FromArgb(CByte(20), CByte(50), CByte(90))
        lblNom.Location = New Point(86, 10)
        lblNom.Name = "lblNom"
        lblNom.Size = New Size(74, 28)
        lblNom.TabIndex = 1
        lblNom.Text = "Label1"
        ' 
        ' pbFoto
        ' 
        pbFoto.BackColor = Color.FromArgb(CByte(230), CByte(235), CByte(245))
        pbFoto.BorderStyle = BorderStyle.FixedSingle
        pbFoto.Location = New Point(0, 8)
        pbFoto.Name = "pbFoto"
        pbFoto.Size = New Size(70, 70)
        pbFoto.SizeMode = PictureBoxSizeMode.Zoom
        pbFoto.TabIndex = 0
        pbFoto.TabStop = False
        ' 
        ' FormFicha
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(982, 633)
        Controls.Add(pnlFitxa)
        Controls.Add(pnlLeft)
        Name = "FormFicha"
        StartPosition = FormStartPosition.CenterScreen
        Text = "Ficha profesor"
        pnlLeft.ResumeLayout(False)
        pnlLeft.PerformLayout()
        pnlFitxa.ResumeLayout(False)
        pnlFitxa.PerformLayout()
        CType(dgvAbsencies, ComponentModel.ISupportInitialize).EndInit()
        CType(dgvContractes, ComponentModel.ISupportInitialize).EndInit()
        CType(dgvAssignatures, ComponentModel.ISupportInitialize).EndInit()
        tbpContacte.ResumeLayout(False)
        tbpContacte.PerformLayout()
        pnlCap.ResumeLayout(False)
        pnlCap.PerformLayout()
        CType(pbFoto, ComponentModel.ISupportInitialize).EndInit()
        ResumeLayout(False)
    End Sub

    Friend WithEvents pnlLeft As Panel
    Friend WithEvents txtCerca As TextBox
    Friend WithEvents lblCercaTitol As Label
    Friend WithEvents sep As Panel
    Friend WithEvents lstProfessors As ListBox
    Friend WithEvents pnlFitxa As Panel
    Friend WithEvents pnlCap As Panel
    Friend WithEvents lblNom As Label
    Friend WithEvents pbFoto As PictureBox
    Friend WithEvents tbpContacte As TableLayoutPanel
    Friend WithEvents lblDedicacio As Label
    Friend WithEvents lblRol As Label
    Friend WithEvents lblEmail As Label
    Friend WithEvents lblDni As Label
    Friend WithEvents lblTelf As Label
    Friend WithEvents lblNaix As Label
    Friend WithEvents lblAsigTitle As Label
    Friend WithEvents lblPoblacio As Label
    Friend WithEvents dgvAssignatures As DataGridView
    Friend WithEvents Codigo As DataGridViewTextBoxColumn
    Friend WithEvents Asignatura As DataGridViewTextBoxColumn
    Friend WithEvents dgvContractes As DataGridView
    Friend WithEvents lblContractesTitle As Label
    Friend WithEvents Centro As DataGridViewTextBoxColumn
    Friend WithEvents Vinculacion As DataGridViewTextBoxColumn
    Friend WithEvents Fecha_alta As DataGridViewTextBoxColumn
    Friend WithEvents Fecha_baja As DataGridViewTextBoxColumn
    Friend WithEvents dgvAbsencies As DataGridView
    Friend WithEvents Tipo As DataGridViewTextBoxColumn
    Friend WithEvents Motivo As DataGridViewTextBoxColumn
    Friend WithEvents Justifcado As DataGridViewTextBoxColumn
    Friend WithEvents Justificante As DataGridViewTextBoxColumn
    Friend WithEvents lblAbsenciesTitle As Label
End Class
