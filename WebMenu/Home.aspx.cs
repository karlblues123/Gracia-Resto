using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class Home : System.Web.UI.Page
    {
        private cTransaction oTrans = new cTransaction();
        private cMenu oMenu = new cMenu();
        private cMaster oMaster = new cMaster();
        private cSystem oSys = new cSystem();
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
            }
            this.DISPLAY_LIST_SALES(ddStatusFilter.SelectedValue);
            this.DISPLAY_LOW_STOCK();
            this.DISPLAY_PRICE_IMBALANCE();
            this.DISPLAY_TABLES();
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_STATUS_LIST()
        {
            //Get the Sales Status types from the database
            ddStatusFilter.DataSource = oTrans.GET_SALES_STATUSES();

            //Bind the types to the Filter DropDownList
            ddStatusFilter.DataTextField = "Description";
            ddStatusFilter.DataValueField = "ID";
            ddStatusFilter.DataBind();
        }

        private void DISPLAY_LIST_SALES(string filter)
        {
            //Get the list of Sales from the database
            DataView data = new DataView(this.oTrans.GET_LIST_SALES());

            //Apply the selected Status filter
            data.RowFilter = "Status = " + filter + " AND Date = #" + DateTime.Now.ToString("yyyy-MM-dd") + "#";

            //Bind the data to the GridView
            this.gvTodaySales.DataSource = data;
            this.gvTodaySales.DataBind();

        }

        private void DISPLAY_LOW_STOCK()
        {
            //Get the Menu from the database
            DataView data = new DataView(this.oMenu.GET_ACTIVE_DISHES());

            //Apply the filter
            data.RowFilter = "Stock <= 5";

            //Bind the data to the GridView
            this.gvMenuStock.DataSource = data;
            this.gvMenuStock.DataBind();
        }

        private void DISPLAY_PRICE_IMBALANCE()
        {
            DataTable data = this.oMenu.GET_ACTIVE_DISHES();

            //Append a new Column Actual Price to the table
            data.Columns.Add("ActualPrice", typeof(System.Decimal));

            //Calculate the Actual Price and insert
            foreach(DataRow dish in data.Rows)
            {
                DataTable ingredients = this.oMenu.GET_LIST_DISH_ITEMS(dish["DishCode"].ToString());

                ingredients.Columns.Add("Total", typeof(System.Decimal), "Quantity * Price");

                decimal total = 0.00m;
                foreach (DataRow ing in ingredients.Rows)
                {
                    total += decimal.Parse(ing["Total"].ToString());
                }

                dish["ActualPrice"] = total;
            }

            //Filter the data
            DataView filtered_data = data.DefaultView;
            filtered_data.RowFilter = "Price < ActualPrice";

            //Display the data
            this.gvMenuPrice.DataSource = filtered_data;
            this.gvMenuPrice.DataBind();
        }

        private void DISPLAY_TABLES()
        {
            DataView data = this.oMaster.GET_TABLE_LISTS().DefaultView;
            data.RowFilter = "TableStatusCode = 'R' OR TableStatusCode = 'O'";

            this.gvTables.DataSource = data;
            this.gvTables.DataBind();
        }
        #endregion

        #region EVENTS
        protected void ddStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.DISPLAY_LIST_SALES(ddStatusFilter.SelectedValue);
        }

        protected void btnViewSale_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            Session["ViewedSales"] = this.gvTodaySales.DataKeys[r.RowIndex].Value.ToString();
            Response.Redirect("Sales.aspx");
        }
        #endregion


    }
}