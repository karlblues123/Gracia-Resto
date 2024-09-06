using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GraciaResto
{
    public partial class DishData : System.Web.UI.Page
    {
        private cMenu oMenu = new cMenu();
        private cSystem oSys = new cSystem();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Redirect the user if he/she is not logged in
                if (Request.Cookies["User"] == null && int.Parse(Request.Cookies["User"].Values["AccessLevel"].ToString()) != 1)
                    Response.Redirect("Login.aspx");
                else if (this.oSys.GET_USER(Request.Cookies["User"].Values["Username"].ToString()).Rows.Count == 0)
                    Response.Redirect("Login.aspx");

                this.DISPLAY_DISH_DATA_LIST();
                this.DISPLAY_DISH_TYPE();
                this.DISPLAY_ITEMS();

                this.gvRecipe.DataSource = null;
                this.gvRecipe.DataBind();
            }
                
        }

        #region LOCAL FUNCTIONS
        private decimal CALCULAT_TOTAL(DataTable data)
        {
            decimal total = 0.00m;
            foreach (DataRow row in data.Rows)
            {
                total += decimal.Parse(row["Total"].ToString());
            }
            return total;
        }

        private void DISPLAY_DISH_DATA_LIST()
        {
            this.gvDish.DataSource = oMenu.GET_LIST_DISH();
            this.gvDish.DataBind();
        }

        private void DISPLAY_ITEMS()
        {
            this.gvItems.DataSource = oMenu.GET_ITEM_DATA();
            this.gvItems.DataBind();

            foreach (GridViewRow row in this.gvItems.Rows)
            {
                LinkButton btn = row.FindControl("btnAdd") as LinkButton;
                ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(btn);
            }
        }

        private void DISPLAY_DISH_TYPE()
        {
            this.ddSelectedDishType.DataSource = oMenu.GET_DISH_TYPES();
            this.ddSelectedDishType.DataTextField = "Description";
            this.ddSelectedDishType.DataValueField = "ID";
            this.ddSelectedDishType.DataBind();
        }

        private void DISPLAY_SELECTED_DISH(string dish_code)
        {
            //Get the Header data
            DataTable data = oMenu.GET_DISH_HDR(dish_code);

            //Supply the fields with the Header data
            foreach (DataRow row in data.Rows)
            {
                this.txtSelectedDishName.Text = row["Name"].ToString();
                this.txtSelectedDishServing.Text = row["Serving"].ToString();
                this.txtSelectedDishDescription.Text = row["Description"].ToString();
                this.ddSelectedDishType.SelectedValue = row["Type"].ToString();
                this.txtSelectedDishPrice.Text = row["Price"].ToString();
                this.txtSelectedDishStock.Text = row["Stock"].ToString();
                this.iDishImage.ImageUrl = "~/Images/" + row["Name"].ToString().Replace(' ', '-') + ".png";
                this.cbIsActive.Checked = bool.Parse(row["IsActive"].ToString());
            }

            if (!string.IsNullOrWhiteSpace(this.hiddenSelectedDish.Value))
            {
                //Get the list of ingredients of the dish from the database
                data = oMenu.GET_LIST_DISH_ITEMS(dish_code);

                //Add a Total column
                data.Columns.Add("Total", typeof(decimal), "Quantity * Price");

                //Store the data to Session
                Session["Recipe"] = data;
            }

            
            if(Session["Recipe"] != null)
                //Calculate the total
                this.CALCULAT_TOTAL(data);

            //Supply the GridView with the data
            this.gvRecipe.DataSource = Session["Recipe"] as DataTable;
            this.gvRecipe.DataBind();

            //Register the Edit buttons of the GrdiView as AsyncPostBack trigger
            if(this.gvRecipe.EditIndex == -1)
            {
                foreach (GridViewRow row in this.gvRecipe.Rows)
                {
                    LinkButton btn = row.FindControl("btnEditIngredient") as LinkButton;
                    ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(btn);
                }
            }
        }

        private void CLEAR_DISH()
        {
            //Clear the controls
            this.txtSelectedDishName.Text = string.Empty;
            this.txtSelectedDishServing.Text = string.Empty;
            this.txtSelectedDishDescription.Text = string.Empty;
            this.ddSelectedDishType.SelectedValue = "1";
            this.iDishImage.ImageUrl = null;
            this.hiddenSelectedDish.Value = string.Empty;
            this.txtRemarks.CssClass = "form-control";
            this.txtLineRemarks.CssClass = "form-control";

            this.gvRecipe.DataSource = null;
            this.gvRecipe.DataBind();

            Session.Remove("Recipe");
        }

        //private byte[] CONVERT_DISH_PHOTO()
        //{
        //    //Initialize a null byte[]
        //    byte[] photo = null;

        //    //Check whether the user has selected a photo
        //    if (uploadDishImage.HasFile)
        //    {
        //        //Get the file name
        //        string pFilename = Path.GetFileName(uploadDishImage.PostedFile.FileName);
        //        string fileContentType = uploadDishImage.PostedFile.ContentType;

        //        //Get the file and set it to the byte[]
        //        using (Stream s = uploadDishImage.PostedFile.InputStream)
        //        {
        //            using (BinaryReader r = new BinaryReader(s))
        //            {
        //                photo = r.ReadBytes((Int32)s.Length);
        //            }
        //        }
        //    }
        //    return photo;
        //}

        private void UPLOAD_DISH_PHOTO()
        {
            if (this.uploadDishImage.HasFile)
            {
                string fileName = Path.Combine(Server.MapPath("~/Images/" + this.txtSelectedDishName.Text.Replace(' ', '-') + ".png"));

                if (File.Exists(fileName))
                    File.Delete(fileName);

                Bitmap convert = (Bitmap)Bitmap.FromStream(uploadDishImage.PostedFile.InputStream);
                convert.Save(fileName, ImageFormat.Png);
            }
        }

        private bool VALIDATE_DISH_HDR()
        {
            bool is_valid = true;

            if (string.IsNullOrWhiteSpace(this.txtSelectedDishName.Text))
            {
                is_valid = false;
                this.txtSelectedDishName.CssClass += " is-invalid";
            }
            else
                this.txtSelectedDishName.CssClass = "form-control";

            if (string.IsNullOrWhiteSpace(this.txtSelectedDishServing.Text))
            {
                is_valid = false;
                this.txtSelectedDishServing.CssClass += " is-invalid";
            }
            else
                this.txtSelectedDishServing.CssClass = "form-control";

            return is_valid;
        }

        private void INSERT_NEW_DISH_HEADER()
        {
            //Get the data for Insert
            string dish_code = this.oSys.GET_SERIES_NUMBER("DISH");
            string dish_name = this.txtSelectedDishName.Text == string.Empty ? "Unknown" : this.txtSelectedDishName.Text;
            int dish_serving = 0;
            int.TryParse(this.txtSelectedDishServing.Text, out dish_serving);
            int dish_type = 0;
            int.TryParse(this.ddSelectedDishType.SelectedValue, out dish_type);
            string dish_description = this.txtSelectedDishDescription.Text == string.Empty ? string.Empty : this.txtSelectedDishDescription.Text;

            //Insert
            this.oMenu.INSERT_NEW_DISH_HDR(dish_code, dish_name, 0.00m, dish_serving, dish_type, dish_description);
            this.UPLOAD_DISH_PHOTO();

            //Display the new dish data in the controls
            this.DISPLAY_SELECTED_DISH(dish_code);

            //Display a success toast
            Show_Message_Toast("Successfully created " + dish_name + ". Please proceed to adding the ingredients of the dish in the Recipe tab.");
        }

        private void INSERT_DISH_LINE(string ing_code)
        {
            //Get or Create a Dish Line DataTable
            DataTable recipe;
            if (Session["Recipe"] == null)
            {
                recipe = new DataTable();
                recipe.Columns.Add("DishCode", typeof(string));
                recipe.Columns.Add("ItemCode", typeof(string));
                recipe.Columns.Add("Name", typeof(string));
                recipe.Columns.Add("Quantity", typeof(decimal));
                recipe.Columns.Add("Price", typeof(decimal));
                recipe.Columns.Add("UM", typeof(string));
                recipe.Columns.Add("Total", typeof(decimal), "Quantity * Price");

            }
            else
                recipe = Session["Recipe"] as DataTable;

            //Get the Item data from the database
            DataRow ingredient = this.oMenu.GET_SELECTED_ITEM_DATA(ing_code).Rows[0];

            //Insert the Item data to the Session table
            if(ingredient[0] != null)
            {
                DataRow new_ing = recipe.NewRow();

                new_ing["ItemCode"] = ingredient["ItemCode"].ToString();
                new_ing["Name"] = ingredient["Name"].ToString();
                new_ing["Quantity"] = 0.00m;
                new_ing["Price"] = decimal.Parse(ingredient["Price"].ToString());
                new_ing["UM"] = ingredient["UM"].ToString();

                recipe.Rows.Add(new_ing);

                Session["Recipe"] = recipe;
            }
        }

        private void UPDATE_DISH_LINE(int index)
        {
            //Check if there is an existing DataTable
            if (Session["Recipe"] != null)
            {
                //Get the data from Session
                DataTable recipe = Session["Recipe"] as DataTable;

                //Get the user input
                string qty = (this.gvRecipe.Rows[index].FindControl("txtQuantity") as TextBox).Text;

                if (!string.IsNullOrWhiteSpace(qty))
                {
                    //Set the ingredient quantity
                    recipe.Rows[index]["Quantity"] = decimal.Parse(qty);
                }

            }
        }

        private void DELETE_DISH_LINE(int index)
        {
            //Check if there is an existing DataTable
            if (Session["Recipe"] != null)
            {
                //Get the data from Session
                DataTable recipe = Session["Recipe"] as DataTable;

                //Remove the selected row
                recipe.Rows.RemoveAt(index);

                //Finalize the changes
                recipe.AcceptChanges();
            }
        }

        private void UPDATE_DISH_HEADER()
        {
            //Get the data for Update
            string remarks = this.txtRemarks.Text;
            if (!string.IsNullOrWhiteSpace(remarks))
            {
                string dish_code = this.hiddenSelectedDish.Value;
                string dish_name = this.txtSelectedDishName.Text;
                int dish_serving = 0;
                int.TryParse(this.txtSelectedDishServing.Text, out dish_serving);
                int dish_type = 0;
                int.TryParse(this.ddSelectedDishType.SelectedValue, out dish_type);
                string dish_description = this.txtSelectedDishDescription.Text == string.Empty ? string.Empty : this.txtSelectedDishDescription.Text;

                //Update database
                this.oMenu.UPDATE_DISH_HDR(dish_code, dish_name, dish_serving, dish_type, dish_description, cbIsActive.Checked,
                    remarks, Request.Cookies["User"].Values["Username"].ToString());
                this.UPLOAD_DISH_PHOTO();

                //Display the updated Dish header data
                this.DISPLAY_SELECTED_DISH(dish_code);
                this.txtRemarks.CssClass = "form-control";

                //Display a success toast
                Show_Message_Toast("Successfully updated " + dish_name);
            }
            else
            {
                Show_Error_Toast("Error - Empty Remarks. Please provide a reason to update the price");
                this.txtRemarks.CssClass += " is-invalid";
            }
        }

        private void UPDATE_DISH_PRICE()
        {
            //Get the data for Update
            string remarks = this.txtLineRemarks.Text;
            if (!string.IsNullOrWhiteSpace(remarks))
            {
                string dish_code = this.hiddenSelectedDish.Value;
                decimal dish_price = 0.00m;
                decimal.TryParse(this.txtSelectedDishPrice.Text, out dish_price);

                //Update the database
                this.oMenu.UPDATE_DISH_PRICE(dish_code, dish_price, remarks, Request.Cookies["User"].Values["Username"].ToString());

                //Display the updated Dish data
                this.DISPLAY_SELECTED_DISH(dish_code);

                //Display a success toast
                this.Show_Message_Toast("Successfully updated price of " + this.txtSelectedDishName.Text);
            }
            else
            {
                this.Show_Error_Toast("Empty Remarks. Please provide a reason to update the price");
                this.txtLineRemarks.CssClass += " is-invalid";
            }
                
        }

        private void INSERT_STOCK_ADJUSTMENT()
        {
            //Check if both fields are active
            if (!this.txtSelectedDishStock.ReadOnly && !this.txtStockAdjustmentReason.ReadOnly)
            {
                //Check if the user has given input
                if (!string.IsNullOrEmpty(this.txtSelectedDishStock.Text) && !string.IsNullOrEmpty(this.txtStockAdjustmentReason.Text))
                {
                    //Get the data for Upsert
                    string code = this.hiddenSelectedDish.Value;
                    int stock = 0;
                    int.TryParse(this.txtSelectedDishStock.Text, out stock);
                    string reason = this.txtStockAdjustmentReason.Text;

                    //Upsert
                    this.oMenu.UPSERT_DISH_STOCK_ADJUSTMENT(code, stock, reason, Request.Cookies["User"].Values["Username"].ToString());

                    //Display a success toast
                    Show_Message_Toast("Successfully adjusted the stock of " + this.txtSelectedDishName.Text + ".");

                    //Refresh the controls
                    this.txtSelectedDishStock.ReadOnly = true;
                    this.txtStockAdjustmentReason.ReadOnly = true;
                    this.txtStockAdjustmentReason.Text = string.Empty;

                    this.DISPLAY_SELECTED_DISH(this.hiddenSelectedDish.Value);
                }
                //Display an error toast
                else
                {
                    if (string.IsNullOrEmpty(this.txtStockAdjustmentReason.Text))
                        Show_Error_Toast("Empty Remarks. Please provide a reason for stock adjustment.");
                    if (string.IsNullOrEmpty(this.txtSelectedDishStock.Text))
                        Show_Error_Toast("Empty Stock Input. Please provide a stock number.");
                }
            }
        }

        private void UPSERT_DISH_LINES()
        {
            //Check if there is an existing Dish, Dish Line table, and Remarks
            if (Session["Recipe"] != null && !string.IsNullOrWhiteSpace(this.hiddenSelectedDish.Value) 
                && !string.IsNullOrWhiteSpace(this.txtLineRemarks.Text))
            {
                //Get the Dish Line table from Session
                DataTable recipe = Session["Recipe"] as DataTable;

                //Get the Remarks
                string remarks = this.txtLineRemarks.Text;

                //Populate the i
                foreach (DataRow ing in recipe.Rows)
                    ing["DishCode"] = this.hiddenSelectedDish.Value;

                //Remove the unnecessary columns
                recipe.Columns.Remove("Name");
                recipe.Columns.Remove("Total");
                recipe.Columns.Remove("Price");
                recipe.Columns.Remove("UM");

                //Organize the Columns to match the Table type in the database
                recipe.Columns["DishCode"].SetOrdinal(0);
                recipe.Columns["ItemCode"].SetOrdinal(1);
                recipe.Columns["Quantity"].SetOrdinal(2);

                //Upsert
                this.oMenu.UPSERT_DISH_LINE(recipe,remarks, Request.Cookies["User"].Values["Username"].ToString());

                this.Show_Message_Toast("Successfully updated the recipe for " + this.txtSelectedDishName.Text);
            }
            else if(Session["Recipe"] == null)
            {
                this.Show_Error_Toast("Empty Recipe. Please try again.");
            }
            else if(string.IsNullOrWhiteSpace(this.hiddenSelectedDish.Value))
            {
                this.Show_Error_Toast("No Dish selected. Please create or select a dish first.");
            }
            else if (string.IsNullOrWhiteSpace(this.txtLineRemarks.Text))
            {
                this.Show_Error_Toast("Empty Remarks. Please provide a reason to update the recipe.");
            }
            else
            {
                this.Show_Error_Toast("Unexpected Error. Please try again");
            }
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
        protected void btnNewDish_Click(object sender, EventArgs e)
        {
            this.pDishList.Visible = false;
            this.pDishForm.Visible = true;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvItems.DataKeys[r.RowIndex].Value.ToString();

            this.INSERT_DISH_LINE(code);

            this.gvRecipe.DataSource = Session["Recipe"] as DataTable;
            this.gvRecipe.DataBind();
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            this.pDishForm.Visible = false;
            this.pDishList.Visible = true;

            CLEAR_DISH();
            DISPLAY_DISH_DATA_LIST();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (this.VALIDATE_DISH_HDR())
            {
                if (string.IsNullOrEmpty(this.hiddenSelectedDish.Value))
                    this.INSERT_NEW_DISH_HEADER();
                else
                    this.UPDATE_DISH_HEADER();
            }
            else
                Show_Error_Toast("Error - Empty Input. Please fill the highlighted fields and try again.");
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            var selEdit = (Control)sender;
            GridViewRow r = (GridViewRow)selEdit.NamingContainer;
            string code = this.gvDish.DataKeys[r.RowIndex].Value.ToString();

            this.hiddenSelectedDish.Value = code;

            this.DISPLAY_SELECTED_DISH(code);

            this.pDishList.Visible = false;
            this.pDishForm.Visible = true;
        }

        protected void gvRecipe_RowEditing(object sender, GridViewEditEventArgs e)
        {
            this.gvRecipe.EditIndex = e.NewEditIndex;

            this.gvRecipe.DataSource = Session["Recipe"] as DataTable;
            this.gvRecipe.DataBind();

            //if(this.gvRecipe.EditIndex > -1)
            //{
            //    LinkButton btn = this.gvRecipe.Rows[e.NewEditIndex].FindControl("btnUpdateLine") as LinkButton;
            //    ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(btn);

            //    btn = this.gvRecipe.Rows[e.NewEditIndex].FindControl("btnDeleteLine") as LinkButton;
            //    ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(btn);

            //    btn = this.gvRecipe.Rows[e.NewEditIndex].FindControl("btnCancelEdit") as LinkButton;
            //    ScriptManager.GetCurrent(this).RegisterAsyncPostBackControl(btn);
            //}
        }


        protected void gvRecipe_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            this.gvRecipe.EditIndex = -1;

            this.gvRecipe.DataSource = Session["Recipe"] as DataTable;
            this.gvRecipe.DataBind();
        }

        protected void gvRecipe_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            this.UPDATE_DISH_LINE(e.RowIndex);

            this.gvRecipe.EditIndex = -1;

            this.gvRecipe.DataSource = Session["Recipe"] as DataTable;
            this.gvRecipe.DataBind();
        }

        protected void gvRecipe_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            this.DELETE_DISH_LINE(e.RowIndex);

            this.gvRecipe.EditIndex = -1;

            this.gvRecipe.DataSource = Session["Recipe"] as DataTable;
            this.gvRecipe.DataBind();
        }

        protected void btnUpdatePrice_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(this.hiddenSelectedDish.Value))
                this.UPDATE_DISH_PRICE();
            else
                this.Show_Error_Toast("No dish was selected.");
        }

        protected void btnEnableAdjustment_Click(object sender, EventArgs e)
        {
            this.txtSelectedDishStock.ReadOnly = false;
            this.txtStockAdjustmentReason.ReadOnly = false;
            Show_Warning_Toast("Stock Adjustment enabled.");
        }

        protected void btnSaveAdjustment_Click(object sender, EventArgs e)
        {
            this.INSERT_STOCK_ADJUSTMENT();
        }

        protected void btnReport_Click(object sender, EventArgs e)
        {
            string s = "window.open('DishStock.aspx', 'popup_window', 'width=1024, height=768, left=0, top=0, resizable=yes');";
            ScriptManager.RegisterClientScriptBlock(this, this.Page.GetType(), "New Page", s, true);
        }

        protected void gvRecipe_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label total = (Label)e.Row.FindControl("lblRecipeTotal");

                total.Text = this.CALCULAT_TOTAL(Session["Recipe"] as DataTable).ToString("N2");
            }
        }

        protected void btnSaveRecipe_Click(object sender, EventArgs e)
        {
            this.UPSERT_DISH_LINES();

            this.DISPLAY_SELECTED_DISH(this.hiddenSelectedDish.Value);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            this.CLEAR_DISH();
        }
        #endregion


    }
}