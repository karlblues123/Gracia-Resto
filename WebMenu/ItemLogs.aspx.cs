using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class ItemLogs : System.Web.UI.Page
    {
        cMenu oMenu = new cMenu();
        protected void Page_Load(object sender, EventArgs e)
        {
            this.DISPLAY_LOGS();
        }

        private void DISPLAY_LOGS()
        {
            this.gvLogs.DataSource = this.oMenu.GET_ITEM_LOGS();
            this.gvLogs.DataBind();
        }
    }
}