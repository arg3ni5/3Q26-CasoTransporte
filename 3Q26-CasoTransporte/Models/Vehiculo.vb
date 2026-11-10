Public Class Vehiculo
    Public Property IdVehiculo As Integer
    Public Property Placa As String
    Public Property Marca As String
    Public Property Modelo As String
    Public Property IdPropietario As Integer
    Public Property PropietarioObj As Propietario

    Public Sub New()
    End Sub

    Public Sub New(idVehiculo As Integer, placa As String, marca As String, modelo As String, idPropietario As Integer)
        Me.IdVehiculo = idVehiculo
        Me.Placa = placa
        Me.Marca = marca
        Me.Modelo = modelo
        Me.IdPropietario = idPropietario
    End Sub
End Class