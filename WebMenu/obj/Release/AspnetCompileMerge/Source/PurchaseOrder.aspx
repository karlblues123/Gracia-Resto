<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="PurchaseOrder.aspx.cs" Inherits="WebMenu.PurchaseOrder" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row flex-nowrap my-2">
            <%-- Sidebar Navigation --%>
            <aside class="col-auto col-md-1 col-xl-1">
                <div class="d-flex flex-column align-items-center">
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link btn-blue active" id="details-tab" data-bs-toggle="pill" data-bs-target="#form-pane" type="button" 
                                role="tab" aria-controls="form-pane" aria-selected="true">
                                <span class="fa fa-edit"></span><p class="d-none d-xxl-inline"> Form</p>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link btn-blue" id="recipe-tab" data-bs-toggle="pill" data-bs-target="#history-pane" type="button" 
                                role="tab" aria-controls="history-pane" aria-selected="false">
                                <span class="fa fa-archive"></span><p class="d-none d-xxl-inline"> History</p> 
                            </button>
                        </li>
                    </ul>
                </div>
            </aside>
            <main class="col tab-content">
                <asp:HiddenField runat="server" ID="hiddenSelectedPO" />
                <%-- Form Pane --%>
                <div class="tab-pane fade show active" id="form-pane">
                    <div class="row mb-2">
                        <div class="col">
                            <div class="card" style="max-height:20vh;">
                                <div class="card-body">
                                    <div class="row mb-1">
                                        <%-- In Charge --%>
                                        <div class="col-8">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtInCharge" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtInCharge.ClientID %>">In Charge</label>
                                            </div>
                                        </div>
                                        <%-- Date --%>
                                        <div class="col-4">
                                            <asp:TextBox runat="server" ID="txtDate" CssClass="form-control h-100" TextMode="Date" AutoCompleteType="Disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row mb-1">
                                        <div class="col-4">
                                            <%-- Created by --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtCreatedBy" CssClass="form-control" AutoCompleteType="Disabled" Enabled="false"></asp:TextBox>
                                                <label for="<%=txtCreatedBy.ClientID%>">Created By</label>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <%-- Receiver --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtReceiver" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtReceiver.ClientID%>">Received By</label>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <%-- Remarks --%>
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtRemarks.ClientID%>">Remarks</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="card" style="max-height:65vh;">
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-2">
                                            <%-- Ingredient Modal Trigger --%>
                                            <button type="button" id="item-modal-trigger" class="btn btn-green-fill" 
                                                data-bs-toggle="modal" data-bs-target="#item-list-modal"><span class="fa fa-plus"></span></button>
                                            <%-- Menu Modal Trigger --%>
                                            <button type="button" id="menu-modal-trigger" class="btn btn-green-fill" 
                                                data-bs-toggle="modal" data-bs-target="#menu-modal"><span class="fa fa-book"></span></button>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body overflow-y-auto">
                                    <%-- Ingredient List --%>
                                    <asp:GridView runat="server" ID="gvIngredientList" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                        DataKeyNames="ItemCode" OnRowEditing="gvIngredientList_RowEditing" OnRowUpdating="gvIngredientList_RowUpdating" 
                                        OnRowDeleting="gvIngredientList_RowDeleting" OnRowCancelingEdit="gvIngredientList_RowCancelingEdit" 
                                        ShowFooter="true" OnRowCreated="gvIngredientList_RowCreated" EmptyDataText="No item listed." EmptyDataRowStyle-CssClass="text-center">
                                        <Columns>
                                            <%-- Item Name --%>
                                            <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="true" ItemStyle-Width="15%"/>
                                            <%-- Item Price --%>
                                            <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="true" ItemStyle-Width="10%"/>
                                            <%-- Item UM --%>
                                            <asp:BoundField DataField="UM" ReadOnly="true" ItemStyle-Width="10%" />
                                            <%-- Item Quantity --%>
                                            <asp:TemplateField HeaderText="Quantity" ItemStyle-Width="15%">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblItemQuantity" Text='<%#Eval("Quantity")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtItemQuantity" CssClass="form-control" 
                                                        AutoCompleteType="Disabled" TextMode="Number" Text='<%#Eval("Quantity")%>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <%-- Recevied Quantity --%>
                                            <asp:TemplateField HeaderText="Received" ItemStyle-Width="15%">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblReceivedQuantity" Text='<%#Eval("ReceivedQuantity")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtReceivedQuantity" Text='<%#Eval("ReceivedQuantity")%>' 
                                                        AutoCompleteType="Disabled" TextMode="Number" CssClass="form-control"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <%-- Total --%>
                                            <asp:TemplateField ItemStyle-Width="10%" HeaderText="Total">
                                                <ItemTemplate>
                                                    <%#Eval("Total","{0:0.00}")%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblTotal"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%-- GridView Buttons --%>
                                            <asp:TemplateField ItemStyle-Width="25%">
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="btnEdit" CommandName="Edit" CssClass="btn btn-green-fill">
                                                        <span class="fa fa-edit"></span>
                                                    </asp:LinkButton>
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
                                <div class="card-footer">
                                    <div class="row">
                                        <%-- Amount Tendered --%>
                                        <div class="col-3 offset-7">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtCashGiven" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Number">0.00</asp:TextBox>
                                                <label for="<%=txtCashGiven.ClientID %>">Cash Given</label>
                                            </div>
                                        </div>
                                         <%-- Save --%>
                                        <div class="col-2">
                                            <asp:LinkButton runat="server" ID="btnSave" CssClass="btn btn-green-fill" OnClick="btnSave_Click"><span class="fa fa-save"></span></asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="btnClear" CssClass="btn btn-dark" OnClick="btnClear_Click"><span class="fa fa-eraser"></span></asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="btnPrint" CssClass="btn btn-blue-fill"><span class="fa fa-print"></span></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Item List Modal --%>
                    <div class="modal fade" tabindex="-1" id="item-list-modal" aria-labelledby="IngredientListModal">
                        <div class="modal-dialog">
                            <div class="modal-content" style="max-height:85vh;">
                                <div class="modal-header">
                                    <%-- Ingredient Search Textbox --%>
                                    <input type="text" id="ing-search" class="form-control" placeholder="Search ingredient" autocomplete="off"/>
                                </div>
                                <div class="modal-body overflow-y-auto" style="max-height:85vh;">
                                    <%-- Ingredients GridView --%>
                                    <asp:GridView runat="server" ID="gvIngredients" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                        DataKeyNames="ItemCode">
                                        <Columns>
                                            <%-- Item Name --%>
                                            <asp:BoundField DataField="Name" HeaderText="Name" />
                                            <%-- Item Price --%>
                                            <asp:BoundField DataField="Price" HeaderText="Price" />
                                            <%-- Item UM --%>
                                            <asp:BoundField DataField="UM" HeaderText="Unit of Measure" />
                                            <%-- Add Item Button --%>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="btnAddItem" CssClass="btn btn-green" OnClick="btnAddItem_Click">
                                                        <span class="fa fa-plus"></span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="modal-footer">
                                    <%-- Modal Close --%>
                                    <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Menu Modal --%>
                    <div class="modal fade" id="menu-modal" tabindex="-1" aria-labelledby="MenuLookupModal">
                        <div class="modal-dialog modal-xl">
                            <div class="modal-content" style="max-height:85vh;">
                                <div class="modal-header">
                                    <h6>Menu</h6>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <asp:UpdatePanel runat="server" ID="upMenu" ChildrenAsTriggers="false" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-4">
                                                        <div class="card" style="height:70vh;">
                                                            <div class="card-body overflow-y-auto">
                                                                <asp:GridView runat="server" ID="gvDish" CssClass="table table-responsive-sm" AutoGenerateColumns="false" 
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
                                                                        <%-- View Recipe --%>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton runat="server" ID="btnViewRecipe" OnClick="btnViewRecipe_Click" CssClass="btn btn-blue">
                                                                                    <span class="fa fa-search"></span>
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </div>
                                                        
                                                    </div>
                                                    <div class="col-8">
                                                        <div class="card" style="height:100%;">
                                                            <div class="card-header">
                                                                <asp:Label runat="server" ID="lblSelectedDish">No Dish has been selected</asp:Label>
                                                            </div>
                                                            <div class="card-body overflow-y-auto">
                                                                <asp:GridView runat="server" ID="gvRecipe" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                                                    DataKeyNames="ItemCode">
                                                                    <Columns>
                                                                        <%-- Item Name --%>
                                                                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="true" />
                                                                        <%-- Item Price --%>
                                                                        <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="true" />
                                                                        <%-- Item UM --%>
                                                                        <asp:BoundField DataField="UM" ReadOnly="true" />
                                                                        <%-- Item Quantity --%>
                                                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                                                                        <%-- Item Total --%>
                                                                        <asp:BoundField DataField="Total" HeaderText="Total" ReadOnly="true" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- History Pane --%>
                <div class="tab-pane fade" id="history-pane">
                    <div class="row">
                        <div class="col">
                            <div class="card" style="max-height:85vh;">
                                <div class="card-header">
                                    <div class="row">
                                        <div class="col-6">
                                            <input type="text" id="po-search" class="form-control" placeholder="Search" />
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body overflow-y-auto">
                                    <%-- PO GridView --%>
                                    <asp:GridView runat="server" ID="gvPO" CssClass="table table-responsive" 
                                        AutoGenerateColumns="false" DataKeyNames="POCode">
                                        <Columns>
                                            <%-- PO Code --%>
                                            <asp:BoundField DataField="POCode" HeaderText="Code" />
                                            <%-- PO Date --%>
                                            <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}" />
                                            <%-- Edit Button --%>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="btnEditPO" CssClass="btn btn-green-fill" OnClick="btnEditPO_Click">
                                                        <span class="fa fa-edit"></span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Ingredients
            $('[id*=ing-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvIngredients] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            //Search function for PO
            $('[id*=po-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvPO] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
</asp:Content>
