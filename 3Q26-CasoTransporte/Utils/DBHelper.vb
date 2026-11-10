Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Public Class DBHelper
    'Cadena de conexión a la base de datos
    Private ReadOnly _connectionString As String

    Public Sub New()
        _connectionString = ConfigurationManager.ConnectionStrings("ConexionTransporteDB").ConnectionString
    End Sub
    ' Devuelve una conexión a la base de datos
    Public Function GetConnection() As SqlConnection
        Return New SqlConnection(_connectionString)
    End Function
    'Ejecuta una consulta SQL que no devuelve resultados (INSERT, UPDATE, DELETE)
    Public Function ExecuteNonQuery(query As String, Optional parameters As List(Of SqlParameter) = Nothing) As Integer
        Using conn As SqlConnection = GetConnection()
            Using cmd As New SqlCommand(query, conn)
                If parameters IsNot Nothing Then
                    cmd.Parameters.AddRange(parameters.ToArray())
                End If
                conn.Open()
                Return cmd.ExecuteNonQuery()
            End Using
        End Using
    End Function

    ' Ejecuta una consulta SQL que devuelve resultados (SELECT)
    Public Function ExecuteQuery(query As String, Optional parameters As List(Of SqlParameter) = Nothing) As DataTable
        Dim dt As New DataTable()
        Using conn As SqlConnection = GetConnection()
            Using cmd As New SqlCommand(query, conn)
                If parameters IsNot Nothing Then
                    cmd.Parameters.AddRange(parameters.ToArray())
                End If
                Using adapter As New SqlDataAdapter(cmd)
                    adapter.Fill(dt)
                End Using
            End Using
        End Using
        Return dt
    End Function
End Class
