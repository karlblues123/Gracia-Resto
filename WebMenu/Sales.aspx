<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="Sales.aspx.cs" Inherits="GraciaResto.Sales" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid my-2">
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
                        <li class="nav-item" role="presentation">
                            <button class="nav-link btn-blue" id="report-tab" data-bs-toggle="pill" data-bs-target="#report-pane" type="button" 
                                role="tab" aria-controls="history-pane" aria-selected="false">
                                <span class="fa fa-file"></span><p class="d-none d-xxl-inline"> Report</p>
                            </button>
                        </li>
                    </ul>
                </div>
            </aside>
            <%-- Main Content --%>
            <main class="col tab-content">
                <%-- Form Tab --%>
                <div class="tab-pane fade show active" id="form-pane">
                    <asp:HiddenField runat="server" ID="hiddenSelectedSale" />
                    <div class="row mb-2">
                        <div class="col">
                            <div class="card" style="max-height:28vh;">
                                <div class="card-body">
                                    <div class="row mb-1">
                                        <div class="col-2">
                                            <div class="input-group">
                                                <div class="form-floating">
                                                    <%-- Customer Code --%>
                                                    <asp:TextBox runat="server" ID="txtCustomerCode" CssClass="form-control" 
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                    <label for="<%=txtCustomerCode.ClientID%>">Code</label>
                                                </div>
                                                <button type="button" class="btn btn-green-fill" data-bs-toggle="modal" data-bs-target="#customer-modal"><span class="fa fa-search"></span></button>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- First Name --%>
                                                <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtFirstName.ClientID %>">First Name</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Last Name --%>
                                                <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtLastName.ClientID %>">Last Name</label>
                                            </div>
                                        </div>
                                        <%-- Date --%>
                                        <div class="col-4">
                                            <asp:TextBox runat="server" ID="txtDate" CssClass="form-control h-100" TextMode="Date" AutoCompleteType="Disabled"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="row mb-1">
                                        <%-- Room --%>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtRoom" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtRoom.ClientID %>">Room</label>
                                            </div>
                                        </div>
                                        <%-- Waiter Name --%>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtWaiterName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtWaiterName.ClientID %>">Waiter</label>
                                            </div>
                                        </div>
                                        <%-- Receiver Name --%>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtReceiverName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=txtReceiverName.ClientID %>">Receiver</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <%-- Sales Remarks --%>
                                        <div class="col-8">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="MultiLine"></asp:TextBox>
                                                <label for="<%=txtRemarks.ClientID %>">Remarks</label>
                                            </div>
                                        </div>
                                        <%-- Sales Tips --%>
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtTips" CssClass="form-control" 
                                                    AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                                                <label for="<%=txtTips.ClientID %>">Tips</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="card" style="max-height:57vh;">
                                <div class="card-header">
                                    <div class="row">
                                        <%-- Dish Modal Trigger --%>
                                        <div class="col-1">
                                            <button type="button" id="modal-trigger" class="btn btn-green-fill" data-bs-toggle="modal" data-bs-target="#dish-list-modal"><span class="fa fa-plus"></span></button>
                                        </div>
                                        <%-- Dish Status Dropdown --%>
                                        <div class="col-3 offset-8">
                                            <asp:DropDownList runat="server" ID="ddSaleStatus" CssClass="form-select float-end"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                                <%-- Order GridView --%>
                                <div class="card-body overflow-y-auto">
                                    <asp:GridView runat="server" ID="gvDishLine" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                        OnRowEditing="gvDishLine_RowEditing" OnRowUpdating="gvDishLine_RowUpdating" OnRowDeleting="gvDishLine_RowDeleting" 
                                        OnRowCancelingEdit="gvDishLine_RowCancelingEdit" DataKeyNames="ID, DishCode" ShowFooter="true" 
                                        EmptyDataText="No dish selected." EmptyDataRowStyle-CssClass="text-center" OnRowCreated="gvDishLine_RowCreated">
                                        <Columns>
                                            <%-- Dish Name --%>
                                            <asp:BoundField DataField="Name" ReadOnly="true"  HeaderText="Name"/>
                                            <%-- Dish Price --%>
                                            <asp:BoundField DataField="Price" ReadOnly="true" HeaderText="Price"/>
                                            <%-- Dish Quantity --%>
                                            <asp:TemplateField HeaderText="Quantity">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblQuantity" Text='<%#Eval("Quantity")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtQuantity" Text='<%#Eval("Quantity")%>' 
                                                        TextMode="Number" AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <%-- Dish Discount --%>
                                            <asp:TemplateField HeaderText="Discount">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" ID="lblDiscount" Text='<%#Eval("Discount")%>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" ID="txtDiscount" Text='<%#Eval("Discount") %>' 
                                                        TextMode="Number" AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <%-- Dish Total --%>
                                            <asp:TemplateField HeaderText="Total">
                                                <ItemTemplate>
                                                    <%#Eval("Total","{0:0.00}")%>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:Label runat="server" ID="lblTotalAmount"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <%-- GridView Buttons --%>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="btnEditLine" CommandName="Edit" CssClass="btn btn-green-fill"><span class="fa fa-edit"></span></asp:LinkButton>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <asp:TextBox runat="server" ID="txtLineRemarks" CssClass="form-control" AutoCompleteType="Disabled" placeholder="Remarks"></asp:TextBox>
                                                        </div>
                                                        <div class="col-6">
                                                            <asp:LinkButton runat="server" ID="btnUpdateLine" CommandName="Update" CssClass="btn btn-green-fill"><span class="fa fa-check"></span></asp:LinkButton>
                                                            <asp:LinkButton runat="server" ID="btnDeleteLine" CommandName="Delete" CssClass="btn btn-red-fill"><span class="fa fa-minus"></span></asp:LinkButton>
                                                            <asp:LinkButton runat="server" ID="btnCancelEdit" CommandName="Cancel" CssClass="btn btn-dark"><span class="fa fa-close"></span></asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="card-footer">
                                    <div class="row">
                                        <%-- Amount Tendered --%>
                                        <div class="col-2 offset-6">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtAmountTendered" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Number">0.00</asp:TextBox>
                                                <label for="<%=txtAmountTendered.ClientID %>" class="d-none d-xxl-inline">Amount Tendered</label>
                                            </div>
                                        </div>
                                        <%-- Total Amount --%>
                                        <div class="col-2 d-flex flex-column">
                                            
                                            <asp:Label runat="server" ID="lblChangeAmount" CssClass="card-text">Change: 0.00</asp:Label>
                                        </div>
                                        <%-- Save --%>
                                        <div class="col-2">
                                            <asp:LinkButton runat="server" ID="btnClear" CssClass="btn btn-dark" OnClick="btnClear_Click">
                                                <span class="fa fa-eraser d-xxl-none"></span>
                                                <span class="d-xxl-inline d-none">Clear</span>
                                            </asp:LinkButton>
                                            <asp:LinkButton runat="server" ID="btnSave" CssClass="btn btn-green-fill" OnClick="btnSave_Click">
                                                <span class="fa fa-save d-xxl-none"></span>
                                                <span class="d-xxl-inline d-none">Save</span>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Dish Modal --%>
                    <div class="modal fade" tabindex="-1" id="dish-list-modal" aria-labelledby="DishListModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <input type="text" id="dish-search" class="form-control" placeholder="Search" autocomplete="off"/>
                                </div>
                                <div class="modal-body overflow-y-auto" style="max-height:85vh;">
                                    <%-- Dish GridView --%>
                                    <asp:GridView runat="server" ID="gvDishes" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                        DataKeyNames="DishCode">
                                        <Columns>
                                            <%-- Dish Name --%>
                                            <asp:BoundField DataField="Name" HeaderText="Name" />
                                            <%-- Dish Price --%>
                                            <asp:BoundField DataField="Price" HeaderText="Price" />
                                            <%-- Dish Stock --%>
                                            <asp:BoundField DataField="Stock" HeaderText="Stock" />
                                            <%-- Add Button --%>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton runat="server" ID="btnAddDish" CssClass="btn btn-green" OnClick="btnAddDish_Click">
                                                        <span class="fa fa-plus"></span>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="modal-footer">
                                    <%-- Close Button --%>
                                    <button type="button" class="btn btn-dark" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- Customer modal --%>
                    <div class="modal fade" tabindex="-1" id="customer-modal" aria-labelledby="CustomerModal">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <input type="text" id="customer-search" class="form-control" placeholder="Search" autocomplete="off" /> 
                                </div>
                                <div class="modal-body overflow-y-auto" style="max-height:75vh;">
                                    <asp:GridView runat="server" ID="gvCustomers" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                        DataKeyNames="GuestCode">
                                        <Columns>
                                            <%-- Code --%>
                                            <asp:BoundField DataField="GuestCode" HeaderText="Code" ItemStyle-Width="20%" />
                                            <%-- Name --%>
                                            <asp:TemplateField ItemStyle-Width="20%" HeaderText="Name">
                                                <ItemTemplate>
                                                    <%#Eval("LastName")%>, <%#Eval("FirstName")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- Birthdate --%>
                                            <asp:BoundField DataField="Birthdate" HeaderText="Birthdate" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-Width="20%" />
                                            <%-- Gender --%>
                                            <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-Width="10%" />
                                            <%-- Date Recorded --%>
                                            <asp:BoundField DataField="DI" HeaderText="Date Recorded" ItemStyle-Width="20%" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <%-- Select Button --%>
                                                    <asp:LinkButton runat="server" ID="btnSelectCustomer" CssClass="btn btn-green-fill" OnClick="btnSelectCustomer_Click"><span class="fa fa-check"></span></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-dark float-end" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- History Tab --%>
                <div class="tab-pane fade" id="history-pane">
                    <asp:UpdatePanel runat="server" ID="upHistory" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col">
                                    <div class="card" style="max-height:85vh;">
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col-6">
                                                    <%-- Search Textbox --%>
                                                    <input type="text" id="sales-search" class="form-control" placeholder="Search" autocomplete="off" />
                                                </div>
                                                <div class="col-3 offset-3">
                                                    <%-- Status Filter DropDownList --%>
                                                    <asp:DropDownList runat="server" ID="ddStatusFilter" CssClass="form-select" 
                                                        OnSelectedIndexChanged="ddStatusFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body overflow-y-auto">
                                            <asp:Label runat="server" ID="lblNoSales" CssClass="card-text">No sales found.</asp:Label>
                                            <%-- Sales GridView --%>
                                            <asp:GridView runat="server" ID="gvSales" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                                DataKeyNames="SalesCode">
                                                <Columns>
                                                    <%-- Customer Name --%>
                                                    <asp:TemplateField HeaderText="Customer">
                                                        <ItemTemplate>
                                                            <%#Eval("LastName")%>, <%#Eval("FirstName")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <%-- Date of Sale --%>
                                                    <asp:BoundField DataField="Date" DataFormatString="{0:MM/dd/yyyy}" />
                                                    <%-- Total --%>
                                                    <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:0.00}" />
                                                    <%-- Edit Button --%>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnEditSale" CssClass="btn btn-green-fill" 
                                                                OnClick="btnEditSale_Click"><span class="fa fa-edit"></span></asp:LinkButton>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddStatusFilter" EventName="SelectedIndexChanged" />
                            <asp:PostBackTrigger ControlID="btnSave" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
                <%-- Report Tab --%>
                <div class="tab-pane fade" id="report-pane">
                    <asp:UpdatePanel runat="server" ID="upReport" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="container-fluid my-2">
                                <div class="row">
                                    <div class="col-4">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="row my-2">
                                                    <div class="col">
                                                        <div class="form-floating">
                                                            <%-- Start Date --%>
                                                            <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" TextMode="Date" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=this.txtStartDate.ClientID%>">Start Date</label>
                                                        </div>
                                    
                                                    </div>
                                                </div>
                                                <div class="row my-2">
                                                    <div class="col">
                                                        <div class="form-floating">
                                                            <%-- End Date --%>
                                                            <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" TextMode="Date" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=this.txtEndDate.ClientID%>">End Date</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row my-2">
                                                    <div class="col">
                                                        <%-- Submit --%>
                                                        <asp:LinkButton runat="server" ID="btnReportSubmit" CssClass="btn btn-sm btn-green-fill" OnClick="btnReportSubmit_Click">Submit</asp:LinkButton>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-8">
                                        <div class="card">
                                            <div class="card-header">
                                                <p class="h6">Sales Report</p>
                                            </div>
                                            <div class="card-body">
                                                <%-- Crystal Report --%>
                                                <CR:CrystalReportViewer ID="CRV" runat="server" AutoDataBind="true" 
                                                    PageZoomFactor="75"
                                                    HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="False" DisplayToolbar="True" ToolPanelView="None" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnReportSubmit" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </main>
        </div>
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Items
            $('[id*=dish-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvDishes] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            //Search function for Sales
            $('[id*=sales-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvSales] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            //Search function for Customers
            $('[id*=customer-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvCustomers] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
</asp:Content>
