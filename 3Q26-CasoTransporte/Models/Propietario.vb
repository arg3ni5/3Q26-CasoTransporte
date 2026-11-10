Public Class Propietario
    Inherits Persona
    Public Property Telefono As String
    Public Property Direccion As String

    Public Sub New()
        MyBase.New()
    End Sub

    Public Sub New(idPersona As Integer, identificacion As String, nombreCompleto As String, correo As String,
                   telefono As String, direccion As String)
        MyBase.New(idPersona, identificacion, nombreCompleto, correo)
        Me.Telefono = telefono
        Me.Direccion = direccion
    End Sub
End Class