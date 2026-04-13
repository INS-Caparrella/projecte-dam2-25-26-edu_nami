<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class IntroducirNotas
    Inherits System.Windows.Forms.UserControl

    'UserControl reemplaza a Dispose para limpiar la lista de componentes.
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
        tlpInfo = New TableLayoutPanel()
        lblLogOut = New Label()
        pbProf = New PictureBox()
        lblName = New Label()
        lblHome = New Label()
        lblTitle = New Label()
        lblAsig = New Label()
        lblStatus = New Label()
        pnlDgv = New Panel()
        pnlFoot = New Panel()
        btnClose = New Button()
        btnSave = New Button()
        sep = New Panel()
        dgvEstudiants = New DataGridView()
        NIA = New DataGridViewTextBoxColumn()
        Alumno = New DataGridViewTextBoxColumn()
        Media = New DataGridViewTextBoxColumn()
        Estado = New DataGridViewTextBoxColumn()
        Comentarios = New DataGridViewTextBoxColumn()
        tlpInfo.SuspendLayout()
        CType(pbProf, ComponentModel.ISupportInitialize).BeginInit()
        pnlDgv.SuspendLayout()
        pnlFoot.SuspendLayout()
        CType(dgvEstudiants, ComponentModel.ISupportInitialize).BeginInit()
        SuspendLayout()
        ' 
        ' tlpInfo
        ' 
        tlpInfo.ColumnCount = 4
        tlpInfo.ColumnStyles.Add(New ColumnStyle(SizeType.Absolute, 80F))
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
        tlpInfo.RowStyles.Add(New RowStyle(SizeType.Percent, 100F))
        tlpInfo.Size = New Size(922, 53)
        tlpInfo.TabIndex = 0
        ' 
        ' lblLogOut
        ' 
        lblLogOut.Anchor = AnchorStyles.None
        lblLogOut.AutoSize = True
        lblLogOut.Location = New Point(806, 16)
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
        lblName.Font = New Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
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
        lblHome.Location = New Point(707, 16)
        lblHome.Name = "lblHome"
        lblHome.Size = New Size(45, 20)
        lblHome.TabIndex = 2
        lblHome.Text = "Inicio"
        ' 
        ' lblTitle
        ' 
        lblTitle.AutoSize = True
        lblTitle.Dock = DockStyle.Top
        lblTitle.Font = New Font("Segoe UI", 10.8F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblTitle.Location = New Point(0, 53)
        lblTitle.Name = "lblTitle"
        lblTitle.Size = New Size(199, 25)
        lblTitle.TabIndex = 1
        lblTitle.Text = "Introducción de notas"
        ' 
        ' lblAsig
        ' 
        lblAsig.AutoSize = True
        lblAsig.Dock = DockStyle.Top
        lblAsig.ForeColor = Color.DimGray
        lblAsig.Location = New Point(0, 78)
        lblAsig.Name = "lblAsig"
        lblAsig.Size = New Size(122, 20)
        lblAsig.TabIndex = 2
        lblAsig.Text = "Asignatura, curso"
        ' 
        ' lblStatus
        ' 
        lblStatus.AutoSize = True
        lblStatus.Dock = DockStyle.Top
        lblStatus.Location = New Point(0, 98)
        lblStatus.Name = "lblStatus"
        lblStatus.Padding = New Padding(0, 20, 0, 0)
        lblStatus.Size = New Size(135, 40)
        lblStatus.TabIndex = 3
        lblStatus.Text = "Estado: Cargando..."
        ' 
        ' pnlDgv
        ' 
        pnlDgv.Anchor = AnchorStyles.Top Or AnchorStyles.Bottom Or AnchorStyles.Left Or AnchorStyles.Right
        pnlDgv.Controls.Add(pnlFoot)
        pnlDgv.Controls.Add(sep)
        pnlDgv.Controls.Add(dgvEstudiants)
        pnlDgv.Location = New Point(0, 192)
        pnlDgv.Name = "pnlDgv"
        pnlDgv.Size = New Size(922, 359)
        pnlDgv.TabIndex = 2
        ' 
        ' pnlFoot
        ' 
        pnlFoot.BackColor = Color.White
        pnlFoot.Controls.Add(btnClose)
        pnlFoot.Controls.Add(btnSave)
        pnlFoot.Dock = DockStyle.Bottom
        pnlFoot.Location = New Point(0, 306)
        pnlFoot.Name = "pnlFoot"
        pnlFoot.Padding = New Padding(12, 8, 12, 8)
        pnlFoot.Size = New Size(922, 52)
        pnlFoot.TabIndex = 0
        ' 
        ' btnClose
        ' 
        btnClose.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        btnClose.BackColor = Color.MistyRose
        btnClose.Cursor = Cursors.Hand
        btnClose.Enabled = False
        btnClose.FlatStyle = FlatStyle.Flat
        btnClose.Location = New Point(770, 5)
        btnClose.Name = "btnClose"
        btnClose.Size = New Size(130, 36)
        btnClose.TabIndex = 1
        btnClose.Text = "Cerrar"
        btnClose.UseVisualStyleBackColor = False
        ' 
        ' btnSave
        ' 
        btnSave.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        btnSave.BackColor = Color.Azure
        btnSave.Cursor = Cursors.Hand
        btnSave.Enabled = False
        btnSave.FlatStyle = FlatStyle.Flat
        btnSave.Location = New Point(622, 5)
        btnSave.Name = "btnSave"
        btnSave.Size = New Size(130, 36)
        btnSave.TabIndex = 0
        btnSave.Text = "Guardar"
        btnSave.UseVisualStyleBackColor = False
        ' 
        ' sep
        ' 
        sep.BackColor = Color.Gainsboro
        sep.Dock = DockStyle.Bottom
        sep.Location = New Point(0, 358)
        sep.Name = "sep"
        sep.Size = New Size(922, 1)
        sep.TabIndex = 1
        ' 
        ' dgvEstudiants
        ' 
        dgvEstudiants.AllowUserToAddRows = False
        dgvEstudiants.AllowUserToDeleteRows = False
        DataGridViewCellStyle1.BackColor = Color.FromArgb(CByte(250), CByte(250), CByte(252))
        dgvEstudiants.AlternatingRowsDefaultCellStyle = DataGridViewCellStyle1
        dgvEstudiants.BackgroundColor = Color.White
        dgvEstudiants.BorderStyle = BorderStyle.None
        dgvEstudiants.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal
        DataGridViewCellStyle2.Alignment = DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle2.BackColor = Color.WhiteSmoke
        DataGridViewCellStyle2.Font = New Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
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
        DataGridViewCellStyle3.Font = New Font("Segoe UI", 9F)
        DataGridViewCellStyle3.ForeColor = Color.FromArgb(CByte(40), CByte(40), CByte(40))
        DataGridViewCellStyle3.Padding = New Padding(6, 0, 0, 0)
        DataGridViewCellStyle3.SelectionBackColor = SystemColors.GradientActiveCaption
        DataGridViewCellStyle3.SelectionForeColor = Color.Black
        DataGridViewCellStyle3.WrapMode = DataGridViewTriState.False
        dgvEstudiants.DefaultCellStyle = DataGridViewCellStyle3
        dgvEstudiants.Dock = DockStyle.Fill
        dgvEstudiants.EnableHeadersVisualStyles = False
        dgvEstudiants.GridColor = Color.FromArgb(CByte(230), CByte(230), CByte(230))
        dgvEstudiants.Location = New Point(0, 0)
        dgvEstudiants.MultiSelect = False
        dgvEstudiants.Name = "dgvEstudiants"
        dgvEstudiants.RowHeadersVisible = False
        dgvEstudiants.RowHeadersWidth = 51
        dgvEstudiants.SelectionMode = DataGridViewSelectionMode.FullRowSelect
        dgvEstudiants.Size = New Size(922, 359)
        dgvEstudiants.TabIndex = 0
        ' 
        ' NIA
        ' 
        NIA.HeaderText = "NIA"
        NIA.MinimumWidth = 6
        NIA.Name = "NIA"
        NIA.Visible = False
        NIA.Width = 125
        ' 
        ' Alumno
        ' 
        Alumno.FillWeight = 20F
        Alumno.HeaderText = "Alumno"
        Alumno.MinimumWidth = 6
        Alumno.Name = "Alumno"
        Alumno.ReadOnly = True
        Alumno.Width = 395
        ' 
        ' Media
        ' 
        Media.FillWeight = 10F
        Media.HeaderText = "Media"
        Media.MinimumWidth = 6
        Media.Name = "Media"
        Media.ReadOnly = True
        Media.Width = 132
        ' 
        ' Estado
        ' 
        Estado.FillWeight = 10F
        Estado.HeaderText = "Estado"
        Estado.MinimumWidth = 6
        Estado.Name = "Estado"
        Estado.ReadOnly = True
        Estado.Width = 132
        ' 
        ' Comentarios
        ' 
        Comentarios.FillWeight = 20F
        Comentarios.HeaderText = "Comentarios"
        Comentarios.MinimumWidth = 6
        Comentarios.Name = "Comentarios"
        Comentarios.ReadOnly = True
        Comentarios.Width = 263
        ' 
        ' IntroducirNotas
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        Controls.Add(lblStatus)
        Controls.Add(pnlDgv)
        Controls.Add(lblAsig)
        Controls.Add(lblTitle)
        Controls.Add(tlpInfo)
        Name = "IntroducirNotas"
        Size = New Size(922, 554)
        tlpInfo.ResumeLayout(False)
        tlpInfo.PerformLayout()
        CType(pbProf, ComponentModel.ISupportInitialize).EndInit()
        pnlDgv.ResumeLayout(False)
        pnlFoot.ResumeLayout(False)
        CType(dgvEstudiants, ComponentModel.ISupportInitialize).EndInit()
        ResumeLayout(False)
        PerformLayout()
    End Sub

    Friend WithEvents tlpInfo As TableLayoutPanel
    Friend WithEvents lblLogOut As Label
    Friend WithEvents pbProf As PictureBox
    Friend WithEvents lblName As Label
    Friend WithEvents lblHome As Label
    Friend WithEvents lblTitle As Label
    Friend WithEvents lblAsig As Label
    Friend WithEvents lblStatus As Label
    Friend WithEvents pnlDgv As Panel
    Friend WithEvents dgvEstudiants As DataGridView
    Friend WithEvents pnlFoot As Panel
    Friend WithEvents btnSave As Button
    Friend WithEvents sep As Panel
    Friend WithEvents btnClose As Button
    Friend WithEvents NIA As DataGridViewTextBoxColumn
    Friend WithEvents Alumno As DataGridViewTextBoxColumn
    Friend WithEvents Media As DataGridViewTextBoxColumn
    Friend WithEvents Estado As DataGridViewTextBoxColumn
    Friend WithEvents Comentarios As DataGridViewTextBoxColumn

End Class
