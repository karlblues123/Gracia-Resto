using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        private cSystem oSys = new cSystem();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region LOCAL FUNCTIONS

        private void UPDATE_USER_PASSWORD()
        {
            //Check if the passwords match
            if (string.Equals(txtCurrentPassword.Text, txtRepeatCurrent.Text))
            {
                //Check if the user has provided the correct password
                if (oSys.VALIDATE_USER(Request.Cookies["User"].Values["Username"].ToString(), txtCurrentPassword.Text) > -1)
                {
                    //Check if the passwords match
                    if (string.Equals(txtNewPassword.Text, txtRepeatNew.Text))
                    {
                        //Update
                        this.oSys.UPDATE_USER_PASSWORD(Session["User"].ToString(), txtNewPassword.Text);

                        //Show Toast
                        Show_Message_Toast("Password successfully updated.");
                    }
                    else
                        Show_Error_Toast("Error - Passwords do not match");
                }
                else
                    Show_Error_Toast("Error - User and Password do not match");
            }
            else
                Show_Error_Toast("Error - Passwords do not match");
        }

        private void CLEAR()
        {
            this.txtCurrentPassword.Text = string.Empty;
            this.txtRepeatCurrent.Text = string.Empty;
            this.txtNewPassword.Text = string.Empty;
            this.txtRepeatNew.Text = string.Empty;
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }
        #endregion

        #region EVENTS
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            this.UPDATE_USER_PASSWORD();
            
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            this.CLEAR();
        }
        #endregion
    }
}