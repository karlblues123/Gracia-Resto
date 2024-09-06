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
    public partial class Standby : System.Web.UI.Page
    {
        private cSystem oSys = new cSystem();
        private cTransaction oTrans = new cTransaction();
        private cMaster oMaster = new cMaster();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["SalesCode"] != null)
            {
                //Display the Sales Code and Customer's order
                this.lblOrderNumber.Text = Session["SalesCode"].ToString();
                this.gvOrder.DataSource = Session["CustomerOrder"] as DataTable;
                this.gvOrder.DataBind();

                this.DISPLAY_ORDER_STATUS();
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

        private void DISPLAY_ORDER_STATUS()
        {
            int status = int.Parse(this.oMaster.GET_ORDER_STATUS(Session["SalesCode"].ToString()).Rows[0]["KitchenStatusID"].ToString());
            switch (status)
            {
                case 1: this.lblOrderStatus.Text = "Your Order is pending."; break;
                case 2: this.lblOrderStatus.Text = "Your Order is accepted and is being prepared.";break;
                case 3: this.lblOrderStatus.Text = "Your Order is complete and is about to be served.";break;
                case 4: this.lblOrderStatus.Text = "Error - Your Order is void."; break;
                default: this.lblOrderStatus.Text = "Error - Unknown status."; break;
            }
        }
        #endregion

        #region EVENTS
        protected void lnkCancelOrder_Click(object sender, EventArgs e)
        {
            //Get the necessary data
            string void_code = oSys.GET_SERIES_NUMBER("V");
            SqlDateTime date = DateTime.Now;
            string reason = "Canceled by the Customer";
            DataTable order = (Session["CustomerOrder"] as DataTable).Copy();
            decimal total = 0.00m;

            if (order.Rows.Count > 0)
            {

                //Add the Sales Code Column and arrange the columns according to the user-defined table type
                order.Columns.Add("SalesCode").SetOrdinal(0);
                order.Columns["DishCode"].SetOrdinal(1);
                order.Columns["Price"].SetOrdinal(2);
                order.Columns["Quantity"].SetOrdinal(3);
                order.Columns["Discount"].SetOrdinal(4);

                //Fill the Sales Code and Total Column
                foreach (DataRow row in order.Rows)
                {
                    row["SalesCode"] = Session["SalesCode"].ToString();
                    total += decimal.Parse(row["Total"].ToString());
                }

                //Remove the unnecessary columns
                order.Columns.Remove("Total");
                order.Columns.Remove("Name");

            }

            //Upsert the transaction as a Void Sales
            this.oTrans.UPSERT_VOID_SALES(Session["SalesCode"].ToString(), void_code, date, reason, order,string.Empty);

            Session.Remove("CustomerOrder");

            //Redirect back to the Menu webpage
            Response.Redirect("Menu.aspx?Location=" + Session["Location"].ToString());
        }

        protected void btnAdditionalOrder_Click(object sender, EventArgs e)
        {
            Session.Remove("CustomerOrder");

            //Redirect back to the Menu webpage
            Response.Redirect("Menu.aspx?Location=" + Session["Location"].ToString());
        }

        protected void tickUpdate_Tick(object sender, EventArgs e)
        {
            this.DISPLAY_ORDER_STATUS();
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