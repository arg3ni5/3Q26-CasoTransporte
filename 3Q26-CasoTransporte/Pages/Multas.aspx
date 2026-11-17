<%@ Page Title="Multas" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Multas.aspx.vb" Inherits="_3Q26_CasoTransporte.Multas" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="fw-bold">Multas</h2>

    <%-- TODO Grupo D: reemplazar este aviso por el formulario y el GridView del módulo --%>
    <div class="alert alert-info mt-3">
        <strong>Módulo pendiente · Grupo D.</strong>
        Registrar multas (DropDownList de vehículos y de tipos de multa activos; MontoAplicado toma el MontoBase vigente) y consultar las multas de un vehículo con un JOIN entre Multas, Vehiculos, Propietarios, Personas y TiposMulta.
        <hr />
        <span class="small">Archivos del módulo: <code>Models/Multa.vb</code> · <code>Database/MultaDB.vb</code> · <code>Services/MultaService.vb</code> · <code>Pages/Multas.aspx</code></span>
    </div>
</asp:Content>
