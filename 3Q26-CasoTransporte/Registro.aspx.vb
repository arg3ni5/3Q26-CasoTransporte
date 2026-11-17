' Capa de presentación: Registro de usuarios.
' Arma el objeto Usuario con los datos del formulario y delega todas las reglas a UsuarioService.
' Es una página pública: hereda de Page (no de BasePage).
Public Class Registro
    Inherits System.Web.UI.Page

    Private ReadOnly _usuarioService As New UsuarioService()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack AndAlso SesionUtils.HaySesion Then
            Response.Redirect("~/Default", False)
            Context.ApplicationInstance.CompleteRequest()
        End If
    End Sub

    Protected Sub btnRegistrar_Click(sender As Object, e As EventArgs)
        Try
            Dim nuevo As New Usuario() With {
                .Identificacion = txtIdentificacion.Text,
                .NombreCompleto = txtNombreCompleto.Text,
                .Correo = txtCorreo.Text,
                .Username = txtUsername.Text
            }

            _usuarioService.Registrar(nuevo, txtPass.Text, txtConfirmar.Text)

            Response.Redirect("~/Login?registro=ok", False)
            Context.ApplicationInstance.CompleteRequest()
        Catch ex As ArgumentException
            SwalUtils.ShowWarning(Me, ex.Message)
        Catch ex As Exception
            SwalUtils.ShowError(Me, "No se pudo completar el registro: " & ex.Message)
        End Try
    End Sub
End Class
