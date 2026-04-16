<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormNotas
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
        pnlPrincipal = New Panel()
        tlpCorrecion = New TableLayoutPanel()
        btnSaveC = New Button()
        btnCancelC = New Button()
        txtMotive = New TextBox()
        lblValue = New Label()
        txtValue = New TextBox()
        lblMotive = New Label()
        pnlDgv = New Panel()
        pnlFoot = New Panel()
        btnClose = New Button()
        btnSave = New Button()
        dgvEstudiants = New DataGridView()
        NIA = New DataGridViewTextBoxColumn()
        Alumno = New DataGridViewTextBoxColumn()
        Media = New DataGridViewTextBoxColumn()
        Estado = New DataGridViewTextBoxColumn()
        Comentarios = New DataGridViewTextBoxColumn()
        lblStatus = New Label()
        lblAsig = New Label()
        lblTitle = New Label()
        tlpInfo = New TableLayoutPanel()
        lblLogOut = New Label()
        pbProf = New PictureBox()
        lblName = New Label()
        lblHome = New Label()
        pnlPrincipal.SuspendLayout()
        tlpCorrecion.SuspendLayout()
        pnlDgv.SuspendLayout()
        pnlFoot.SuspendLayout()
        CType(dgvEstudiants, ComponentModel.ISupportInitialize).BeginInit()
        tlpInfo.SuspendLayout()
        CType(pbProf, ComponentModel.ISupportInitialize).BeginInit()
        SuspendLayout()
        ' 
        ' pnlPrincipal
        ' 
        pnlPrincipal.Controls.Add(tlpCorrecion)
        pnlPrincipal.Controls.Add(pnlDgv)
        pnlPrincipal.Controls.Add(lblStatus)
        pnlPrincipal.Controls.Add(lblAsig)
        pnlPrincipal.Controls.Add(lblTitle)
        pnlPrincipal.Controls.Add(tlpInfo)
        pnlPrincipal.Dock = DockStyle.Fill
        pnlPrincipal.Location = New Point(0, 0)
        pnlPrincipal.Name = "pnlPrincipal"
        pnlPrincipal.Size = New Size(800, 450)
        pnlPrincipal.TabIndex = 0
        ' 
        ' tlpCorrecion
        ' 
        tlpCorrecion.ColumnCount = 6
        tlpCorrecion.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 13.3584929F))
        tlpCorrecion.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 21.28387F))
        tlpCorrecion.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 13.4933214F))
        tlpCorrecion.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 17.288105F))
        tlpCorrecion.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 17.288105F))
        tlpCorrecion.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 17.288105F))
        tlpCorrecion.Controls.Add(btnSaveC, 4, 0)
        tlpCorrecion.Controls.Add(btnCancelC, 5, 0)
        tlpCorrecion.Controls.Add(txtMotive, 3, 0)
        tlpCorrecion.Controls.Add(lblValue, 0, 0)
        tlpCorrecion.Controls.Add(txtValue, 1, 0)
        tlpCorrecion.Controls.Add(lblMotive, 2, 0)
        tlpCorrecion.Location = New Point(0, 141)
        tlpCorrecion.Name = "tlpCorrecion"
        tlpCorrecion.RowCount = 1
        tlpCorrecion.RowStyles.Add(New RowStyle(SizeType.Percent, 100.0F))
        tlpCorrecion.Size = New Size(800, 35)
        tlpCorrecion.TabIndex = 3
        tlpCorrecion.Visible = False
        ' 
        ' btnSaveC
        ' 
        btnSaveC.Anchor = AnchorStyles.None
        btnSaveC.Location = New Point(543, 3)
        btnSaveC.Name = "btnSaveC"
        btnSaveC.Size = New Size(94, 29)
        btnSaveC.TabIndex = 6
        btnSaveC.Text = "Guardar corrección"
        btnSaveC.UseVisualStyleBackColor = True
        ' 
        ' btnCancelC
        ' 
        btnCancelC.Anchor = AnchorStyles.None
        btnCancelC.Location = New Point(682, 3)
        btnCancelC.Name = "btnCancelC"
        btnCancelC.Size = New Size(94, 29)
        btnCancelC.TabIndex = 5
        btnCancelC.Text = "Cancelar corrección"
        btnCancelC.UseVisualStyleBackColor = True
        ' 
        ' txtMotive
        ' 
        txtMotive.Anchor = AnchorStyles.None
        txtMotive.Location = New Point(389, 4)
        txtMotive.Name = "txtMotive"
        txtMotive.Size = New Size(125, 27)
        txtMotive.TabIndex = 3
        ' 
        ' lblValue
        ' 
        lblValue.Anchor = AnchorStyles.None
        lblValue.AutoSize = True
        lblValue.Location = New Point(7, 7)
        lblValue.Name = "lblValue"
        lblValue.Size = New Size(92, 20)
        lblValue.TabIndex = 0
        lblValue.Text = "Nuevo valor:"
        lblValue.TextAlign = ContentAlignment.MiddleCenter
        ' 
        ' txtValue
        ' 
        txtValue.Anchor = AnchorStyles.None
        txtValue.Location = New Point(128, 4)
        txtValue.Name = "txtValue"
        txtValue.Size = New Size(125, 27)
        txtValue.TabIndex = 1
        ' 
        ' lblMotive
        ' 
        lblMotive.Anchor = AnchorStyles.None
        lblMotive.AutoSize = True
        lblMotive.Location = New Point(300, 7)
        lblMotive.Name = "lblMotive"
        lblMotive.Size = New Size(59, 20)
        lblMotive.TabIndex = 2
        lblMotive.Text = "Motivo:"
        ' 
        ' pnlDgv
        ' 
        pnlDgv.Anchor = AnchorStyles.Top Or AnchorStyles.Bottom Or AnchorStyles.Left Or AnchorStyles.Right
        pnlDgv.Controls.Add(pnlFoot)
        pnlDgv.Controls.Add(dgvEstudiants)
        pnlDgv.Location = New Point(0, 179)
        pnlDgv.Name = "pnlDgv"
        pnlDgv.Size = New Size(800, 271)
        pnlDgv.TabIndex = 9
        ' 
        ' pnlFoot
        ' 
        pnlFoot.BackColor = Color.White
        pnlFoot.Controls.Add(btnClose)
        pnlFoot.Controls.Add(btnSave)
        pnlFoot.Dock = DockStyle.Bottom
        pnlFoot.Location = New Point(0, 219)
        pnlFoot.Name = "pnlFoot"
        pnlFoot.Padding = New Padding(12, 8, 12, 8)
        pnlFoot.Size = New Size(800, 52)
        pnlFoot.TabIndex = 2
        ' 
        ' btnClose
        ' 
        btnClose.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        btnClose.BackColor = Color.MistyRose
        btnClose.Cursor = Cursors.Hand
        btnClose.Enabled = False
        btnClose.FlatStyle = FlatStyle.Flat
        btnClose.Location = New Point(655, 11)
        btnClose.Name = "btnClose"
        btnClose.Size = New Size(130, 36)
        btnClose.TabIndex = 3
        btnClose.Text = "Cerrar"
        btnClose.UseVisualStyleBackColor = False
        ' 
        ' btnSave
        ' 
        btnSave.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        btnSave.BackColor = Color.Azure
        btnSave.Cursor = Cursors.Hand
        btnSave.FlatStyle = FlatStyle.Flat
        btnSave.Location = New Point(509, 11)
        btnSave.Name = "btnSave"
        btnSave.Size = New Size(130, 36)
        btnSave.TabIndex = 2
        btnSave.Text = "Guardar"
        btnSave.UseVisualStyleBackColor = False
        ' 
        ' dgvEstudiants
        ' 
        dgvEstudiants.AllowUserToAddRows = False
        dgvEstudiants.AllowUserToDeleteRows = False
        DataGridViewCellStyle1.BackColor = Color.FromArgb(CByte(250), CByte(250), CByte(252))
        dgvEstudiants.AlternatingRowsDefaultCellStyle = DataGridViewCellStyle1
        dgvEstudiants.Anchor = AnchorStyles.Top Or AnchorStyles.Bottom Or AnchorStyles.Left Or AnchorStyles.Right
        dgvEstudiants.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dgvEstudiants.BackgroundColor = Color.White
        dgvEstudiants.BorderStyle = BorderStyle.None
        dgvEstudiants.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal
        DataGridViewCellStyle2.Alignment = DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = Color.WhiteSmoke
        DataGridViewCellStyle2.Font = New Font("Segoe UI", 9.0F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        DataGridViewCellStyle2.ForeColor = Color.FromArgb(CByte(60), CByte(60), CByte(60))
        DataGridViewCellStyle2.Padding = New Padding(6, 0, 0, 0)
        DataGridViewCellStyle2.SelectionBackColor = SystemColors.ActiveCaption
        DataGridViewCellStyle2.SelectionForeColor = SystemColors.ControlText
        DataGridViewCellStyle2.WrapMode = DataGridViewTriState.True
        dgvEstudiants.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle2
        dgvEstudiants.ColumnHeadersHeight = 36
        dgvEstudiants.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.DisableResizing
        dgvEstudiants.Columns.AddRange(New DataGridViewColumn() {NIA, Alumno, Media, Estado, Comentarios})
        DataGridViewCellStyle3.Alignment = DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle3.BackColor = Color.White
        DataGridViewCellStyle3.Font = New Font("Segoe UI", 9.0F)
        DataGridViewCellStyle3.ForeColor = Color.FromArgb(CByte(40), CByte(40), CByte(40))
        DataGridViewCellStyle3.Padding = New Padding(6, 0, 0, 0)
        DataGridViewCellStyle3.SelectionBackColor = SystemColors.GradientActiveCaption
        DataGridViewCellStyle3.SelectionForeColor = Color.Black
        DataGridViewCellStyle3.WrapMode = DataGridViewTriState.False
        dgvEstudiants.DefaultCellStyle = DataGridViewCellStyle3
        dgvEstudiants.EnableHeadersVisualStyles = False
        dgvEstudiants.GridColor = Color.FromArgb(CByte(230), CByte(230), CByte(230))
        dgvEstudiants.Location = New Point(0, 3)
        dgvEstudiants.MultiSelect = False
        dgvEstudiants.Name = "dgvEstudiants"
        dgvEstudiants.RowHeadersVisible = False
        dgvEstudiants.RowHeadersWidth = 51
        dgvEstudiants.SelectionMode = DataGridViewSelectionMode.FullRowSelect
        dgvEstudiants.Size = New Size(800, 268)
        dgvEstudiants.TabIndex = 1
        ' 
        ' NIA
        ' 
        NIA.HeaderText = "NIA"
        NIA.MinimumWidth = 6
        NIA.Name = "NIA"
        NIA.Visible = False
        ' 
        ' Alumno
        ' 
        Alumno.FillWeight = 150.0F
        Alumno.HeaderText = "Alumno"
        Alumno.MinimumWidth = 6
        Alumno.Name = "Alumno"
        Alumno.ReadOnly = True
        ' 
        ' Media
        ' 
        Media.FillWeight = 50.0F
        Media.HeaderText = "Media"
        Media.MinimumWidth = 6
        Media.Name = "Media"
        Media.ReadOnly = True
        ' 
        ' Estado
        ' 
        Estado.FillWeight = 50.0F
        Estado.HeaderText = "Estado"
        Estado.MinimumWidth = 6
        Estado.Name = "Estado"
        Estado.ReadOnly = True
        ' 
        ' Comentarios
        ' 
        Comentarios.HeaderText = "Comentarios"
        Comentarios.MinimumWidth = 6
        Comentarios.Name = "Comentarios"
        Comentarios.ReadOnly = True
        ' 
        ' lblStatus
        ' 
        lblStatus.AutoSize = True
        lblStatus.Dock = DockStyle.Top
        lblStatus.Location = New Point(0, 98)
        lblStatus.Name = "lblStatus"
        lblStatus.Padding = New Padding(0, 20, 0, 0)
        lblStatus.Size = New Size(135, 40)
        lblStatus.TabIndex = 8
        lblStatus.Text = "Estado: Cargando..."
        ' 
        ' lblAsig
        ' 
        lblAsig.AutoSize = True
        lblAsig.Dock = DockStyle.Top
        lblAsig.ForeColor = Color.DimGray
        lblAsig.Location = New Point(0, 78)
        lblAsig.Name = "lblAsig"
        lblAsig.Size = New Size(122, 20)
        lblAsig.TabIndex = 7
        lblAsig.Text = "Asignatura, curso"
        ' 
        ' lblTitle
        ' 
        lblTitle.AutoSize = True
        lblTitle.Dock = DockStyle.Top
        lblTitle.Font = New Font("Segoe UI", 10.8F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblTitle.Location = New Point(0, 53)
        lblTitle.Name = "lblTitle"
        lblTitle.Size = New Size(199, 25)
        lblTitle.TabIndex = 5
        lblTitle.Text = "Introducción de notas"
        ' 
        ' tlpInfo
        ' 
        tlpInfo.ColumnCount = 4
        tlpInfo.ColumnStyles.Add(New ColumnStyle(SizeType.Absolute, 80.0F))
        tlpInfo.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 70.70707F))
        tlpInfo.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 13.1313133F))
        tlpInfo.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 16.1616154F))
        tlpInfo.Controls.Add(lblLogOut, 3, 0)
        tlpInfo.Controls.Add(pbProf, 0, 0)
        tlpInfo.Controls.Add(lblName, 1, 0)
        tlpInfo.Controls.Add(lblHome, 2, 0)
        tlpInfo.Dock = DockStyle.Top
        tlpInfo.Location = New Point(0, 0)
        tlpInfo.Name = "tlpInfo"
        tlpInfo.RowCount = 1
        tlpInfo.RowStyles.Add(New RowStyle(SizeType.Percent, 100.0F))
        tlpInfo.Size = New Size(800, 53)
        tlpInfo.TabIndex = 4
        ' 
        ' lblLogOut
        ' 
        lblLogOut.Anchor = AnchorStyles.None
        lblLogOut.AutoSize = True
        lblLogOut.Location = New Point(694, 16)
        lblLogOut.Name = "lblLogOut"
        lblLogOut.Size = New Size(94, 20)
        lblLogOut.TabIndex = 3
        lblLogOut.Text = "Cerrar sesión"
        ' 
        ' pbProf
        ' 
        pbProf.Dock = DockStyle.Fill
        pbProf.Location = New Point(3, 3)
        pbProf.Name = "pbProf"
        pbProf.Size = New Size(74, 47)
        pbProf.TabIndex = 0
        pbProf.TabStop = False
        ' 
        ' lblName
        ' 
        lblName.Anchor = AnchorStyles.Left
        lblName.AutoSize = True
        lblName.Font = New Font("Segoe UI", 9.0F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblName.ForeColor = Color.LightSlateGray
        lblName.Location = New Point(83, 16)
        lblName.Name = "lblName"
        lblName.Size = New Size(67, 20)
        lblName.TabIndex = 1
        lblName.Text = "Nombre"
        ' 
        ' lblHome
        ' 
        lblHome.Anchor = AnchorStyles.None
        lblHome.AutoSize = True
        lblHome.Location = New Point(613, 16)
        lblHome.Name = "lblHome"
        lblHome.Size = New Size(45, 20)
        lblHome.TabIndex = 2
        lblHome.Text = "Inicio"
        ' 
        ' FormNotas
        ' 
        AutoScaleDimensions = New SizeF(8.0F, 20.0F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 450)
        Controls.Add(pnlPrincipal)
        Name = "FormNotas"
        StartPosition = FormStartPosition.CenterScreen
        Text = "Introducción de notas"
        pnlPrincipal.ResumeLayout(False)
        pnlPrincipal.PerformLayout()
        tlpCorrecion.ResumeLayout(False)
        tlpCorrecion.PerformLayout()
        pnlDgv.ResumeLayout(False)
        pnlFoot.ResumeLayout(False)
        CType(dgvEstudiants, ComponentModel.ISupportInitialize).EndInit()
        tlpInfo.ResumeLayout(False)
        tlpInfo.PerformLayout()
        CType(pbProf, ComponentModel.ISupportInitialize).EndInit()
        ResumeLayout(False)
    End Sub

    Friend WithEvents pnlPrincipal As Panel
    Friend WithEvents lblStatus As Label
    Friend WithEvents lblAsig As Label
    Friend WithEvents lblTitle As Label
    Friend WithEvents tlpInfo As TableLayoutPanel
    Friend WithEvents lblLogOut As Label
    Friend WithEvents pbProf As PictureBox
    Friend WithEvents lblName As Label
    Friend WithEvents lblHome As Label
    Friend WithEvents pnlDgv As Panel
    Friend WithEvents dgvEstudiants As DataGridView
    Friend WithEvents NIA As DataGridViewTextBoxColumn
    Friend WithEvents Alumno As DataGridViewTextBoxColumn
    Friend WithEvents Media As DataGridViewTextBoxColumn
    Friend WithEvents Estado As DataGridViewTextBoxColumn
    Friend WithEvents Comentarios As DataGridViewTextBoxColumn
    Friend WithEvents pnlFoot As Panel
    Friend WithEvents Button1 As Button
    Friend WithEvents btnSave As Button
    Friend WithEvents btnClose As Button
    Friend WithEvents tlpCorrecion As TableLayoutPanel
    Friend WithEvents lblValue As Label
    Friend WithEvents btnCancelC As Button
    Friend WithEvents txtMotive As TextBox
    Friend WithEvents txtValue As TextBox
    Friend WithEvents lblMotive As Label
    Friend WithEvents btnSaveC As Button
End Class
