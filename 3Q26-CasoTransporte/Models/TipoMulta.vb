Public Class TipoMulta
    Public Property IdTipoMulta As Integer
    Public Property Descripcion As String
    Public Property MontoBase As Decimal
    Public Property Activa As Boolean

    Public Sub New()
    End Sub

    Public Sub New(idTipoMulta As Integer, descripcion As String, montoBase As Decimal, activa As Boolean)
        Me.IdTipoMulta = idTipoMulta
        Me.Descripcion = descripcion
        Me.MontoBase = montoBase
        Me.Activa = activa
    End Sub
End Class
