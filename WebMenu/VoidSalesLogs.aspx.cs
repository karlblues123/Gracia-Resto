using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class VoidSalesLogs : System.Web.UI.Page
    {
        private cTransaction oTrans = new cTransaction();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.DISPLAY_LOGS();
        }

        private void DISPLAY_LOGS()
        {
            this.gvLogs.DataSource = oTrans.GET_LIST_VOID_SALES();
            this.gvLogs.DataBind();
        }
    }
}