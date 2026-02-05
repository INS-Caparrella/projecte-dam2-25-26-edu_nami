<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class Form1
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
        Panel1 = New Panel()
        btnContinue = New Button()
        txtPass = New TextBox()
        lblPass = New Label()
        lblUser = New Label()
        txtUser = New TextBox()
        Panel1.SuspendLayout()
        SuspendLayout()
        ' 
        ' Panel1
        ' 
        Panel1.Controls.Add(btnContinue)
        Panel1.Controls.Add(txtPass)
        Panel1.Controls.Add(lblPass)
        Panel1.Controls.Add(lblUser)
        Panel1.Controls.Add(txtUser)
        Panel1.Location = New Point(0, 0)
        Panel1.Name = "Panel1"
        Panel1.Size = New Size(788, 438)
        Panel1.TabIndex = 0
        ' 
        ' btnContinue
        ' 
        btnContinue.BackColor = SystemColors.ButtonHighlight
        btnContinue.Enabled = False
        btnContinue.ForeColor = SystemColors.ActiveCaptionText
        btnContinue.Location = New Point(354, 278)
        btnContinue.Name = "btnContinue"
        btnContinue.Size = New Size(94, 29)
        btnContinue.TabIndex = 6
        btnContinue.Text = "continuar"
        btnContinue.UseVisualStyleBackColor = False
        ' 
        ' txtPass
        ' 
        txtPass.Location = New Point(267, 228)
        txtPass.Name = "txtPass"
        txtPass.Size = New Size(262, 27)
        txtPass.TabIndex = 5
        ' 
        ' lblPass
        ' 
        lblPass.AutoSize = True
        lblPass.Location = New Point(354, 194)
        lblPass.Name = "lblPass"
        lblPass.Size = New Size(81, 20)
        lblPass.TabIndex = 4
        lblPass.Text = "contraseña"
        ' 
        ' lblUser
        ' 
        lblUser.AutoSize = True
        lblUser.Location = New Point(365, 120)
        lblUser.Name = "lblUser"
        lblUser.Size = New Size(57, 20)
        lblUser.TabIndex = 3
        lblUser.Text = "usuario"
        ' 
        ' txtUser
        ' 
        txtUser.Location = New Point(267, 154)
        txtUser.Name = "txtUser"
        txtUser.Size = New Size(262, 27)
        txtUser.TabIndex = 0
        ' 
        ' Form1
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 450)
        Controls.Add(Panel1)
        Name = "Form1"
        Text = "login"
        Panel1.ResumeLayout(False)
        Panel1.PerformLayout()
        ResumeLayout(False)
    End Sub

    Friend WithEvents Panel1 As Panel
    Friend WithEvents Button1 As Button
    Friend WithEvents TextBox2 As TextBox
    Friend WithEvents txtUser As TextBox
    Friend WithEvents lblPass As Label
    Friend WithEvents lblUser As Label
    Friend WithEvents Panel2 As Panel
    Friend WithEvents Label1 As Label
    Friend WithEvents txtPass As TextBox
    Friend WithEvents btnContinue As Button

End Class
