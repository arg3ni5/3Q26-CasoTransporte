<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Registro.aspx.vb" Inherits="_3Q26_CasoTransporte.Registro" %>

<!DOCTYPE html>
<html lang="es">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Crear cuenta - Control de Transporte</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>

    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="~/Content/Auth.css" rel="stylesheet" />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
</head>
<body class="auth-body">
    <form id="form1" runat="server" defaultbutton="btnRegistrar">
        <main class="auth-wrapper">
            <div class="auth-card auth-card-wide">

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
                        <h1>Cree su cuenta</h1>
                        <p class="mt-2">Con su usuario podrá administrar la información de la flota.</p>
                    </div>
                    <ul class="auth-features">
                        <li>Usuario de 4 a 30 caracteres</li>
                        <li>Contraseña de 8 o más, con letras y números</li>
                        <li>Identificación y usuario no se repiten</li>
                    </ul>
                </section>

                <%-- Formulario --%>
                <section class="auth-form">
                    <h2>Crear cuenta</h2>
                    <p class="auth-subtitle">Complete sus datos personales y sus credenciales de acceso.</p>

                    <div class="auth-section-title">Datos personales</div>
                    <div class="row g-3 mb-3">
                        <div class="col-md-5">
                            <div class="form-floating">
                                <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="form-control" placeholder="Identificación" MaxLength="30"></asp:TextBox>
                                <label for="txtIdentificacion">Identificación</label>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="form-floating">
                                <asp:TextBox ID="txtNombreCompleto" runat="server" CssClass="form-control" placeholder="Nombre completo"
                                    MaxLength="120" autocomplete="name"></asp:TextBox>
                                <label for="txtNombreCompleto">Nombre completo</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-floating">
                                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" TextMode="Email" placeholder="Correo"
                                    MaxLength="120" autocomplete="email"></asp:TextBox>
                                <label for="txtCorreo">Correo electrónico</label>
                            </div>
                        </div>
                    </div>

                    <div class="auth-section-title">Credenciales</div>
                    <div class="row g-3">
                        <div class="col-12">
                            <div class="form-floating">
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nombre de usuario"
                                    MaxLength="30" autocomplete="username"></asp:TextBox>
                                <label for="txtUsername">Nombre de usuario</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating password-field">
                                <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" TextMode="Password"
                                    placeholder="Contraseña" autocomplete="new-password"></asp:TextBox>
                                <label for="txtPass">Contraseña</label>
                                <button type="button" class="password-toggle" data-target="txtPass" aria-label="Mostrar contraseña">Mostrar</button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating password-field">
                                <asp:TextBox ID="txtConfirmar" runat="server" CssClass="form-control" TextMode="Password"
                                    placeholder="Confirmar contraseña" autocomplete="new-password"></asp:TextBox>
                                <label for="txtConfirmar">Confirmar contraseña</label>
                                <button type="button" class="password-toggle" data-target="txtConfirmar" aria-label="Mostrar contraseña">Mostrar</button>
                            </div>
                        </div>
                    </div>
                    <p class="auth-hint mt-2 mb-4">Mínimo 8 caracteres, con al menos una letra y un número.</p>

                    <asp:Button ID="btnRegistrar" runat="server" Text="Crear cuenta" OnClick="btnRegistrar_Click"
                        CssClass="btn btn-auth w-100" />

                    <p class="auth-switch mb-0">
                        ¿Ya tiene cuenta?<a href="Login">Iniciar sesión</a>
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
