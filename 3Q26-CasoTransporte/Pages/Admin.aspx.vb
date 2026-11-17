Public Class Admin
    Inherits BasePage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not SesionUtils.EsAdministrador Then
            Response.Redirect("~/Pages/User", True)
        End If
    End Sub

    Protected Overrides Sub OnInit(e As EventArgs)
        If Not SesionUtils.EsAdministrador Then
            Response.Redirect("~/Pages/User", True)
        End If
        MyBase.OnInit(e)
    End Sub
End Class