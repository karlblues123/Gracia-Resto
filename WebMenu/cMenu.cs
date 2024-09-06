using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace GraciaResto
{
    public class cMenu : cBase
    {
        #region GET FUNCTIONS

        public DataTable GET_ITEM_DATA()
        {
            return queryCommandDT_StoredProc("[Menu].[spGET_ITEM_DATA]");
        }

        public DataTable GET_SELECTED_ITEM_DATA(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spGET_SINGLE_ITEM_DATA]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ITEMCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_LIST_DISH()
        {
            return queryCommandDT_StoredProc("[Menu].[spGET_LIST_DISH]");
        }

        public DataTable GET_LIST_DISH_ITEMS(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spGET_DISH_ITEMS]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public DataTable GET_ACTIVE_DISHES()
        {
            return queryCommandDT_StoredProc("[Menu].[spGET_ACTIVE_DISHES]");
        }

        public DataTable GET_DISH_HDR(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spGET_DISH_HDR]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        internal DataTable GET_LIST_DISH_WITH_TYPE(int type)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spGET_LIST_DISH_WITH_TYPE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHTYPE", type);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        internal DataTable GET_DISH_TYPES()
        {
            return queryCommandDT_StoredProc("[Menu].[spGET_DISH_TYPES]");
        }

        internal DataTable GET_STOCK_ADJUSTMENT_LOGS()
        {
            return queryCommandDT_StoredProc("[Menu].[spGET_STOCK_ADJUSTMENT_LOGS]");
        }

        internal DataTable GET_DISH_LOGS()
        {
            return queryCommandDT_StoredProc("[Menu].[spGET_DISH_LOGS]");
        }

        internal DataTable GET_ITEM_LOGS()
        {
            return queryCommandDT_StoredProc("[Menu].[spGET_ITEM_LOGS]");
        }

        internal DataTable GET_DISH_WITH_ITEM(string code)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spGET_DISH_WITH_ITEM]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ITEMCODE", code);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }
        #endregion

        #region INSERT FUNCTIONS
        public void INSERT_NEW_ITEM_DATA(string code, string name, decimal price, string um, string notes, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spINSERT_ITEM_DATA]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ITEMCODE", code);
                    cmd.Parameters.AddWithValue("@ITEMNAME", name);
                    cmd.Parameters.AddWithValue("@ITEMPRICE", price);
                    cmd.Parameters.AddWithValue("ITEMUM", um);
                    cmd.Parameters.AddWithValue("NOTES", notes);
                    cmd.Parameters.AddWithValue("USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }

        internal bool INSERT_NEW_DISH_HDR(string code, string name, decimal price, int serving, int type, string description)
        {
            bool didInsert = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spINSERT_DISH_HDR]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);
                    cmd.Parameters.AddWithValue("@DISHNAME", name);
                    cmd.Parameters.AddWithValue("@DISHPRICE", price);
                    cmd.Parameters.AddWithValue("@DISHSERVING", serving);
                    cmd.Parameters.AddWithValue("@DISHTYPE", type);
                    cmd.Parameters.AddWithValue("@DISHDESCRIPTION", description);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didInsert = true;
                    }
                }
            }
            return didInsert;
        }

        public void INSERT_NEW_DISH_LINE(string dish_code, string item_code, Single quantity, decimal item_price)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spINSERT_DISH_LINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", dish_code);
                    cmd.Parameters.AddWithValue("@ITEMCODE", item_code);
                    cmd.Parameters.AddWithValue("@QUANTITY", quantity);
                    cmd.Parameters.AddWithValue("@ITEMPRICE", item_price);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }

        public bool INSERT_DISH(string code, decimal price, string name, int serving, byte[] image, DataTable data)
        {
            bool didInsert = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spINSERT_DISH]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);
                    cmd.Parameters.AddWithValue("@DISHNAME", name);
                    cmd.Parameters.AddWithValue("@DISHPRICE", price);
                    cmd.Parameters.AddWithValue("@DISHSERVING", serving);
                    cmd.Parameters.AddWithValue("@DISHIMAGE", image);
                    cmd.Parameters.AddWithValue("@LINETABLE", data);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didInsert = true;
                    }
                }
            }
            return didInsert;
        }
        #endregion

        #region UPDATE FUNCTIONS

        public void UPDATE_SINGLE_ITEM_DATA(string code, string name, decimal price, string um, string notes, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spUPDATE_SINGLE_ITEM_DATA]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ITEMCODE", code);
                    cmd.Parameters.AddWithValue("@ITEMNAME", name);
                    cmd.Parameters.AddWithValue("@ITEMPRICE", price);
                    cmd.Parameters.AddWithValue("@ITEMUM", um);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }

        public bool UPDATE_SINGLE_DISH_LINE(string dish_code, string item_code, decimal qty, string notes, string username)
        {
            bool didUpdate = false;

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spUPDATE_SINGLE_DISH_LINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", dish_code);
                    cmd.Parameters.AddWithValue("@ITEMCODE", item_code);
                    cmd.Parameters.AddWithValue("@ITEMQUANTITY", qty);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    if (cmd.ExecuteNonQuery() > 0)
                    {
                        didUpdate = true;
                    }
                }
            }

            return didUpdate;
        }

        public bool UPDATE_ITEM_DATA(DataTable dt)
        {
            bool didUpdate = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[UPDATE_ITEM_DATA]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@ITEMDATA", dt);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didUpdate = true;
                    }
                }
            }
            return didUpdate;
        }

        public bool UPDATE_DISH_HDR(string code, string name, int serving, int type, string description, bool is_active, 
            string notes, string username)
        {
            bool didUpdate = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spUPDATE_DISH_HDR]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);
                    cmd.Parameters.AddWithValue("@DISHNAME", name);
                    cmd.Parameters.AddWithValue("@DISHSERVING", serving);
                    cmd.Parameters.AddWithValue("@DISHTYPE", type);
                    cmd.Parameters.AddWithValue("@DISHDESCRIPTION", description);
                    cmd.Parameters.AddWithValue("@ISACTIVE", is_active);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didUpdate = true;
                    }
                }
            }
            return didUpdate;
        }

        public bool UPDATE_DISH_PRICE(string code, decimal price, string notes, string username)
        {
            bool didUpdate = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spUPDATE_DISH_PRICE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);
                    cmd.Parameters.AddWithValue("@DISHPRICE", price);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didUpdate = true;
                    }
                }
            }
            return didUpdate;
        }

        internal void UPSERT_DISH_LINE(DataTable data, string remarks, string username)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spUPSERT_DELETE_DISH_LINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@LINETABLE", data);
                    cmd.Parameters.AddWithValue("@NOTES", remarks);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }

        public bool UPDATE_DISH_STOCK(string code, int stock)
        {
            bool didUpdate = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[UPDATE_DISH_STOCK]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);
                    cmd.Parameters.AddWithValue("@DISHSTOCK", stock);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didUpdate = true;
                    }
                }
            }
            return didUpdate;
        }

        public bool UPDATE_DISH(string code, string name, decimal price, int stock, int serving, byte[] image, DataTable data)
        {
            bool didUpdate = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[UPDATE_DISH]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);
                    cmd.Parameters.AddWithValue("@DISHNAME", name);
                    cmd.Parameters.AddWithValue("@DISHPRICE", price);
                    cmd.Parameters.AddWithValue("@DISHSTOCK", stock);
                    cmd.Parameters.AddWithValue("@DISHSERVING", serving);

                    cmd.Parameters.Add(new SqlParameter("@DISHIMAGE", SqlDbType.VarBinary)).Value = image == null ? DBNull.Value : (Object)image;

                    cmd.Parameters.AddWithValue("@LINETABLE", data);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didUpdate = true;
                    }
                }
            }
            return didUpdate;
        }

        public bool UPSERT_DISH_STOCK_ADJUSTMENT(string code, int stock, string reason, string username)
        {
            bool didUpsert = false;
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spUPSERT_DISH_STOCK_ADJUSTMENT]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", code);
                    cmd.Parameters.AddWithValue("@DISHSTOCK", stock);
                    cmd.Parameters.AddWithValue("@REASON", reason);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    int affected = cmd.ExecuteNonQuery();
                    if (affected > 0)
                    {
                        didUpsert = true;
                    }
                }
            }
            return didUpsert;
        }
        #endregion

        #region DELETE

        public bool DELETE_SINGLE_DISH_LINE(string dish_code, string item_code, string notes, string username)
        {
            bool didDelete = false;

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[Menu].[spDELETE_SINGLE_DISH_LINE]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DISHCODE", dish_code);
                    cmd.Parameters.AddWithValue("@ITEMCODE", item_code);
                    cmd.Parameters.AddWithValue("@NOTES", notes);
                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    if (cmd.ExecuteNonQuery() > 0)
                    {
                        didDelete = true;
                    }
                }
            }

            return didDelete;
        }

        #endregion
    }
}