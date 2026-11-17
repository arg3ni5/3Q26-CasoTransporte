' Un Usuario ES una Persona (relación 1:1: Usuarios.IdPersona es PK y FK a Personas).
' Hereda IdPersona, Identificacion, NombreCompleto y Correo; igual que Propietario.
Public Class Usuario
    Inherits Persona

    Public Const ROL_ADMINISTRADOR As String = "Administrador"
    Public Const ROL_OPERADOR As String = "Operador"

    Public Property Username As String
    Public Property PasswordHash As String
    Public Property Rol As String
    Public Property Activo As Boolean

    Public Sub New()
        MyBase.New()
    End Sub

    Public Sub New(idPersona As Integer, identificacion As String, nombreCompleto As String, correo As String,
                   username As String, rol As String, activo As Boolean)
        MyBase.New(idPersona, identificacion, nombreCompleto, correo)
        Me.Username = username
        Me.Rol = rol
        Me.Activo = activo
    End Sub
End Class
