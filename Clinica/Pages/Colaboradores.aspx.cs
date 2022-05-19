using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Clinica.Code;
using Clinica.Datos;
using System.Data;
using PCL_Comun.Utilidades;
using System.Configuration;
using System.Web.Services;

namespace Clinica.Pages
{
    public partial class Colaboradores : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCombo();
                hdnIdColaborador.Value = "0";
                hdnIdColaboradorDetalle.Value = "0";
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            DataTable dt = null;
            try
            {
                BDGenerica bd = new BDGenerica("BusquedaColaborador", 1);
                bd.AgregarParametros("Nombre", 22, txtNombre.Value.ToUpper(), 0);
                dt = bd.EjecutarSP();
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        MostrarDatos(dt);
                        gvColaboradores.DataSource = dt;
                        gvColaboradores.DataBind();
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
            if (txtNombreG.Value == "")
            {
                ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Favor de proporcionar un nombre para el colaborador');", true);
                return;
            }

            string Mensaje = string.Empty;
            bool Exito = false;
            bool Nuevo = false;
            try
            {
                if (int.Parse(hdnIdColaborador.Value) == int.Parse("0"))
                {
                    Nuevo = true;
                    hdnIdColaborador.Value = NuevoIdMaestro();
                    Mensaje = "Datos guardados correctamente";
                }
                else
                    Mensaje = "Datos actualizados correctamente";
                BDGenerica bd = new BDGenerica("CatColaboradorMaestro", 2);
                bd.AgregarParametros("Id", 0, hdnIdColaborador.Value, 0);
                bd.AgregarParametros("Nombre", 22, txtNombreG.Value.ToUpper(), 1);
                dt = bd.EjecutarSP();
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        if (int.Parse(hdnIdColaboradorDetalle.Value) == int.Parse("0"))
                        {
                            hdnIdColaboradorDetalle.Value = NuevoIdDetalle();
                        }
                        BDGenerica bd2 = new BDGenerica("CatColaboradorDetalle", 7);
                        bd2.AgregarParametros("Id", 0, hdnIdColaboradorDetalle.Value, 0);
                        bd2.AgregarParametros("ColaboradorId", 0, hdnIdColaborador.Value, 1);
                        bd2.AgregarParametros("FechaEmision", 31, DateTime.Parse(txtFechaEmisionG.Value.ToString()).ToString("dd/MM/yyyy"), 2);
                        bd2.AgregarParametros("Importe", 5, txtImporte.Value, 3);
                        int val = 0;
                        if (txtPagado.Checked)
                            val = 1;
                        bd2.AgregarParametros("Pagado", 20, val.ToString(), 4);
                        if (txtFechaPago.Value != "" && txtPagado.Checked)
                            bd2.AgregarParametros("FechaPago", 31, DateTime.Parse(txtFechaPago.Value.ToString()).ToString("dd/MM/yyyy"), 5);
                        else
                            bd2.AgregarParametros("FechaPago", 31, new DateTime(1990, 1, 1).ToString("dd/MM/yyyy"), 5);
                        bd2.AgregarParametros("Concepto", 22, txtConcepto.Value.ToUpper(), 6);
                        dt = bd2.EjecutarSP();

                        if (dt != null)
                        {
                            if (dt.Rows.Count > 0)
                            {
                                Exito = true;
                                LimpiarPantalla();
                            }
                        }
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
                {
                    if (Nuevo)
                        CargarCombo();
                    ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('" + Mensaje + "');", true);
                }
                else
                    ScriptManager.RegisterStartupScript(this, GetType(), Guid.NewGuid().ToString(), "alert('Error');", true);
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            LimpiarPantalla();
        }

        protected void gvColaboradores_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdnIdColaborador.Value = gvColaboradores.SelectedRow.Cells[1].Text;
            ddlColaboradores.Visible = true;
            txtNombreG.Visible = false;
            ddlColaboradores.SelectedValue = hdnIdColaborador.Value;
            txtNombreG.Value = gvColaboradores.SelectedRow.Cells[2].Text;
            txtDetalleG.Value = gvColaboradores.SelectedRow.Cells[3].Text;
            hdnIdColaboradorDetalle.Value = txtDetalleG.Value;
            txtFechaEmisionG.Value = DateTime.Parse(gvColaboradores.SelectedRow.Cells[4].Text).ToString("dd/MM/yyyy");
            txtImporte.Value = gvColaboradores.SelectedRow.Cells[5].Text;
            int Pagado = int.Parse(gvColaboradores.SelectedRow.Cells[6].Text);
            if (Pagado == 1)
                txtPagado.Checked = true;
            else
                txtPagado.Checked = false;
            if (gvColaboradores.SelectedRow.Cells[7].Text != "")
                txtFechaPago.Value = DateTime.Parse(gvColaboradores.SelectedRow.Cells[7].Text).ToString("dd/MM/yyyy");
            else
                txtFechaPago.Value = "";
            txtConcepto.Value = gvColaboradores.SelectedRow.Cells[8].Text;
        }

