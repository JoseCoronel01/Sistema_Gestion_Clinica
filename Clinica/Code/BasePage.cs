using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Configuration;

namespace Clinica.Code
{
    public class BasePage : Page
    {
        public string ObtenerCadenaConexionSql
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            }
        }

        public string UsuarioSis
        {
            get
            {
                return (Session["UsuarioSis"] != null) ? Session["UsuarioSis"].ToString() : null;
            }
            set
            {
                Session["UsuarioSis"] = value;
            }
        }
    }
}
