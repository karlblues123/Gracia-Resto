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
    public partial class EmployeeSignUp : System.Web.UI.Page
    {
        private cSystem oSys = new cSystem();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        #region LOCAL FUNCTIONS

        private void INSERT_NEW_USER()
        {
            //Check if the user supplied the fields
            if (!string.IsNullOrEmpty(txtPassword.Text) && !string.IsNullOrEmpty(txtUsername.Text))
            {
                if (this.oSys.GET_USER(txtUsername.Text).Rows.Count == 0)
                {
                    this.oSys.INSERT_NEW_USER(txtUsername.Text, txtPassword.Text);
                    Show_Message_Toast("Sign up complete. Please contact the administration to activate your account.");
                    this.CLEAR();
                }
                else
                    Show_Error_Toast("Error - Username has already been taken.");
            }
            else
            {
                Show_Error_Toast("Error - Empty fields.");
            }
            
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }

        private void CLEAR()
        {
            this.txtPassword.Text = string.Empty;
            this.txtUsername.Text = string.Empty;
        }
        #endregion


        #region EVENTS
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            INSERT_NEW_USER();
        }
        #endregion
    }
}