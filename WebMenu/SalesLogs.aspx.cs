using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class SalesLogs : System.Web.UI.Page
    {
        cTransaction oTrans = new cTransaction();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.DISPLAY_LOGS();
        }

        private void DISPLAY_LOGS()
        {
            this.gvLogs.DataSource = this.oTrans.GET_SALES_LOGS();
            this.gvLogs.DataBind();
        }
    }
}