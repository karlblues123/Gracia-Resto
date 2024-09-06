using CrystalDecisions.CrystalReports.Engine;
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
    public partial class Sales : System.Web.UI.Page
    {
        private cTransaction oTransaction = new cTransaction();
        private cMenu oMenu = new cMenu();
        private cSystem oSys = new cSystem();
        private cMaster oMaster = new cMaster();
        private ReportDocument oReportDocument = new ReportDocument();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Redirect the user if he/she is not logged in
                if (Request.Cookies["User"] == null)
                    Response.Redirect("Login.aspx");
                else if (this.oSys.GET_USER(Request.Cookies["User"].Values["Username"].ToString()).Rows.Count == 0)
                    Response.Redirect("Login.aspx");

                this.DISPLAY_STATUS_LIST();


                this.ddSaleStatus.SelectedIndex = 0;
                this.ddSaleStatus.Enabled = false;

                if (Session["ViewedSales"] != null)
                {
                    if (!string.IsNullOrEmpty(Session["ViewedSales"].ToString()))
                    {
                        string code = Session["ViewedSales"].ToString();
                        Session.Remove("ViewedSales");
                        this.DISPLAY_ORDER(code);
                    }
                }
                this.DISPLAY_CUSTOMERS();
            }
            this.DISPLAY_LIST_DISH();
            this.DISPLAY_LIST_SALES(this.ddStatusFilter.SelectedValue);
        }

        #region LOCAL FUNCTIONS

        private decimal CALCULAT_TOTAL(DataTable data)
        {
            decimal total = 0.00m;
            
            foreach (DataRow row in data.Rows)
            {
                if (row["Total"] != null)
                {
                    total += decimal.Parse(row["Total"].ToString());
                }
            }

            return total;
        }

        private void DISPLAY_STATUS_LIST()
        {
            //Get the Sales Status types from the database
            this.ddSaleStatus.DataSource = oTransaction.GET_SALES_STATUSES();

            //Bind the types to the Form DropDownList
            this.ddSaleStatus.DataTextField = "Description";
            this.ddSaleStatus.DataValueField = "ID";
            this.ddSaleStatus.DataBind();

            //Get the Sales Status types from the database
            this.ddStatusFilter.DataSource = oTransaction.GET_SALES_STATUSES();

            //Bind the types to the Filter DropDownList
            this.ddStatusFilter.DataTextField = "Description";
            this.ddStatusFilter.DataValueField = "ID";
            this.ddStatusFilter.DataBind();
        }

        private void DISPLAY_LIST_DISH()
        {
            //Get the menu from the database
            this.gvDishes.DataSource = this.oMenu.GET_ACTIVE_DISHES();

            //Bind the data to the GridView
            this.gvDishes.DataBind();
        }

        private void DISPLAY_CUSTOMERS()
        {
            this.gvCustomers.DataSource = this.oMaster.GET_CUSTOMERS();
            this.gvCustomers.DataBind();
        }

        private void DISPLAY_DISH_LINE()
        {
            //Display the Dish Line data from Session
            if (string.IsNullOrWhiteSpace(this.hiddenSelectedSale.Value))
            {
                this.gvDishLine.DataSource = Session["Order"] as DataTable;
                this.gvDishLine.DataBind();
            }
            //Display the Dish Line data from the database
            else
            {
                DataTable order = this.oTransaction.GET_SALES_DISHES(this.hiddenSelectedSale.Value);
                order.Columns.Add("Total", typeof(decimal), "(Price - (Discount * Price)) * Quantity");
                this.gvDishLine.DataSource = order;
                this.gvDishLine.DataBind();
            }
        }

        //Used for displaying Sales from the database
        private void DISPLAY_ORDER(string code)
        {
            this.hiddenSelectedSale.Value = code;

            this.DISPLAY_DISH_LINE();

            //Get the header data of the Sale from the database
            DataRow details = this.oTransaction.GET_SALES_HDR(this.hiddenSelectedSale.Value).Rows[0];

            //Display the data to the corresponding controls
            this.txtAmountTendered.Text = details["AmountTendered"].ToString();
            if (!string.IsNullOrEmpty(this.txtAmountTendered.Text))
            {
                decimal total;
                decimal.TryParse(details["TotalAmount"].ToString(), out total);
                lblChangeAmount.Text = "Change: " + (decimal.Parse(details["AmountTendered"].ToString()) - total).ToString();
            }
            this.txtCustomerCode.Text = details["CustomerCode"].ToString();
            this.txtFirstName.Text = details["FirstName"].ToString();
            this.txtLastName.Text = details["LastName"].ToString();
            this.txtDate.Text = details["Date"].ToString();
            this.txtWaiterName.Text = details["WaiterName"].ToString();
            this.txtRoom.Text = details["Room"].ToString();
            this.txtReceiverName.Text = details["ReceiverName"].ToString();
            this.txtDate.Text = DateTime.Parse(details["Date"].ToString()).ToString("yyyy-MM-dd");
            this.txtTips.Text = details["TipAmount"].ToString();
            this.ddSaleStatus.SelectedValue = details["Status"].ToString();

            if (int.Parse(details["Status"].ToString()) == 4)
            {
                DataRow void_sale = this.oTransaction.GET_VOID_SALES(this.hiddenSelectedSale.Value).Rows[0];

                this.txtRemarks.Text = void_sale["Reason"].ToString();

                this.txtAmountTendered.Enabled = false;
                this.txtCustomerCode.Enabled = false;
                this.txtDate.Enabled = false;
                this.txtWaiterName.Enabled = false;
                this.txtRoom.Enabled = false;
                this.txtReceiverName.Enabled = false;
                this.txtDate.Enabled = false;
                this.txtTips.Enabled = false;
                this.btnSave.Enabled = false;
                this.ddSaleStatus.Enabled = false;
                this.txtRemarks.Enabled = false;
                this.gvDishLine.Enabled = false;
                this.gvDishes.Enabled = false;
            }
            else
            {
                this.ddSaleStatus.Enabled = true;
                this.txtAmountTendered.Enabled = true;
                this.txtCustomerCode.Enabled = true;
                this.txtDate.Enabled = true;
                this.txtWaiterName.Enabled = true;
                this.txtRoom.Enabled = true;
                this.txtReceiverName.Enabled = true;
                this.txtDate.Enabled = true;
                this.txtTips.Enabled = true;
                this.btnSave.Enabled = true;
                this.ddSaleStatus.Enabled = true;
                this.txtRemarks.Enabled = true;
                this.gvDishLine.Enabled = true;
                this.gvDishes.Enabled = true;
            }
           
        }

        private void DISPLAY_LIST_SALES(string filter)
        {
            //Get the list of Sales from the database
            DataView data = this.oTransaction.GET_LIST_SALES().DefaultView;

            //Apply the selected Status filter
            data.RowFilter = "Status = " + filter;

            //Toggle placeholder text based on the filtered data
            this.lblNoSales.Visible = !(data.Count > 0);

            //Bind the data to the GridView
            this.gvSales.DataSource = data;
            this.gvSales.DataBind();

            //Register the GridView buttons as PostBack controls
            foreach (GridViewRow row in this.gvSales.Rows)
            {
                LinkButton btn = row.FindControl("btnEditSale") as LinkButton;
                ScriptManager.GetCurrent(this).RegisterPostBackControl(btn);
            }
        }

        private void ADD_DISH(string code)
        {
            //Get the selected Dish data from the database
            DataRow data = oMenu.GET_DISH_HDR(code).Rows[0];

            //Check if there is stock available
            if(int.Parse(data["Stock"].ToString()) > 0)
            {
                //Check if this is an exisiting sale or new sale
                if (string.IsNullOrEmpty(this.hiddenSelectedSale.Value))
                {
                    DataTable new_order;

                    //Get or create a DataTable for Dish Line
                    if (Session["Order"] == null)
                    {
                        new_order = new DataTable();
                        new_order.Columns.Add("ID", typeof(int));
                        new_order.Columns.Add("DishCode", typeof(string));
                        new_order.Columns.Add("Name", typeof(string));
                        new_order.Columns.Add("Price", typeof(decimal));
                        new_order.Columns.Add("Quantity", typeof(int));
                        new_order.Columns.Add("Discount", typeof(decimal));
                        new_order.Columns.Add("Total", typeof(decimal), "(Price - (Discount * Price)) * Quantity");
                        Session["Order"] = new_order;

                    }
                    else
                        new_order = Session["Order"] as DataTable;

                    //Add the selected Dish data to the table
                    DataRow dish = new_order.NewRow();

                    dish["DishCode"] = data["DishCode"].ToString();
                    dish["Name"] = data["Name"].ToString();
                    dish["Price"] = decimal.Parse(data["Price"].ToString());
                    dish["Quantity"] = 0;
                    dish["Discount"] = 0.00m;

                    new_order.Rows.Add(dish);

                    this.DISPLAY_DISH_LINE();
                }
                else
                {
                    //Insert a new Dish line into the selected Sale
                    string remarks = this.txtRemarks.Text;
                    if (!string.IsNullOrWhiteSpace(remarks))
                    {
                        decimal price = decimal.Parse(data["Price"].ToString());

                        this.oTransaction.INSERT_SINGLE_SALES_LINE(code, this.hiddenSelectedSale.Value, price, 1, 0.00m, remarks,
                            Request.Cookies["User"].Values["Username"].ToString());

                        this.txtRemarks.CssClass = "form-control";

                        this.DISPLAY_DISH_LINE();
                    }
                    else
                    {
                        Show_Error_Toast("Empty Remarks. Please provide the reason for updating this sale.");
                        this.txtRemarks.CssClass += " is-invalid";
                    }

                }
            }
            else
            {
                Show_Error_Toast("Error - No stock available for " + data["Name"]);
            }
            
        }

        private void UPDATE_DISH(int index)
        {
            //Get the user input
            string qty_string = (this.gvDishLine.Rows[index].FindControl("txtQuantity") as TextBox).Text;
            string dis_string = (this.gvDishLine.Rows[index].FindControl("txtDiscount") as TextBox).Text;
            string remarks = (this.gvDishLine.Rows[index].FindControl("txtLineRemarks") as TextBox).Text;

            //Check the user input
            if (!string.IsNullOrWhiteSpace(qty_string) && !string.IsNullOrWhiteSpace(dis_string))
            {
                //Parse the user input
                int qty = int.Parse((this.gvDishLine.Rows[index].FindControl("txtQuantity") as TextBox).Text);
                decimal discount = decimal.Parse((this.gvDishLine.Rows[index].FindControl("txtDiscount") as TextBox).Text);

                //Check if this is an existing Sale
                if (string.IsNullOrWhiteSpace(this.hiddenSelectedSale.Value))
                {
                    //Add the input to the table in Session
                    DataRow dish = (Session["Order"] as DataTable).Rows[index];

                    dish["Quantity"] = qty;
                    dish["Discount"] = discount;
                }
                else
                {
                    //Insert a new Dish line into the selected Sale
                    if (!string.IsNullOrWhiteSpace(remarks))
                    {
                        this.oTransaction.UPDATE_SINGLE_SALES_LINE(int.Parse(this.gvDishLine.DataKeys[index].Values[0].ToString()),
                            this.gvDishLine.DataKeys[index].Values[1].ToString(), this.hiddenSelectedSale.Value.ToString(), qty, discount, 
                            remarks, Request.Cookies["User"].Values["Username"].ToString());
                        this.txtRemarks.CssClass = "form-control";
                    }
                    else
                    {
                        this.Show_Error_Toast("Empty Remarks. Please provide the reason for updating this sale.");
                        this.txtRemarks.CssClass += " is-invalid";
                    }
                }
            }
        }

        private void DELETE_DISH(int index)
        {
            //Remove the row in the Session datatable
            if (string.IsNullOrEmpty(this.hiddenSelectedSale.Value))
            {
                //Get the data from Session
                DataTable order = Session["Order"] as DataTable;

                //Delete the row
                order.Rows[index].Delete();

                //Finalize the changes
                order.AcceptChanges();
            }
            //Delete the line in the database
            else
            {
                string remarks = (this.gvDishLine.Rows[index].FindControl("txtLineRemarks") as TextBox).Text;

                if (!string.IsNullOrWhiteSpace(remarks))
                {
                    //Delete the specified line in the database
                    this.oTransaction.DELETE_SINGLE_SALES_LINE(int.Parse(this.gvDishLine.DataKeys[index].Values[0].ToString()), 
                        this.hiddenSelectedSale.Value, this.gvDishLine.DataKeys[index].Values[1].ToString(),
                        remarks, Request.Cookies["User"].Values["Username"].ToString());

                    //Refresh the controls
                    this.DISPLAY_LIST_DISH();
                }
                else
                {
                    Show_Error_Toast("Empty Remarks. Please provide the reason for updating this sale.");
                    this.txtRemarks.CssClass += " is-invalid";
                }
                
            }
        }

        private void CLEAR()
        {
            this.hiddenSelectedSale.Value = string.Empty;
            this.txtCustomerCode.Text = string.Empty;
            this.txtFirstName.Text = string.Empty;
            this.txtLastName.Text = string.Empty;
            this.txtAmountTendered.Text = 0.00m.ToString();
            this.txtDate.Text = string.Empty;
            this.txtReceiverName.Text = string.Empty;
            this.txtRoom.Text = string.Empty;
            this.txtWaiterName.Text = string.Empty;
            this.txtRemarks.Text = string.Empty;
            this.txtTips.Text = string.Empty;
            this.lblChangeAmount.Text = "Total: 0.00";
            this.gvDishLine.DataSource = null;
            this.gvDishLine.DataBind();
            Session.Remove("Order");

            this.ddSaleStatus.Enabled = false;
            this.ddSaleStatus.SelectedIndex = 0;

            //Enable buttons in case they were disabled when viewing Void Sales
            this.txtAmountTendered.Enabled = true;
            this.txtCustomerCode.Enabled = true;
            this.txtDate.Enabled = true;
            this.txtWaiterName.Enabled = true;
            this.txtRoom.Enabled = true;
            this.txtReceiverName.Enabled = true;
            this.txtDate.Enabled = true;
            this.txtTips.Enabled = true;
            this.btnSave.Enabled = true;
            this.ddSaleStatus.Enabled = false;
            this.txtRemarks.Enabled = true;
            this.gvDishLine.Enabled = true;
            this.gvDishes.Enabled = true;

            this.txtCustomerCode.CssClass = "form-control";
            this.txtRemarks.CssClass = "form-control";
        }

        private void INSERT_NEW_SALE()
        {
            //Get the user input for Customer
            string customer = this.txtCustomerCode.Text;

            //Check if there is a Dish Line table and selected Customer
            if (Session["Order"] != null && !string.IsNullOrWhiteSpace(customer))
            {
                //Get the data for Insert
                DataTable data = Session["Order"] as DataTable;
                string code = this.oSys.GET_SERIES_NUMBER("S");
                decimal total = 0.00m;
                data.Columns.Remove("ID");
                data.Columns.Add("SalesCode").SetOrdinal(0);
                foreach (DataRow row in data.Rows)
                {
                    row["SalesCode"] = code;
                    total += decimal.Parse(row["Total"].ToString());
                }
                data.Columns.Remove("Total");
                data.Columns.Remove("Name");
                data.Columns["DishCode"].SetOrdinal(1);
                data.Columns["Price"].SetOrdinal(2);
                data.Columns["Quantity"].SetOrdinal(3);
                data.Columns["Discount"].SetOrdinal(4);
                decimal tendered = 0.00m;
                decimal.TryParse(this.txtAmountTendered.Text, out tendered);
                SqlDateTime date = this.txtDate.Text == string.Empty ? DateTime.Now : SqlDateTime.Parse(this.txtDate.Text);
                string waiter = this.txtWaiterName.Text == string.Empty ? "None Specified" : this.txtWaiterName.Text;
                string room = this.txtRoom.Text == string.Empty ? "None Specified" : this.txtRoom.Text;

                //Update the database
                this.oTransaction.INSERT_NEW_SALE(code, customer, total, tendered, date, waiter, room, data, Request.Cookies["User"].Values["Username"].ToString());


                //Display a success toast
                this.Show_Message_Toast("Sales " + code + " saved.");

                this.CLEAR();
            }
            else
            {
                Show_Error_Toast("Empty Customer Name. Please provide the customer name.");
                this.txtCustomerCode.CssClass += " is-invalid";
            }
        }

        private void UPDATE_SALE_HDR()
        {
            //Get the data for Update
            string code = this.hiddenSelectedSale.Value;
            decimal tendered = 0.00m;
            decimal.TryParse(this.txtAmountTendered.Text, out tendered);
            string waiter = this.txtWaiterName.Text == string.Empty ? "None Specified" : this.txtWaiterName.Text;
            string room = this.txtRoom.Text == string.Empty ? "None Specified" : this.txtRoom.Text;
            decimal tip = 0.00m;
            decimal.TryParse(this.txtTips.Text, out tip);
            string receiver = this.txtReceiverName.Text == string.Empty ? "None Specified" : this.txtReceiverName.Text;
            int status = int.Parse(this.ddSaleStatus.SelectedValue);
            string remarks = string.Empty;
            if(!string.IsNullOrEmpty(this.txtRemarks.Text))
                remarks = this.txtRemarks.Text;

            if(status < 4)
            {
                if (!string.IsNullOrWhiteSpace(remarks))
                {
                    //Update the database
                    this.oTransaction.UPDATE_SALES_HDR(code, tendered, waiter, room, tip, receiver, status, remarks, 
                        Request.Cookies["User"].Values["Username"].ToString());

                    Show_Message_Toast("Updated " + code);
                }
                else
                {
                    Show_Error_Toast("Empty Remarks. Please provide a reason to update.");
                    this.txtRemarks.CssClass += " is-invalid";
                }
            }
            //Upsert a void sale
            else
            {
                if (!string.IsNullOrEmpty(remarks))
                {
                    //Get the data for Upsert
                    DataTable data = this.oTransaction.GET_SALES_DISHES(code);
                    data.Columns.Add("SalesCode").SetOrdinal(0);
                    data.Columns.Remove("Name");
                    data.Columns.Remove("ID");
                    data.Columns["DishCode"].SetOrdinal(1);
                    data.Columns["Price"].SetOrdinal(2);
                    data.Columns["Quantity"].SetOrdinal(3);
                    data.Columns["Discount"].SetOrdinal(4);
                    string void_code = this.oSys.GET_SERIES_NUMBER("V");

                    //Upsert
                    this.oTransaction.UPSERT_VOID_SALES(code, void_code, DateTime.Now, remarks, data, 
                        Request.Cookies["User"].Values["Username"].ToString());

                    Show_Warning_Toast(code + " is now void");
                }
                else
                {
                    Show_Error_Toast("Empty Remarks. Please provide a reason to void this sales.");
                    this.txtRemarks.CssClass += " is-invalid";
                }   
            }
        }

        private void SELECT_CUSTOMER(string code)
        {
            //Get the Customer data from the database
            DataRow customer = this.oMaster.GET_CUSTOMER_BY_CODE(code).Rows[0];

            //Check if there is a Customer
            if (!customer.IsNull(0))
            {
                //Display the Customer data to the controls
                this.txtCustomerCode.Text = customer["GuestCode"].ToString();
                this.txtFirstName.Text = customer["FirstName"].ToString();
                this.txtLastName.Text = customer["LastName"].ToString();
            }
        }

        private bool VALIDATE_REPORT_INPUT()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtStartDate.Text))
                is_valid = false;
            if (string.IsNullOrWhiteSpace(this.txtEndDate.Text))
                is_valid = false;

            return is_valid;
        }

        private void DISPLAY_REPORT()
        {
            DateTime start_date = DateTime.Parse(this.txtStartDate.Text);
            DateTime end_date = DateTime.Parse(this.txtEndDate.Text);

            //Load the report
            this.oReportDocument.Load(Server.MapPath("~/Reports/repSales.rpt"));

            this.oReportDocument.Database.Tables[0].SetDataSource(this.oTransaction.GET_PAID_SALES(start_date, end_date));

            //Display the data
            this.CRV.ReportSource = this.oReportDocument;
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
        protected void btnAddDish_Click(object sender, EventArgs e)
        {
            //Get the code
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvDishes.DataKeys[r.RowIndex].Value.ToString();

            this.ADD_DISH(code);

        }

        protected void gvDishLine_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.gvDishLine.EditIndex = e.NewEditIndex;

            this.DISPLAY_DISH_LINE();
        }

        protected void gvDishLine_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            this.UPDATE_DISH(e.RowIndex);

            this.gvDishLine.EditIndex = -1;
            this.DISPLAY_DISH_LINE();
            this.DISPLAY_LIST_DISH();
        }

        protected void gvDishLine_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            this.DELETE_DISH(e.RowIndex);

            this.gvDishLine.EditIndex = -1;
            this.DISPLAY_DISH_LINE();
            this.DISPLAY_LIST_DISH();
        }

        protected void gvDishLine_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.gvDishLine.EditIndex = -1;
            this.DISPLAY_DISH_LINE();
        }

        protected void ddStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_LIST_SALES(this.ddStatusFilter.SelectedValue);
        }

        protected void btnEditSale_Click(object sender, EventArgs e)
        {
            //Get the code
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvSales.DataKeys[r.RowIndex].Value.ToString();

            this.DISPLAY_ORDER(code);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(this.hiddenSelectedSale.Value))
                this.UPDATE_SALE_HDR();
            else
                this.INSERT_NEW_SALE();
            DISPLAY_LIST_SALES(this.ddStatusFilter.SelectedValue);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            this.CLEAR();
        }

        protected void btnSelectCustomer_Click(object sender, EventArgs e)
        {
            //Get the code
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvCustomers.DataKeys[r.RowIndex].Value.ToString();

            this.SELECT_CUSTOMER(code);
        }

        protected void gvDishLine_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label total = (Label)e.Row.FindControl("lblTotalAmount");

                if(Session["Order"] != null)
                    total.Text = this.CALCULAT_TOTAL(Session["Order"] as DataTable).ToString("N2");
            }
        }

        protected void btnReportSubmit_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_REPORT_INPUT())
                this.DISPLAY_REPORT();
        }
        #endregion


    }
}