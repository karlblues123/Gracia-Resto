using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace GraciaResto
{
    public partial class webKitchen : System.Web.UI.Page
    {
       
        cMaster oMaster = new cMaster();
        cSystem oSys = new cSystem();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //Redirect the user if he/she is not logged in
                if (Request.Cookies["User"] == null)
                    Response.Redirect("Login.aspx");
                else if (this.oSys.GET_USER(Request.Cookies["User"].Values["Username"].ToString()).Rows.Count == 0)
                    Response.Redirect("Login.aspx");

                DISPLAY_REQUEST_ORDERS();

                DISPLAY_PREPARING_ORDERS();

                DISPLAY_ORDERS_COMPLETED();
            }



        }

        #region "UDF"
        private void DISPLAY_REQUEST_ORDERS()
        {
            DataTable dt = oMaster.GET_ORDER_REQUEST_LISTS();
            rptRequest.DataSource = dt;
            rptRequest.DataBind();

            lblRequestOrderCount.Text = dt.Rows.Count.ToString();
        }


        private void DISPLAY_PREPARING_ORDERS()
        {
            DataTable dt = oMaster.GET_ORDER_PREPARING_LISTS();
            rptPreparation.DataSource = dt;
            rptPreparation.DataBind();

            lblOrdersPreparingCount.Text = dt.Rows.Count.ToString();
        }

        private void DISPLAY_ORDERS_COMPLETED()
        {
            DataTable dt = oMaster.GET_ORDERS_COMPLETION();
            gvOrdersCompleted.DataSource = dt;
            gvOrdersCompleted.DataBind();
        }
        #endregion







        #region "Local Functions"
        public string GetImage(string dish_name)
        {
            return "~/Images/" + dish_name.Replace(' ', '-') + ".png";
        }


        #endregion



        protected void rptRequest_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var hfSalesOrder = (HiddenField)e.Item.FindControl("hfSalesCode");
                var rptRequestChild = (Repeater)e.Item.FindControl("rptRequestChild");

                DataTable dt = oMaster.GET_REQUEST_ORDERS(hfSalesOrder.Value);

                rptRequestChild.DataSource = dt;
                rptRequestChild.DataBind();
            }
        }

        protected void rptRequest_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ACCEPT")
            {
                var hfSalesCode = (e.Item.FindControl("hfSalesCode") as HiddenField);

                oMaster.UPDATE_ACCEPT_REQUEST(hfSalesCode.Value, Request.Cookies["User"].Values["Username"].ToString());

                //Refresh table list here
                DISPLAY_REQUEST_ORDERS();

                DISPLAY_PREPARING_ORDERS();

                //Display the Toast and hide the modal
                ScriptManager.RegisterStartupScript(this, this.Page.GetType(), "Success", "showToastSuccess('Orders accepted and preparing.');", true);

            }
        }

        protected void rptPreparation_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var hfSalesOrder = (HiddenField)e.Item.FindControl("hfSalesCode");
                var rptPreparingChild = (Repeater)e.Item.FindControl("rptPreparingChild");

                DataTable dt = oMaster.GET_PREPARING_ORDERS(hfSalesOrder.Value);

                rptPreparingChild.DataSource = dt;
                rptPreparingChild.DataBind();
            }
        }

        protected void rptPreparation_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "COMPLETE")
            {
                var hfSalesCode = (e.Item.FindControl("hfSalesCode") as HiddenField);

                oMaster.UPDATE_ORDER_COMPLETE(hfSalesCode.Value, Request.Cookies["User"].Values["Username"].ToString());

                DISPLAY_PREPARING_ORDERS();
                DISPLAY_ORDERS_COMPLETED();

                //Display the Toast and hide the modal
                ScriptManager.RegisterStartupScript(this, this.Page.GetType(), "Success", "showToastSuccess('Orders completed!.');", true);

            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            DISPLAY_REQUEST_ORDERS();
        }
    }
}