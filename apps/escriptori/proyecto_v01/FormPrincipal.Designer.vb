<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FormPrincipal
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormPrincipal))
        pnlPrincipal = New Panel()
        tsMenuPrincipal = New ToolStrip()
        btnGrades = New ToolStripButton()
        btnOpenT = New ToolStripButton()
        btnOrlas = New ToolStripButton()
        btnDownload = New ToolStripButton()
        pbPicture = New PictureBox()
        tlpInfoP = New TableLayoutPanel()
        lblName = New Label()
        lblRol = New Label()
        tsMenuPrincipal.SuspendLayout()
        CType(pbPicture, ComponentModel.ISupportInitialize).BeginInit()
        tlpInfoP.SuspendLayout()
        SuspendLayout()
        ' 
        ' pnlPrincipal
        ' 
        pnlPrincipal.Anchor = AnchorStyles.Top Or AnchorStyles.Bottom Or AnchorStyles.Left Or AnchorStyles.Right
        pnlPrincipal.Location = New Point(25, 65)
        pnlPrincipal.Name = "pnlPrincipal"
        pnlPrincipal.Size = New Size(775, 385)
        pnlPrincipal.TabIndex = 0
        ' 
        ' tsMenuPrincipal
        ' 
        tsMenuPrincipal.Dock = DockStyle.Left
        tsMenuPrincipal.ImageScalingSize = New Size(20, 20)
        tsMenuPrincipal.Items.AddRange(New ToolStripItem() {btnGrades, btnOpenT, btnOrlas, btnDownload})
        tsMenuPrincipal.Location = New Point(0, 0)
        tsMenuPrincipal.Name = "tsMenuPrincipal"
        tsMenuPrincipal.Size = New Size(40, 450)
        tsMenuPrincipal.TabIndex = 14
        tsMenuPrincipal.Text = "Menú"
        tsMenuPrincipal.TextDirection = ToolStripTextDirection.Vertical90
        ' 
        ' btnGrades
        ' 
        btnGrades.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnGrades.Image = CType(resources.GetObject("btnGrades.Image"), Image)
        btnGrades.ImageTransparentColor = Color.Magenta
        btnGrades.Name = "btnGrades"
        btnGrades.Size = New Size(37, 24)
        btnGrades.Text = "Introducir notas"
        ' 
        ' btnOpenT
        ' 
        btnOpenT.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnOpenT.Image = CType(resources.GetObject("btnOpenT.Image"), Image)
        btnOpenT.ImageTransparentColor = Color.Magenta
        btnOpenT.Name = "btnOpenT"
        btnOpenT.Size = New Size(37, 24)
        btnOpenT.Text = "Gestionar período evaluación"
        ' 
        ' btnOrlas
        ' 
        btnOrlas.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnOrlas.Image = CType(resources.GetObject("btnOrlas.Image"), Image)
        btnOrlas.ImageTransparentColor = Color.Magenta
        btnOrlas.Name = "btnOrlas"
        btnOrlas.Size = New Size(37, 24)
        btnOrlas.Text = "Ver la orla de profesores"
        ' 
        ' btnDownload
        ' 
        btnDownload.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnDownload.Image = CType(resources.GetObject("btnDownload.Image"), Image)
        btnDownload.ImageTransparentColor = Color.Magenta
        btnDownload.Name = "btnDownload"
        btnDownload.Size = New Size(37, 24)
        btnDownload.Text = "Descargar PDF"
        ' 
        ' pbPicture
        ' 
        pbPicture.Anchor = AnchorStyles.None
        pbPicture.Location = New Point(723, 3)
        pbPicture.Name = "pbPicture"
        pbPicture.Size = New Size(77, 59)
        pbPicture.TabIndex = 13
        pbPicture.TabStop = False
        ' 
        ' tlpInfoP
        ' 
        tlpInfoP.ColumnCount = 1
        tlpInfoP.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 100F))
        tlpInfoP.ColumnStyles.Add(New ColumnStyle(SizeType.Absolute, 20F))
        tlpInfoP.Controls.Add(lblName, 0, 0)
        tlpInfoP.Controls.Add(lblRol, 0, 1)
        tlpInfoP.Location = New Point(506, 3)
        tlpInfoP.Name = "tlpInfoP"
        tlpInfoP.RowCount = 2
        tlpInfoP.RowStyles.Add(New RowStyle(SizeType.Percent, 100F))
        tlpInfoP.RowStyles.Add(New RowStyle(SizeType.Absolute, 20F))
        tlpInfoP.RowStyles.Add(New RowStyle(SizeType.Absolute, 20F))
        tlpInfoP.Size = New Size(211, 59)
        tlpInfoP.TabIndex = 12
        ' 
        ' lblName
        ' 
        lblName.Anchor = AnchorStyles.None
        lblName.AutoSize = True
        lblName.Font = New Font("Segoe UI", 12F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblName.ForeColor = Color.RoyalBlue
        lblName.Location = New Point(61, 5)
        lblName.Name = "lblName"
        lblName.Size = New Size(89, 28)
        lblName.TabIndex = 1
        lblName.Text = "Nombre"
        ' 
        ' lblRol
        ' 
        lblRol.Anchor = AnchorStyles.None
        lblRol.AutoSize = True
        lblRol.ForeColor = Color.CornflowerBlue
        lblRol.Location = New Point(90, 39)
        lblRol.Name = "lblRol"
        lblRol.Size = New Size(31, 20)
        lblRol.TabIndex = 2
        lblRol.Text = "Rol"
        ' 
        ' FormPrincipal
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 450)
        Controls.Add(tsMenuPrincipal)
        Controls.Add(pbPicture)
        Controls.Add(tlpInfoP)
        Controls.Add(pnlPrincipal)
        Name = "FormPrincipal"
        StartPosition = FormStartPosition.CenterScreen
        Text = "Inicio"
        tsMenuPrincipal.ResumeLayout(False)
        tsMenuPrincipal.PerformLayout()
        CType(pbPicture, ComponentModel.ISupportInitialize).EndInit()
        tlpInfoP.ResumeLayout(False)
        tlpInfoP.PerformLayout()
        ResumeLayout(False)
        PerformLayout()
    End Sub
    Friend WithEvents pnlPrincipal As Panel
    Friend WithEvents tsMenuPrincipal As ToolStrip
    Friend WithEvents btnGrades As ToolStripButton
    Friend WithEvents btnOpenT As ToolStripButton
    Friend WithEvents btnOrlas As ToolStripButton
    Friend WithEvents btnDownload As ToolStripButton
    Friend WithEvents pbPicture As PictureBox
    Friend WithEvents tlpInfoP As TableLayoutPanel
    Friend WithEvents lblName As Label
    Friend WithEvents lblRol As Label
End Class
