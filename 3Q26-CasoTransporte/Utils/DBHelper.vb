Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

' Utilidad de acceso a datos (ADO.NET).
' Las clases de la capa Data (PersonaDB, UsuarioDB, ...) usan SIEMPRE esta clase:
' nunca abren conexiones por su cuenta ni concatenan valores en el SQL (usar parámetros).
Public Class DBHelper
    'Cadena de conexión a la base de datos (Web.config > connectionStrings)
    Private ReadOnly _connectionString As String

    Public Sub New()
        Dim cadena As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("ConexionTransporteDB")
        If cadena Is Nothing Then
            Throw New ConfigurationErrorsException("No existe la cadena de conexión 'ConexionTransporteDB'. " &
                                                   "Revise el archivo ConnectionStrings.config (ver README del repositorio).")
        End If
        _connectionString = cadena.ConnectionString
    End Sub

    ' Devuelve una conexión a la base de datos
    Public Function GetConnection() As SqlConnection
        Return New SqlConnection(_connectionString)
    End Function

    ' Ejecuta una consulta SQL que no devuelve resultados (INSERT, UPDATE, DELETE).
    ' Si se envía una transacción, el comando se ejecuta dentro de ella (ver ExecuteInTransaction).
    Public Function ExecuteNonQuery(query As String, Optional parameters As List(Of SqlParameter) = Nothing,
                                    Optional tran As SqlTransaction = Nothing) As Integer
        If tran IsNot Nothing Then
            Using cmd As SqlCommand = CreateCommand(query, parameters, tran.Connection, tran)
                Return cmd.ExecuteNonQuery()
            End Using
        End If

        Using conn As SqlConnection = GetConnection()
            Using cmd As SqlCommand = CreateCommand(query, parameters, conn, Nothing)
                conn.Open()
                Return cmd.ExecuteNonQuery()
            End Using
        End Using
    End Function

    ' Ejecuta una consulta SQL que devuelve resultados (SELECT, o INSERT ... OUTPUT)
    Public Function ExecuteQuery(query As String, Optional parameters As List(Of SqlParameter) = Nothing,
                                 Optional tran As SqlTransaction = Nothing) As DataTable
        Dim dt As New DataTable()
        If tran IsNot Nothing Then
            Using cmd As SqlCommand = CreateCommand(query, parameters, tran.Connection, tran)
                Using adapter As New SqlDataAdapter(cmd)
                    adapter.Fill(dt)
                End Using
            End Using
            Return dt
        End If

        Using conn As SqlConnection = GetConnection()
            Using cmd As SqlCommand = CreateCommand(query, parameters, conn, Nothing)
                Using adapter As New SqlDataAdapter(cmd)
                    adapter.Fill(dt)
                End Using
            End Using
        End Using
        Return dt
    End Function

    ' Ejecuta una consulta que devuelve un único valor (COUNT, SUM, un Id, ...).
    ' Devuelve Nothing si la consulta no trae filas.
    Public Function ExecuteScalar(query As String, Optional parameters As List(Of SqlParameter) = Nothing,
                                  Optional tran As SqlTransaction = Nothing) As Object
        Dim valor As Object
        If tran IsNot Nothing Then
            Using cmd As SqlCommand = CreateCommand(query, parameters, tran.Connection, tran)
                valor = cmd.ExecuteScalar()
            End Using
        Else
            Using conn As SqlConnection = GetConnection()
                Using cmd As SqlCommand = CreateCommand(query, parameters, conn, Nothing)
                    conn.Open()
                    valor = cmd.ExecuteScalar()
                End Using
            End Using
        End If
        If valor Is DBNull.Value Then Return Nothing
        Return valor
    End Function

    ' Ejecuta varias operaciones como una sola unidad: o se guardan todas o ninguna.
    ' Ejemplo (UsuarioService.Registrar): insertar en Personas y luego en Usuarios.
    '   _db.ExecuteInTransaction(Sub(tran)
    '                                id = _personaDB.Insert(persona, tran)
    '                                _usuarioDB.Insert(usuario, tran)
    '                            End Sub)
    ' Si cualquier operación lanza una excepción se hace Rollback y la excepción se vuelve a lanzar.
    Public Sub ExecuteInTransaction(operaciones As Action(Of SqlTransaction))
        Using conn As SqlConnection = GetConnection()
            conn.Open()
            Using tran As SqlTransaction = conn.BeginTransaction()
                Try
                    operaciones(tran)
                    tran.Commit()
                Catch
                    tran.Rollback()
                    Throw
                End Try
            End Using
        End Using
    End Sub

    Private Function CreateCommand(query As String, parameters As List(Of SqlParameter),
                                   conn As SqlConnection, tran As SqlTransaction) As SqlCommand
        Dim cmd As New SqlCommand(query, conn)
        If tran IsNot Nothing Then
            cmd.Transaction = tran
        End If
        If parameters IsNot Nothing Then
            cmd.Parameters.AddRange(parameters.ToArray())
        End If
        Return cmd
    End Function
End Class
