using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class ItemData : System.Web.UI.Page
    {
        private cMenu oMenu = new cMenu();
        private cSystem oSystem = new cSystem();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Redirect the user if he/she is not logged in
                if (Request.Cookies["User"] == null)
                    Response.Redirect("Login.aspx");
                else if (this.oSystem.GET_USER(Request.Cookies["User"].Values["Username"].ToString()).Rows.Count == 0)
                    Response.Redirect("Login.aspx");

                DISPLAY_ITEM_DATA();
            }
                
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_ITEM_DATA()
        {
            gvItems.DataSource = oMenu.GET_ITEM_DATA();
            gvItems.DataBind();
        }

        private void INSERT_NEW_ITEM()
        {
            string name = this.txtNewItemName.Text;
            string price_text = this.txtNewItemPrice.Text;
            string um = this.txtNewItemUM.Text;
            string remarks = this.txtNewItemRemarks.Text;

            if (!string.IsNullOrWhiteSpace(name) && !string.IsNullOrWhiteSpace(um) && !string.IsNullOrWhiteSpace(remarks))
            {
                //Get the data for Insert
                string code = oSystem.GET_SERIES_NUMBER("ING");
                decimal price = 0.00m;
                decimal.TryParse(price_text, out price);

                //Insert the new item to the database
                oMenu.INSERT_NEW_ITEM_DATA(code, name, price, um, remarks, Request.Cookies["User"].Values["Username"].ToString());

                Show_Message_Toast("Successfully added " + name);
            }
            else if (string.IsNullOrWhiteSpace(remarks))
            {
                Show_Error_Toast("Empty Remarks. Please provide a reason to add.");
            }
            else
            {
                Show_Error_Toast("Empty Input. Please try again with complete information.");
            }
        }

        private void UPDATE_ITEM_DATA(int index)
        {
            string name = (this.gvItems.Rows[index].FindControl("txtItemName") as TextBox).Text;
            string price_text = (this.gvItems.Rows[index].FindControl("txtItemPrice") as TextBox).Text;
            string um = (this.gvItems.Rows[index].FindControl("txtItemUM") as TextBox).Text;
            string remarks = (this.gvItems.Rows[index].FindControl("txtRemarks") as TextBox).Text;

            if (!string.IsNullOrWhiteSpace(name) && !string.IsNullOrWhiteSpace(price_text) && !string.IsNullOrWhiteSpace(um) 
                && !string.IsNullOrWhiteSpace(remarks))
            {
                string code = this.gvItems.DataKeys[index].Value.ToString();
                
                decimal price = 0.00m;
                decimal.TryParse(price_text, out price);
                

                //Update the selected Item in the database
                this.oMenu.UPDATE_SINGLE_ITEM_DATA(code, name, price, um, remarks, Request.Cookies["User"].Values["Username"].ToString());

                DataTable affected = this.oMenu.GET_DISH_WITH_ITEM(code);

                string affected_str = "Successfully updated " + name + ".<br/>The following dishes are affected:<br/>";

                if (affected.Rows.Count > 0)
                    foreach (DataRow dish in affected.Rows)
                        affected_str += dish["Name"].ToString() + "<br/>";
                else
                    affected_str += "None";

                Show_Warning_Toast(affected_str);
            }
            else if (string.IsNullOrWhiteSpace(remarks))
            {
                Show_Error_Toast("Empty Remarks. Please provide a reason to update.");
            }
            else
            {
                Show_Error_Toast("Empty Input. Please try again with complete information.");
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

        private void Show_Warning_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Warning", "<script>showToastWarning('" + msg + "');</script>", false);
        }
        #endregion

        #region EVENTS
        protected void gvItems_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvItems.EditIndex = e.NewEditIndex;
            DISPLAY_ITEM_DATA();
            (gvItems.Rows[e.NewEditIndex].FindControl("txtItemName") as TextBox).Focus();
        }

        protected void gvItems_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvItems.EditIndex = -1;
            DISPLAY_ITEM_DATA();
        }

        protected void gvItems_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            this.UPDATE_ITEM_DATA(e.RowIndex);

            //Refresh the GridView
            gvItems.EditIndex = -1;
            DISPLAY_ITEM_DATA();
        }

        protected void btnAddNewItem_Click(object sender, EventArgs e)
        {
            this.INSERT_NEW_ITEM();

            //Refresh the GridView
            DISPLAY_ITEM_DATA();
        }
        #endregion


    }
}