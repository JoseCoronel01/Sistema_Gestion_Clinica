<%@ Page Title="Notas de evolución" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="NotasEvolucion.aspx.cs" Inherits="Clinica.Pages.NotasEvolucion" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="../Scripts/jquery-3.6.0.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-3">
            <Label Text="Título:"></Label>
            <input type="text" runat="server" id="txtTitulo" class="form-control UpperCase" placeholder="Título" maxlength="30" />
        </div>
        <div class="col-md-3">
            <Label Text="Fecha:"></Label>
            <input type="datetime-local" runat="server" id="txtFecha" class="form-control" placeholder="dd/MM/yyyy hh:mm:ss" />
        </div>
        <div class="col-md-3"></div>
        <div class="col-md-3"></div>
    </div>

    <div class="row mt-4">
        <div class="col-md-3">
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" OnClick="btnBuscar_Click" style="width: 90%;" />
        </div>
        <div class="col-md-3">
            <input type="button" id="btnExportarExcel" Text="Exportar Excel" class="btn btn-success" onclick="btnExportarExcel_Click();return false;" value="Exportar Excel" style="width: 90%;" />
        </div>
        <div class="col-md-3">
        </div>
        <div class="col-md-3">
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-12">
            <asp:GridView ID="gvNotasEvolucion" runat="server" AutoGenerateColumns="false"
                CssClass="table table-responsive-md" 
                OnSelectedIndexChanged="gvNotasEvolucion_SelectedIndexChanged" 
                AutoGenerateSelectButton="true">
                <Columns>
                    <asp:BoundField HeaderText="Id" DataField="Id" />
                    <asp:BoundField HeaderText="Titulo" DataField="Titulo" />
                    <asp:BoundField HeaderText="Descripción" DataField="Descripcion" />
                    <asp:BoundField HeaderText="Fecha" DataField="Fecha" />
                    <asp:BoundField HeaderText="Paciente" DataField="Paciente" />
                    <asp:BoundField HeaderText="Usuario" DataField="Usuario" />
                    <asp:BoundField HeaderText="Estado" DataField="Estado" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div class="row mt-lg-5">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Título:"></asp:Label>
            <input type="text" runat="server" id="txtTituloG" class="form-control UpperCase" placeholder="Título" maxlength="30" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Descripción:"></asp:Label>
            <input type="text" runat="server" id="txtDescripcionG" class="form-control UpperCase" placeholder="Descripción" maxlength="150" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Fecha:"></asp:Label>
            <input type="datetime-local" runat="server" id="txtFechaG" class="form-control" placeholder="dd/MM/yyyy hh:mm:ss" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Paciente:"></asp:Label>
            <asp:DropDownList ID="ddlPacientesG" runat="server" DataValueField="Id" DataTextField="NombreCompleto" CssClass="form-control"></asp:DropDownList>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Colaborador:"></asp:Label>
            <input type="text" runat="server" id="txtUsuarioG" class="form-control UpperCase" placeholder="Colaborador" maxlength="15" readonly="readonly" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Estado de la nota:"></asp:Label>
            <asp:DropDownList ID="ddlEstadoG" runat="server" DataValueField="Id" DataTextField="Nombre" CssClass="form-control"></asp:DropDownList>
        </div>
        <div class="col-md-3">
        </div>
        <div class="col-md-3">
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-3">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-warning" OnClick="btnGuardar_Click" style="width: 90%;" />
        </div>
        <div class="col-md-3">
            <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" CssClass="btn btn-danger" OnClick="btnNuevo_Click" style="width: 90%;" />
        </div>
        <div class="col-md-3">
        </div>
        <div class="col-md-3">
        </div>
    </div>

    <input type="hidden" id="hdnIdNotaEvolucion" runat="server" />

    <script type="text/javascript">
        function btnExportarExcel_Click() {
            $.ajax({
                async: false,
                url: '/Pages/NotasEvolucion.aspx/btnExportarExcel_Click',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: null,
                success: function (data) {
                    swal('Aviso', data.d, 'success');
                },
                error: function (error) {
                    swal('Error', error, 'error');
                }
            });
        }
    </script>

</asp:Content>
