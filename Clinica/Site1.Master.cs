using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Clinica.Code;

namespace Clinica
{
    public partial class Site1 : BaseMasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Cache.SetExpires(DateTime.Now.AddDays(-1));
                Response.Cache.SetNoStore();
            }

            if (this.UsuarioSis == null)
            {
                Response.Cache.SetExpires(DateTime.Now.AddDays(-1));
                Response.Cache.SetNoStore();

                this.Page.Response.Redirect("/Inicio.aspx");
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            this.UsuarioSis = null;
            this.Page.Response.Redirect("/Inicio.aspx");
        }
    }
}
