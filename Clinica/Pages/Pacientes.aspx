<%@ Page Title="Pacientes" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Pacientes.aspx.cs" Inherits="Clinica.Pages.Pacientes" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="../Scripts/jquery-3.6.0.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Apellido paterno:"></asp:Label>
            <input type="text" runat="server" id="txtPaterno" class="form-control UpperCase" placeholder="Apellido Paterno" maxlength="80" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Apellido materno:"></asp:Label>
            <input type="text" runat="server" id="txtMaterno" class="form-control UpperCase" placeholder="Apellido Materno" maxlength="80" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Nombre:"></asp:Label>
            <input type="text" runat="server" id="txtNombre" class="form-control UpperCase" placeholder="Nombre" maxlength="80" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Teléfono:"></asp:Label>
            <input type="number" runat="server" id="txtTelContacto" class="form-control UpperCase" placeholder="Teléfono" />
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-3">
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-primary" OnClick="btnBuscar_Click" style="width: 90%;" />
        </div>
        <div class="col-md-3">
            <input type="button" id="btnExportarExcel" value="Exportar Excel" class="btn btn-success" onclick="btnExportarExcel_Click();return false;" style="width: 90%;" />
        </div>
        <div class="col-md-3">
        </div>
        <div class="col-md-3">
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-12">
            <asp:GridView ID="gvPacientes" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive-md" OnSelectedIndexChanged="gvPacientes_SelectedIndexChanged" AutoGenerateSelectButton="true">
                <Columns>
                    <asp:BoundField HeaderText="Id" DataField="Id" />
                    <asp:BoundField HeaderText="ApellidoPaterno" DataField="ApellidoPaterno" />
                    <asp:BoundField HeaderText="ApellidoMaterno" DataField="ApellidoMaterno" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="TelContacto" DataField="TelContacto" />
                    <asp:BoundField HeaderText="Responsable" DataField="Responsable" />
                    <asp:BoundField HeaderText="LugarResidencia" DataField="LugarResidencia" />
                    <asp:BoundField HeaderText="Estatus" DataField="Estatus" />
                    <asp:BoundField HeaderText="Tipo" DataField="Tipo" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div class="row mt-lg-5">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Apellido paterno:"></asp:Label>
            <input type="text" runat="server" id="txtPaternoG" class="form-control UpperCase" placeholder="Apellido Paterno" maxlength="80" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Apellido materno:"></asp:Label>
            <input type="text" runat="server" id="txtMaternoG" class="form-control UpperCase" placeholder="Apellido Materno" maxlength="80" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Nombre:"></asp:Label>
            <input type="text" runat="server" id="txtNombreG" class="form-control UpperCase" placeholder="Nombre" maxlength="80" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Teléfono:"></asp:Label>
            <input type="number" runat="server" id="txtTelContactoG" class="form-control UpperCase" placeholder="Teléfono" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Responsable:"></asp:Label>
            <input type="text" runat="server" id="txtResponsableG" class="form-control UpperCase" placeholder="Responsable" maxlength="200" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Lugar de residencia:"></asp:Label>
            <input type="text" runat="server" id="txtLugarResidenciaG" class="form-control UpperCase" placeholder="Lugar de Residencia" maxlength="200" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Estatus:"></asp:Label>
            <select id="sEstatus" runat="server" class="form-control">
                <option value="0">SELECCIONE UN ESTATUS</option>
                <option value="1">ACTIVO</option>
                <option value="2">INACTIVO</option>
                <option value="3">BAJA</option>
            </select>
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Tipo de tratamiento:"></asp:Label>
            <asp:DropDownList ID="sTipo" runat="server" AutoPostBack="false" DataTextField="Nombre" DataValueField="Id" CssClass="form-control"></asp:DropDownList>
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

    <input type="hidden" id="hdnIdPaciente" runat="server" />

    <script type="text/javascript">
        function btnExportarExcel_Click() {
            $.ajax({
                async: false,
                url: '/Pages/Pacientes.aspx/btnExportarExcel_Click',
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

