using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Clinica.Code;
using System.Data;
using Clinica.Datos;
using PCL_Comun.Utilidades;
using System.Configuration;

namespace Clinica.Pages
{
    public partial class Pacientes : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                hdnIdPaciente.Value = "0";
                ObtenerTipotratamiento();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            DataTable dt = null;

            try
            {
                BDGenerica bd = new BDGenerica("BusquedaPaciente", 4);
                bd.AgregarParametros("ApellidoPaterno", 22, txtPaterno.Value.ToUpper(), 0);
                bd.AgregarParametros("ApellidoMaterno", 22, txtMaterno.Value.ToUpper(), 1);
                bd.AgregarParametros("Nombre", 22, txtNombre.Value.ToUpper(), 2);
                bd.AgregarParametros("TelContacto", 22, txtTelContacto.Value.ToUpper(), 3);
                dt = bd.EjecutarSP();
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        MostrarDatos(dt);
                        gvPacientes.DataSource = dt;
                        gvPacientes.DataBind();
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
            if (txtPaternoG.Value == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Favor de proporcionar el Apellido paterno del paciente');", true);
                return;
            }
            else if (txtNombreG.Value == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Favor de proporcionar el Nombre del paciente');", true);
                return;
            }


            string Mensaje = string.Empty;
            bool Exito = false;
            try
            {
                if (int.Parse(hdnIdPaciente.Value) == int.Parse("0"))
                {
                    hdnIdPaciente.Value = NuevoId();
                    Mensaje = "Datos guardados correctamente";
                }
                else
                    Mensaje = "Datos actualizados correctamente";
                BDGenerica bd = new BDGenerica("CatPacientes", 9);
                bd.AgregarParametros("ApellidoPaterno", 22, txtPaternoG.Value.ToUpper(), 0);
                bd.AgregarParametros("ApellidoMaterno", 22, txtMaternoG.Value.ToUpper(), 1);
                bd.AgregarParametros("Nombre", 22, txtNombreG.Value.ToUpper(), 2);
                bd.AgregarParametros("TelContacto", 22, txtTelContactoG.Value.ToUpper(), 3);
                bd.AgregarParametros("Responsable", 22, txtResponsableG.Value.ToUpper(), 4);
                bd.AgregarParametros("LugarResidencia", 22, txtLugarResidenciaG.Value.ToUpper(), 5);
                bd.AgregarParametros("Estatus", 22, sEstatus.Value, 6);
                bd.AgregarParametros("Tipo", 20, sTipo.SelectedValue, 7);
                bd.AgregarParametros("Id", 0, hdnIdPaciente.Value, 8);
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

        protected void gvPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdnIdPaciente.Value = gvPacientes.SelectedRow.Cells[1].Text;
            txtPaternoG.Value = gvPacientes.SelectedRow.Cells[2].Text;
            txtMaternoG.Value = gvPacientes.SelectedRow.Cells[3].Text;
            txtNombreG.Value = gvPacientes.SelectedRow.Cells[4].Text;
            txtTelContactoG.Value = gvPacientes.SelectedRow.Cells[5].Text;
            txtResponsableG.Value = gvPacientes.SelectedRow.Cells[6].Text;
            txtLugarResidenciaG.Value = gvPacientes.SelectedRow.Cells[7].Text;
            sEstatus.Value = gvPacientes.SelectedRow.Cells[8].Text;
            sTipo.SelectedValue = gvPacientes.SelectedRow.Cells[9].Text;
        }

        protected void btnExportarExcel_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string btnExportarExcel_Click()
        {
            string msj = string.Empty;
            DataTable tabla = null;
            BDGenerica bd = new BDGenerica("ReportePacientes", 0);
            tabla = bd.EjecutarSP();
            if (tabla.Rows.Count > 0)
            {
                Util.ExportarExcel(@"" + ConfigurationManager.AppSettings["Reportes"].ToString(), "Pacientes.xlsx", "Pacientes", tabla);
                msj = "Reporte descargado correctamente, ubicación: " + ConfigurationManager.AppSettings["Reportes"].ToString() + "";
            }
            else
                msj = "Sin datos";
            return msj;
        }

        #region Metodos de usuario
        private void ObtenerTipotratamiento()
        {
            DataTable tabla = null;
            try
            {
                BDGenerica bd = new BDGenerica("ObtenerListadoDeTiposTratamiento", 0);
                tabla = bd.EjecutarSP();
                sTipo.DataSource = tabla;
                sTipo.DataBind();
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally { }
        }

        private void MostrarDatos(DataTable dt)
        {
            txtPaterno.Value = "";
            txtMaterno.Value = "";
            txtNombre.Value = "";
            txtTelContacto.Value = "";

            hdnIdPaciente.Value = dt.Rows[0]["Id"].ToString();
            txtPaternoG.Value = dt.Rows[0]["ApellidoPaterno"].ToString();
            txtMaternoG.Value = dt.Rows[0]["ApellidoMaterno"].ToString();
            txtNombreG.Value = dt.Rows[0]["Nombre"].ToString();
            txtTelContactoG.Value = dt.Rows[0]["TelContacto"].ToString();
            txtResponsableG.Value = dt.Rows[0]["Responsable"].ToString();
            txtLugarResidenciaG.Value = dt.Rows[0]["LugarResidencia"].ToString();
            sEstatus.Value = dt.Rows[0]["Estatus"].ToString();
            sTipo.SelectedValue = dt.Rows[0]["Tipo"].ToString();
        }

        private string NuevoId()
        {
            BDGenerica bd = new BDGenerica("UltimoIdPaciente", 0);
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
            txtPaterno.Value = "";
            txtMaterno.Value = "";
            txtNombre.Value = "";
            txtTelContacto.Value = "";

            gvPacientes.DataSource = null;
            gvPacientes.DataBind();

            hdnIdPaciente.Value = "0";
            txtPaternoG.Value = "";
            txtMaternoG.Value = "";
            txtNombreG.Value = "";
            txtTelContactoG.Value = "";
            txtResponsableG.Value = "";
            txtLugarResidenciaG.Value = "";
            sEstatus.Value = "0";
            sTipo.SelectedValue = "0";
            txtPaternoG.Focus();
        }
        #endregion

    }
}
