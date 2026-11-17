<%@ Page Title="Tipos de multa" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="TiposMulta.aspx.vb" Inherits="_3Q26_CasoTransporte.TiposMulta" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="fw-bold">Tipos de multa</h2>

    <%-- TODO Grupo C: reemplazar este aviso por el formulario y el GridView del módulo --%>
    <div class="alert alert-info mt-3">
        <strong>Módulo pendiente · Grupo C.</strong>
        Mantenimiento del catálogo de tipos de multa: descripción, monto base y estado activo/inactivo. Un tipo con multas asociadas no se elimina: se desactiva.
        <hr />
        <span class="small">Archivos del módulo: <code>Models/TipoMulta.vb</code> · <code>Database/TipoMultaDB.vb</code> · <code>Services/TipoMultaService.vb</code> · <code>Pages/TiposMulta.aspx</code></span>
    </div>
</asp:Content>
