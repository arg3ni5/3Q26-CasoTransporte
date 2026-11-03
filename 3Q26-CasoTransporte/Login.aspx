<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="_3Q26_CasoTransporte.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Iniciar Sesión</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>

    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

    <style>
        .form-floating > .form-control {
            height: 58px;
            min-height: 58px;
            padding: 1rem 0.75rem;
            width: 100% !important;
        }

        .form-floating > label {
            padding: 1rem 0.75rem;
        }
    </style>
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <div class="container min-vh-100 d-flex align-items-center justify-content-center py-4">
            <div class="card shadow-lg border-0 rounded-4 w-100" style="max-width: 500px;">

                <div class="card-header text-center text-white rounded-top-4 border-0 py-4"
                    style="background: linear-gradient(135deg, #1ECECB, #159f9c);">
                    <h2 class="mb-1 fw-bold">Iniciar Sesión</h2>
                    <p class="mb-0 small">Ingrese sus credenciales para continuar</p>
                </div>

                <div class="card-body p-4">
                    <div class="mx-auto w-100" style="max-width: 420px;">

                        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block" Visible="False"></asp:Label>

                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control rounded-3" placeholder="Nombre de usuario"></asp:TextBox>
                            <label for="txtUsername">Nombre de usuario</label>
                        </div>

                        <div class="form-floating mb-3">
                            <asp:TextBox ID="txtPass" runat="server" CssClass="form-control rounded-3" TextMode="Password" placeholder="Contraseña"></asp:TextBox>
                            <label for="txtPass">Contraseña</label>
                        </div>

                        <div class="d-grid mt-4">
                            <asp:Button ID="btnLogin" runat="server" Text="Ingresar" OnClick="btnLogin_Click"
                                CssClass="btn btn-lg text-white fw-bold rounded-3"
                                Style="background-color: #E76862;" />
                        </div>
                    </div>
                </div>

                <div class="card-footer bg-white text-center border-0 pb-4">
                    <span class="text-muted">¿No tiene cuenta?</span>
                    <a href="Registro.aspx" class="text-decoration-none fw-bold ms-1" style="color:#1ECECB;">Registrarse</a>
                </div>

            </div>
        </div>        
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </form>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/jquery") %>
        <%: Scripts.Render("~/bundles/bootstrap") %>
    </asp:PlaceHolder>
</body>
</html>
