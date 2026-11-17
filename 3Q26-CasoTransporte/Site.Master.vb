Public Class SiteMaster
    Inherits MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        ' Muestra el usuario conectado y el botón para cerrar sesión
        Dim usuario As Usuario = SesionUtils.UsuarioActual
        phUsuario.Visible = usuario IsNot Nothing
        If usuario IsNot Nothing Then
            litUsuario.Text = Server.HtmlEncode(usuario.NombreCompleto & " (" & usuario.Rol & ")")
        End If
    End Sub

    Protected Sub lnkCerrarSesion_Click(sender As Object, e As EventArgs)
        SesionUtils.CerrarSesion()
        Response.Redirect("~/Login?sesion=cerrada", False)
        Context.ApplicationInstance.CompleteRequest()
    End Sub
End Class
