<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="DishData.aspx.cs" Inherits="WebMenu.DishData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid my-2">
        <asp:Panel runat="server" ID="pDishList">
            <div class="card" style="max-height:85vh;">
                <div class="card-header">
                    <div class="row">
                        <div class="col-6">
                            <input type="search" class="form-control" id="dish-search" placeholder="Search" autocomplete="off" />
                        </div>
                        <div class="col-1 offset-5">
                            <asp:LinkButton runat="server" ID="btnReport" CssClass="btn btn-blue-fill float-end" OnClick="btnReport_Click">
                                <span class="fa fa-file"></span>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="card-body overflow-y-auto">
                    <%-- Dish GridView --%>
                    <asp:GridView runat="server" ID="gvDish" CssClass="table table-responsive table-responsive-md" AutoGenerateColumns="false" 
                        DataKeyNames="DishCode">
                        <Columns>
                            <%-- Dish Name --%>
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <%-- Dish Price --%>
                            <asp:BoundField DataField="Price" HeaderText="Price" />
                            <%-- Dish Stock --%>
                            <asp:TemplateField HeaderText="Stock">
                                <ItemTemplate>
                                    <p class="card-text <%#(int)Eval("Stock") <= 5 ? "btn-red" : string.Empty %>"><%#Eval("Stock").ToString()%></p>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- Edit Button --%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" ID="btnEdit" OnClick="btnEdit_Click" CssClass="btn btn-green-fill"><span class="fa fa-edit"></span></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
            <%-- New Dish Button --%>
            <asp:LinkButton runat="server" ID="btnNewDish" CssClass="btn btn-green-fill position-fixed bottom-0 end-0 mb-5 mb-xxl-2 me-5" 
                OnClick="btnNewDish_Click">New Dish <span class="fa fa-plus-circle"></span></asp:LinkButton>
        </asp:Panel>
        <%-- Dish Form Panel --%>
        <asp:Panel runat="server" ID="pDishForm" Visible="false" CssClass="row flex-nowrap my-2">
            <%-- Selected Dish HiddenField --%>
            <asp:HiddenField runat="server" ID="hiddenSelectedDish" />
            <%-- Sidebar --%>
            <aside class="col-auto col-md-1 col-xl-1">
                <div class="d-flex flex-column align-items-center">
                    <%-- Back Button --%>
                    <asp:LinkButton runat="server" ID="lnkBack" CssClass="btn" OnClick="lnkBack_Click"><span class="fa fa-arrow-left"/></asp:LinkButton>
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item" role="presentation">
                            <%-- Details Nav Pill --%>
                            <button class="nav-link btn-blue active" id="details-tab" data-bs-toggle="pill" data-bs-target="#details-pane" type="button" 
                                role="tab" aria-controls="details-pane" aria-selected="true">
                                <span class="fa fa-info-circle"></span><p class="d-none d-xxl-inline"> Details</p>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <%-- Recipe Nav Pill --%>
                            <button class="nav-link btn-blue" id="recipe-tab" data-bs-toggle="pill" data-bs-target="#recipe-pane" type="button" 
                                role="tab" aria-controls="recipe-pane" aria-selected="false">
                                <span class="fa fa-list"></span><p class="d-none d-xxl-inline"> Recipe</p> 
                            </button>
                        </li>
                    </ul>
                </div>
            </aside>
            <%-- Main Content --%>
            <main class="col tab-content">
                <%-- Details Pane --%>
                <div class="tab-pane fade show active" id="details-pane">
                    <%-- Details Row --%>
                    <div class="row mb-3">
                        <div class="col-3">
                            <div class="card border-0" style="max-height:40vh;">
                                <%-- Dish Image Control --%>
                                <asp:Image runat="server" ID="iDishImage" CssClass="img-thumbnail" />
                                <div class="card-body">
                                    <%-- Dish Image Upload --%>
                                    <asp:FileUpload runat="server" ID="uploadDishImage" CssClass="form-control" accept="image/*" />
                                </div>
                            </div>
                        </div>
                        <div class="col-9">
                            <div class="card" style="max-height:40vh;">
                                <div class="card-body">
                                    <div class="row my-2">
                                        <div class="col">
                                            <div class="form-floating">
                                                <%-- Selected Dish Name --%>
                                                <asp:TextBox runat="server" ID="txtSelectedDishName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtSelectedDishName.ClientID%>">Name</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <%-- Dish Serving Textbox --%>
                                                <asp:TextBox runat="server" ID="txtSelectedDishServing" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                                                <label for="<%=txtSelectedDishServing.ClientID%>">Serving</label>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <%-- Dish Type Dropdown --%>
                                            <asp:DropDownList runat="server" ID="ddSelectedDishType" CssClass="form-select h-100"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <%-- Dish Description Textbox --%>
                                                <asp:TextBox runat="server" ID="txtSelectedDishDescription" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="MultiLine"></asp:TextBox>
                                                <label for="<%=txtSelectedDishDescription.ClientID %>">Description</label>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <%-- Remarks Textbox --%>
                                                <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtRemarks.ClientID %>">Remarks</label>
                                            </div>
                                        </div>
                                        <div class="col-2 d-flex">
                                            <div class="form-check align-self-center">
                                                <%-- Is Active CheckBox --%>
                                                <asp:CheckBox runat="server" ID="cbIsActive" />
                                                <label for="<%=cbIsActive.ClientID %>" class="form-check-label">Active</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="row">
                                        <div class="col-2 offset-10">
                                            <%-- Clear Button --%>
                                            <asp:LinkButton runat="server" ID="btnClear" CssClass="btn btn-dark" OnClick="btnClear_Click">
                                                Clear
                                            </asp:LinkButton>
                                             <%-- Save Button --%>
                                            <asp:LinkButton runat="server" ID="btnSave" CssClass="btn btn-green-fill" 
                                                OnClick="btnSave_Click">Save</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Stock Adjustment Row --%>
                    <div class="row">
                        <div class="col-9 offset-3">
                            <div class="card" style="max-height:30vh">
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-3 d-flex justify-content-evenly">
                                            <h5 class="my-1">Stock Adjustment</h5>
                                            <%-- Enable Adjustment Button --%>
                                            <asp:LinkButton runat="server" ID="btnEnableAdjustment" CssClass="btn btn-yellow btn-sm" 
                                                OnClick="btnEnableAdjustment_Click"><span class="fa fa-edit"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Dish Stock Textbox --%>
                                                <asp:TextBox runat="server" ID="txtSelectedDishStock" CssClass="form-control" TextMode="Number" 
                                                    AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                <label for="<%=txtSelectedDishStock.ClientID %>">Stock</label>
                                            </div>
                                        </div>
                                        <div class="col-9">
                                            <div class="form-floating">
                                                <%-- Adjustment Reason Textbox --%>
                                                <asp:TextBox runat="server" ID="txtStockAdjustmentReason" CssClass="form-control" TextMode="MultiLine" 
                                                    AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                <label for="<%=txtStockAdjustmentReason.ClientID %>">Reason</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <%-- Save Adjustment Button --%>
                                    <asp:LinkButton runat="server" ID="btnSaveAdjustment" CssClass="btn btn-green-fill float-end" 
                                        OnClick="btnSaveAdjustment_Click">
                                        <span class="fa fa-check-circle"></span>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- Recipe Pane --%>
                <div class="tab-pane fade" id="recipe-pane">
                    <asp:UpdatePanel runat="server" ID="upRecipe" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-4">
                                    <div class="card" style="max-height:85vh;">
                                        <div class="card-header">
                                            <%-- Item Search Textbox --%>
                                            <input type="text" id="item-search" class="form-control" placeholder="Search" autocomplete="off" />
                                        </div>
                                        <div class="card-body overflow-y-auto">
                                            <asp:GridView runat="server" ID="gvItems" AutoGenerateColumns="false" CssClass="table table-responsive" 
                                                DataKeyNames="ItemCode">
                                                <Columns>
                                                    <%-- Item Name --%>
                                                    <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="true" />
                                                    <%-- Item Price --%>
                                                    <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="true" />
                                                    <%-- Item Unit of Measure --%>
                                                    <asp:BoundField DataField="UM" />
                                                    <asp:TemplateField>
                                                        <%-- Add Button --%>
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnAdd" CssClass="btn btn-green" OnClick="btnAdd_Click">
                                                                <span class="fa fa-plus"></span></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                                <%-- Dish Recipe --%>
                                <div class="col-8">
                                    <div class="card" style="max-height:85vh;">
                                        <div class="card-body overflow-y-auto">
                                            <div class="row my-2">
                                                <div class="col">
                                                    <asp:GridView runat="server" ID="gvRecipe" AutoGenerateColumns="false" CssClass="table table-responsive table-responsive-md" 
                                                        DataKeyNames="ItemCode" OnRowEditing="gvRecipe_RowEditing" OnRowCancelingEdit="gvRecipe_RowCancelingEdit" 
                                                        OnRowUpdating="gvRecipe_RowUpdating" OnRowDeleting="gvRecipe_RowDeleting" OnRowCreated="gvRecipe_RowCreated" 
                                                        ShowFooter="true" EmptyDataText="No ingredient selected." EmptyDataRowStyle-CssClass="text-center">
                                                        <Columns>
                                                            <%-- Item Name --%>
                                                            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="true" />
                                                            <%-- Item Price --%>
                                                            <asp:TemplateField HeaderText="Price">
                                                                <ItemTemplate>
                                                                    <%#Eval("Price")%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <asp:Label runat="server" ID="lblRecipeTotal"></asp:Label>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <%-- Item UM --%>
                                                            <asp:BoundField DataField="UM" ReadOnly="true" />
                                                            <%-- Item Quantity --%>
                                                            <asp:TemplateField HeaderText="Quantity">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblQuantity" Text='<%#Eval("Quantity")%>'></asp:Label>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox runat="server" ID="txtQuantity" CssClass="form-control" Text='<%#Eval("Quantity")%>' TextMode="Number" AutoCompleteType="Disabled"></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <%-- Item Total --%>
                                                            <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="true" />
                                                            <%-- GridView Buttons --%>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <%-- Edit Button --%>
                                                                    <asp:LinkButton runat="server" ID="btnEditIngredient" CommandName="Edit" CssClass="btn btn-green-fill"><span class="fa fa-edit"></span></asp:LinkButton>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:LinkButton runat="server" ID="btnUpdateLine" CommandName="Update" CssClass="btn btn-green-fill"><span class="fa fa-check"></span></asp:LinkButton>
                                                                    <asp:LinkButton runat="server" ID="btnDeleteLine" CommandName="Delete" CssClass="btn btn-red-fill"><span class="fa fa-minus"></span></asp:LinkButton>
                                                                    <asp:LinkButton runat="server" ID="btnCancelEdit" CommandName="Cancel" CssClass="btn btn-dark"><span class="fa fa-close"></span></asp:LinkButton>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row my-2">
                                                <div class="col-6">
                                                    <div class="form-floating">
                                                        <%-- Dish Line Remarks --%>
                                                        <asp:TextBox runat="server" ID="txtLineRemarks" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                        <label for="<%=this.txtLineRemarks.ClientID%>">Remarks</label>
                                                    </div>
                                                </div>
                                                <%-- Dish Price Textbox --%>
                                                <div class="col-3">
                                                    <div class="input-group">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtSelectedDishPrice" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=txtSelectedDishPrice.ClientID %>">Price</label>
                                                        </div>
                                                        <%-- Update Price Button --%>
                                                        <asp:LinkButton runat="server" ID="btnUpdatePrice" CssClass="btn btn-green-fill" 
                                                            OnClick="btnUpdatePrice_Click"><span class="fa fa-save"></span></asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <div class="row">
                                                <div class="col-1 offset-11">
                                                    <%-- Save Recipe Button --%>
                                                    <asp:LinkButton runat="server" ID="btnSaveRecipe" CssClass="btn btn-green-fill" OnClick="btnSaveRecipe_Click">
                                                        <span class="fa fa-save"></span>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="gvRecipe" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvRecipe" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvRecipe" EventName="RowUpdating" />
                            <asp:AsyncPostBackTrigger ControlID="gvRecipe" EventName="RowDeleting" />
                            <asp:AsyncPostBackTrigger ControlID="gvRecipe" EventName="RowCreated" />
                            <asp:AsyncPostBackTrigger ControlID="btnUpdatePrice" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div> 
            </main>
        </asp:Panel>  
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Items
            $('[id*=item-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvItems] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            //Search function for Dishes
            $('[id*=dish-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvDish] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
</asp:Content>
