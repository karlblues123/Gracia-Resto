using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using System.Configuration;
using System.Data.SqlClient;

namespace GraciaResto
{
    public partial class DishStock : System.Web.UI.Page
    {
        ReportDocument oReportDocument = new ReportDocument();
        cMenu oMenu = new cMenu();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["User"] == null)
                Response.Redirect("Login.aspx");

            this.DISPLAY_REPORT();
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_REPORT()
        {
            //Load the report
            this.oReportDocument.Load(Server.MapPath("~/Reports/repMenuStock.rpt"));

            //Get the data from the database
            this.oReportDocument.SetDataSource(this.oMenu.GET_LIST_DISH());

            //Display the data
            this.CRV.ReportSource = this.oReportDocument;

        }
        #endregion
    }
}