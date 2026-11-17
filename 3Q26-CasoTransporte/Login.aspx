<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="_3Q26_CasoTransporte.Login" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Iniciar sesión - Control de Transporte</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>

    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/Content/Auth.css" rel="stylesheet" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
</head>
<body class="auth-body">
    <form id="form1" runat="server" defaultbutton="btnLogin">
        <main class="auth-wrapper">
            <div class="auth-card">

                <%-- Panel de marca --%>
                <section class="auth-brand">
                    <div class="auth-logo">
                        <span class="auth-logo-icon" aria-hidden="true">
                            <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M3 6h11v9H3z" /><path d="M14 9h4l3 3v3h-7z" />
                                <circle cx="7" cy="17.5" r="1.8" /><circle cx="17" cy="17.5" r="1.8" />
                            </svg>
                        </span>
                        Control de Transporte
                    </div>
                    <div class="auth-brand-text">
                        <h1>Toda la flota en un solo lugar</h1>
                        <p class="mt-2">Consulte propietarios, vehículos y multas desde una misma aplicación.</p>
                    </div>
                    <ul class="auth-features">
                        <li>Propietarios y sus vehículos</li>
                        <li>Multas por vehículo y tipo</li>
                        <li>Acceso con usuario y sesión</li>
                    </ul>
                </section>

                <%-- Formulario --%>
                <section class="auth-form">
                    <h2>Iniciar sesión</h2>
                    <p class="auth-subtitle">Ingrese sus credenciales para continuar.</p>

                    <div class="form-floating mb-3">
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nombre de usuario"
                            MaxLength="30" autocomplete="username" autofocus="autofocus"></asp:TextBox>
                        <label for="txtUsername">Nombre de usuario</label>
                    </div>

                    <div class="form-floating password-field mb-4">
                        <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password"
                            placeholder="Contraseña" autocomplete="current-password"></asp:TextBox>
                        <label for="txtPass">Contraseña</label>
                        <button type="button" class="password-toggle" data-target="txtPass" aria-label="Mostrar contraseña">Mostrar</button>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Ingresar" OnClick="btnLogin_Click"
                        CssClass="btn btn-auth w-100" />

                    <p class="auth-switch mb-0">
                        ¿No tiene cuenta?<a href="Registro">Crear una cuenta</a>
                    </p>
                </section>

            </div>
        </main>

        <%-- SweetAlert2 debe cargarse antes de los mensajes que registra SwalUtils --%>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            // Mostrar / ocultar contraseña
            document.querySelectorAll('.password-toggle').forEach(function (btn) {
                btn.addEventListener('click', function () {
                    var input = document.getElementById(btn.getAttribute('data-target'));
                    var visible = input.type === 'text';
                    input.type = visible ? 'password' : 'text';
                    btn.textContent = visible ? 'Mostrar' : 'Ocultar';
                    btn.setAttribute('aria-label', visible ? 'Mostrar contraseña' : 'Ocultar contraseña');
                });
            });
        </script>
    </form>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/jquery") %>
        <%: Scripts.Render("~/bundles/bootstrap") %>
    </asp:PlaceHolder>
</body>
</html>
