using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Clinica.Code;
using System.Data;
using Clinica.Datos;
using System.Configuration;
using System.Web.Services;

namespace Clinica.Pages
{
    public partial class NotasEvolucion : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hdnIdNotaEvolucion.Value = "0";
                txtUsuarioG.Value = this.UsuarioSis;
                ObtenerEstadosNE();
                CargarPacientes();
            }
        }

        [WebMethod]
        public static string btnExportarExcel_Click()
        {
            string mensaje = string.Empty;
            DataTable tabla = null;
            BDGenerica bd = new BDGenerica("ReporteNotasEvolucion", 0);
            tabla = bd.EjecutarSP();
            if (tabla.Rows.Count > 0)
            {
                Util.ExportarExcel(@"" + ConfigurationManager.AppSettings["Reportes"].ToString(), "NotasEvolucion.xlsx", "NotasEvolucion", tabla);
                mensaje = "Reporte descargado correctamente, ubicación: " + ConfigurationManager.AppSettings["Reportes"].ToString() + "";
                //ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('');", true);
            }
            else
                mensaje = "Sin datos";
            return mensaje;
            //else
            //    ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('');", true);
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            DataTable dt = null;
            try
            {
                BDGenerica bd = null;
                if (txtFecha.Value != "")
                {
                    bd = new BDGenerica("BusquedaNotaEvolucion", 2);
                    bd.AgregarParametros("Titulo", 22, txtTitulo.Value.ToUpper(), 0);
                    bd.AgregarParametros("Fecha", 4, DateTime.Parse(txtFecha.Value).ToString("yyyy/MM/dd"), 1);
                }
                else
                {
                    bd = new BDGenerica("BusquedaNotaEvolucion", 2);
                    bd.AgregarParametros("Titulo", 22, txtTitulo.Value.ToUpper(), 0);
                    bd.AgregarParametros("Fecha", 4, new DateTime(1990, 1, 1).ToString("yyyy/MM/dd"), 1);
                }
                dt = bd.EjecutarSP();
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        MostrarDatos(dt);
                        gvNotasEvolucion.DataSource = dt;
                        gvNotasEvolucion.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('" + ex.Message + "');", true);
            }
            finally { }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            DataTable dt = null;
            if (txtTituloG.Value == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Favor de proporcionar un título para la nota de evolución');", true);
                return;
            }
            else if (txtFechaG.Value == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Favor de proporcionar una fecha para la nota de evolución');", true);
                return;
            }

            string Mensaje = string.Empty;
            bool Exito = false;
            try
            {
                if (int.Parse(hdnIdNotaEvolucion.Value) == int.Parse("0"))
                {
                    hdnIdNotaEvolucion.Value = NuevoId();
                    Mensaje = "Datos guardados correctamente";
                }
                else
                    Mensaje = "Datos actualizados correctamente";
                BDGenerica bd = new BDGenerica("CatNotaEvolucion", 7);
                bd.AgregarParametros("Titulo", 22, txtTituloG.Value.ToUpper(), 0);
                bd.AgregarParametros("Descripcion", 22, txtDescripcionG.Value.ToUpper(), 1);
                bd.AgregarParametros("Fecha", 4, txtFechaG.Value, 2);
                bd.AgregarParametros("Paciente", 0, ddlPacientesG.SelectedValue, 3);
                bd.AgregarParametros("Usuario", 22, txtUsuarioG.Value.ToUpper(), 4);
                bd.AgregarParametros("Estado", 8, ddlEstadoG.SelectedValue, 5);
                bd.AgregarParametros("Id", 0, hdnIdNotaEvolucion.Value, 6);
                dt = bd.EjecutarSP();
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        Exito = true;
                        LimpiarPantalla();
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('" + ex.Message + "');", true);
            }
            finally 
            {
                if (Exito)
                    ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('" + Mensaje + "');", true);
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Error');", true);
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            LimpiarPantalla();
        }

        protected void gvNotasEvolucion_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdnIdNotaEvolucion.Value = gvNotasEvolucion.SelectedRow.Cells[1].Text;
            txtTituloG.Value = gvNotasEvolucion.SelectedRow.Cells[2].Text;
            txtDescripcionG.Value = gvNotasEvolucion.SelectedRow.Cells[3].Text;
            txtFechaG.Value = DateTime.Parse(gvNotasEvolucion.SelectedRow.Cells[4].Text).ToString("dd/MM/yyyy hh:mm:ss");
            ddlPacientesG.SelectedValue = gvNotasEvolucion.SelectedRow.Cells[5].Text;
            txtUsuarioG.Value = gvNotasEvolucion.SelectedRow.Cells[6].Text;
            ddlEstadoG.SelectedValue = gvNotasEvolucion.SelectedRow.Cells[7].Text;
        }

        protected void btnExportarExcel_Click(object sender, EventArgs e)
        {

        }

        #region Metodos de usuario
        private void CargarPacientes()
        {
            DataTable tabla = null;
            try
            {
                BDGenerica bd = new BDGenerica("ObtenerListadoPacientes", 0);
                tabla = bd.EjecutarSP();
                ddlPacientesG.DataSource = tabla;
                ddlPacientesG.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally { }
        }

        private void ObtenerEstadosNE()
        {
            DataTable tabla = null;
            try
            {
                BDGenerica bd = new BDGenerica("ObtenerEstadosNotaEvolucion", 0);
                tabla = bd.EjecutarSP();
                ddlEstadoG.DataSource = tabla;
                ddlEstadoG.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally { }
        }

        private void MostrarDatos(DataTable dt)
        {
            txtTitulo.Value = "";
            txtFecha.Value = "";
            
            hdnIdNotaEvolucion.Value = dt.Rows[0]["Id"].ToString();
            txtTituloG.Value = dt.Rows[0]["Titulo"].ToString();
            txtDescripcionG.Value = dt.Rows[0]["Descripcion"].ToString();
            txtFechaG.Value = DateTime.Parse(dt.Rows[0]["Fecha"].ToString()).ToString("dd/MM/yyyy hh:mm:ss");
            ddlPacientesG.SelectedValue = dt.Rows[0]["Paciente"].ToString();
            txtUsuarioG.Value = dt.Rows[0]["Usuario"].ToString();
            ddlEstadoG.SelectedValue = dt.Rows[0]["Estado"].ToString();
        }

        private string NuevoId()
        {
            BDGenerica bd = new BDGenerica("UltimoIdNotaEvolucion", 0);
            DataTable dt = bd.EjecutarSP();
            long id = 1;
            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    id = int.Parse(dt.Rows[0]["Id"].ToString());
                    id = id + 1;
                }
            }
            return id.ToString();
        }

        private void LimpiarPantalla()
        {
            txtTitulo.Value = "";
            txtFecha.Value = "";
            gvNotasEvolucion.DataSource = null;
            gvNotasEvolucion.DataBind();
            txtTituloG.Value = "";
            txtDescripcionG.Value = "";
            txtFechaG.Value = "";

            txtUsuarioG.Value = this.UsuarioSis;
            hdnIdNotaEvolucion.Value = "0";
            txtTituloG.Focus();
        }
        #endregion

    }
}
