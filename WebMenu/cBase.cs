using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Sql;
using System.Data;
using System.Data.SqlClient;

namespace GraciaResto
{
    public class cBase
    {
        public static string cs = System.Configuration.ConfigurationManager.ConnectionStrings["GRDB"].ConnectionString;

        public cBase() { }

        public static DataSet queryCommandDS_StoredProc(string sqlQuery)
        {
            DataSet ds = new DataSet();
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand(sqlQuery, cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                }
            }

            return ds;
        }

        public static DataTable queryCommandDT_StoredProc(string sqlQuery)
        {
            DataTable dt = new DataTable();
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand(sqlQuery, cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }
    }
}