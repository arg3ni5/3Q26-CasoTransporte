Public Class Persona
    Public Property IdPersona As Integer
    Public Property Identificacion As String
    Public Property NombreCompleto As String
    Public Property Correo As String

    Public Sub New()
    End Sub

    Public Sub New(idPersona As Integer, identificacion As String, nombreCompleto As String, correo As String)
        Me.IdPersona = idPersona
        Me.Identificacion = identificacion
        Me.NombreCompleto = nombreCompleto
        Me.Correo = correo
    End Sub
End Class