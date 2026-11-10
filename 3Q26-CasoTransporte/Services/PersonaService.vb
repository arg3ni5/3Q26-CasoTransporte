Public Class PersonaService
    Private ReadOnly _personaDB As New PersonaDB()

    Public Function ListarPersonas() As List(Of Persona)
        Return _personaDB.GetAll()
    End Function

    Public Function ObtenerPorId(id As Integer) As Persona
        If id <= 0 Then
            Throw New ArgumentException("El ID de la persona no es válido.")
        End If
        Return _personaDB.GetById(id)
    End Function

    Public Function ObtenerPorIdentificacion(identificacion As String) As Persona
        If String.IsNullOrWhiteSpace(identificacion) Then
            Throw New ArgumentException("La identificación no es válida.")
        End If
        Return _personaDB.GetByIdentificacion(identificacion)
    End Function

    Public Sub GuardarPersona(p As Persona)
        ValidarPersona(p)
        If p.IdPersona = 0 Then
            If _personaDB.GetByIdentificacion(p.Identificacion) IsNot Nothing Then
                Throw New ArgumentException("La identificación de la persona ya existe.")
            End If
            Dim nuevoId = _personaDB.Insert(p)
            p.IdPersona = nuevoId
        Else
            _personaDB.Update(p)
        End If
    End Sub

    Public Sub EliminarPersona(id As Integer)
        If id <= 0 Then
            Throw New ArgumentException("Seleccione un registro válido para eliminar.")
        End If
        _personaDB.Delete(id)
    End Sub

    Private Sub ValidarPersona(p As Persona)
        If p Is Nothing Then Throw New ArgumentException("Datos requeridos.")
        If String.IsNullOrWhiteSpace(p.Identificacion) Then Throw New ArgumentException("La identificación es obligatoria.")
        If String.IsNullOrWhiteSpace(p.NombreCompleto) Then Throw New ArgumentException("El nombre completo es obligatorio.")
        If String.IsNullOrWhiteSpace(p.Correo) OrElse Not p.Correo.Contains("@") Then Throw New ArgumentException("Ingrese un correo válido.")
    End Sub
End Class