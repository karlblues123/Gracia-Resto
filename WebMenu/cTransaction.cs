using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;

namespace GraciaResto
{
    public class cTransaction : cBase
    {
        #region GET FUNCTIONS

        public DataTable GET_LIST_PO()
        {
            return queryCommandDT_StoredProc("[Trans].[spGET_LIST_PO]");
        }

        public DataTable GET_LIST_PO_ITEMS(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spGET_PO_ITEMS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@POCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_PO_HDR(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spGET_PO_HDR]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@POCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_LIST_SALES()
        {
            return queryCommandDT_StoredProc("[Trans].[spGET_LIST_SALES]");
        }

        public DataTable GET_SALES_HDR(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spGET_SALES_HDR]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SALESCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_SALES_DISHES(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spGET_SALES_DISHES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SALESCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        internal DataTable GET_SALES_STATUSES()
        {
            return queryCommandDT_StoredProc("[Trans].[spGET_SALES_STATUSES]");
        }

        internal DataTable GET_LIST_VOID_SALES()
        {
            return queryCommandDT_StoredProc("[Trans].[spGET_LIST_VOID_SALES]");
        }

        internal DataTable GET_VOID_SALES(string sales_code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spGET_VOID_SALES]", cn))
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

        internal DataTable GET_SALES_LOGS()
        {
            return queryCommandDT_StoredProc("[Trans].[spGET_SALES_LOGS]");
        }

        internal DataTable GET_PO_LOGS()
        {
            return queryCommandDT_StoredProc("[Trans].[spGET_PO_LOGS]");
        }

        internal DataTable GET_LIST_RENTALS()
        {
            return queryCommandDT_StoredProc("[Trans].[spGET_LIST_RENTALS]");
        }

        internal DataTable GET_CUSTOMER_SALES(string guest_code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spGET_CUSTOMER_SALES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@GUESTCODE", guest_code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        internal DataTable GET_PAID_SALES(DateTime start_date, DateTime end_date)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spGET_PAID_SALES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@STARTDATE", start_date);
                    cmd.Parameters.AddWithValue("@ENDDATE", end_date);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }
        #endregion


        #region INSERT FUNCTIONS
        public bool INSERT_NEW_SALE(string code, string customer, decimal total, decimal tendered, SqlDateTime date, string waiter, string room, 
            DataTable data, string username)
        {
            bool didInsert = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spINSERT_SALES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SALESCODE", code);
                    cmd.Parameters.AddWithValue("@CUSTOMERCODE", customer);
                    cmd.Parameters.AddWithValue("@TOTALAMOUNT", total);
                    cmd.Parameters.AddWithValue("@AMOUNTTENDERED", tendered);
                    cmd.Parameters.AddWithValue("@DATE", date);
                    cmd.Parameters.AddWithValue("@WAITERNAME", waiter);
                    cmd.Parameters.AddWithValue("@ROOM", room);
                    cmd.Parameters.AddWithValue("@LINETABLE", data);
                    cmd.Parameters.AddWithValue("@USERNAME", username);


                    cn.Open();

                    if (cmd.ExecuteNonQuery() > 0)
                        didInsert = true;
                }
            }
            return didInsert;
        }

