using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace GraciaResto
{
    public class cSystem : cBase
    {
        private string CREATE_MD5_HASH(string input)
        {
            using (MD5 hasher = MD5.Create())
            {
                byte[] hash = hasher.ComputeHash(Encoding.UTF8.GetBytes(input));
                StringBuilder sBuilder = new StringBuilder();
                for (int i = 0; i < hash.Length; i++)
                {
                    sBuilder.Append(hash[i].ToString("x2"));
                }
                return sBuilder.ToString();
            }

        }

        internal int VALIDATE_USER(string username, string password)
        {
            int access_level = -1;

            DataRow user_info = this.GET_USER(username).Rows[0];

            string hash = this.CREATE_MD5_HASH(password);
            bool is_active = bool.Parse(user_info["IsActive"].ToString());

            if (is_active && string.Equals(hash, user_info["Password"].ToString()))
                access_level = int.Parse(user_info["UserType"].ToString());

            return access_level;
        }

        #region GET
        public string GET_SERIES_NUMBER(string prefix)
        {
            int SERIESNUMBER = 0;
            string AutoNumber = "";

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[xSystem].[spGET_SERIES_NUMBER]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@PREFIX", prefix);

                    cn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.HasRows)
                    {

                        while (dr.Read())
                        {

                            if ((int)dr["Series"] > 0)
                            {

                                SERIESNUMBER = (int)dr["Series"] + 1;

                                /*Format Transaction AutoNumber
                                 * UP TO 999999999 AutoNumbers
                                 */
                                if (SERIESNUMBER > 9999)
                                {
                                    AutoNumber = prefix + "-" + SERIESNUMBER;
                                }

                                else if (SERIESNUMBER > 999)
                                {
                                    AutoNumber = prefix + "-0" + SERIESNUMBER;
                                }

                                else if (SERIESNUMBER > 99)
                                {
                                    AutoNumber = prefix + "-00" + SERIESNUMBER;
                                }

                                else if (SERIESNUMBER > 9)
                                {
                                    AutoNumber = prefix + "-000" + SERIESNUMBER;
                                }

                                else
                                {
                                    AutoNumber = prefix + "-0000" + SERIESNUMBER;
                                }

                            }

                            else
                            {
                                SERIESNUMBER = SERIESNUMBER + 1;
                                AutoNumber = prefix + "-0000" + SERIESNUMBER;
                            }
                        }

                    }


                }
            }
            return AutoNumber;
        }

        internal DataTable GET_USER(string username)
        {
            DataTable dt = new DataTable();

            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[xSystem].[spGET_USER]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@USERNAME", username);

                    cn.Open();

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        internal DataTable GET_LIST_USERS()
        {
            return queryCommandDT_StoredProc("[xSystem].[spGET_LIST_USERS]");
        }

        internal DataTable GET_LIST_USER_TYPES()
        {
            return queryCommandDT_StoredProc("[xSystem].[spGET_LIST_USER_TYPES]");
        }
        #endregion

        #region INSERT
        internal void INSERT_NEW_USER(string username, string password)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[xSystem].[spINSERT_USER]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@USERNAME", username);
                    cmd.Parameters.AddWithValue("@PASSWORD", this.CREATE_MD5_HASH(password));
                    

                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }
        #endregion

        #region UPDATE
        public void UPDATE_USER(int user_id, int type, bool is_active)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[xSystem].[spUPDATE_USER]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@TYPEID", type);
                    cmd.Parameters.AddWithValue("@ISACTIVE", is_active);
                    cmd.Parameters.AddWithValue("@USERID", user_id);


                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }

        internal void UPDATE_USER_PASSWORD(string username, string password)
        {
            using (SqlConnection cn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("[xSystem].[spUPDATE_USER_PASSWORD]", cn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@USERNAME", username);
                    cmd.Parameters.AddWithValue("@PASSWORD", CREATE_MD5_HASH(password));


                    cn.Open();

                    cmd.ExecuteNonQuery();
                }
            }
        }
        #endregion
    }
}