<%@ Page Title="Inicio" Language="VB" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="_3Q26_CasoTransporte._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="mb-4">
            <h1 class="fw-bold">Bienvenido,
                <asp:Literal ID="litNombre" runat="server" /></h1>
            <p class="lead text-muted mb-0">Sistema de control de propietarios, vehículos y multas.</p>
        </section>

        <div class="row g-3">
            <div class="col-sm-6 col-lg-3">
                <a runat="server" href="~/Pages/Propietarios" class="card h-100 text-decoration-none shadow-sm">
                    <div class="card-body">
                        <span class="badge bg-secondary mb-2">Grupo A</span>
                        <h5 class="card-title text-dark">Propietarios</h5>
                        <p class="card-text text-muted small">Registrar y consultar propietarios.</p>
                    </div>
                </a>
            </div>
            <div class="col-sm-6 col-lg-3">
                <a runat="server" href="~/Pages/Vehiculos" class="card h-100 text-decoration-none shadow-sm">
                    <div class="card-body">
                        <span class="badge bg-secondary mb-2">Grupo B</span>
                        <h5 class="card-title text-dark">Vehículos</h5>
                        <p class="card-text text-muted small">Registrar vehículos asociados a un propietario.</p>
                    </div>
                </a>
            </div>
            <div class="col-sm-6 col-lg-3">
                <a runat="server" href="~/Pages/TiposMulta" class="card h-100 text-decoration-none shadow-sm">
                    <div class="card-body">
                        <span class="badge bg-secondary mb-2">Grupo C</span>
                        <h5 class="card-title text-dark">Tipos de multa</h5>
                        <p class="card-text text-muted small">Catálogo de multas con monto base y estado.</p>
                    </div>
                </a>
            </div>
            <div class="col-sm-6 col-lg-3">
                <a runat="server" href="~/Pages/Multas" class="card h-100 text-decoration-none shadow-sm">
                    <div class="card-body">
                        <span class="badge bg-secondary mb-2">Grupo D</span>
                        <h5 class="card-title text-dark">Multas</h5>
                        <p class="card-text text-muted small">Registrar multas y consultarlas por vehículo.</p>
                    </div>
                </a>
            </div>

            <div class="col-sm-6 col-lg-3">
                <a runat="server" href="~/Pages/Personas" class="card h-100 text-decoration-none shadow-sm">
                    <div class="card-body">
                        <span class="badge bg-secondary mb-2">Grupo E</span>
                        <h5 class="card-title text-dark">Personas</h5>
                        <p class="card-text text-muted small">Registrar y consultar las Personas.</p>
                    </div>
                </a>
            </div>
        </div>
    </main>

</asp:Content>
