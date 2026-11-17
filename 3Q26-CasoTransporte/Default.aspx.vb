' Página de inicio: requiere sesión, por eso hereda de BasePage.
Public Class _Default
    Inherits BasePage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            litNombre.Text = Server.HtmlEncode(UsuarioActual.NombreCompleto)
        End If
    End Sub
End Class
