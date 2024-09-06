using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;

namespace WebMenu
{
    public partial class webTestPrint : System.Web.UI.Page
    {
        ReportDocument oReportDocument = new ReportDocument();

        protected void Page_Load(object sender, EventArgs e)
        {
            oReportDocument.Load(Server.MapPath("~/Reports/crTest.rpt"));
            CRV.ReportSource = oReportDocument;
        }
    }
}