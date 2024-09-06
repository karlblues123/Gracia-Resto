<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="Rental.aspx.cs" Inherits="WebMenu.Rental" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid my-2">
        <div class="row flex-nowrap my-2">
            <asp:HiddenField runat="server" ID="hiddenSelectedRental" />
            <aside class="col-auto col-md-1 col-xl-1">
                <div class="d-flex flex-column align-items-center">
                    <%-- Sidebar Navigation --%>
                    <ul class="nav nav-pills flex-column">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link btn-blue active" id="form-tab" data-bs-toggle="pill" data-bs-target="#form-pane" type="button" 
                                role="tab" aria-controls="form-pane" aria-selected="true">
                                <span class="fa fa-edit"></span><p class="d-none d-xxl-inline"> Form</p>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link btn-blue" id="history-tab" data-bs-toggle="pill" data-bs-target="#list-pane" type="button" 
                                role="tab" aria-controls="list-pane" aria-selected="false">
                                <span class="fa fa-book"></span><p class="d-none d-xxl-inline"> History</p> 
                            </button>
                        </li>
                    </ul>
                </div>
            </aside>
            <main class="col tab-content">
                <div class="tab-pane fade show active" id="form-pane">
                    <asp:UpdatePanel runat="server" ID="upForm" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="card my-2">
                                <div class="card-header">
                                    <p class="h6">Representative Information</p>
                                </div>
                                <div class="card-body">
                                    <%-- Rental Code Hiddenfield --%>
                                    <div class="row my-2">
                                        <div class="col-3">
                                            <div class="input-group">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtGuestCode" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                    <label for="<%=this.txtGuestCode%>">Guest Code</label>
                                                </div>
                                                <button type="button" class="btn btn-green-fill" data-bs-toggle="modal" data-bs-target="#customer-modal"><span class="fa fa-search"></span></button>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- First Name --%>
                                                <asp:Textbox runat="server" ID="txtRepFirstName" CssClass="form-control" AutoCompleteType="Disabled"></asp:Textbox>
                                                <label for="<%=this.txtRepFirstName.ClientID%>">First Name</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Last Name --%>
                                                <asp:Textbox runat="server" ID="txtRepLastName" CssClass="form-control" AutoCompleteType="Disabled"></asp:Textbox>
                                                <label for="<%=this.txtRepLastName.ClientID%>">Last Name</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Birthdate --%>
                                                <asp:TextBox runat="server" ID="txtBirthdate" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                <label for="<%=this.txtBirthdate.ClientID%>">Birthdate</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Gender --%>
                                                <asp:RadioButtonList runat="server" ID="rbGender">
                                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <%-- Address --%>
                                                <asp:TextBox runat="server" ID="txtAddress" AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=this.txtAddress.ClientID%>">Address</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Contact Number --%>
                                                <asp:TextBox runat="server" ID="txtContactNumber" AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=this.txtContactNumber.ClientID%>">Contact Number</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Emergency Contact --%>
                                                <asp:TextBox runat="server" ID="txtEmergencyContact" AutoCompleteType="Disabled" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=this.txtEmergencyContact.ClientID%>">Emergency Contact</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- No. of Adults --%>
                                                <asp:TextBox runat="server" ID="txtNumAdults" AutoCompleteType="Disabled" TextMode="Number" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=this.txtNumAdults.ClientID%>">No. of Adults</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- No. of Kids --%>
                                                <asp:TextBox runat="server" ID="txtNumKids" AutoCompleteType="Disabled" TextMode="Number" CssClass="form-control"></asp:TextBox>
                                                <label for="<%=this.txtNumKids.ClientID%>">No. of Kids</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card my-2">
                                <div class="card-header">
                                    <p class="h6">Rentals Information</p>
                                </div>
                                <div class="card-body">
                                    <div class="row my-2">
                                        <div class="col-4">
                                            <div class="form-floating">
                                                <%-- Name of Group --%>
                                                <asp:TextBox runat="server" ID="txtGroupName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtGroupName.Text%>">Name of Group</label>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="form-floating">
                                                <%-- Date --%>
                                                <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                <label for="<%=this.txtStartDate.ClientID%>">Start Date</label>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="form-floating">
                                                <%-- Time --%>
                                                <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" TextMode="Date" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtEndDate%>">End Date</label>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="input-group">
                                                <%-- Rental Dropdown --%>
                                                <asp:DropDownList runat="server" ID="ddRental" CssClass="form-select"></asp:DropDownList>
                                                <asp:LinkButton runat="server" ID="btnAddRental" CssClass="btn btn-green-fill" OnClick="btnAddRental_Click">
                                                    <span class="fa fa-plus"></span>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col">
                                            <%-- Rental GridView --%>
                                            <asp:GridView runat="server" ID="gvRentals" AutoGenerateColumns="false" CssClass="table table-responsive" 
                                                EmptyDataRowStyle-CssClass="text-center" EmptyDataText="No rentals added" OnRowEditing="gvRentals_RowEditing" 
                                                OnRowUpdating="gvRentals_RowUpdating" OnRowDeleting="gvRentals_RowDeleting" OnRowCancelingEdit="gvRentals_RowCancelingEdit" 
                                                ShowFooter="true" OnRowCreated="gvRentals_RowCreated">
                                                <Columns>
                                                    <asp:BoundField DataField="Name" HeaderText="Particulars" ReadOnly="true" ItemStyle-Width="15%" />
                                                    <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="true" ItemStyle-Width="15%" />
                                                    <asp:TemplateField HeaderText="Qty / Hour" ItemStyle-Width="10%">
                                                        <ItemTemplate>
                                                            <%#Eval("Quantity")%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtQuantity" TextMode="Number" AutoCompleteType="Disabled" CssClass="form-control" 
                                                                Text='<%#Eval("Quantity")%>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Discount" ItemStyle-Width="10%">
                                                        <ItemTemplate>
                                                            <%#Eval("Discount")%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtDiscount" TextMode="Number" AutoCompleteType="Disabled" CssClass="form-control" 
                                                                Text='<%#Eval("Discount")%>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Total" ItemStyle-Width="15%">
                                                        <ItemTemplate>
                                                            <%#Eval("Total","{0:N2}")%>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            <asp:Label runat="server" ID="lblTotal"></asp:Label>
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Start Time" ItemStyle-Width="10%">
                                                        <ItemTemplate>
                                                            <%# (DateTime.Parse(Eval("StartTime").ToString()).ToString("HH:mm")) %>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtStartTime" CssClass="form-control" TextMode="Time" AutoCompleteType="Disabled" Text='<%# (DateTime.Parse(Eval("StartTime").ToString()).ToString("HH:mm")) %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="End Time" ItemStyle-Width="10%">
                                                        <ItemTemplate>
                                                            <%# (DateTime.Parse(Eval("EndTime").ToString()).ToString("HH:mm")) %>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtEndTime" CssClass="form-control" TextMode="Time" AutoCompleteType="Disabled" Text='<%# (DateTime.Parse(Eval("EndTime").ToString()).ToString("HH:mm")) %>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField ItemStyle-Width="15%">
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnEditLine" CommandName="Edit" CssClass="btn btn-green-fill"><span class="fa fa-edit"></span></asp:LinkButton>
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
                                    <div class="row">
                                        <div class="col-7">
                                            <div class="form-floating">
                                                <%-- Remarks --%>
                                                <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtRemarks.ClientID%>">Remarks</label>
                                            </div>
                                        </div>
                                        <div class="col-2">
                                            <div class="form-floating">
                                                 <%-- Amount Tendered --%>
                                                <asp:TextBox runat="server" ID="txtTendered" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                                                <label for="<%=this.txtTendered.ClientID%>">Amount Tendered</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="row">
                                        <div class="col-2 offset-10">
                                            <%-- Save Button --%>
                                            <asp:LinkButton runat="server" ID="btnSave" CssClass="btn btn-green-fill float-end ms-2" OnClick="btnSave_Click">
                                                Save
                                            </asp:LinkButton>
                                            <%-- Clear Button --%>
                                            <asp:LinkButton runat="server" ID="btnClear" CssClass="btn btn-dark float-end" OnClick="btnClear_Click">
                                                Clear
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddRental" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvRentals" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvRentals" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvRentals" EventName="RowUpdating" />
                            <asp:AsyncPostBackTrigger ControlID="gvRentals" EventName="RowDeleting" />
                            <asp:PostBackTrigger ControlID="btnSave" />
                            <asp:PostBackTrigger ControlID="btnClear" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <div class="modal fade" tabindex="-1" id="customer-modal" aria-labelledby="CustomerModal">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <input type="text" id="customer-search" class="form-control" placeholder="Search" autocomplete="off" /> 
                                </div>
                                <div class="modal-body overflow-y-auto" style="max-height:75vh;">
                                    <asp:GridView runat="server" ID="gvGuests" CssClass="table table-responsive" AutoGenerateColumns="false" 
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
                                                    <asp:LinkButton runat="server" ID="btnSelectGuest" CssClass="btn btn-green-fill" OnClick="btnSelectGuest_Click"><span class="fa fa-check"></span></asp:LinkButton>
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
                <div class="tab-pane fade" id="list-pane">
                    <asp:UpdatePanel runat="server" ID="upList" ChildrenAsTriggers="false" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col">
                                    <div class="card" style="max-height:85vh;">
                                        <div class="card-header">
                                            <div class="row">
                                                <div class="col-4">
                                                    <input type="text" autocomplete="off" id="search-bar" class="form-control" placeholder="Search" />
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <%-- Start Date Filter --%>
                                                        <asp:TextBox runat="server" ID="txtStartDateFilter" TextMode="Date" CssClass="form-control" 
                                                            AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="txtStartDateFilter_TextChanged"></asp:TextBox>
                                                        <label for="<%=txtStartDateFilter.ClientID%>">Start Date</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <%-- End Date Filter --%>
                                                        <asp:TextBox runat="server" ID="txtEndDateFilter" TextMode="Date" CssClass="form-control" 
                                                            AutoCompleteType="Disabled" AutoPostBack="true" OnTextChanged="txtEndDateFilter_TextChanged"></asp:TextBox>
                                                        <label for="<%=txtEndDateFilter.ClientID%>">End Date</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body overflow-y-auto">
                                            <%-- Reservations GridView --%>
                                            <asp:GridView runat="server" ID="gvListRentals" AutoGenerateColumns="false" DataKeyNames="RentalCode" 
                                                CssClass="table table-responsive" EmptyDataText="No Rentals found." EmptyDataRowStyle-CssClass="text-center" 
                                                OnRowDataBound="gvListRentals_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Representative">
                                                        <ItemTemplate>
                                                            <%#Eval("LastName")%>, <%#Eval("FirstName")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="StartDate" HeaderText="Date" DataFormatString="{0:MM/dd/yyyy}" />
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnViewRental" CssClass="btn btn-green-fill" OnClick="btnViewRental_Click">
                                                                <span class="fa fa-search"></span>
                                                            </asp:LinkButton>
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
                            <asp:AsyncPostBackTrigger ControlID="txtStartDateFilter" EventName="TextChanged" />
                            <asp:AsyncPostBackTrigger ControlID="txtEndDateFilter" EventName="TextChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </main>
        </div>
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Customers
            $('[id*=customer-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvGuests] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
</asp:Content>
