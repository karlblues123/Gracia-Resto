using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class TableLogs : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            this.DISPLAY_AUDIT_LOGS();

            this.DISPLAY_INFO_LOGS();
        }

        private void DISPLAY_AUDIT_LOGS()
        {
            this.gvAuditLogs.DataSource = cBase.queryCommandDT_StoredProc("[Master].[spGET_TABLE_LOGS]");
            this.gvAuditLogs.DataBind();
        }

        private void DISPLAY_INFO_LOGS()
        {
            this.gvInfoLogs.DataSource = cBase.queryCommandDT_StoredProc("[Master].[spGET_TABLE_INFO_LOGS]");
            this.gvInfoLogs.DataBind();
        }
    }
}