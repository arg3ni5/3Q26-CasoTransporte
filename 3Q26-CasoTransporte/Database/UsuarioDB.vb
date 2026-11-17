Imports System.Data
Imports System.Data.SqlClient

' Capa de datos: tabla Usuarios.
' Las consultas de lectura hacen JOIN con Personas para traer los datos heredados
' (Identificacion, NombreCompleto, Correo) en un solo objeto Usuario.
Public Class UsuarioDB
    Private ReadOnly _db As New DBHelper()

    Private Const SELECT_USUARIO As String =
        "SELECT u.IdPersona, u.Username, u.PasswordHash, u.Rol, u.Activo, " &
        "       p.Identificacion, p.NombreCompleto, p.Correo " &
        "FROM dbo.Usuarios u " &
        "INNER JOIN dbo.Personas p ON p.IdPersona = u.IdPersona "

    Public Function GetAll() As List(Of Usuario)
        Dim lista As New List(Of Usuario)()
        Dim dt As DataTable = _db.ExecuteQuery(SELECT_USUARIO & "ORDER BY p.NombreCompleto")
        For Each row As DataRow In dt.Rows
            lista.Add(MapRowToUsuario(row))
        Next
        Return lista
    End Function

    ' Devuelve Nothing si no existe un usuario con ese nombre
    Public Function GetByUsername(username As String) As Usuario
        Dim query As String = SELECT_USUARIO & "WHERE u.Username = @Username"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@Username", username)
        }
        Dim dt As DataTable = _db.ExecuteQuery(query, params)
        If dt.Rows.Count > 0 Then
            Return MapRowToUsuario(dt.Rows(0))
        End If
        Return Nothing
    End Function

    ' Inserta solo la fila de Usuarios: la Persona ya debe existir (u.IdPersona > 0).
    Public Function Insert(u As Usuario, Optional tran As SqlTransaction = Nothing) As Boolean
        Dim query As String = "INSERT INTO dbo.Usuarios (IdPersona, Username, PasswordHash, Rol, Activo) " &
                              "VALUES (@IdPersona, @Username, @PasswordHash, @Rol, @Activo)"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@IdPersona", u.IdPersona),
            New SqlParameter("@Username", u.Username),
            New SqlParameter("@PasswordHash", u.PasswordHash),
            New SqlParameter("@Rol", u.Rol),
            New SqlParameter("@Activo", u.Activo)
        }
        Return _db.ExecuteNonQuery(query, params, tran) > 0
    End Function

    Private Function MapRowToUsuario(row As DataRow) As Usuario
        Return New Usuario() With {
            .IdPersona = Convert.ToInt32(row("IdPersona")),
            .Identificacion = row("Identificacion").ToString(),
            .NombreCompleto = row("NombreCompleto").ToString(),
            .Correo = If(IsDBNull(row("Correo")), Nothing, row("Correo").ToString()),
            .Username = row("Username").ToString(),
            .PasswordHash = row("PasswordHash").ToString(),
            .Rol = row("Rol").ToString(),
            .Activo = Convert.ToBoolean(row("Activo"))
        }
    End Function
End Class
