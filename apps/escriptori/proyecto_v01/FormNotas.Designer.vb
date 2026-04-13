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
        pnlDgv = New Panel()
        pnlFoot = New Panel()
        Button1 = New Button()
        Button2 = New Button()
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
        pnlDgv.SuspendLayout()
        pnlFoot.SuspendLayout()
        CType(dgvEstudiants, ComponentModel.ISupportInitialize).BeginInit()
        tlpInfo.SuspendLayout()
        CType(pbProf, ComponentModel.ISupportInitialize).BeginInit()
        SuspendLayout()
        ' 
        ' pnlPrincipal
        ' 
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
        ' pnlDgv
        ' 
        pnlDgv.Anchor = AnchorStyles.Top Or AnchorStyles.Bottom Or AnchorStyles.Left Or AnchorStyles.Right
        pnlDgv.Controls.Add(pnlFoot)
        pnlDgv.Controls.Add(dgvEstudiants)
        pnlDgv.Location = New Point(0, 141)
        pnlDgv.Name = "pnlDgv"
        pnlDgv.Size = New Size(800, 309)
        pnlDgv.TabIndex = 9
        ' 
        ' pnlFoot
        ' 
        pnlFoot.BackColor = Color.White
        pnlFoot.Controls.Add(Button1)
        pnlFoot.Controls.Add(Button2)
        pnlFoot.Controls.Add(btnClose)
        pnlFoot.Controls.Add(btnSave)
        pnlFoot.Dock = DockStyle.Bottom
        pnlFoot.Location = New Point(0, 257)
        pnlFoot.Name = "pnlFoot"
        pnlFoot.Padding = New Padding(12, 8, 12, 8)
        pnlFoot.Size = New Size(800, 52)
        pnlFoot.TabIndex = 2
        ' 
        ' Button1
        ' 
        Button1.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        Button1.BackColor = Color.MistyRose
        Button1.Cursor = Cursors.Hand
        Button1.Enabled = False
        Button1.FlatStyle = FlatStyle.Flat
        Button1.Location = New Point(657, 11)
        Button1.Name = "Button1"
        Button1.Size = New Size(130, 36)
        Button1.TabIndex = 3
        Button1.Text = "Cerrar"
        Button1.UseVisualStyleBackColor = False
        ' 
        ' Button2
        ' 
        Button2.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        Button2.BackColor = Color.Azure
        Button2.Cursor = Cursors.Hand
        Button2.Enabled = False
        Button2.FlatStyle = FlatStyle.Flat
        Button2.Location = New Point(509, 11)
        Button2.Name = "Button2"
        Button2.Size = New Size(130, 36)
        Button2.TabIndex = 2
        Button2.Text = "Guardar"
        Button2.UseVisualStyleBackColor = False
        ' 
        ' btnClose
        ' 
        btnClose.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        btnClose.BackColor = Color.MistyRose
        btnClose.Cursor = Cursors.Hand
        btnClose.Enabled = False
        btnClose.FlatStyle = FlatStyle.Flat
        btnClose.Location = New Point(1358, 13)
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
        btnSave.Location = New Point(1210, 13)
        btnSave.Name = "btnSave"
        btnSave.Size = New Size(130, 36)
        btnSave.TabIndex = 0
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
        dgvEstudiants.EnableHeadersVisualStyles = False
        dgvEstudiants.GridColor = Color.FromArgb(CByte(230), CByte(230), CByte(230))
        dgvEstudiants.Location = New Point(0, 0)
        dgvEstudiants.MultiSelect = False
        dgvEstudiants.Name = "dgvEstudiants"
        dgvEstudiants.RowHeadersVisible = False
        dgvEstudiants.RowHeadersWidth = 51
        dgvEstudiants.SelectionMode = DataGridViewSelectionMode.FullRowSelect
        dgvEstudiants.Size = New Size(800, 309)
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
        Alumno.FillWeight = 150F
        Alumno.HeaderText = "Alumno"
        Alumno.MinimumWidth = 6
        Alumno.Name = "Alumno"
        Alumno.ReadOnly = True
        ' 
        ' Media
        ' 
        Media.FillWeight = 50F
        Media.HeaderText = "Media"
        Media.MinimumWidth = 6
        Media.Name = "Media"
        Media.ReadOnly = True
        ' 
        ' Estado
        ' 
        Estado.FillWeight = 50F
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
        lblHome.Location = New Point(613, 16)
        lblHome.Name = "lblHome"
        lblHome.Size = New Size(45, 20)
        lblHome.TabIndex = 2
        lblHome.Text = "Inicio"
        ' 
        ' FormNotas
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 450)
        Controls.Add(pnlPrincipal)
        Name = "FormNotas"
        StartPosition = FormStartPosition.CenterScreen
        Text = "Introducción de notas"
        pnlPrincipal.ResumeLayout(False)
        pnlPrincipal.PerformLayout()
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
    Friend WithEvents btnClose As Button
    Friend WithEvents btnSave As Button
    Friend WithEvents Button1 As Button
    Friend WithEvents Button2 As Button
End Class
