Imports System.Web
Imports System.Web.SessionState

' Único punto del proyecto que lee o escribe la sesión del usuario.
' Las páginas usan SesionUtils en lugar de Session("...") para no repetir claves de texto.
Public NotInheritable Class SesionUtils
    Private Const CLAVE_USUARIO As String = "UsuarioActual"

    Private Sub New()
    End Sub

    Private Shared ReadOnly Property Sesion As HttpSessionState
        Get
            Return HttpContext.Current.Session
        End Get
    End Property

    ' Guarda el usuario autenticado (sin el hash de la contraseña)
    Public Shared Sub IniciarSesion(usuario As Usuario)
        usuario.PasswordHash = Nothing
        Sesion(CLAVE_USUARIO) = usuario
    End Sub

    Public Shared ReadOnly Property UsuarioActual As Usuario
        Get
            Return TryCast(Sesion(CLAVE_USUARIO), Usuario)
        End Get
    End Property

    Public Shared ReadOnly Property HaySesion As Boolean
        Get
            Return UsuarioActual IsNot Nothing
        End Get
    End Property

    Public Shared ReadOnly Property EsAdministrador As Boolean
        Get
            Return HaySesion AndAlso UsuarioActual.Rol = Usuario.ROL_ADMINISTRADOR
        End Get
    End Property

    Public Shared Sub CerrarSesion()
        Sesion.Clear()
        Sesion.Abandon()
    End Sub
End Class
