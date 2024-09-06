using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class KitchenLogs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.DISPLAY_LOGS();
        }

        private void DISPLAY_LOGS()
        {
            this.gvLogs.DataSource = cBase.queryCommandDT_StoredProc("[Kitchen].[spGET_KITCHEN_LOGS]");
            this.gvLogs.DataBind();
        }
    }
}