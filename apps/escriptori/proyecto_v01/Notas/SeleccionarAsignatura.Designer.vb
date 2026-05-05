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
        FlowLayoutPanel1 = New FlowLayoutPanel()
        lblAsig = New Label()
        cbAsignaturas = New ComboBox()
        lblGrup = New Label()
        ComboBox1 = New ComboBox()
        btnAccept = New Button()
        btnCancel = New Button()
        FlowLayoutPanel1.SuspendLayout()
        SuspendLayout()
        ' 
        ' FlowLayoutPanel1
        ' 
        FlowLayoutPanel1.Controls.Add(lblAsig)
        FlowLayoutPanel1.Controls.Add(cbAsignaturas)
        FlowLayoutPanel1.Controls.Add(lblGrup)
        FlowLayoutPanel1.Controls.Add(ComboBox1)
        FlowLayoutPanel1.Controls.Add(btnAccept)
        FlowLayoutPanel1.Controls.Add(btnCancel)
        FlowLayoutPanel1.Dock = DockStyle.Fill
        FlowLayoutPanel1.Location = New Point(0, 0)
        FlowLayoutPanel1.Name = "FlowLayoutPanel1"
        FlowLayoutPanel1.Size = New Size(800, 450)
        FlowLayoutPanel1.TabIndex = 0
        ' 
        ' lblAsig
        ' 
        lblAsig.AutoSize = True
        lblAsig.Dock = DockStyle.Top
        lblAsig.Font = New Font("Segoe UI", 12F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblAsig.ForeColor = Color.LightSlateGray
        lblAsig.Location = New Point(3, 0)
        lblAsig.Name = "lblAsig"
        lblAsig.Size = New Size(264, 28)
        lblAsig.TabIndex = 0
        lblAsig.Text = "Seleccione una asignatura:"
        ' 
        ' cbAsignaturas
        ' 
        cbAsignaturas.DropDownStyle = ComboBoxStyle.DropDownList
        cbAsignaturas.FormattingEnabled = True
        cbAsignaturas.Location = New Point(273, 3)
        cbAsignaturas.Name = "cbAsignaturas"
        cbAsignaturas.Size = New Size(329, 28)
        cbAsignaturas.TabIndex = 1
        ' 
        ' lblGrup
        ' 
        lblGrup.AutoSize = True
        lblGrup.Dock = DockStyle.Top
        lblGrup.Font = New Font("Segoe UI", 12F, FontStyle.Bold, GraphicsUnit.Point, CByte(0))
        lblGrup.ForeColor = Color.LightSlateGray
        lblGrup.Location = New Point(3, 34)
        lblGrup.Name = "lblGrup"
        lblGrup.Size = New Size(209, 28)
        lblGrup.TabIndex = 6
        lblGrup.Text = "Seleccione un grupo:"
        ' 
        ' ComboBox1
        ' 
        ComboBox1.DropDownStyle = ComboBoxStyle.DropDownList
        ComboBox1.FormattingEnabled = True
        ComboBox1.Location = New Point(218, 37)
        ComboBox1.Name = "ComboBox1"
        ComboBox1.Size = New Size(329, 28)
        ComboBox1.TabIndex = 7
        ' 
        ' btnAccept
        ' 
        btnAccept.Location = New Point(100, 268)
        btnAccept.Margin = New Padding(100, 200, 3, 3)
        btnAccept.Name = "btnAccept"
        btnAccept.Size = New Size(247, 29)
        btnAccept.TabIndex = 8
        btnAccept.Text = "Aceptar"
        btnAccept.UseVisualStyleBackColor = True
        ' 
        ' btnCancel
        ' 
        btnCancel.Location = New Point(450, 268)
        btnCancel.Margin = New Padding(100, 200, 3, 3)
        btnCancel.Name = "btnCancel"
        btnCancel.Size = New Size(247, 29)
        btnCancel.TabIndex = 9
        btnCancel.Text = "Cancelar"
        btnCancel.UseVisualStyleBackColor = True
        ' 
        ' SeleccionarAsignatura
        ' 
        AutoScaleDimensions = New SizeF(8F, 20F)
        AutoScaleMode = AutoScaleMode.Font
        ClientSize = New Size(800, 450)
        Controls.Add(FlowLayoutPanel1)
        FormBorderStyle = FormBorderStyle.FixedDialog
        MaximizeBox = False
        MinimizeBox = False
        Name = "SeleccionarAsignatura"
        StartPosition = FormStartPosition.CenterParent
        Text = "Selección de asignatura"
        FlowLayoutPanel1.ResumeLayout(False)
        FlowLayoutPanel1.PerformLayout()
        ResumeLayout(False)
    End Sub

    Friend WithEvents FlowLayoutPanel1 As FlowLayoutPanel
    Friend WithEvents lblAsig As Label
    Friend WithEvents cbAsignaturas As ComboBox
    Friend WithEvents Label1 As Label
    Friend WithEvents cbGrups As ComboBox
    Friend WithEvents lblGrup As Label
    Friend WithEvents ComboBox1 As ComboBox
    Friend WithEvents btnAccept As Button
    Friend WithEvents btnCancel As Button
End Class
