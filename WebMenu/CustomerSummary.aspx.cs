using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class CustomerSummary : System.Web.UI.Page
    {
        ReportDocument oReportDocument = new ReportDocument();
        cMaster oMaster = new cMaster();
        cTransaction oTransaction = new cTransaction();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["User"] == null)
                Response.Redirect("Login.aspx");
            

            this.DISPLAY_REPORT(Request.QueryString["GuestCode"]);
        }

        private void DISPLAY_REPORT(string guest)
        {
            //Load the report
            this.oReportDocument.Load(Server.MapPath("~/Reports/repCustomerSummary.rpt"));

            //this.oReportDocument.Database.Tables[0].SetDataSource(this.oMaster.GET_CUSTOMER_BY_CODE(guest));

            //this.oReportDocument.Subreports[0].Database.Tables[0].SetDataSource(this.oTransaction.GET_CUSTOMER_RENTALS(guest));
            //this.oReportDocument.Subreports[1].Database.Tables[0].SetDataSource(this.oTransaction.GET_CUSTOMER_RESERVATION(guest));
            //this.oReportDocument.Subreports[2].Database.Tables[0].SetDataSource(this.oTransaction.GET_CUSTOMER_SALES(guest));

            //Display the data
            this.CRV.ReportSource = this.oReportDocument;

        }
    }
}