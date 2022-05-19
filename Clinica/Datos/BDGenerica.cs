using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace Clinica.Datos
{
    public class BDGenerica
    {
        public string NombreSP { get; set; }
        public SqlParameter[] Parametros { get; set; }

        public BDGenerica(string nombreSp, int numParametros)
        {
            this.NombreSP = nombreSp;
            this.Parametros = new SqlParameter[numParametros];
        }

        public void AgregarParametros(string Nombre, int Tipo, string Valor, int Index)
        {
            SqlParameter sqlp = new SqlParameter();

            sqlp.ParameterName = Nombre;
            switch (Tipo)
            {
                case (int)SqlDbType.BigInt:
                    {
                        sqlp.SqlDbType = SqlDbType.BigInt;
                        break;
                    }
                case (int)SqlDbType.Int:
                    {
                        sqlp.SqlDbType = SqlDbType.Int;
                        break;
                    }
                case (int)SqlDbType.SmallInt:
                    {
                        sqlp.SqlDbType = SqlDbType.SmallInt;
                        break;
                    }
                case (int)SqlDbType.TinyInt:
                    {
                        sqlp.SqlDbType = SqlDbType.TinyInt;
                        break;
                    }
                case (int)SqlDbType.VarChar:
                    {
                        sqlp.SqlDbType = SqlDbType.VarChar;
                        break;
                    }
                case (int)SqlDbType.DateTime:
                    {
                        sqlp.SqlDbType = SqlDbType.DateTime;
                        break;
                    }
                case (int)SqlDbType.Date:
                    {
                        sqlp.SqlDbType = SqlDbType.Date;
                        break;
                    }
                case (int)SqlDbType.Decimal:
                    {
                        sqlp.SqlDbType = SqlDbType.Decimal;
                        break;
                    }
                case (int)SqlDbType.Bit:
                    {
                        sqlp.SqlDbType = SqlDbType.Bit;
                        break;
                    }
            }
            sqlp.Value = Valor;

            this.Parametros[Index] = sqlp;
        }

        public DataTable EjecutarSP()
        {
            DataTable tabla = null;
            using (var sql = new SqlConnection(ConfigurationManager.ConnectionStrings["db"].ConnectionString))
            {
                if (sql.State == ConnectionState.Open) sql.Close();
                sql.Open();
                using (var cmd = new SqlCommand())
                {
                    cmd.Connection = sql;
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.CommandText = this.NombreSP;
                    if (this.Parametros.Length > 0)
                        cmd.Parameters.AddRange(this.Parametros);
                    SqlDataReader reader = cmd.ExecuteReader();
                    tabla = new DataTable("Exito");
                    bool bandera = true;
                    List<string> Columnas = new List<string>();
                    while (reader != null && reader.Read())
                    {
                        if (bandera)
                        {
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                Columnas.Add(reader.GetName(i));
                                tabla.Columns.Add(reader.GetName(i));
                            }
                        }

                        DataRow dr = tabla.NewRow();
                        for (int i = 0; i < reader.FieldCount; i++)
                            dr[Columnas[i]] = reader.GetValue(i);
                        tabla.Rows.Add(dr);

                        if (bandera)
                            bandera = false;
                    }
                    reader.Close();
                }
                sql.Close();
            }
            return tabla;
        }
    }
}
