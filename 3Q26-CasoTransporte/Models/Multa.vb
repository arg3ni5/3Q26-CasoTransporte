Public Class Multa
    Public Property IdMulta As Integer
    Public Property IdVehiculo As Integer
    Public Property IdTipoMulta As Integer
    Public Property Fecha As DateTime
    ' Copia del MontoBase del tipo de multa al momento de registrarla:
    ' si el tipo cambia de monto después, las multas viejas conservan su valor.
    Public Property MontoAplicado As Decimal
    Public Property Pagada As Boolean

    ' Se llenan con consultas JOIN cuando se necesitan para mostrar información relacionada
    Public Property VehiculoObj As Vehiculo
    Public Property TipoMultaObj As TipoMulta

    Public Sub New()
    End Sub

    Public Sub New(idMulta As Integer, idVehiculo As Integer, idTipoMulta As Integer, fecha As DateTime,
                   montoAplicado As Decimal, pagada As Boolean)
        Me.IdMulta = idMulta
        Me.IdVehiculo = idVehiculo
        Me.IdTipoMulta = idTipoMulta
        Me.Fecha = fecha
        Me.MontoAplicado = montoAplicado
        Me.Pagada = pagada
    End Sub
End Class
