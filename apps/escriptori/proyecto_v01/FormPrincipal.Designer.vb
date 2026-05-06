<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class FormPrincipal
    Inherits System.Windows.Forms.Form

    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    Private components As System.ComponentModel.IContainer

    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FormPrincipal))
        pnlPrincipal = New Panel()
        tsMenuPrincipal = New ToolStrip()
        btnFicha = New ToolStripButton()
        btnGrades = New ToolStripButton()
        btnOpenT = New ToolStripButton()
        btnOrlas = New ToolStripButton()
        btnCSV = New ToolStripButton()
        btnJSON = New ToolStripButton()
        btnXML = New ToolStripButton()
        pbPicture = New PictureBox()
        tlpInfoP = New TableLayoutPanel()
        lblName = New Label()
        lblRol = New Label()
        tsMenuPrincipal.SuspendLayout()
        CType(pbPicture, ComponentModel.ISupportInitialize).BeginInit()
        tlpInfoP.SuspendLayout()
        SuspendLayout()

        ' pnlPrincipal
        pnlPrincipal.Anchor = AnchorStyles.Top Or AnchorStyles.Bottom Or AnchorStyles.Left Or AnchorStyles.Right
        pnlPrincipal.Location = New Point(35, 90)
        pnlPrincipal.Name = "pnlPrincipal"
        pnlPrincipal.Size = New Size(1065, 560)
        pnlPrincipal.TabIndex = 0

        ' tsMenuPrincipal
        tsMenuPrincipal.Dock = DockStyle.Left
        tsMenuPrincipal.ImageScalingSize = New Size(24, 24)
        tsMenuPrincipal.Items.AddRange(New ToolStripItem() {btnFicha, btnGrades, btnOpenT, btnOrlas, btnCSV, btnJSON, btnXML})
        tsMenuPrincipal.Location = New Point(0, 0)
        tsMenuPrincipal.Name = "tsMenuPrincipal"
        tsMenuPrincipal.Size = New Size(35, 700)
        tsMenuPrincipal.TabIndex = 14
        tsMenuPrincipal.Text = "Menú"
        tsMenuPrincipal.TextDirection = ToolStripTextDirection.Vertical90

        ' btnFicha
        btnFicha.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnFicha.Image = CType(resources.GetObject("btnFicha.Image"), Image)
        btnFicha.ImageTransparentColor = Color.Magenta
        btnFicha.Name = "btnFicha"
        btnFicha.Size = New Size(33, 28)
        btnFicha.ToolTipText = "Ficha de profesor"

        ' btnGrades
        btnGrades.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnGrades.Image = CType(resources.GetObject("btnGrades.Image"), Image)
        btnGrades.ImageTransparentColor = Color.Magenta
        btnGrades.Name = "btnGrades"
        btnGrades.Size = New Size(33, 28)
        btnGrades.ToolTipText = "Introducir notas"

        ' btnOpenT
        btnOpenT.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnOpenT.Image = CType(resources.GetObject("btnOpenT.Image"), Image)
        btnOpenT.ImageTransparentColor = Color.Magenta
        btnOpenT.Name = "btnOpenT"
        btnOpenT.Size = New Size(33, 28)
        btnOpenT.ToolTipText = "Gestionar período de evaluación"

        ' btnOrlas
        btnOrlas.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnOrlas.Image = CType(resources.GetObject("btnOrlas.Image"), Image)
        btnOrlas.ImageTransparentColor = Color.Magenta
        btnOrlas.Name = "btnOrlas"
        btnOrlas.Size = New Size(33, 28)
        btnOrlas.ToolTipText = "Orla de profesores"

        ' btnCSV
        btnCSV.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnCSV.Image = CType(resources.GetObject("btnCSV.Image"), Image)
        btnCSV.ImageTransparentColor = Color.Magenta
        btnCSV.Name = "btnCSV"
        btnCSV.Size = New Size(33, 28)
        btnCSV.ToolTipText = "Exportar clase a CSV"

        ' btnJSON
        btnJSON.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnJSON.Image = CType(resources.GetObject("btnJSON.Image"), Image)
        btnJSON.ImageTransparentColor = Color.Magenta
        btnJSON.Name = "btnJSON"
        btnJSON.Size = New Size(33, 28)
        btnJSON.ToolTipText = "Exportar profesores a JSON"

        ' btnXML
        btnXML.DisplayStyle = ToolStripItemDisplayStyle.Image
        btnXML.Image = CType(resources.GetObject("btnXML.Image"), Image)
        btnXML.ImageTransparentColor = Color.Magenta
        btnXML.Name = "btnXML"
        btnXML.Size = New Size(33, 28)
        btnXML.ToolTipText = "Descargar log logins XML"

        ' pbPicture
        pbPicture.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        pbPicture.Location = New Point(1030, 8)
        pbPicture.Name = "pbPicture"
        pbPicture.Size = New Size(70, 70)
        pbPicture.SizeMode = PictureBoxSizeMode.Zoom
        pbPicture.TabStop = False

        ' tlpInfoP
        tlpInfoP.Anchor = AnchorStyles.Top Or AnchorStyles.Right
        tlpInfoP.ColumnCount = 1
        tlpInfoP.ColumnStyles.Add(New ColumnStyle(SizeType.Percent, 100.0F))
        tlpInfoP.Controls.Add(lblName, 0, 0)
        tlpInfoP.Controls.Add(lblRol, 0, 1)
        tlpInfoP.Location = New Point(650, 8)
        tlpInfoP.Name = "tlpInfoP"
        tlpInfoP.RowCount = 2
        tlpInfoP.RowStyles.Add(New RowStyle(SizeType.Percent, 60.0F))
        tlpInfoP.RowStyles.Add(New RowStyle(SizeType.Percent, 40.0F))
        tlpInfoP.Size = New Size(370, 72)
        tlpInfoP.TabIndex = 12

        ' lblName
        lblName.Anchor = AnchorStyles.Left Or AnchorStyles.Right
        lblName.AutoSize = True
        lblName.Font = New Font("Segoe UI", 14.0F, FontStyle.Bold)
        lblName.ForeColor = Color.FromArgb(50, 50, 50)
        lblName.Location = New Point(3, 6)
        lblName.Name = "lblName"
        lblName.Text = "Nombre"

        ' lblRol
        lblRol.Anchor = AnchorStyles.Left Or AnchorStyles.Right
        lblRol.AutoSize = True
        lblRol.Font = New Font("Segoe UI", 9.0F)
        lblRol.ForeColor = Color.DimGray
        lblRol.Location = New Point(3, 48)
        lblRol.Name = "lblRol"
        lblRol.Text = "Rol"

        ' Form
        AutoScaleDimensions = New SizeF(8.0F, 20.0F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(1100, 660)
        MinimumSize = New Size(900, 580)
        WindowState = FormWindowState.Maximized
        Controls.Add(tsMenuPrincipal)
        Controls.Add(pbPicture)
        Controls.Add(tlpInfoP)
        Controls.Add(pnlPrincipal)
        Name = "FormPrincipal"
        StartPosition = FormStartPosition.CenterScreen
        Text = "EVALIS"

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
    Friend WithEvents btnFicha As ToolStripButton
    Friend WithEvents btnGrades As ToolStripButton
    Friend WithEvents btnOpenT As ToolStripButton
    Friend WithEvents btnOrlas As ToolStripButton
    Friend WithEvents btnCSV As ToolStripButton
    Friend WithEvents btnJSON As ToolStripButton
    Friend WithEvents btnXML As ToolStripButton
    Friend WithEvents pbPicture As PictureBox
    Friend WithEvents tlpInfoP As TableLayoutPanel
    Friend WithEvents lblName As Label
    Friend WithEvents lblRol As Label
End Class