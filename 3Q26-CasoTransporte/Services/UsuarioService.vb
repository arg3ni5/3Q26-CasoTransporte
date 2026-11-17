Imports System.Data.SqlClient
Imports System.Text.RegularExpressions

' Capa de servicio: reglas de negocio de autenticación y registro.
' Igual que PersonaService, los errores de validación se comunican con ArgumentException;
' la página los atrapa y los muestra con SwalUtils.
Public Class UsuarioService
    Private ReadOnly _db As New DBHelper()
    Private ReadOnly _personaDB As New PersonaDB()
    Private ReadOnly _usuarioDB As New UsuarioDB()
    Private ReadOnly _personaService As New PersonaService()

    ' Devuelve el usuario autenticado o lanza ArgumentException con el motivo.
    Public Function Login(username As String, password As String) As Usuario
        If String.IsNullOrWhiteSpace(username) OrElse String.IsNullOrEmpty(password) Then
            Throw New ArgumentException("Ingrese el nombre de usuario y la contraseña.")
        End If

        Dim usuario As Usuario = _usuarioDB.GetByUsername(username.Trim())

        ' Mismo mensaje si no existe o si la contraseña es incorrecta:
        ' así no se revela qué nombres de usuario existen.
        If usuario Is Nothing OrElse Not PasswordHasher.Verificar(password, usuario.PasswordHash) Then
            Throw New ArgumentException("Usuario o contraseña incorrectos.")
        End If

        If Not usuario.Activo Then
            Throw New ArgumentException("El usuario está inactivo. Contacte al administrador.")
        End If

        usuario.PasswordHash = Nothing ' el hash no sale de esta capa
        Return usuario
    End Function

    ' Crea la Persona y su Usuario en una sola transacción. Devuelve el IdPersona creado.
    ' Los usuarios que se registran solos quedan con rol Operador.
    Public Function Registrar(u As Usuario, password As String, confirmacion As String) As Integer
        Normalizar(u)
        ValidarRegistro(u, password, confirmacion)

        If _personaDB.GetByIdentificacion(u.Identificacion) IsNot Nothing Then
            Throw New ArgumentException("Ya existe una persona registrada con esa identificación.")
        End If
        If _usuarioDB.GetByUsername(u.Username) IsNot Nothing Then
            Throw New ArgumentException("El nombre de usuario ya está en uso.")
        End If

        u.PasswordHash = PasswordHasher.Hash(password)
        u.Rol = Usuario.ROL_OPERADOR
        u.Activo = True

        Try
            ' Si falla el INSERT de Usuarios, también se deshace el de Personas
            _db.ExecuteInTransaction(Sub(tran)
                                         u.IdPersona = _personaDB.Insert(u, tran)
                                         _usuarioDB.Insert(u, tran)
                                     End Sub)
        Catch ex As SqlException When ex.Number = 2601 OrElse ex.Number = 2627
            ' Índice único violado: alguien registró los mismos datos al mismo tiempo
            Throw New ArgumentException("La identificación o el nombre de usuario ya están registrados.")
        End Try

        u.PasswordHash = Nothing
        Return u.IdPersona
    End Function

    Private Sub Normalizar(u As Usuario)
        If u Is Nothing Then Return
        u.Identificacion = If(u.Identificacion, "").Trim()
        u.NombreCompleto = If(u.NombreCompleto, "").Trim()
        u.Correo = If(u.Correo, "").Trim()
        u.Username = If(u.Username, "").Trim()
    End Sub

    Private Sub ValidarRegistro(u As Usuario, password As String, confirmacion As String)
        ' Reglas de Persona: se reutilizan las de PersonaService
        _personaService.ValidarPersona(u)

        If u.Identificacion.Length > 30 Then Throw New ArgumentException("La identificación admite máximo 30 caracteres.")
        If u.NombreCompleto.Length > 120 Then Throw New ArgumentException("El nombre completo admite máximo 120 caracteres.")
        If u.Correo.Length > 120 Then Throw New ArgumentException("El correo admite máximo 120 caracteres.")

        ' Reglas propias de Usuario
        If Not Regex.IsMatch(u.Username, "^[a-zA-Z0-9._]{4,30}$") Then
            Throw New ArgumentException("El usuario debe tener entre 4 y 30 caracteres: letras, números, punto o guion bajo.")
        End If
        If String.IsNullOrEmpty(password) OrElse password.Length < 8 Then
            Throw New ArgumentException("La contraseña debe tener al menos 8 caracteres.")
        End If
        If Not Regex.IsMatch(password, "[a-zA-Z]") OrElse Not Regex.IsMatch(password, "[0-9]") Then
            Throw New ArgumentException("La contraseña debe incluir al menos una letra y un número.")
        End If
        If password <> confirmacion Then
            Throw New ArgumentException("La contraseña y su confirmación no coinciden.")
        End If
    End Sub
End Class
