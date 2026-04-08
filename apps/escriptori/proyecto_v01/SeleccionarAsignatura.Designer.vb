<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class SeleccionarAsignatura
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
        lblSelect = New Label()
        cbAsignaturas = New ComboBox()
        btnAccept = New Button()
        btnCancel = New Button()
        SuspendLayout()
        ' 
        ' lblSelect
        ' 
        lblSelect.AutoSize = True
        lblSelect.Font = New Font("Segoe UI", 12F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblSelect.ForeColor = SystemColors.ControlText
        lblSelect.Location = New Point(16, 16)
        lblSelect.Name = "lblSelect"
        lblSelect.Size = New Size(250, 28)
        lblSelect.TabIndex = 0
        lblSelect.Text = "Seleccione su asignatura:"
        ' 
        ' cbAsignaturas
        ' 
        cbAsignaturas.DropDownStyle = ComboBoxStyle.DropDownList
        cbAsignaturas.FormattingEnabled = True
        cbAsignaturas.Location = New Point(12, 47)
        cbAsignaturas.Name = "cbAsignaturas"
        cbAsignaturas.Size = New Size(316, 28)
        cbAsignaturas.TabIndex = 1
        ' 
        ' btnAccept
        ' 
        btnAccept.Enabled = False
        btnAccept.Location = New Point(140, 82)
        btnAccept.Name = "btnAccept"
        btnAccept.Size = New Size(90, 30)
        btnAccept.TabIndex = 2
        btnAccept.Text = "Aceptar"
        btnAccept.UseVisualStyleBackColor = True
        ' 
        ' btnCancel
        ' 
        btnCancel.Location = New Point(242, 82)
        btnCancel.Name = "btnCancel"
        btnCancel.Size = New Size(90, 30)
        btnCancel.TabIndex = 3
        btnCancel.Text = "Cancelar"
        btnCancel.UseVisualStyleBackColor = True
        ' 
        ' SeleccionarAsignatura
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 450)
        Controls.Add(btnCancel)
        Controls.Add(btnAccept)
        Controls.Add(cbAsignaturas)
        Controls.Add(lblSelect)
        FormBorderStyle = FormBorderStyle.FixedDialog
        MaximizeBox = False
        MinimizeBox = False
        Name = "SeleccionarAsignatura"
        StartPosition = FormStartPosition.CenterParent
        Text = "Selección de asignatura"
        ResumeLayout(False)
        PerformLayout()
    End Sub

    Friend WithEvents lblSelect As Label
    Friend WithEvents cbAsignaturas As ComboBox
    Friend WithEvents btnAccept As Button
    Friend WithEvents btnCancel As Button
End Class
