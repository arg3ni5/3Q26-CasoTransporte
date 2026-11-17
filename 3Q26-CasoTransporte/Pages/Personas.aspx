<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Personas.aspx.vb" Inherits="_3Q26_CasoTransporte.Personas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2 class="mb-3">Gestión de Personas</h2>
    <div class="card mb-4">

        <div class="card-header bg-primary text-white">
            <asp:Label ID="lblTituloForm" runat="server" Text="Nueva Persona" />
        </div>

        <div class="card-body row g-3" runat="server" id="divFormulario" visible="false">
            <div class="col-md-4">
                <label>Identificación</label>
                <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="form-control" />
            </div>
            <div class="col-md-4">
                <label>Nombre Completo</label>
                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" />
            </div>
            <div class="col-md-6">
                <label>Correo</label>
                <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" TextMode="Email" />
            </div>

            <div class="col-md-3 d-flex align-items-end gap-2">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-success w-100" OnClick="btnGuardar_Click" />
                <asp:Button ID="btnLimpiar" runat="server" Text="Cancelar" CssClass="btn btn-secondary w-100" OnClick="btnLimpiar_Click" />
            </div>
        </div>

        <div class="card-body row g-3">
            <asp:GridView ID="gvPersonas" runat="server"
                CssClass="table"
                AllowPaging="True" AutoGenerateColumns="False"
                DataKeyNames="Identificacion" 
                OnRowCommand="gvPersonas_RowCommand">
                <Columns>
                    <asp:BoundField DataField="IdPersona" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="IdPersona" />
                    <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                    <asp:BoundField DataField="NombreCompleto" HeaderText="Nombre Completo" SortExpression="NombreCompleto" />
                    <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
                    <asp:TemplateField HeaderText="Acciones">
                        <ItemTemplate>
                            <asp:Button ID="btnSeleccionar" runat="server" Text="Editar" CommandName="Seleccionar" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-warning me-1" />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CommandName="Eliminar" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-sm btn-danger" OnClientClick="return confirm('¿Eliminar este registro?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>
    </div>
</asp:Content>
