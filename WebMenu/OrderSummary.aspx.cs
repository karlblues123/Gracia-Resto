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
    public partial class OrderSummary : System.Web.UI.Page
    {
        private cSystem oSys = new cSystem();
        private cTransaction oTrans = new cTransaction();
        private cMenu oMenu = new cMenu();
        private cMaster oMaster = new cMaster();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["CustomerOrder"] != null)
            {
                if(Session["Location"] != null)
                    if (!string.IsNullOrWhiteSpace(Session["Location"].ToString()))
                    {
                        string location = this.PARSE_LOCATION(Session["Location"].ToString());
                        if (!string.IsNullOrWhiteSpace(location))
                            this.txtCustomerLocation.Text = location;
                        else
                            Response.Redirect("Menu.aspx?Location=" + Session["Location"].ToString());
                    }
                        

                this.DISPLAY_ORDER();

            }
        }

        #region LOCAL FUNCTIONS
        private decimal Calculate_Total(DataTable data)
        {
            decimal total = 0.00m;
            foreach (DataRow row in data.Rows)
            {
                total += decimal.Parse(row["Total"].ToString());
            }
            return total;
        }

        private bool INSERT_NEW_ORDER()
        {
            bool newOrder = false;
            string location = this.PARSE_LOCATION(Session["Location"].ToString());
            if (Session["CustomerOrder"] != null && !string.IsNullOrWhiteSpace(this.txtCustomerCode.Text) && !string.IsNullOrWhiteSpace(location))
            {
                DataTable guest = this.oMaster.GET_CUSTOMER_BY_CODE(this.txtCustomerCode.Text);

                if (guest.Rows.Count > 0)
                {
                    //Copy the data to a new data table
                    DataTable order = (Session["CustomerOrder"] as DataTable).Copy();

                    if (order.Rows.Count > 0)
                    {
                        //Get the necessary data
                        string code = oSys.GET_SERIES_NUMBER("S");
                        string customer = this.txtCustomerCode.Text;

                        decimal total = 0.00m;
                        SqlDateTime date = DateTime.Now;


                        //Add the Sales Code Column and arrange the columns according to the user-defined table type
                        order.Columns.Add("SalesCode").SetOrdinal(0);
                        order.Columns["DishCode"].SetOrdinal(1);
                        order.Columns["Price"].SetOrdinal(2);
                        order.Columns["Quantity"].SetOrdinal(3);
                        order.Columns["Discount"].SetOrdinal(4);

                        //Fill the Sales Code and Total Column
                        foreach (DataRow row in order.Rows)
                        {
                            row["SalesCode"] = code;
                            total += decimal.Parse(row["Total"].ToString());
                        }

                        //Remove the unnecessary columns
                        order.Columns.Remove("Total");
                        order.Columns.Remove("Name");

                        //Insert the data to the database
                        this.oTrans.INSERT_NEW_SALE(code, customer, total, 0.00m, date, "None", location, order, string.Empty);

                        //Insert the Sales Code to the Session
                        Session.Add("SalesCode", code);

                        newOrder = true;

                        this.txtCustomerCode.CssClass = "form-control";
                    }
                    else
                    {
                        this.lblErrorAlert.Text = "Empty Basket. Please place an item.";
                        this.lblErrorAlert.Visible = true;
                    }
                }
                else
                {
                    this.txtCustomerCode.CssClass += " is-invalid";
                    this.lblErrorAlert.Text = "Code is invalid. Please see a Frontdesk personnel for help.";
                    this.lblErrorAlert.Visible = true;
                }
            }
            else if (string.IsNullOrWhiteSpace(this.txtCustomerCode.Text))
            {
                this.txtCustomerCode.CssClass += " is-invalid";
                this.lblErrorAlert.Text = "No code given. Please provide your code.";
                this.lblErrorAlert.Visible = true;
            }
            else if (string.IsNullOrWhiteSpace(location))
            {
                this.txtCustomerLocation.CssClass += " is-invalid";
                this.lblErrorAlert.Text = "No location found. Please scan the QR Code again to get the location.";
                this.lblErrorAlert.Visible = true;
            }
            return newOrder;
            
        }

        private void DISPLAY_SELECTED_DISH()
        {
            if (!string.IsNullOrEmpty(this.hiddenSelectedDish.Value))
            {
                //Get the data from the database
                foreach (DataRow row in oMenu.GET_DISH_HDR(this.hiddenSelectedDish.Value).Rows)
                {
                    //Display the data to the Labels
                    this.lblSelectedDishName.Text = row["Name"].ToString();
                    this.lblSelectedDishPrice.Text = row["Price"].ToString();
                    this.lblSelectedDishServing.Text = row["Serving"].ToString();
                }
                //Display the dish quantity
                if (Session["CustomerOrder"] != null && (Session["CustomerOrder"] as DataTable).Rows.Count > 0)
                {
                    //Display the current quantity of an existing dish
                    if ((Session["CustomerOrder"] as DataTable).Select("DishCode='" + this.hiddenSelectedDish.Value.ToString() + "'").SingleOrDefault<DataRow>() != null)
                    {
                        DataRow row = (Session["CustomerOrder"] as DataTable).Select("DishCode='" + this.hiddenSelectedDish.Value.ToString() + "'").SingleOrDefault<DataRow>();
                        txtDishOrderQty.Text = int.Parse(row["Quantity"].ToString()).ToString();
                    }
                    else
                        txtDishOrderQty.Text = "0";
                }
                this.pOrder.Visible = false;
                this.pSelectedDish.Visible = true;
            }
        }

        private void UPDATE_DISH()
        {
            //Get the quantity input from the customer
            int count = int.Parse(txtDishOrderQty.Text);

            //Get the order data and the selected dish data
            DataTable order = Session["CustomerOrder"] as DataTable;
            DataRow selectedDish = order.Select("DishCode='" + this.hiddenSelectedDish.Value.ToString() + "'").SingleOrDefault<DataRow>();

            //Update the count
            if (count > 0)
            {
                selectedDish["Quantity"] = count;
                selectedDish["Total"] = count * decimal.Parse(selectedDish["Price"].ToString());
            }
            //Remove the dish if count is 0
            else
            {
                selectedDish.Delete();
                order.AcceptChanges();
            }

            this.Calculate_Total(order);

            //Update the order
            this.gvOrder.DataSource = order;
            this.gvOrder.DataBind();

            this.hiddenSelectedDish.Value = string.Empty;
        }

        private void CLEAR_SELECTED_DISH()
        {
            this.hiddenSelectedDish.Value = string.Empty;
            this.lblSelectedDishName.Text = string.Empty;
            this.lblSelectedDishPrice.Text = string.Empty;
            this.lblSelectedDishServing.Text = string.Empty;
            this.txtDishOrderQty.Text = "0";
        }

        private string PARSE_LOCATION(string location)
        {
            string parsed_location = location;

            //Check if the customer submitted a location
            if (!string.IsNullOrEmpty(location))
            {
                if (this.oMaster.GET_TABLE_BY_CODE(location).Rows.Count == 0)
                    parsed_location = string.Empty;
                else
                    parsed_location = this.oMaster.GET_TABLE_BY_CODE(location).Rows[0]["TableName"].ToString();
            }

            return parsed_location;
        }

        private void DISPLAY_ORDER()
        {
            //Display the customer's order in the Repeater
            this.gvOrder.DataSource = Session["CustomerOrder"] as DataTable;
            this.gvOrder.DataBind();
        }
        #endregion

        #region EVENTS
        protected void lnkBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu.aspx?Location=" + Session["Location"].ToString());
        }

        protected void lnkPlaceOrder_Click(object sender, EventArgs e)
        {
            if (INSERT_NEW_ORDER())
                Response.Redirect("Standby.aspx");
            else
                this.lblErrorAlert.Visible = true;
        }

        protected void lnkConfirmChanges_Click(object sender, EventArgs e)
        {
            this.UPDATE_DISH();

            this.CLEAR_SELECTED_DISH();
            this.pSelectedDish.Visible = false;
            this.pOrder.Visible = true;
        }

        protected void btnQty_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvOrder.DataKeys[r.RowIndex].Value.ToString();

            this.hiddenSelectedDish.Value = code;
            this.DISPLAY_SELECTED_DISH();
            this.DISPLAY_ORDER();
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            this.CLEAR_SELECTED_DISH();
            this.pSelectedDish.Visible = false;
            this.pOrder.Visible = true;
        }

        protected void gvOrder_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                // Get the OrderTotalLabel Label control in the footer row.
                Label total = (Label)e.Row.FindControl("lblTotal");

                // Display the grand total of the order formatted as currency.
                if (total != null)
                {
                    total.Text = this.Calculate_Total(Session["CustomerOrder"] as DataTable).ToString();
                }
            }
        }
        #endregion


    }
}