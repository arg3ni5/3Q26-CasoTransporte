' Grupo B: módulo de Vehículos.
' La página ya está protegida: hereda de BasePage, así que sin sesión redirige al Login.
' Reglas: la página solo llama a VehiculoService y muestra mensajes con SwalUtils
' (atrapar ArgumentException -> SwalUtils.ShowWarning, Exception -> SwalUtils.ShowError).
Public Class Vehiculos
    Inherits BasePage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' TODO Grupo B: cargar el GridView / DropDownList del módulo
        End If
    End Sub
End Class
