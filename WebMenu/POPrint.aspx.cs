using System;
using CrystalDecisions.CrystalReports.Engine;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace GraciaResto
{
    public partial class POPrint : System.Web.UI.Page
    {
        ReportDocument oReportDocument = new ReportDocument();
        cTransaction oTransaction = new cTransaction();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["User"] == null)
                Response.Redirect("Login.aspx");

            this.DISPLAY_REPORT(Request.QueryString["POCode"]);
        }

        private void DISPLAY_REPORT(string code)
        {
            
            //Load the report
            this.oReportDocument.Load(Server.MapPath("~/Reports/repPurchaseOrder.rpt"));

            this.oReportDocument.Database.Tables[0].SetDataSource(this.oTransaction.GET_PO_HDR(code));
            this.oReportDocument.Database.Tables[1].SetDataSource(this.oTransaction.GET_LIST_PO_ITEMS(code));

            //Display the data
            this.CRV.ReportSource = this.oReportDocument;

        }
    }
}