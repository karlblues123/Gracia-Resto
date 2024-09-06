using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class Employee : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        #region EVENTS
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Cookies["User"].Expires = DateTime.Now.AddDays(-1);
            Response.Redirect("Login.aspx");
        }
        #endregion
    }
}