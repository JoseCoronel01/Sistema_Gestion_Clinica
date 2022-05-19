<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="Clinica.Inicio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container p-lg-5">
            <div class="row mt-5">
                <div class="col-md-12">
                    <input type="text" id="txtUser" runat="server" placeholder="Usuario" class="form-control" />
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <input type="password" id="txtPwd" runat="server" placeholder="Contraseña" class="form-control" />
                </div>
            </div>
            <div class="row mt-5">
                <div class="col-md-12">
                    <asp:Button ID="btnEntrar" runat="server" Text="ENTRAR" OnClick="btnEntrar_Click" CssClass="btn btn-primary" style="width: 100%;" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
