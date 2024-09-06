using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class UserList : System.Web.UI.Page
    {
        private cSystem oSys = new cSystem();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.DISPLAY_USERS();
            }
        }

        #region LOCAL FUNCTIONS
        private void DISPLAY_USERS()
        {
            this.gvUsers.DataSource = this.oSys.GET_LIST_USERS();
            this.gvUsers.DataBind();
        }

        private void DISPLAY_USER_TYPES(DropDownList type_dropdown, string selected_user)
        {
            type_dropdown.DataTextField = "TypeName";
            type_dropdown.DataValueField = "ID";
            type_dropdown.DataSource = this.oSys.GET_LIST_USER_TYPES();
            type_dropdown.DataBind();
            type_dropdown.SelectedValue = this.oSys.GET_USER(selected_user).Rows[0]["UserType"].ToString();
        }

        private void UPDATE_USER(int index)
        {
            DropDownList type_dropdown = this.gvUsers.Rows[index].FindControl("ddType") as DropDownList;
            CheckBox active_checkbox = this.gvUsers.Rows[index].FindControl("cbActive") as CheckBox;

            int user_id = int.Parse(this.gvUsers.DataKeys[index].Value.ToString());
            int type_id = int.Parse(type_dropdown.SelectedValue);
            bool is_active = active_checkbox.Checked;

            this.oSys.UPDATE_USER(user_id, type_id, is_active);
        }
        #endregion

        #region EVENTS
        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            string selected_user = this.gvUsers.Rows[e.NewEditIndex].Cells[0].Text;

            this.gvUsers.EditIndex = e.NewEditIndex;

            this.DISPLAY_USERS();
            this.DISPLAY_USER_TYPES(this.gvUsers.Rows[e.NewEditIndex].FindControl("ddType") as DropDownList,selected_user);
        }

        protected void gvUsers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.gvUsers.EditIndex = -1;

            this.DISPLAY_USERS();
        }

        protected void gvUsers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            if(this.gvUsers.EditIndex > -1)
            {
                this.UPDATE_USER(e.RowIndex);
                this.gvUsers.EditIndex = -1;

                this.DISPLAY_USERS();
            }
        }
        #endregion


    }
}