' Página base para todas las páginas que requieren sesión.
' En lugar de heredar de System.Web.UI.Page, cada página protegida hereda de BasePage:
'
'   Public Class Vehiculos
'       Inherits BasePage
'
' Si no hay un usuario autenticado, se redirige al Login antes de ejecutar Page_Load.
' Login.aspx y Registro.aspx NO heredan de BasePage (son públicas).
Public Class BasePage
    Inherits System.Web.UI.Page

    Protected Overrides Sub OnInit(e As EventArgs)
        If Not SesionUtils.HaySesion Then
            Response.Redirect("~/Login?sesion=requerida", True)
        End If
        MyBase.OnInit(e)
    End Sub

    ' Usuario autenticado, disponible en cualquier página que herede de BasePage
    Protected ReadOnly Property UsuarioActual As Usuario
        Get
            Return SesionUtils.UsuarioActual
        End Get
    End Property
End Class
