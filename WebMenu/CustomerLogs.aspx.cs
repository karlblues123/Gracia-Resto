using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class CustomerLogs : System.Web.UI.Page
    {
        cMaster oMaster = new cMaster();
        cSystem oSys = new cSystem();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["User"] == null)
                Response.Redirect("Login.aspx");
            else if (this.oSys.GET_USER(Request.Cookies["User"].Values["Username"].ToString()).Rows.Count == 0)
                Response.Redirect("Login.aspx");

            this.DISPLAY_CUSTOMERS();
        }


        #region LOCAL FUNCTIONS
        private void DISPLAY_CUSTOMERS()
        {
            this.gvLogs.DataSource = this.oMaster.GET_CUSTOMERS();
            this.gvLogs.DataBind();
        }

        private bool VALIDATE_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtCustomerCode.Text))
                is_valid = false;
            if (string.IsNullOrWhiteSpace(this.txtFirstName.Text))
                is_valid = false;
            if (string.IsNullOrWhiteSpace(this.txtLastName.Text))
                is_valid = false;
            if (string.IsNullOrWhiteSpace(this.txtBirthdate.Text))
                is_valid = false;
            if (this.rblGender.SelectedIndex == -1)
                is_valid = false;

            return is_valid;
        }

        private bool CHECK_CODE()
        {
            return string.IsNullOrWhiteSpace(this.txtCustomerCode.Text) == true ? false : this.oMaster.GET_CUSTOMER_BY_CODE(this.txtCustomerCode.Text).Rows.Count == 0;
        }

        private void INSERT_CUSTOMER()
        {
            //Parse the data
            DateTime birthdate = DateTime.Parse(this.txtBirthdate.Text);
            char gender = char.Parse(this.rblGender.SelectedValue);

            //Insert
            this.oMaster.INSERT_CUSTOMER(this.txtCustomerCode.Text, this.txtLastName.Text, this.txtFirstName.Text, birthdate, gender);

            //Show Success Toast
            this.Show_Message_Toast("Succesfully recored " + this.txtFirstName.Text + " " + this.txtLastName.Text);
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }

        private void Show_Warning_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Warning", "<script>showToastWarning('" + msg + "');</script>", false);
        }
        #endregion

        #region EVENTS
        protected void btnViewSummary_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string guest_code = this.gvLogs.DataKeys[r.RowIndex].Value.ToString();

            string s = "window.open('CustomerSummary.aspx?GuestCode=" + guest_code + "', 'popup_window', 'width=1024, height=768, left=0, top=0, resizable=yes');";
            ScriptManager.RegisterClientScriptBlock(this, this.Page.GetType(), "New Page", s, true);
        }

        protected void btnRecord_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_FORM() && this.CHECK_CODE())
            {
                this.INSERT_CUSTOMER();
                this.DISPLAY_CUSTOMERS();
            }
            else if (!this.CHECK_CODE())
                this.Show_Error_Toast("Code is invalid or taken. Please provide an available code.");
            else
                this.Show_Error_Toast("Please try again with complete information.");
        }
        #endregion
    }
}