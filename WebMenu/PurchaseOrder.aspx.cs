using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class PurchaseOrder : System.Web.UI.Page
    {
        private cSystem oSys = new cSystem();
        private cMenu oMenu = new cMenu();
        private cTransaction oTrans = new cTransaction();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Redirect the user if he/she is not logged in
                if (Request.Cookies["User"] == null)
                    Response.Redirect("Login.aspx");
                else if (this.oSys.GET_USER(Request.Cookies["User"].Values["Username"].ToString()).Rows.Count == 0)
                    Response.Redirect("Login.aspx");

                this.CLEAR();

                this.DISPLAY_INGREDIENTS_LIST();
                this.DISPLAY_DISH_DATA_LIST();
            }
            this.DISPLAY_PURCHASE_ORDER_LIST();
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_INGREDIENTS_LIST()
        {
            this.gvIngredients.DataSource = this.oMenu.GET_ITEM_DATA();
            this.gvIngredients.DataBind();
        }

        private void DISPLAY_PURCHASE_ORDER_LIST()
        {
            this.gvPO.DataSource = this.oTrans.GET_LIST_PO();
            this.gvPO.DataBind();
        }

        private void DISPLAY_PURCHASE_ORDER()
        {
            DataTable po;

            //Initialize a new table to Session
            if (Session["NewPO"] == null)
            {
                if (string.IsNullOrWhiteSpace(this.hiddenSelectedPO.Value))
                {
                    po = new DataTable();
                    po.Columns.Add("ItemCode", typeof(string));
                    po.Columns.Add("Name", typeof(string));
                    po.Columns.Add("Price", typeof(decimal));
                    po.Columns.Add("UM", typeof(string));
                    po.Columns.Add("Quantity", typeof(double));
                    po.Columns.Add("ReceivedQuantity", typeof(double));
                    po.Columns.Add("ActualPrice", typeof(decimal));
                    po.Columns.Add("Total", typeof(decimal), "Quantity * Price");

                    Session["NewPO"] = po;
                }
                else
                {
                    po = this.oTrans.GET_LIST_PO_ITEMS(this.hiddenSelectedPO.Value);
                    po.Columns.Add("Total", typeof(decimal), "Quantity * Price");

                    Session["NewPO"] = po;
                }

            }
            //Get the existing table from Session
            else
                po = Session["NewPO"] as DataTable;
           
            if(!string.IsNullOrWhiteSpace(this.hiddenSelectedPO.Value))
            {
                //Get the header data from the database
                DataRow header = this.oTrans.GET_PO_HDR(this.hiddenSelectedPO.Value).Rows[0];

                //Display the header data
                this.txtInCharge.Text = header["InCharge"].ToString();
                this.txtCashGiven.Text = header["CashGiven"].ToString();
                this.txtDate.Text = DateTime.Parse(header["Date"].ToString()).ToString("yyyy-MM-dd");
                this.txtCreatedBy.Text = header["Username"].ToString();
                this.txtReceiver.Text = header["Receiver"].ToString();
                this.txtRemarks.Text = header["Remarks"].ToString();
            }

            //Display the item line
            this.gvIngredientList.DataSource = po;
            this.gvIngredientList.DataBind();
        }

        private void DISPLAY_DISH_DATA_LIST()
        {
            this.gvDish.DataSource = oMenu.GET_LIST_DISH();
            this.gvDish.DataBind();
        }

        private void DISPLAY_SELECTED_DISH(string dish_code, string dish_name)
        {
            DataTable data = oMenu.GET_LIST_DISH_ITEMS(dish_code);

            //Add a Total column
            data.Columns.Add("Total", typeof(System.Decimal), "Quantity * Price");

            this.lblSelectedDish.Text = dish_name;

            //Supply the GridView with the data
            this.gvRecipe.DataSource = data;
            this.gvRecipe.DataBind();
        }

        private decimal CALCULATE_TOTAL(DataTable data)
        {
            decimal total = 0.00m;

            foreach (DataRow row in data.Rows)
            {
                total += decimal.Parse(row["Total"].ToString());
            }

            return total;
        }

        private void CLEAR()
        {
            this.txtCashGiven.Text = "0.00";
            this.txtInCharge.Text = string.Empty;
            this.txtCreatedBy.Text = string.Empty;
            this.txtReceiver.Text = string.Empty;
            this.hiddenSelectedPO.Value = string.Empty;
            Session.Remove("NewPO");
            this.gvIngredientList.DataSource = null;
            this.gvIngredientList.DataBind();

            this.txtRemarks.CssClass = "form-control";
        }

        private void ADD_ITEM(string code)
        {
            //Get the selected Item
            DataRow item = this.oMenu.GET_SELECTED_ITEM_DATA(code).Rows[0];

            //Check if the item exists
            if (item[0] != null)
            {
                //Get or create the table
                DataTable po;
                if (Session["NewPO"] == null)
                {
                    po = new DataTable();
                    po.Columns.Add("ItemCode", typeof(string));
                    po.Columns.Add("Name", typeof(string));
                    po.Columns.Add("Price", typeof(decimal));
                    po.Columns.Add("UM", typeof(string));
                    po.Columns.Add("Quantity", typeof(double));
                    po.Columns.Add("ReceivedQuantity", typeof(double));
                    po.Columns.Add("ActualPrice", typeof(decimal));
                    po.Columns.Add("Total", typeof(decimal), "Quantity * Price");

                    Session["NewPO"] = po;
                }
                else
                    po = Session["NewPO"] as DataTable;

                //Create a new Line
                DataRow new_item = po.NewRow();

                //Store the data
                new_item["ItemCode"] = item["ItemCode"].ToString();
                new_item["Name"] = item["Name"].ToString();
                new_item["Price"] = decimal.Parse(item["Price"].ToString());
                new_item["UM"] = item["UM"].ToString();
                new_item["Quantity"] = 0.00;
                new_item["ReceivedQuantity"] = 0.00;
                new_item["ActualPrice"] = 0.00m;

                //Add the new Line
                po.Rows.Add(new_item);
            }
        }

        private void DELETE_ITEM(int index)
        {
            //Check if the table exists
            if (Session["NewPO"] != null)
            {
                //Get the table from Session
                DataTable po = Session["NewPO"] as DataTable;

                //Delete the selected Line
                po.Rows.RemoveAt(index);
                po.AcceptChanges();
            }
        }


        private void UPDATE_ITEM(int index)
        {
            //Check if the table exists
            if (Session["NewPO"] != null)
            {
                //Get the table from Session
                DataTable po = Session["NewPO"] as DataTable;

                double quantity = float.Parse((this.gvIngredientList.Rows[index].FindControl("txtItemQuantity") as TextBox).Text);
                double received = 0f;
                double.TryParse((this.gvIngredientList.Rows[index].FindControl("txtReceivedQuantity") as TextBox).Text, out received);
                decimal actual = 0.00m;
                decimal.TryParse((this.gvIngredientList.Rows[index].FindControl("txtActualPrice") as TextBox).Text,out actual);

                po.Rows[index]["Quantity"] = quantity;
                po.Rows[index]["ReceivedQuantity"] = received;
                po.Rows[index]["ActualPrice"] = actual;
            }
        }

        private bool VALIDATE_PO()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtRemarks.Text))
            {
                is_valid = false;
                this.txtRemarks.CssClass += " is-invalid";
            }
            else
                this.txtRemarks.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtDate.Text))
            {
                is_valid = false;
                this.txtDate.Text += " is_invalid";
            }
            else
                this.txtDate.CssClass = "form-control";

            return is_valid;
        }

        private void INSERT_PO()
        {
            //Check if its a new entry and there is data
            if (string.IsNullOrEmpty(this.hiddenSelectedPO.Value) && Session["NewPO"] != null
                && !string.IsNullOrWhiteSpace(this.txtRemarks.Text))
            {
                //Get the data from the controls
                string code = this.oSys.GET_SERIES_NUMBER("PO");
                string in_charge = this.txtInCharge.Text == string.Empty ? "None Assigned" : this.txtInCharge.Text;
                string remarks = this.txtRemarks.Text;
                DateTime date;
                DateTime.TryParse(this.txtDate.Text, out date);
                DataTable purchase_order = Session["NewPO"] as DataTable;
                

                //Prepare the data for Insert
                purchase_order.Columns.Add("POCode").SetOrdinal(0);

                purchase_order.Columns.Remove("Total");
                purchase_order.Columns.Remove("UM");
                purchase_order.Columns.Remove("Name");

                purchase_order.Columns["ItemCode"].SetOrdinal(1);
                purchase_order.Columns["Quantity"].SetOrdinal(2);
                purchase_order.Columns["Price"].SetOrdinal(3);
                purchase_order.Columns["ReceivedQuantity"].SetOrdinal(4);
                purchase_order.Columns["ActualPrice"].SetOrdinal(5);

                //Populate the POCode Column
                foreach (DataRow row in purchase_order.Rows)
                {
                    row["POCode"] = code;
                }

                //Insert
                this.oTrans.INSERT_NEW_PO(code, date, in_charge, remarks, purchase_order, Request.Cookies["User"].Values["Username"].ToString());

                //Display a success toast
                this.Show_Message_Toast("Successfully added " + code + " to the database");

                //Clear the controls
                this.CLEAR();
            }
            else if (Session["NewPO"] == null || (Session["NewPO"] as DataTable).Rows.Count <= 0)
            {
                this.Show_Error_Toast("Empty input. Please add items before saving.");
            }
            else if (string.IsNullOrWhiteSpace(this.txtRemarks.Text))
            {
                this.Show_Error_Toast("Empty Remarks. Please provide the reason for this PO");
                this.txtRemarks.CssClass += " is-invalid";
            }
                
        }

        private void UPDATE_PO()
        {
            if (!string.IsNullOrEmpty(this.hiddenSelectedPO.Value) && Session["NewPO"] != null
                && !string.IsNullOrWhiteSpace(this.txtRemarks.Text))
            {
                string code = this.hiddenSelectedPO.Value;
                decimal cash_given = 0.00m;
                decimal.TryParse(this.txtCashGiven.Text, out cash_given);
                string remarks = this.txtRemarks.Text;
                string in_charge = this.txtInCharge.Text == string.Empty ? "None Assigned" : this.txtInCharge.Text;
                DateTime date;
                DateTime.TryParse(this.txtDate.Text, out date);
                DataTable purchase_order = Session["NewPO"] as DataTable;

                //Prepare the data for Insert
                purchase_order.Columns.Add("POCode").SetOrdinal(0);

                purchase_order.Columns.Remove("Total");
                purchase_order.Columns.Remove("UM");
                purchase_order.Columns.Remove("Name");

                purchase_order.Columns["ItemCode"].SetOrdinal(1);
                purchase_order.Columns["Quantity"].SetOrdinal(2);
                purchase_order.Columns["Price"].SetOrdinal(3);
                purchase_order.Columns["ReceivedQuantity"].SetOrdinal(4);
                purchase_order.Columns["ActualPrice"].SetOrdinal(5);

                //Populate the POCode Column
                foreach (DataRow row in purchase_order.Rows)
                {
                    row["POCode"] = code;
                }

                //Update
                this.oTrans.UPDATE_PO(code, date, in_charge, cash_given, remarks, purchase_order, Request.Cookies["User"].Values["Username"].ToString());

                //Display a success toast
                this.Show_Message_Toast("Successfully updated " + code);
            }
            else if (Session["NewPO"] == null || (Session["NewPO"] as DataTable).Rows.Count <= 0)
            {
                this.Show_Error_Toast("Empty input. Please add items before saving.");
            }
            else if (string.IsNullOrWhiteSpace(this.txtRemarks.Text))
            {
                this.Show_Error_Toast("Empty Remarks. Please provide the reason for this PO");
                this.txtRemarks.CssClass += " is-invalid";
            }
        }

        private void UPDATE_PO_HEADER()
        {
            //Check if there is a selected PO
            if (!string.IsNullOrEmpty(this.hiddenSelectedPO.Value))
            {
                //Get the data from the controls
                string po_code = this.hiddenSelectedPO.Value;
                string remarks = this.txtRemarks.Text;
                string received_by = this.txtReceiver.Text;
                DateTime date;
                DateTime.TryParse(this.txtDate.Text, out date);
                string in_charge = this.txtInCharge.Text == string.Empty ? "None Assigned" : this.txtInCharge.Text;
                float cash_given = 0f;
                float.TryParse(this.txtCashGiven.Text, out cash_given);

                //Update
                this.oTrans.UPDATE_PO_HDR(po_code, date, in_charge, received_by, cash_given, remarks, 
                    Request.Cookies["User"].Values["Username"].ToString());

                //Display the changes
                this.DISPLAY_PURCHASE_ORDER();

                //Display a toast
                this.Show_Message_Toast("Successfully update " + po_code);
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
        #endregion


        #region EVENTS
        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            //Get the Item Code from the DataKeys
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvIngredients.DataKeys[r.RowIndex].Value.ToString();

            this.ADD_ITEM(code);
            this.DISPLAY_PURCHASE_ORDER();
        }

        protected void btnEditPO_Click(object sender, EventArgs e)
        {
            //Get the PO Code from the DataKeys
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvPO.DataKeys[r.RowIndex].Value.ToString();

            this.hiddenSelectedPO.Value = code;
            this.DISPLAY_PURCHASE_ORDER();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (VALIDATE_PO())
            {
                //Save the new PO to the database
                if (string.IsNullOrEmpty(this.hiddenSelectedPO.Value))
                {
                    this.INSERT_PO();
                }
                //Update the Header data of the selected PO
                else
                {
                    this.UPDATE_PO();
                }
                this.DISPLAY_PURCHASE_ORDER_LIST();
            }
            
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            this.CLEAR();
        }

        protected void gvIngredientList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.gvIngredientList.EditIndex = e.NewEditIndex;

            this.DISPLAY_PURCHASE_ORDER();
        }

        protected void gvIngredientList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            this.UPDATE_ITEM(e.RowIndex);

            this.gvIngredientList.EditIndex = -1;
            this.DISPLAY_PURCHASE_ORDER();
        }

        protected void gvIngredientList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            this.DELETE_ITEM(e.RowIndex);

            this.gvIngredientList.EditIndex = -1;
            this.DISPLAY_PURCHASE_ORDER();
        }

        protected void gvIngredientList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.gvIngredientList.EditIndex = -1;
            this.DISPLAY_PURCHASE_ORDER();
        }

        protected void btnViewRecipe_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string name = r.Cells[0].Text;
            string code = this.gvDish.DataKeys[r.RowIndex].Value.ToString();

            this.DISPLAY_SELECTED_DISH(code,name);
            this.upMenu.Update();
        }

        protected void gvIngredientList_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                if(Session["NewPO"] != null)
                {
                    Label total = (Label)e.Row.FindControl("lblTotal");

                    total.Text = this.CALCULATE_TOTAL(Session["NewPO"] as DataTable).ToString("N2");
                }

            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(this.hiddenSelectedPO.Value))
            {
                string s = "window.open('POPrint.aspx?POCode=" + this.hiddenSelectedPO.Value + "', 'popup_window', 'width=1024, height=768, left=0, top=0, resizable=yes');";
                ScriptManager.RegisterClientScriptBlock(this, this.Page.GetType(), "New Page", s, true);
            }
            else
            {
                this.Show_Error_Toast("No Purchase Order selected.");
            }
        }
        #endregion


    }
}