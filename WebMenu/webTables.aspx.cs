using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace GraciaResto
{
    public partial class webTables : System.Web.UI.Page
    {
        //cSys oSys = new cSys();
        cMaster oMaster = new cMaster();
        cSystem oSys = new cSystem();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //Redirect the user if he/she is not logged in
                if (Request.Cookies["User"] == null)
                    Response.Redirect("Login.aspx");
                else if (this.oSys.GET_USER(Request.Cookies["User"].Values["Username"].ToString()).Rows.Count == 0)
                    Response.Redirect("Login.aspx");

                LoadRepeaterData();
            }
        }

        private void LoadRepeaterData()
        {
            DataTable dt = oMaster.GET_TABLE_LISTS();
            rpt.DataSource = dt;
            rpt.DataBind();

            DataView dvCountAvailble = dt.DefaultView;
            dvCountAvailble.RowFilter = "TableStatusCode = 'A'";
            lnkCountAvailable.Text = dvCountAvailble.Count.ToString();

            DataView dvCountReserve = dt.DefaultView;
            dvCountReserve.RowFilter = "TableStatusCode = 'R'";
            lnkCountReserve.Text = dvCountReserve.Count.ToString();

            DataView dvCountOccupied = dt.DefaultView;
            dvCountOccupied.RowFilter = "TableStatusCode = 'O'";
            lnkCountOccupied.Text = dvCountOccupied.Count.ToString();
        }

        protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //foreach (RepeaterItem item in rpt.Items)
            //{
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                   
                    {

                    var linkbtn = e.Item.FindControl("lnkTakeTable") as LinkButton;
                    var tableStatusCode = e.Item.FindControl("lblTableStatusCode") as Label;

                    var panelAvailable = e.Item.FindControl("panelAvailable") as Panel;
                    var panelOccupied = e.Item.FindControl("panelOccupied") as Panel;
                    var panelReserve = e.Item.FindControl("panelReserved") as Panel;
                    var panelUnavailable = e.Item.FindControl("panelUnavailable") as Panel;

                    var lblTableNumber = e.Item.FindControl("lblTableNumber") as Label;

                    int _tblNumber = Convert.ToInt32(lblTableNumber.Text);

                    //Occupied Controls
                    var lblCustomerName = e.Item.FindControl("lblCustomerName") as Label;


           
                    switch (tableStatusCode.Text)
                    {
                            case "A":
                                    panelAvailable.Visible = true;
                                    panelOccupied.Visible = false;
                                    panelReserve.Visible = false;
                                    panelUnavailable.Visible = false;
                            break;

                            case "R":
                                    panelReserve.Visible = true;
                                    panelOccupied.Visible = false;
                                    panelAvailable.Visible = false;
                                    panelUnavailable.Visible = false;
                            break;

                            case "O":
                                    panelOccupied.Visible = true;
                                    panelAvailable.Visible = false;
                                    panelReserve.Visible = false;
                                    panelUnavailable.Visible = false;
                            break;

                            case "U":
                                    panelUnavailable.Visible = true;
                                    panelAvailable.Visible = false;
                                    panelReserve.Visible = false;
                                    panelOccupied.Visible = false;
                            break;
                    }

                
            }
        }

        protected void rpt_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GET")
            {
                var lblTableName = (e.Item.FindControl("lblTableName") as Label);
                ViewState["V_TABLENAME"] = lblTableName.Text;

                var tblNumber = (e.Item.FindControl("lblTableNumber") as Label);


                lblSendRoom.Text = lblTableName.Text;
                lblTableNumberDisplay.Text = tblNumber.Text;

                hfTableNumber.Value = tblNumber.Text;

                this.upGuestList.Update();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "<script>$('#modalCustomerEntry').modal('show');</script>", false);

            }

            if (e.CommandName == "OPEN")
            {
                var tblOccupiedNumber = (e.Item.FindControl("lblOccupiedTableNumber") as Label);

                oMaster.UPDATE_OPEN_TABLE(Convert.ToInt32(tblOccupiedNumber.Text), Request.Cookies["User"].Values["Username"].ToString());

                //Refresh table list here
                //DataTable dt = oMaster.GET_TABLE_LISTS();

                //rpt.DataSource = dt;
                //rpt.DataBind();
                LoadRepeaterData();

                //Display the Toast and hide the modal
                ScriptManager.RegisterStartupScript(this, this.Page.GetType(), "Success", "showToastSuccess('Table is now Available.');", true);


            }

            if (e.CommandName == "CONFIRM")
            {
                var lblreserveTableNumber = (e.Item.FindControl("lblreserveTableNumber") as Label);

                oMaster.UPDATE_RESERVE_TO_DINE(Convert.ToInt32(lblreserveTableNumber.Text), Request.Cookies["User"].Values["Username"].ToString());

                //Refresh table list here
                //DataTable dt = oMaster.GET_TABLE_LISTS();
                //rpt.DataSource = dt;
                //rpt.DataBind();

                LoadRepeaterData();

                //Display the Toast and hide the modal
                ScriptManager.RegisterStartupScript(this, this.Page.GetType(), "Success", "showToastSuccess('Table successfully occupied.');", true);

            }

            if(e.CommandName == "EDIT")
            {
                //Get the data
                var lblTableName = (e.Item.FindControl("lblTableName") as Label);
                var lblTableCapacity = (e.Item.FindControl("lblTableCapacity") as Label);
                var lblLocation = (e.Item.FindControl("lblLocation") as Label);
                var lblTableNumber = (e.Item.FindControl("lblTableNumber") as Label);
                var lblTableStatusCode = (e.Item.FindControl("lblTableStatusCode") as Label);

                //Display the data
                this.txtTableName.Text = lblTableName.Text;
                this.txtCapacity.Text = lblTableCapacity.Text;
                this.txtLocation.Text = lblLocation.Text;
                this.lblSelectedTableNumber.Text = lblTableNumber.Text;
                if (string.Equals(lblTableStatusCode.Text, "A"))
                    this.cbAvailable.Checked = true;

                //Refresh the UpdatePanel
                this.upTableInformation.Update();

                //Display the modal
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "<script>$('#table-modal').modal('show');</script>", false);
            }
        }

        #region "Local Functions"

       

        private bool VALIDATE_TABLE_FORM()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtTableName.Text))
                is_valid = false;
            if (string.IsNullOrWhiteSpace(this.txtCapacity.Text))
                is_valid = false;

            return is_valid;
        }

        private void CLEAR_TABLE_FORM()
        {
            this.lblSelectedTableNumber.Text = string.Empty;
            this.txtTableName.Text = string.Empty;
            this.txtCapacity.Text = string.Empty;
            this.txtLocation.Text = string.Empty;
            this.cbAvailable.Checked = false;
            this.txtRemarks.Text = string.Empty;   
        }

        private void UPDATE_TABLE_INFORMATION()
        {
            //Parse the input
            int num = 0;
            int.TryParse(this.lblSelectedTableNumber.Text, out num);
            int capacity = 0;
            int.TryParse(this.txtCapacity.Text, out capacity);
            string remarks = this.txtRemarks.Text;

            if (capacity > 0 && !string.IsNullOrWhiteSpace(remarks))
            {
                //Update
                this.oMaster.UPDATE_TABLE_INFORMATION(num, this.txtTableName.Text, capacity, this.txtLocation.Text,
                    this.cbAvailable.Checked, remarks, Request.Cookies["User"].Values["Username"].ToString());

                LoadRepeaterData();

                //Display success message
                this.Show_Message_Toast("Successfully Updated Table " + num.ToString());

                this.CLEAR_TABLE_FORM();
            }
            else if (string.IsNullOrWhiteSpace(remarks))
                this.Show_Error_Toast("Empty Remarks. Please provide a reason to update this table.");
            else
                this.Show_Error_Toast("Empty Capacity");
        }

        private void INSERT_TABLE()
        {
            int capacity = 0;
            int.TryParse(this.txtCapacity.Text, out capacity);

            int table_id = this.oMaster.GET_TABLE_LISTS().Rows.Count + 1;

            Random rng = new Random();
            int table_code = 0;
            while(table_code == 0)
            {
                table_code = rng.Next(0, 999999);
                if (this.oMaster.GET_TABLE_BY_CODE(table_code.ToString()).Rows.Count > 0)
                    table_code = 0;
            }

            if (capacity > 0)
                this.oMaster.INSERT_TABLE(table_id,this.txtTableName.Text, capacity, this.txtLocation.Text, table_code.ToString(),
                    Request.Cookies["User"].Values["Username"].ToString());
            else
                this.Show_Error_Toast("Empty Capacity");

            this.CLEAR_TABLE_FORM();

            LoadRepeaterData();
        }

        private void Show_Message_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Success", "<script>showToastSuccess('" + msg + "');</script>", false);
        }

        private void Show_Error_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Error", "<script>showToastError('" + msg + "');</script>", false);
        }

        private void Show_Warning_Toast(string msg)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Warning", "<script>showToastWarning('" + msg + "');</script>", false);
        }
        #endregion


        #region EVENTS
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_TABLE_FORM())
            {
                if (string.IsNullOrWhiteSpace(this.lblSelectedTableNumber.Text))
                {
                    this.INSERT_TABLE();
                }
                else
                    this.UPDATE_TABLE_INFORMATION();
            }
            else
                this.Show_Error_Toast("Empty Input. Please try again.");
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            this.CLEAR_TABLE_FORM();
            this.upTableInformation.Update();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", "<script>$('#table-modal').modal('show');</script>", false);
        }

        protected void lnkSubmit_Click(object sender, EventArgs e)
        {
            bool _flgTableStatus;
            if (radDine.Checked)
            { _flgTableStatus = true; }
            else
            { _flgTableStatus = false; }

            this.oMaster.UPDATE_TABLE_STATUS(this.txtCustomer.Text, this.txtNotes.Text, Convert.ToInt32(hfTableNumber.Value), _flgTableStatus, Request.Cookies["User"].Values["Username"].ToString());



            //Refresh table list here
            //DataTable dt = oMaster.GET_TABLE_LISTS();
            //rpt.DataSource = dt;
            //rpt.DataBind();

            LoadRepeaterData();

            //Clear input
            this.txtCustomer.Text = string.Empty;
            txtNotes.Text = string.Empty;
            //txtNumberOfGuest.Text = "1";

            //Display the Toast and hide the modal
            ScriptManager.RegisterStartupScript(this, this.Page.GetType(), "Success", "$('#modalCustomerEntry').hide();$('.modal-backdrop').remove();$('body').removeClass('modal-open');$('body').css('overflow-y', 'auto');showToastSuccess('" + lblSendRoom.Text + " statsus change to occupied.');", true);
        }
        #endregion

    }
}