        internal void INSERT_NEW_PO(string code, SqlDateTime date, string incharge, string remarks, DataTable data,string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spINSERT_PO]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@POCODE", code);
                    cmd.Parameters.AddWithValue("@PODATE", date);
                    cmd.Parameters.AddWithValue("@POINCHARGE", incharge);
                    cmd.Parameters.AddWithValue("@REMARKS", remarks);
                    cmd.Parameters.AddWithValue("@LINETABLE", data);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                   cmd.ExecuteNonQuery();
                }
            }
        }

        public bool UPSERT_VOID_SALES(string sales_code, string void_code, SqlDateTime date, string reason, DataTable data, string username)
        {
            bool didUpdate = false;

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spUPSERT_VOID_SALES]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SALESCODE", sales_code);
                    cmd.Parameters.AddWithValue("@VOIDCODE", void_code);
                    cmd.Parameters.AddWithValue("@DATE", date);
                    cmd.Parameters.AddWithValue("@REASON", reason);
                    cmd.Parameters.AddWithValue("@LINETABLE", data);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                        didUpdate = true;
                }
            }

            return didUpdate;
        }

        internal void INSERT_SINGLE_SALES_LINE(string dish_code, string sales_code, decimal price, int quantity, decimal discount, string notes, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spINSERT_SINGLE_SALES_LINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", dish_code);
                    cmd.Parameters.AddWithValue("@SALESCODE", sales_code);
                    cmd.Parameters.AddWithValue("@PRICE", price);
                    cmd.Parameters.AddWithValue("@QUANTITY", quantity);
                    cmd.Parameters.AddWithValue("@DISCOUNT", discount);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }
        #endregion

        #region UPDATE
        public bool UPDATE_SALES_HDR(string code, decimal tendered, string waiter, string room, decimal tip, string receiver, int status, 
            string remarks, string username)
        {
            bool didUpdate = false;

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spUPDATE_SALES_HDR]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@SALESCODE", code);
                    cmd.Parameters.AddWithValue("@AMOUNTTENDERED", tendered);
                    cmd.Parameters.AddWithValue("@WAITERNAME", waiter);
                    cmd.Parameters.AddWithValue("@ROOM", room);
                    cmd.Parameters.AddWithValue("@TIPAMOUNT", tip);
                    cmd.Parameters.AddWithValue("RECEIVERNAME", receiver);
                    cmd.Parameters.AddWithValue("@STATUS", status);
                    cmd.Parameters.AddWithValue("@REMARKS", remarks);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                        didUpdate = true;
                }
            }

            return didUpdate;
        }

        public bool UPDATE_PO_HDR(string code, DateTime date, string in_charge, string received_by ,float cash_given, string notes, string username)
        {
            bool didUpdate = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spUPDATE_PO_HDR]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@POCODE", code);
                    cmd.Parameters.AddWithValue("@PODATE", date);
                    cmd.Parameters.AddWithValue("@POINCHARGE", in_charge);
                    cmd.Parameters.AddWithValue("@PORECEIVER", received_by);
                    cmd.Parameters.AddWithValue("@POCASHGIVEN", cash_given);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                        didUpdate = true;
                }
            }

            return didUpdate;
        }

        internal void UPDATE_PO(string code, SqlDateTime date, string incharge, decimal cash_given, string remarks, DataTable data,string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spUPDATE_PO]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@POCODE", code);
                    cmd.Parameters.AddWithValue("@PODATE", date);
                    cmd.Parameters.AddWithValue("@POINCHARGE", incharge);
                    cmd.Parameters.AddWithValue("@POCASHGIVEN", cash_given);
                    cmd.Parameters.AddWithValue("@NOTES", remarks);
                    cmd.Parameters.AddWithValue("@LINETABLE", data);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                   cmd.ExecuteNonQuery();
                }
            }
        }

        public bool UPDATE_SINGLE_SALES_LINE(int id, string dish_code, string sales_code, int quantity, decimal discount, 
            string notes, string username)
        {
            bool didUpdate = false;

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spUPDATE_SINGLE_SALES_LINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ID", id);
                    cmd.Parameters.AddWithValue("@DISHCODE", dish_code);
                    cmd.Parameters.AddWithValue("@SALESCODE", sales_code);
                    cmd.Parameters.AddWithValue("@QUANTITY", quantity);
                    cmd.Parameters.AddWithValue("@DISCOUNT", discount);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                        didUpdate = true;
                }
            }

            return didUpdate;
        }
        #endregion


        #region DELETE
        public void DELETE_SINGLE_SALES_LINE(int id, string sales_code, string dish_code, string notes, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Trans].[spDELETE_SINGLE_SALES_LINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ID", id);
                    cmd.Parameters.AddWithValue("@DISHCODE", dish_code);
                    cmd.Parameters.AddWithValue("@SALESCODE", sales_code);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }
        #endregion
    }
}