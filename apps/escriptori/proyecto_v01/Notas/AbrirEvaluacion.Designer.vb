<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class AbrirEvaluacion
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
        dgvPeriodes = New DataGridView()
        Trimestre = New DataGridViewTextBoxColumn()
        Curso = New DataGridViewTextBoxColumn()
        Estado = New DataGridViewTextBoxColumn()
        Empezado = New DataGridViewTextBoxColumn()
        Cerrado = New DataGridViewTextBoxColumn()
        AbiertaPor = New DataGridViewTextBoxColumn()
        pnlButtons = New FlowLayoutPanel()
        lblTitle = New Label()
        btnOpen = New Button()
        btnClose = New Button()
        btnUpdate = New Button()
        lblStatus = New Label()
        CType(dgvPeriodes, ComponentModel.ISupportInitialize).BeginInit()
        pnlButtons.SuspendLayout()
        SuspendLayout()
        ' 
        ' dgvPeriodes
        ' 
        dgvPeriodes.AllowUserToAddRows = False
        dgvPeriodes.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill
        dgvPeriodes.BorderStyle = BorderStyle.None
        DataGridViewCellStyle1.Alignment = DataGridViewContentAlignment.MiddleLeft
        DataGridViewCellStyle1.BackColor = SystemColors.Control
        DataGridViewCellStyle1.Font = New Font("Segoe UI", 9F, FontStyle.Bold)
        DataGridViewCellStyle1.ForeColor = SystemColors.WindowText
        DataGridViewCellStyle1.SelectionBackColor = SystemColors.Highlight
        DataGridViewCellStyle1.SelectionForeColor = SystemColors.HighlightText
        DataGridViewCellStyle1.WrapMode = DataGridViewTriState.True
        dgvPeriodes.ColumnHeadersDefaultCellStyle = DataGridViewCellStyle1
        dgvPeriodes.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize
        dgvPeriodes.Columns.AddRange(New DataGridViewColumn() {Trimestre, Curso, Estado, Empezado, Cerrado, AbiertaPor})
        dgvPeriodes.Dock = DockStyle.Fill
        dgvPeriodes.EnableHeadersVisualStyles = False
        dgvPeriodes.Location = New Point(0, 0)
        dgvPeriodes.MultiSelect = False
        dgvPeriodes.Name = "dgvPeriodes"
        dgvPeriodes.ReadOnly = True
        dgvPeriodes.RowHeadersVisible = False
        dgvPeriodes.RowHeadersWidth = 51
        dgvPeriodes.SelectionMode = DataGridViewSelectionMode.FullRowSelect
        dgvPeriodes.Size = New Size(897, 533)
        dgvPeriodes.TabIndex = 0
        ' 
        ' Trimestre
        ' 
        Trimestre.FillWeight = 20F
        Trimestre.HeaderText = "Trimestre"
        Trimestre.MinimumWidth = 6
        Trimestre.Name = "Trimestre"
        Trimestre.ReadOnly = True
        ' 
        ' Curso
        ' 
        Curso.FillWeight = 15F
        Curso.HeaderText = "Curso"
        Curso.MinimumWidth = 6
        Curso.Name = "Curso"
        Curso.ReadOnly = True
        ' 
        ' Estado
        ' 
        Estado.FillWeight = 12F
        Estado.HeaderText = "Estado"
        Estado.MinimumWidth = 6
        Estado.Name = "Estado"
        Estado.ReadOnly = True
        ' 
        ' Empezado
        ' 
        Empezado.FillWeight = 25F
        Empezado.HeaderText = "Fecha inicio"
        Empezado.MinimumWidth = 6
        Empezado.Name = "Empezado"
        Empezado.ReadOnly = True
        ' 
        ' Cerrado
        ' 
        Cerrado.FillWeight = 25F
        Cerrado.HeaderText = "Fecha cierre"
        Cerrado.MinimumWidth = 6
        Cerrado.Name = "Cerrado"
        Cerrado.ReadOnly = True
        ' 
        ' AbiertaPor
        ' 
        AbiertaPor.FillWeight = 25F
        AbiertaPor.HeaderText = "Iniciado por"
        AbiertaPor.MinimumWidth = 6
        AbiertaPor.Name = "AbiertaPor"
        AbiertaPor.ReadOnly = True
        ' 
        ' pnlButtons
        ' 
        pnlButtons.Controls.Add(lblTitle)
        pnlButtons.Controls.Add(btnOpen)
        pnlButtons.Controls.Add(btnClose)
        pnlButtons.Controls.Add(btnUpdate)
        pnlButtons.Dock = DockStyle.Bottom
        pnlButtons.Location = New Point(0, 473)
        pnlButtons.Name = "pnlButtons"
        pnlButtons.Padding = New Padding(8)
        pnlButtons.Size = New Size(897, 60)
        pnlButtons.TabIndex = 1
        ' 
        ' lblTitle
        ' 
        lblTitle.Anchor = AnchorStyles.Right
        lblTitle.AutoSize = True
        lblTitle.Font = New Font("Segoe UI", 9F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblTitle.Location = New Point(11, 17)
        lblTitle.Name = "lblTitle"
        lblTitle.Padding = New Padding(4, 0, 0, 0)
        lblTitle.Size = New Size(173, 20)
        lblTitle.TabIndex = 3
        lblTitle.Text = "Periodos de evaluación"
        lblTitle.TextAlign = ContentAlignment.MiddleLeft
        ' 
        ' btnOpen
        ' 
        btnOpen.Location = New Point(190, 11)
        btnOpen.Name = "btnOpen"
        btnOpen.Size = New Size(130, 32)
        btnOpen.TabIndex = 0
        btnOpen.Text = "Abrir periodo"
        btnOpen.UseVisualStyleBackColor = True
        ' 
        ' btnClose
        ' 
        btnClose.Location = New Point(326, 11)
        btnClose.Name = "btnClose"
        btnClose.Size = New Size(130, 32)
        btnClose.TabIndex = 1
        btnClose.Text = "Cerrar periodo"
        btnClose.UseVisualStyleBackColor = True
        ' 
        ' btnUpdate
        ' 
        btnUpdate.Location = New Point(462, 11)
        btnUpdate.Name = "btnUpdate"
        btnUpdate.Size = New Size(130, 32)
        btnUpdate.TabIndex = 2
        btnUpdate.Text = "Actualizar"
        btnUpdate.UseVisualStyleBackColor = True
        ' 
        ' lblStatus
        ' 
        lblStatus.AutoSize = True
        lblStatus.Dock = DockStyle.Bottom
        lblStatus.ForeColor = Color.DimGray
        lblStatus.Location = New Point(0, 453)
        lblStatus.Name = "lblStatus"
        lblStatus.Size = New Size(83, 20)
        lblStatus.TabIndex = 2
        lblStatus.Text = "Cargando..."
        lblStatus.TextAlign = ContentAlignment.MiddleLeft
        ' 
        ' AbrirEvaluacion
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        Controls.Add(lblStatus)
        Controls.Add(pnlButtons)
        Controls.Add(dgvPeriodes)
        Name = "AbrirEvaluacion"
        Size = New Size(897, 533)
        CType(dgvPeriodes, ComponentModel.ISupportInitialize).EndInit()
        pnlButtons.ResumeLayout(False)
        pnlButtons.PerformLayout()
        ResumeLayout(False)
        PerformLayout()
    End Sub

    Friend WithEvents dgvPeriodes As DataGridView
    Friend WithEvents pnlButtons As FlowLayoutPanel
    Friend WithEvents btnOpen As Button
    Friend WithEvents btnClose As Button
    Friend WithEvents btnUpdate As Button
    Friend WithEvents lblStatus As Label
    Friend WithEvents lblTitle As Label
    Friend WithEvents Trimestre As DataGridViewTextBoxColumn
    Friend WithEvents Curso As DataGridViewTextBoxColumn
    Friend WithEvents Estado As DataGridViewTextBoxColumn
    Friend WithEvents Empezado As DataGridViewTextBoxColumn
    Friend WithEvents Cerrado As DataGridViewTextBoxColumn
    Friend WithEvents AbiertaPor As DataGridViewTextBoxColumn

End Class
