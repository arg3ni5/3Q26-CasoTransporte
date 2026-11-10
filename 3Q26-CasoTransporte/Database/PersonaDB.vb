Imports System.Data
Imports System.Data.SqlClient

' Capa de datos: CRUD de la tabla Personas.
' Solo ejecuta SQL a través de DBHelper. Las validaciones y reglas van en PersonaService
' y los mensajes al usuario (SwalUtils) solo se usan en la capa de presentación.
Public Class PersonaDB
    Private ReadOnly _db As New DBHelper()

    Private Const COLUMNAS As String = "IdPersona, Identificacion, NombreCompleto, Correo"

    Public Function GetAll() As List(Of Persona)
        Dim lista As New List(Of Persona)()
        Dim query As String = "SELECT " & COLUMNAS & " FROM dbo.Personas ORDER BY NombreCompleto"
        Dim dt As DataTable = _db.ExecuteQuery(query)

        For Each row As DataRow In dt.Rows
            lista.Add(MapRowToPersona(row))
        Next
        Return lista
    End Function

    Public Function GetById(idPersona As Integer) As Persona
        Dim query As String = "SELECT " & COLUMNAS & " FROM dbo.Personas WHERE IdPersona = @IdPersona"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@IdPersona", idPersona)
        }
        Dim dt As DataTable = _db.ExecuteQuery(query, params)
        If dt.Rows.Count > 0 Then
            Return MapRowToPersona(dt.Rows(0))
        End If
        Return Nothing
    End Function

    ' Útil para validar en el Service que la identificación no esté repetida.
    Public Function GetByIdentificacion(identificacion As String) As Persona
        Dim query As String = "SELECT " & COLUMNAS & " FROM dbo.Personas WHERE Identificacion = @Identificacion"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@Identificacion", identificacion)
        }
        Dim dt As DataTable = _db.ExecuteQuery(query, params)
        If dt.Rows.Count > 0 Then
            Return MapRowToPersona(dt.Rows(0))
        End If
        Return Nothing
    End Function

    ' Inserta la persona y devuelve el IdPersona generado (0 si no se insertó).
    ' El Id es necesario para crear después el Usuario o el Propietario (relación 1:1).
    Public Function Insert(p As Persona) As Integer
        Dim query As String = "INSERT INTO dbo.Personas (Identificacion, NombreCompleto, Correo) " &
                              "OUTPUT INSERTED.IdPersona " &
                              "VALUES (@Identificacion, @NombreCompleto, @Correo)"
        Dim dt As DataTable = _db.ExecuteQuery(query, BuildParams(p))
        If dt.Rows.Count > 0 Then
            Return Convert.ToInt32(dt.Rows(0)("IdPersona"))
        End If
        Return 0
    End Function

    Public Function Update(p As Persona) As Boolean
        Dim query As String = "UPDATE dbo.Personas " &
                              "SET Identificacion = @Identificacion, NombreCompleto = @NombreCompleto, Correo = @Correo " &
                              "WHERE IdPersona = @IdPersona"
        Dim params As List(Of SqlParameter) = BuildParams(p)
        params.Add(New SqlParameter("@IdPersona", p.IdPersona))
        Return _db.ExecuteNonQuery(query, params) > 0
    End Function

    ' Ojo: por ON DELETE CASCADE, borrar una persona también borra su Usuario y su Propietario.
    Public Function Delete(idPersona As Integer) As Boolean
        Dim query As String = "DELETE FROM dbo.Personas WHERE IdPersona = @IdPersona"
        Dim params As New List(Of SqlParameter) From {
            New SqlParameter("@IdPersona", idPersona)
        }
        Return _db.ExecuteNonQuery(query, params) > 0
    End Function

    ' Parámetros comunes de Insert y Update. Correo admite NULL en la tabla.
    Private Function BuildParams(p As Persona) As List(Of SqlParameter)
        Return New List(Of SqlParameter) From {
            New SqlParameter("@Identificacion", p.Identificacion),
            New SqlParameter("@NombreCompleto", p.NombreCompleto),
            New SqlParameter("@Correo", If(String.IsNullOrWhiteSpace(p.Correo), CObj(DBNull.Value), p.Correo))
        }
    End Function

    Private Function MapRowToPersona(row As DataRow) As Persona
        Return New Persona() With {
            .IdPersona = Convert.ToInt32(row("IdPersona")),
            .Identificacion = row("Identificacion").ToString(),
            .NombreCompleto = row("NombreCompleto").ToString(),
            .Correo = If(IsDBNull(row("Correo")), Nothing, row("Correo").ToString())
        }
    End Function
End Class
