Imports System.Configuration

Public Class BaseUrl
    Public Const BASE_URL As String = "https://192.168.19.105"

    Public Class LogIn
        Public Shared ReadOnly Property login As String = BASE_URL & "/login.php"
    End Class

    Public Class OrlaProf
        Public Shared ReadOnly Property orla As String = BASE_URL & "/orla.php"
    End Class

    Public Class GenActa
        Public Shared ReadOnly Property dadesActa As String = BASE_URL & "/dades_acta.php"
    End Class

    Public Class Evaluacion
        Public Shared ReadOnly Property evaluacion As String = BASE_URL & "/periode.php"
    End Class

    Public Class Notas
        Public Shared ReadOnly Property notas As String = BASE_URL & "/notes.php"
        Public Shared ReadOnly Property acta As String = BASE_URL & "/acta.php"
        Public Shared ReadOnly Property nota_final As String = BASE_URL & "/nota_final.php"
        Public Shared ReadOnly Property crear_acta As String = BASE_URL & "/crear_acta.php"
    End Class

    Public Class NotasExp
        Public Shared ReadOnly Property grad As String = BASE_URL & "/graduar_alumne.php"
    End Class

    Public Class ExpAlumnos
        Public Shared ReadOnly Property expCsv As String = BASE_URL & "/exportar_csv.php"
    End Class

    Public Class FichaProfesores
        Public Shared ReadOnly Property fichaProf As String = BASE_URL & "/fitxa_professor.php"
        Public Shared ReadOnly Property listaProf As String = BASE_URL & "/lista_prof.php"
    End Class

    Public Class ExpXML
        Public Shared ReadOnly Property exp As String = BASE_URL & "/export_logs.php"
    End Class
End Class
