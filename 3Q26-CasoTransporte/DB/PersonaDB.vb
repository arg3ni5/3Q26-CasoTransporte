Imports System.Data
Imports System.Data.SqlClient

Public Class PersonaDB
    Private ReadOnly _db As New DbHelper()

    Public Function GetAll() As List(Of Persona)
        Dim lista As New List(Of Persona)()
        Dim query As String = "SELECT IdPersona, Identificacion, NombreCompleto, Correo FROM PERSONAS ORDER BY IdPersona DESC"
        Dim dt As DataTable = _db.ExecuteQuery(query)

        For Each row As DataRow In dt.Rows
            lista.Add(RowToPersona(row))
        Next
        Return lista
    End Function

    Public Function GetById(id As Integer) As Persona
        Dim query As String = "SELECT IdPersona, Identificacion, NombreCompleto, Correo FROM PERSONAS WHERE IdPersona = @IdPersona"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@IdPersona", id)
        }
        Dim dt As DataTable = _db.ExecuteQuery(query, params)
        If dt.Rows.Count > 0 Then
            Return RowToPersona(dt.Rows(0))
        End If
        Return Nothing
    End Function

    Public Function GetByIdentificacion(identificacion As String) As Persona
        Dim query As String = "SELECT IdPersona, Identificacion, NombreCompleto, Correo FROM PERSONAS WHERE Identificacion = @Identificacion"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@Identificacion", identificacion)
        }
        Dim dt As DataTable = _db.ExecuteQuery(query, params)
        If dt.Rows.Count > 0 Then
            Return RowToPersona(dt.Rows(0))
        End If
        Return Nothing
    End Function

    Public Function Insert(p As Persona) As Integer
        Dim query As String = "INSERT INTO PERSONAS (Identificacion, NombreCompleto, Correo) OUTPUT INSERTED.IdPersona VALUES (@Identificacion, @NombreCompleto, @Correo)"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@Identificacion", p.Identificacion),
            New SqlParameter("@NombreCompleto", p.NombreCompleto),
            New SqlParameter("@Correo", p.Correo)
        }
        Dim dt As DataTable = _db.ExecuteQuery(query, params)
        If dt.Rows.Count > 0 Then
            Return Convert.ToInt32(dt.Rows(0)("IdPersona"))
        End If
        Return 0
    End Function

    Public Function Update(p As Persona) As Boolean
        Dim query As String = "UPDATE PERSONAS SET Identificacion = @Identificacion, NombreCompleto = @NombreCompleto, Correo = @Correo WHERE IdPersona = @IdPersona"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@IdPersona", p.IdPersona),
            New SqlParameter("@Identificacion", p.Identificacion),
            New SqlParameter("@NombreCompleto", p.NombreCompleto),
            New SqlParameter("@Correo", p.Correo)
        }
        Return _db.ExecuteNonQuery(query, params) > 0
    End Function

    Public Function Delete(id As Integer) As Boolean
        Dim query As String = "DELETE FROM PERSONAS WHERE IdPersona = @IdPersona"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@IdPersona", id)
        }
        Return _db.ExecuteNonQuery(query, params) > 0
    End Function

    Private Function RowToPersona(row As DataRow) As Persona
        Return New Persona() With {
            .IdPersona = Convert.ToInt32(row("IdPersona")),
            .Identificacion = row("Identificacion").ToString(),
            .NombreCompleto = row("NombreCompleto").ToString(),
            .Correo = row("Correo").ToString()
        }
    End Function
End Class