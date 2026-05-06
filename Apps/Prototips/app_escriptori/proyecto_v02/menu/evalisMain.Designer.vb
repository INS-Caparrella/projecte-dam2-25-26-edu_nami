<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class evalisMain
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
    Protected Overrides Sub Dispose(disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        menuInicio = New MenuStrip()
        StatusStrip1 = New StatusStrip()
        ProjecteToolStripMenuItem = New ToolStripMenuItem()
        NovaSessióToolStripMenuItem = New ToolStripMenuItem()
        TancarToolStripMenuItem = New ToolStripMenuItem()
        AjudaToolStripMenuItem = New ToolStripMenuItem()
        EvalisToolStripMenuItem = New ToolStripMenuItem()
        menuInicio.SuspendLayout()
        SuspendLayout()
        ' 
        ' menuInicio
        ' 
        menuInicio.ImageScalingSize = New Size(20, 20)
        menuInicio.Items.AddRange(New ToolStripItem() {ProjecteToolStripMenuItem, AjudaToolStripMenuItem})
        menuInicio.Location = New Point(0, 0)
        menuInicio.Name = "menuInicio"
        menuInicio.Size = New Size(800, 28)
        menuInicio.TabIndex = 0
        ' 
        ' StatusStrip1
        ' 
        StatusStrip1.ImageScalingSize = New Size(20, 20)
        StatusStrip1.Location = New Point(0, 428)
        StatusStrip1.Name = "StatusStrip1"
        StatusStrip1.Size = New Size(800, 22)
        StatusStrip1.TabIndex = 1
        StatusStrip1.Text = "StatusStrip1"
        ' 
        ' ProjecteToolStripMenuItem
        ' 
        ProjecteToolStripMenuItem.DropDownItems.AddRange(New ToolStripItem() {NovaSessióToolStripMenuItem, TancarToolStripMenuItem})
        ProjecteToolStripMenuItem.Name = "ProjecteToolStripMenuItem"
        ProjecteToolStripMenuItem.Size = New Size(77, 24)
        ProjecteToolStripMenuItem.Text = "&Projecte"
        ' 
        ' NovaSessióToolStripMenuItem
        ' 
        NovaSessióToolStripMenuItem.Name = "NovaSessióToolStripMenuItem"
        NovaSessióToolStripMenuItem.ShortcutKeys = Keys.Control Or Keys.N
        NovaSessióToolStripMenuItem.Size = New Size(224, 26)
        NovaSessióToolStripMenuItem.Text = "&Nova sessió"
        ' 
        ' TancarToolStripMenuItem
        ' 
        TancarToolStripMenuItem.Name = "TancarToolStripMenuItem"
        TancarToolStripMenuItem.ShortcutKeys = Keys.Control Or Keys.T
        TancarToolStripMenuItem.Size = New Size(224, 26)
        TancarToolStripMenuItem.Text = "&Tancar"
        ' 
        ' AjudaToolStripMenuItem
        ' 
        AjudaToolStripMenuItem.DropDownItems.AddRange(New ToolStripItem() {EvalisToolStripMenuItem})
        AjudaToolStripMenuItem.Name = "AjudaToolStripMenuItem"
        AjudaToolStripMenuItem.Size = New Size(62, 24)
        AjudaToolStripMenuItem.Text = "&Ajuda"
        ' 
        ' EvalisToolStripMenuItem
        ' 
        EvalisToolStripMenuItem.Name = "EvalisToolStripMenuItem"
        EvalisToolStripMenuItem.Size = New Size(224, 26)
        EvalisToolStripMenuItem.Text = "&Sobre Evalis"
        ' 
        ' evalisInicio
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 450)
        Controls.Add(StatusStrip1)
        Controls.Add(menuInicio)
        MainMenuStrip = menuInicio
        Name = "evalisInicio"
        Text = "evalis"
        menuInicio.ResumeLayout(False)
        menuInicio.PerformLayout()
        ResumeLayout(False)
        PerformLayout()
    End Sub

    Friend WithEvents menuInicio As MenuStrip
    Friend WithEvents ProjecteToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents StatusStrip1 As StatusStrip
    Friend WithEvents NovaSessióToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents TancarToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents AjudaToolStripMenuItem As ToolStripMenuItem
    Friend WithEvents EvalisToolStripMenuItem As ToolStripMenuItem

End Class
