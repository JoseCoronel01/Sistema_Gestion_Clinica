using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Clinica.Code;
using Clinica.Datos;
using System.Data;

namespace Clinica
{
    public partial class Inicio : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUser.Value = "";
                txtPwd.Value = "";
            }
        }

        protected void btnEntrar_Click(object sender, EventArgs e)
        {
            bool entro = false;
            if (txtUser.Value != "" && txtPwd.Value != "")
            {
                BDGenerica bd = new BDGenerica("AccesoAlSistema", 2);
                bd.AgregarParametros("Usuario", 22, txtUser.Value, 0);
                bd.AgregarParametros("Password", 22, txtPwd.Value, 1);
                DataTable dt = bd.EjecutarSP();
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        entro = true;
                        this.UsuarioSis = dt.Rows[0]["Usuario"].ToString();
                    }
                }
            }
            if (!entro)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Usuario o contraseña incorrectos');", true);
            }
            else
            {
                txtUser.Value = "";
                txtPwd.Value = "";
                this.Page.Response.Redirect("/Menu.aspx");
            }
        }
    }
}
