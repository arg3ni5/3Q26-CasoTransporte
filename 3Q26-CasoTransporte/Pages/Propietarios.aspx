<%@ Page Title="Propietarios" Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Propietarios.aspx.vb" Inherits="_3Q26_CasoTransporte.Propietarios" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="fw-bold">Propietarios</h2>

    <%-- TODO Grupo A: reemplazar este aviso por el formulario y el GridView del módulo --%>
    <div class="alert alert-info mt-3">
        <strong>Módulo pendiente · Grupo A.</strong>
        Registrar, listar, editar y eliminar propietarios. Al registrar un propietario se crea primero la Persona y luego el Propietario, en una transacción (igual que UsuarioService.Registrar).
        <hr />
        <span class="small">Archivos del módulo: <code>Models/Propietario.vb</code> · <code>Database/PropietarioDB.vb</code> · <code>Services/PropietarioService.vb</code> · <code>Pages/Propietarios.aspx</code></span>
    </div>
</asp:Content>
