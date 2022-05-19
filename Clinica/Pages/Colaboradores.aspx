<%@ Page Title="Colaboradores" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Colaboradores.aspx.cs" Inherits="Clinica.Pages.Colaboradores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="../Scripts/jquery-3.6.0.min.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-md-3">
            <input type="text" runat="server" id="txtNombre" class="form-control UpperCase" placeholder="Nombre" maxlength="100" />
        </div>
        <div class="col-md-3"></div>
        <div class="col-md-3"></div>
        <div class="col-md-3"></div>
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
            <asp:GridView ID="gvColaboradores" runat="server" AutoGenerateColumns="false" CssClass="table table-responsive-md" OnSelectedIndexChanged="gvColaboradores_SelectedIndexChanged" AutoGenerateSelectButton="true">
                <Columns>
                    <asp:BoundField HeaderText="Id" DataField="Id" />
                    <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                    <asp:BoundField HeaderText="Detalle" DataField="Detalle" />
                    <asp:BoundField HeaderText="Fecha de emisión" DataField="FechaEmision" />
                    <asp:BoundField HeaderText="Importe" DataField="Importe" />
                    <asp:BoundField HeaderText="Pagado" DataField="Pagado" />
                    <asp:BoundField HeaderText="Fecha de pago" DataField="FechaPago" />
                    <asp:BoundField HeaderText="Concepto" DataField="Concepto" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div class="row mt-lg-5">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Nombre:"></asp:Label>
            <asp:DropDownList ID="ddlColaboradores" runat="server" Visible="false" DataValueField="Id" DataTextField="Nombre" CssClass="form-control"></asp:DropDownList>
            <input type="text" runat="server" id="txtNombreG" visible="true" class="form-control UpperCase" placeholder="Nombre" maxlength="100" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Detalle:"></asp:Label>
            <input type="text" runat="server" id="txtDetalleG" class="form-control" placeholder="Detalle" readonly="readonly" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Fecha de emisión:"></asp:Label>
            <input type="date" runat="server" id="txtFechaEmisionG" class="form-control" placeholder="dd/MM/yyyy" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Importe:"></asp:Label>
            <input type="number" runat="server" id="txtImporte" class="form-control" placeholder="Importe" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-3">
            <asp:Label runat="server" Text="Pagado:"></asp:Label>
            <input type="checkbox" runat="server" id="txtPagado" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Fecha de pago:"></asp:Label>
            <input type="date" runat="server" id="txtFechaPago" class="form-control" placeholder="dd/MM/yyyy" />
        </div>
        <div class="col-md-3">
            <asp:Label runat="server" Text="Concepto:"></asp:Label>
            <input type="text" runat="server" id="txtConcepto" class="form-control UpperCase" placeholder="Concepto" maxlength="200" />
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
            <asp:Button ID="btnNuevoDetalle" runat="server" Text="Nuevo detalle" CssClass="btn btn-secondary" OnClick="btnNuevoDetalle_Click" style="width: 90%;" />
        </div>
        <div class="col-md-3">
        </div>
    </div>

    <input type="hidden" id="hdnIdColaborador" runat="server" />
    <input type="hidden" id="hdnIdColaboradorDetalle" runat="server" />

    <script type="text/javascript">
        function btnExportarExcel_Click() {
            $.ajax({
                async: false,
                url: '/Pages/Colaboradores.aspx/btnExportarExcel_Click',
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
