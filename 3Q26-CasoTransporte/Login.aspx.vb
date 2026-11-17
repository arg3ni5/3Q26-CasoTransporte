' Capa de presentación: Login.
' Solo lee el formulario, llama al Service y muestra el resultado con SwalUtils.
' Es una página pública: hereda de Page (no de BasePage).
Public Class Login
    Inherits System.Web.UI.Page

    Private ReadOnly _usuarioService As New UsuarioService()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then Return

        ' Si ya inició sesión, no tiene sentido mostrar el login
        If SesionUtils.HaySesion Then
            Response.Redirect("~/Default", False)
            Context.ApplicationInstance.CompleteRequest()
            Return
        End If

        ' Mensajes que llegan desde otras páginas por QueryString
        If Request.QueryString("registro") = "ok" Then
            SwalUtils.ShowSuccess(Me, "Cuenta creada correctamente. Ya puede iniciar sesión.")
        ElseIf Request.QueryString("sesion") = "requerida" Then
            SwalUtils.ShowWarning(Me, "Debe iniciar sesión para acceder a esa página.")
        ElseIf Request.QueryString("sesion") = "cerrada" Then
            SwalUtils.ShowSuccess(Me, "Sesión cerrada correctamente.")
        End If
    End Sub

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs)
        Try
            Dim usuario As Usuario = _usuarioService.Login(txtUsername.Text, txtPass.Text)
            SesionUtils.IniciarSesion(usuario)

            ' Redirect con False + CompleteRequest: evita la ThreadAbortException dentro del Try
            Response.Redirect("~/Default", False)
            Context.ApplicationInstance.CompleteRequest()
        Catch ex As ArgumentException
            SwalUtils.ShowWarning(Me, ex.Message)
        Catch ex As Exception
            SwalUtils.ShowError(Me, "No se pudo iniciar sesión: " & ex.Message)
        End Try
    End Sub
End Class
