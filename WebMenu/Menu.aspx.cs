using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class Menu : System.Web.UI.Page
    {
        private cMenu oMenu = new cMenu();
        private cMaster oMaster = new cMaster();

        protected void Page_Load(object sender, EventArgs e)
        {
            //Get the location from the Query String
            if (!string.IsNullOrWhiteSpace(Request.QueryString["Location"]))
            {
                if (this.VALIDATE_LOCATION(Request.QueryString["Location"]))
                {
                    if (this.CHECK_TABLE(Request.QueryString["Location"]))
                    {
                        Session["Location"] = Request.QueryString["Location"];
                    }
                    else
                        this.lblTableTakenAlert.Visible = true;
                }
                else
                    this.lblNoTableAlert.Visible = true;
            }
            else
                this.lblNoTableAlert.Visible = true;
                
            //Get and Display the data to the Repeaters
            this.rAppetizer.DataSource = oMenu.GET_LIST_DISH_WITH_TYPE(1);
            this.rAppetizer.DataBind();

            this.rSoup.DataSource = oMenu.GET_LIST_DISH_WITH_TYPE(2);
            this.rSoup.DataBind();

            this.rMainDish.DataSource = oMenu.GET_LIST_DISH_WITH_TYPE(3);
            this.rMainDish.DataBind();

            this.rRice.DataSource = oMenu.GET_LIST_DISH_WITH_TYPE(4);
            this.rRice.DataBind();

            this.rDesserts.DataSource = oMenu.GET_LIST_DISH_WITH_TYPE(5);
            this.rDesserts.DataBind();

            this.rBeverages.DataSource = oMenu.GET_LIST_DISH_WITH_TYPE(6);
            this.rBeverages.DataBind();

            if (!IsPostBack)
            {
                this.gvOrder.DataSource = null;
                this.gvOrder.DataBind();
            }

        }

        #region LOCAL FUNCTIONS
        public string GetImage(string dish_name)
        {
            return "~/Images/" + dish_name.Replace(' ', '-') +".png";
        }

        private decimal Calculate_Total(DataTable data)
        {
            decimal total = 0.00m;
            foreach (DataRow row in data.Rows)
            {
                total += decimal.Parse(row["Total"].ToString());
            }
            return total;
        }

        private bool VALIDATE_LOCATION(string location)
        {
            bool is_valid = false;

            //Check if the customer submitted a location
            if (!string.IsNullOrEmpty(location))
                is_valid = this.oMaster.GET_TABLE_BY_CODE(location).Rows.Count > 0;

            return is_valid;
        }

        private bool CHECK_TABLE(string location)
        {
            DataRow selected_table = this.oMaster.GET_TABLE_BY_CODE(location).Rows[0];

            return char.Equals(char.Parse(selected_table["TableStatusCode"].ToString()), 'A');
        }

        private void INSERT_DISH(int count)
        {
            //Get or Create the Order DataTable
            DataTable order;
            if (Session["CustomerOrder"] == null)
            {
                order = new DataTable();
                Session.Add("CustomerOrder", order);
                Session.Timeout = 60;
            }
            else
                order = Session["CustomerOrder"] as DataTable;

            if (order.Rows.Count > 0)
            {
                //Check if the dish is already present
                if (order.Select("DishCode='" + this.hiddenSelectedDish.Value.ToString() + "'").SingleOrDefault<DataRow>() != null)
                {
                    //Set the quantity of the selected dish
                    if (count > 0)
                        order.Select("DishCode='" + this.hiddenSelectedDish.Value.ToString() + "'").SingleOrDefault<DataRow>()["Quantity"] = count;
                    //Delete the dish if the quantity is 0
                    else
                    {
                        order.Select("DishCode='" + this.hiddenSelectedDish.Value.ToString() + "'").SingleOrDefault<DataRow>().Delete();
                        order.AcceptChanges();
                    }  
                }
                //Insert a new entry to the Order DataTable    
                else
                {
                    if (count > 0)
                    {
                        //Get the data from the database
                        DataTable data = oMenu.GET_DISH_HDR(hiddenSelectedDish.Value.ToString());

                        //Remove the unnecessary columns
                        data.Columns.Remove("ID");
                        data.Columns.Remove("Stock");
                        data.Columns.Remove("Serving");
                        data.Columns.Remove("Type");
                        data.Columns.Remove("Description");
                        data.Columns.Remove("IsActive");

                        //Add the necessary columns
                        data.Columns.Add("Quantity", typeof(int));
                        data.Columns.Add("Discount", typeof(decimal));
                        data.Columns.Add("Total", typeof(decimal));

                        //Fill the empty columns
                        foreach (DataRow row in data.Rows)
                        {
                            row["Quantity"] = int.Parse(txtDishOrderQty.Text);
                            row["Discount"] = 0.00m;
                            row["Total"] = int.Parse(txtDishOrderQty.Text) * decimal.Parse(this.lblSelectedDishPrice.Text);

                        }

                        order.Merge(data);
                    }
                    
                }
            }
            //Insert a new entry to the Order DataTable
            else
            {
                if(count > 0)
                {
                    //Get the data from the database
                    DataTable data = oMenu.GET_DISH_HDR(hiddenSelectedDish.Value.ToString());

                    //Remove the unnecessary columns
                    data.Columns.Remove("ID");
                    data.Columns.Remove("Stock");
                    data.Columns.Remove("Serving");
                    data.Columns.Remove("Type");
                    data.Columns.Remove("Description");
                    data.Columns.Remove("IsActive");

                    //Add the necessary columns
                    data.Columns.Add("Quantity", typeof(int));
                    data.Columns.Add("Discount", typeof(decimal));
                    data.Columns.Add("Total", typeof(decimal));

                    //Fill the empty columns
                    foreach (DataRow row in data.Rows)
                    {
                        row["Quantity"] = int.Parse(txtDishOrderQty.Text);
                        row["Discount"] = 0.00m;
                        row["Total"] = int.Parse(txtDishOrderQty.Text) * decimal.Parse(this.lblSelectedDishPrice.Text);

                    }

                    order.Merge(data);
                }
                
            }
            this.hiddenSelectedDish.Value = string.Empty;
            this.pSelectedDish.Visible = false;
            this.pMenu.Visible = true;
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
                    this.hiddenDishAvailableStock.Value = row["Stock"].ToString();
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
            }
        }

        private void DISPLAY_ORDER()
        {
            if(Session["CustomerOrder"] != null)
            {
                //Display the customer's order in the Repeater
                this.gvOrder.DataSource = Session["CustomerOrder"] as DataTable;
                this.gvOrder.DataBind();
            }
        }
        #endregion

        #region EVENTS
        protected void lnkAddToOrder_Click(object sender, EventArgs e)
        {
            int count = 0;
            int.TryParse(this.txtDishOrderQty.Text, out count);
            if (!string.IsNullOrEmpty(this.hiddenSelectedDish.Value))
                this.INSERT_DISH(count);
        }

        protected void lnkViewOrder_Click(object sender, EventArgs e)
        {
            if (Session["CustomerOrder"] != null && (Session["CustomerOrder"] as DataTable).Rows.Count > 0 && Session["Location"] != null)
            {
                if (!string.IsNullOrWhiteSpace(Session["Location"].ToString()))
                    Response.Redirect("OrderSummary.aspx");
                else
                    this.lblNoTableAlert.Visible = true;
            }
            else if(Session["Location"] == null)
                this.lblNoTableAlert.Visible = true;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            this.pSelectedDish.Visible = false;

            this.hiddenSelectedDish.Value = string.Empty;
            this.lblSelectedDishName.Text = string.Empty;
            this.lblSelectedDishPrice.Text = string.Empty;
            this.lblSelectedDishServing.Text = string.Empty;

            this.pSelectedDish.Visible = false;
            this.pMenu.Visible = true;
        }

        protected void btnDish_Command(object sender, CommandEventArgs e)
        {
            if (string.Equals(e.CommandName, "Display"))
            {
                this.hiddenSelectedDish.Value = e.CommandArgument.ToString();
                this.DISPLAY_SELECTED_DISH();
                this.DISPLAY_ORDER();

                this.pMenu.Visible = false;
                this.pSelectedDish.Visible = true;
            }
        }

        protected void gvOrder_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                // Get the OrderTotalLabel Label control in the footer row.
                Label total = (Label)e.Row.FindControl("lblTotal");

                // Display the grand total of the order formatted as currency.
                if (total != null && Session["CustomerOrder"] != null)
                {
                    total.Text = this.Calculate_Total(Session["CustomerOrder"] as DataTable).ToString();
                }
            }
        }
        #endregion
    }
}