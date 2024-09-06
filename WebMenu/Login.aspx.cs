using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class Login : System.Web.UI.Page
    {
        private cSystem oSys = new cSystem();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region LOCAL FUNCTIONS
        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }

        private bool VALIDATE_USER()
        {
            bool validated = false;

            //Check if the user has input in the fields
            if (!string.IsNullOrEmpty(txtUsername.Text) && !string.IsNullOrEmpty(txtPassword.Text))
            {
                //Check if the Username and Password match
                if (this.oSys.VALIDATE_USER(this.txtUsername.Text, this.txtPassword.Text) > -1)
                {
                    validated = true;

                    //Create a Cookie that lasts until midnight and contains username
                    HttpCookie userCookie = new HttpCookie("User");
                    userCookie.Values["Username"] = txtUsername.Text;
                    userCookie.Values["AccessLevel"] = this.oSys.VALIDATE_USER(this.txtUsername.Text, this.txtPassword.Text).ToString();
                    userCookie.Expires = DateTime.Today.AddDays(1);

                    Response.Cookies.Add(userCookie);
                }
                else
                    Show_Error_Toast("Username or Password is invalid");
            }
            else
                Show_Error_Toast("Username or Password is empty.");
            return validated;
        }
        #endregion


        #region EVENTS
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (VALIDATE_USER())
                Response.Redirect("Home.aspx");
        }
        #endregion
    }
}