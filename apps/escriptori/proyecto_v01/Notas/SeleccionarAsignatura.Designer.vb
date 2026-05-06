<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class SeleccionarAsignatura
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
        lblTitol = New Label()
        lblAsig = New Label()
        cbAsignaturas = New ComboBox()
        lblGrup = New Label()
        ComboBox1 = New ComboBox()
        btnAccept = New Button()
        btnCancel = New Button()
        SuspendLayout()

        ' lblTitol
        lblTitol.AutoSize = True
        lblTitol.Font = New Font("Segoe UI", 13.0F, FontStyle.Bold)
        lblTitol.ForeColor = Color.FromArgb(50, 50, 50)
        lblTitol.Location = New Point(220, 40)
        lblTitol.Name = "lblTitol"
        lblTitol.Text = "Selección de asignatura"

        ' lblAsig
        lblAsig.AutoSize = True
        lblAsig.Font = New Font("Segoe UI", 10.0F)
        lblAsig.ForeColor = Color.DimGray
        lblAsig.Location = New Point(180, 110)
        lblAsig.Name = "lblAsig"
        lblAsig.Text = "Asignatura:"

        ' cbAsignaturas
        cbAsignaturas.DropDownStyle = ComboBoxStyle.DropDownList
        cbAsignaturas.Font = New Font("Segoe UI", 10.0F)
        cbAsignaturas.Location = New Point(180, 138)
        cbAsignaturas.Name = "cbAsignaturas"
        cbAsignaturas.Size = New Size(440, 28)

        ' lblGrup
        lblGrup.AutoSize = True
        lblGrup.Font = New Font("Segoe UI", 10.0F)
        lblGrup.ForeColor = Color.DimGray
        lblGrup.Location = New Point(180, 182)
        lblGrup.Name = "lblGrup"
        lblGrup.Text = "Grupo:"
        lblGrup.Visible = False

        ' ComboBox1
        ComboBox1.DropDownStyle = ComboBoxStyle.DropDownList
        ComboBox1.Font = New Font("Segoe UI", 10.0F)
        ComboBox1.Location = New Point(180, 210)
        ComboBox1.Name = "ComboBox1"
        ComboBox1.Size = New Size(440, 28)
        ComboBox1.Visible = False

        ' btnAccept
        btnAccept.Font = New Font("Segoe UI", 10.0F)
        btnAccept.Location = New Point(280, 310)
        btnAccept.Name = "btnAccept"
        btnAccept.Size = New Size(130, 36)
        btnAccept.Text = "Aceptar"
        btnAccept.Enabled = False
        btnAccept.UseVisualStyleBackColor = True

        ' btnCancel
        btnCancel.Font = New Font("Segoe UI", 10.0F)
        btnCancel.Location = New Point(430, 310)
        btnCancel.Name = "btnCancel"
        btnCancel.Size = New Size(130, 36)
        btnCancel.Text = "Cancelar"
        btnCancel.UseVisualStyleBackColor = True

        ' Form
        AutoScaleDimensions = New SizeF(8.0F, 20.0F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 400)
        Controls.Add(btnCancel)
        Controls.Add(btnAccept)
        Controls.Add(ComboBox1)
        Controls.Add(lblGrup)
        Controls.Add(cbAsignaturas)
        Controls.Add(lblAsig)
        Controls.Add(lblTitol)
        FormBorderStyle = FormBorderStyle.FixedDialog
        MaximizeBox = False
        MinimizeBox = False
        Name = "SeleccionarAsignatura"
        StartPosition = FormStartPosition.CenterParent
        Text = "Selección de asignatura"
        ResumeLayout(False)
        PerformLayout()
    End Sub

    Friend WithEvents lblTitol As Label
    Friend WithEvents lblAsig As Label
    Friend WithEvents cbAsignaturas As ComboBox
    Friend WithEvents lblGrup As Label
    Friend WithEvents ComboBox1 As ComboBox
    Friend WithEvents btnAccept As Button
    Friend WithEvents btnCancel As Button
End Class