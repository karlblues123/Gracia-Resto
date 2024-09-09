using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace GraciaResto
{
    public class cMaster : cBase
    {

        #region "TABLES MODULE"
        public DataTable GET_TABLE_LISTS()
        {
            DataTable dt = new DataTable();
            dt = queryCommandDT_StoredProc("[Master].[spGET_TABLE_LISTS]");
            return dt;
        }

        internal DataTable GET_TABLE_BY_CODE(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spGET_TABLE_BY_CODE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@TABLECODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public void UPDATE_TABLE_STATUS(string _guc, string _notes, int _tableNumber, bool _isDining, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spUPDATE_TABLE_STATUS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@CUSTOMER", _guc);
                    cmd.Parameters.AddWithValue("@NOTES", _notes);
                    cmd.Parameters.AddWithValue("@TABLENUMBER", _tableNumber);
                    cmd.Parameters.AddWithValue("@ISDINING", _isDining);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }


        //Open Table
        public void UPDATE_OPEN_TABLE(int _tableNumber, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spUPDATE_OPEN_TABLE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@TABLENUMBER", _tableNumber);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        public void UPDATE_RESERVE_TO_DINE(int _tableNumber, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spUPDATE_TABLE_RESERVE_TO_DINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@TABLENUMBER", _tableNumber);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }

        internal void UPDATE_TABLE_INFORMATION(int table_number, string table_name, int capacity, string table_location, bool is_active, 
            string remarks, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spUPDATE_TABLE_INFORMATION]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@TABLENUMBER", table_number);
                    cmd.Parameters.AddWithValue("@TABLENAME", table_name);
                    cmd.Parameters.AddWithValue("@CAPACITY", capacity);
                    cmd.Parameters.AddWithValue("@LOCATION", table_location);
                    cmd.Parameters.AddWithValue("@AVAILABLE", is_active);
                    cmd.Parameters.AddWithValue("@NOTES", remarks);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }

        internal void INSERT_TABLE(int id, string table_name, int capacity, string table_location, string table_code, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Master].[spINSERT_TABLE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@TABLEID", id);
                    cmd.Parameters.AddWithValue("@TABLENAME", table_name);
                    cmd.Parameters.AddWithValue("@CAPACITY", capacity);
                    cmd.Parameters.AddWithValue("@LOCATION", table_location);
                    cmd.Parameters.AddWithValue("@TABLECODE", table_code);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        #endregion

        #region "KITCHEN MODULES"
        public DataTable GET_ORDER_STATUS(string sales_code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Kitchen].[spGET_ORDER_STATUS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SALESCODE", sales_code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }


        public DataTable GET_ORDER_LISTS()
        {
            DataTable dt = new DataTable();
            dt = queryCommandDT_StoredProc("[Kitchen].[spGET_ORDER_LISTS]");
            return dt;
        }

        public DataTable GET_ORDER_REQUEST_LISTS()
        {
            DataTable dt = new DataTable();
            dt = queryCommandDT_StoredProc("[Kitchen].[spGET_ORDER_REQUEST_LISTS]");
            return dt;
        }

        public DataTable GET_REQUEST_ORDERS(string _salesCode)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {

                using (SqlCommand cmd = new SqlCommand("[Kitchen].[spGET_ORDER_REQUESTING]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SALESCODE", _salesCode);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        //2ND Stage

        public DataTable GET_ORDER_PREPARING_LISTS()
        {
            DataTable dt = new DataTable();
            dt = queryCommandDT_StoredProc("[Kitchen].[spGET_ORDER_PREPARING_LISTS]");
            return dt;
        }
        public DataTable GET_PREPARING_ORDERS(string _salesCode)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {

                using (SqlCommand cmd = new SqlCommand("[Kitchen].[spGET_ORDER_PREPARING]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SALESCODE", _salesCode);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }


        public DataTable GET_ORDERS_COMPLETION()
        {
            DataTable dt = new DataTable();
            dt = queryCommandDT_StoredProc("[Kitchen].[spGET_ORDER_COMPLETED_TODAY]");
            return dt;
        }

        //ACTION DATA PROCESS
        public void UPDATE_ACCEPT_REQUEST(string _salesCode, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Kitchen].[spUPDATE_ACCEPT_REQUEST]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@SALESCODE", _salesCode);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        public void UPDATE_ORDER_COMPLETE(string _salesCode, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Kitchen].[spUPDATE_ORDERS_COMPLETE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;


                    cmd.Parameters.AddWithValue("@SALESCODE", _salesCode);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();

                }
            }
        }

        #endregion
    }
}