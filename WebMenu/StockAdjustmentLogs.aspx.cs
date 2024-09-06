using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class StockAdjustmentLogs : System.Web.UI.Page
    {
        private cMenu oMenu = new cMenu();

        protected void Page_Load(object sender, EventArgs e)
        {
            this.DISPLAY_LOGS();
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_LOGS()
        {
            this.gvLogs.DataSource = this.oMenu.GET_STOCK_ADJUSTMENT_LOGS();
            this.gvLogs.DataBind();
        }
        #endregion
    }
}