        protected void btnExportarExcel_Click(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string btnExportarExcel_Click()
        {
            string msj = string.Empty;
            DataTable tabla = null;
            BDGenerica bd = new BDGenerica("ReporteColaboradores", 0);
            tabla = bd.EjecutarSP();
            if (tabla.Rows.Count > 0)
            {
                Util.ExportarExcel(@"" + ConfigurationManager.AppSettings["Reportes"].ToString(), "Colaboradores.xlsx", "Colaboradores", tabla);
                msj = "Reporte descargado correctamente, ubicación: " + ConfigurationManager.AppSettings["Reportes"].ToString() + "";
            }
            else
                msj = "Sin datos";
            return msj;
        }

        #region Metodos de usuario

        private void CargarCombo()
        {
            BDGenerica bd = new BDGenerica("ObtenerListadoColaboradores", 0);
            ddlColaboradores.DataSource = bd.EjecutarSP();
            ddlColaboradores.DataBind();
        }

        private void MostrarDatos(DataTable dt)
        {
            txtNombre.Value = "";

            hdnIdColaborador.Value = dt.Rows[0]["Id"].ToString();
            ddlColaboradores.Visible = true;
            txtNombreG.Visible = false;
            ddlColaboradores.SelectedValue = hdnIdColaborador.Value;

            txtNombreG.Value = dt.Rows[0]["Nombre"].ToString();
            txtDetalleG.Value = dt.Rows[0]["Detalle"].ToString();
            hdnIdColaboradorDetalle.Value = txtDetalleG.Value;
            txtFechaEmisionG.Value = DateTime.Parse(dt.Rows[0]["FechaEmision"].ToString()).ToString("dd/MM/yyyy");
            txtImporte.Value = dt.Rows[0]["Importe"].ToString();
            int Pagado = Convert.ToInt32(dt.Rows[0]["Pagado"]);
            if (Pagado==1)
                txtPagado.Checked = true;
            else
                txtPagado.Checked = false;
            if (dt.Rows[0]["FechaPago"].ToString() != "")
                txtFechaPago.Value = DateTime.Parse(dt.Rows[0]["FechaPago"].ToString()).ToString("dd/MM/yyyy");
            else
                txtFechaPago.Value = "";
            txtConcepto.Value = dt.Rows[0]["Concepto"].ToString();
        }

        private string NuevoIdMaestro()
        {
            BDGenerica bd = new BDGenerica("UltimoIdColaboradorMaestro", 0);
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

        private string NuevoIdDetalle()
        {
            BDGenerica bd = new BDGenerica("UltimoIdColaboradorDetalle", 0);
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
            txtNombre.Value = "";
            txtNombreG.Value = "";
            gvColaboradores.DataSource = null;
            gvColaboradores.DataBind();
            txtNombreG.Visible = true;
            ddlColaboradores.Visible = false;

            hdnIdColaborador.Value = "0";
            hdnIdColaboradorDetalle.Value = "0";
            txtDetalleG.Value = "";
            txtFechaEmisionG.Value = "";
            txtImporte.Value = "";
            txtPagado.Checked = false;
            txtFechaPago.Value = "";
            txtConcepto.Value = "";

            txtNombreG.Focus();
        }
        #endregion

        protected void btnNuevoDetalle_Click(object sender, EventArgs e)
        {
            hdnIdColaboradorDetalle.Value = NuevoIdDetalle();
            txtDetalleG.Value = hdnIdColaboradorDetalle.Value;
        }
    }
}
