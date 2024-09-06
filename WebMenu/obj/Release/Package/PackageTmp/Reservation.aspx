<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="Reservation.aspx.cs" Inherits="WebMenu.Reservation" %>
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
                            <button class="nav-link btn-blue" id="recipe-tab" data-bs-toggle="pill" data-bs-target="#list-pane" type="button" 
                                role="tab" aria-controls="list-pane" aria-selected="false">
                                <span class="fa fa-book"></span><p class="d-none d-xxl-inline"> Reservations</p> 
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
                                    <div class="row">
                                        <div class="col">
                                            <p class="h6">Guest Information</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="row my-2">
                                        <div class="col">
                                            <asp:HiddenField runat="server" ID="hiddenSelectedReservation" />
                                            <label class="card-subtitle small mb-2 text-muted">Guests <button type="button" class="btn btn-sm btn-green-fill" data-bs-toggle="modal" data-bs-target="#guest-modal"><span class="fa fa-plus-circle"></span></button></label>
                                            <%-- Guests --%>
                                            <asp:GridView runat="server" ID="gvGuests" CssClass="table table-responsive" EmptyDataText="No guests recorded." 
                                                AutoGenerateColumns="false" EmptyDataRowStyle-CssClass="text-center" OnRowDeleting="gvGuests_RowDeleting" 
                                                OnRowEditing="gvGuests_RowEditing" OnRowCancelingEdit="gvGuests_RowCancelingEdit" OnRowUpdating="gvGuests_RowUpdating">
                                                <Columns>
                                                    <asp:BoundField DataField="GuestCode" HeaderText="Code" ReadOnly="true" />
                                                    <asp:TemplateField HeaderText="First Name">
                                                        <ItemTemplate>
                                                            <%#Eval("FirstName")%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtGuestListFirstName" CssClass="form-control" AutoCompleteType="Disabled" Text='<%#Eval("FirstName")%>'>
                                                            </asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Last Name">
                                                        <ItemTemplate>
                                                            <%#Eval("LastName")%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtGuestListLastName" CssClass="form-control" AutoCompleteType="Disabled" Text='<%#Eval("LastName")%>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Birthdate">
                                                        <ItemTemplate>
                                                            <%#Eval("Birthdate","{0:MM/dd/yyyy}")%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:TextBox runat="server" ID="txtGuestBirthdate" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Date" Text='<%#Eval("Birthdate","{0:yyyy-MM-dd}")%>'></asp:TextBox>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Gender">
                                                        <ItemTemplate>
                                                            <%#Eval("Gender")%>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:RadioButtonList runat="server" ID="rblGuestGender" SelectedValue='<%#Eval("Gender")%>'>
                                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnEdit" CssClass="btn btn-yellow-fill" CommandName="Edit">
                                                                <span class="fa fa-edit"></span>
                                                            </asp:LinkButton>
                                                            <asp:LinkButton runat="server" ID="btnDelete" CssClass="btn btn-red-fill" CommandName="Delete">
                                                                <span class="fa fa-minus"></span>
                                                            </asp:LinkButton>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnUpdate" CssClass="btn btn-green-fill" CommandName="Update">
                                                                <span class="fa fa-check"></span>
                                                            </asp:LinkButton>
                                                            <asp:LinkButton runat="server" ID="btnCancel" CssClass="btn btn-yellow-fill" CommandName="Cancel">
                                                                <span class="fa fa-close"></span>
                                                            </asp:LinkButton>
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col">
                                            <div class="form-floating">
                                                <%-- Address --%>
                                                <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtAddress.ClientID%>">Address</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <%-- Mobile Number --%>
                                                <asp:TextBox runat="server" ID="txtMobile" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtMobile.ClientID%>">Mobile Number</label>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <%-- Landline --%>
                                                <asp:TextBox runat="server" ID="txtLandline" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtLandline.ClientID%>">Landline</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <%-- Email --%>
                                                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtEmail.ClientID%>">Email</label>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="form-floating">
                                                <%-- Nationality --%>
                                                <asp:TextBox runat="server" ID="txtNationality" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtNationality.ClientID%>">Nationality</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- No. of Adults --%>
                                                <asp:TextBox runat="server" ID="txtNumberAdults" CssClass="form-control" AutoCompleteType="Disabled" 
                                                    TextMode="Number"></asp:TextBox>
                                                <label for="<%=this.txtNumberAdults.ClientID%>">No. of Adults</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- No. of Kids --%>
                                                <asp:TextBox runat="server" ID="txtNumberKids" CssClass="form-control" AutoCompleteType="Disabled" 
                                                    TextMode="Number"></asp:TextBox>
                                                <label for="<%=this.txtNumberKids.ClientID%>">No. of Kids</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Car Number --%>
                                                <asp:TextBox runat="server" ID="txtCarNumber" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtCarNumber.ClientID%>">Car Number</label>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-floating">
                                                <%-- Car Number 2 --%>
                                                <asp:TextBox runat="server" ID="txtCarNumber2" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtCarNumber2.ClientID%>">Car Number</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card my-2">
                                <div class="card-header">
                                    <h6>Accomodation Information</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-8">
                                            <%--<div class="row my-2">
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        
                                                        <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" TextMode="Date" AutoCompleteType="Disabled" 
                                                            OnTextChanged="txtStartDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                        <label for="<%=this.txtStartDate.ClientID%>">Start date</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        
                                                        <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" TextMode="Date" AutoCompleteType="Disabled" 
                                                            OnTextChanged="txtEndDate_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                        <label for="<%=this.txtEndDate.ClientID%>">End date</label>
                                                    </div>
                                                </div>
                                                <div class="col-2">
                                                    <div class="form-floating">
                                                        
                                                        <asp:TextBox runat="server" ID="txtNumberDays" CssClass="form-control" TextMode="Number" 
                                                            AutoCompleteType="Disabled" ReadOnly="true">1</asp:TextBox>
                                                        <label for="<%=this.txtNumberDays.ClientID%>">No. of Nights</label>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <div class="row my-2">
                                                <div class="col">
                                                    <%-- Rooms --%>
                                                    <asp:GridView runat="server" ID="gvReservation" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                                        EmptyDataText="No rooms selected." EmptyDataRowStyle-CssClass="text-center" OnRowCreated="gvReservation_RowCreated" 
                                                        ShowFooter="true" OnRowDeleting="gvReservation_RowDeleting" OnRowEditing="gvReservation_RowEditing" 
                                                        OnRowUpdating="gvReservation_RowUpdating" OnRowCancelingEdit="gvReservation_RowCancelingEdit">
                                                        <Columns>
                                                            <asp:BoundField DataField="Room" HeaderText="Room" ReadOnly="true" />
                                                            <asp:BoundField DataField="Rate" HeaderText="Rate" DataFormatString="{0:N2}" ReadOnly="true" />
                                                            <asp:TemplateField HeaderText="Discount">
                                                                <ItemTemplate>
                                                                    <%#Eval("Discount","{0:N2}")%>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox runat="server" ID="txtDiscount" CssClass="form-control" TextMode="Number" Text='<%#Eval("Discount","{0:N2}")%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Occupancy">
                                                                <ItemTemplate>
                                                                    <%#Eval("Occupancy")%>
                                                                </ItemTemplate>
                                                                <FooterTemplate>
                                                                    <asp:Label runat="server" ID="lblTotalOccupancy"></asp:Label>
                                                                </FooterTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Start Date">
                                                                <ItemTemplate>
                                                                    <%#Eval("StartDate","{0:MM/dd/yyyy}")%>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox runat="server" ID="txtStartDate" CssClass="form-control" TextMode="Date" Text='<%#Eval("StartDate","{0:yyyy-MM-dd}")%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="End Date">
                                                                <ItemTemplate>
                                                                    <%#Eval("EndDate","{0:MM/dd/yyyy}")%>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox runat="server" ID="txtEndDate" CssClass="form-control" TextMode="Date" Text='<%#Eval("EndDate","{0:yyyy-MM-dd}")%>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton runat="server" ID="btnEdit" CommandName="Edit" CssClass="btn btn-green-fill"><span class="fa fa-edit"></span></asp:LinkButton>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:LinkButton runat="server" ID="btnUpdate" CommandName="Update" CssClass="btn btn-green-fill"><span class="fa fa-check"></span></asp:LinkButton>
                                                                    <asp:LinkButton runat="server" ID="btnDelete" CommandName="Delete" CssClass="btn btn-red-fill"><span class="fa fa-minus"></span></asp:LinkButton>
                                                                    <asp:LinkButton runat="server" ID="btnCancel" CommandName="Cancel" CssClass="btn btn-dark"><span class="fa fa-close"></span></asp:LinkButton>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                            <div class="row my-2">
                                                <div class="col-4">
                                                    <%-- Total Amount --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtTotalAmount" AutoCompleteType="Disabled" ReadOnly="true" 
                                                            TextMode="Number" CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtTotalAmount.ClientID%>">Room Total</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Amount Tendered --%>
                                                    <div class="form-floating">
                                                        <asp:TextBox runat="server" ID="txtAmountTendered" AutoCompleteType="Disabled" TextMode="Number" 
                                                            CssClass="form-control"></asp:TextBox>
                                                        <label for="<%=txtAmountTendered.ClientID%>">Amount Tendered</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <asp:DropDownList runat="server" ID="ddStatus" CssClass="form-select" Enabled="false"></asp:DropDownList>
                                                        <label for="<%=ddStatus.ClientID%>">Status</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-4 d-flex flex-column align-items-center my-2">
                                            <div class="input-group">
                                                <%-- Room Select --%>
                                                <asp:DropDownList runat="server" ID="ddRoom" CssClass="form-select" AutoPostBack="true"></asp:DropDownList>
                                                <%-- Select Button --%>
                                                <asp:LinkButton runat="server" ID="btnAddRoom" CssClass="btn btn-green-fill" OnClick="btnAddRoom_Click">
                                                    <span class="fa fa-plus"></span>
                                                </asp:LinkButton>
                                            </div>
                                            <%-- Calendar --%>
                                            <asp:Calendar runat="server" ID="calReservation" ShowGridLines="true" CssClass="table table-responsive-sm my-2" 
                                                OnDayRender="calReservation_DayRender" NextPrevFormat="ShortMonth" SelectionMode="None">
                                                <NextPrevStyle ForeColor="White" BackColor="#0a91ea" />
                                                <TitleStyle BorderColor="Transparent" BackColor="Transparent" />
                                            </asp:Calendar>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card my-2">
                                <div class="card-header">
                                    <h6>Other Information</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row my-2">
                                        <div class="col">
                                            <div class="form-floating">
                                                <%-- Request --%>
                                                <asp:TextBox runat="server" ID="txtRequest" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtRequest.ClientID%>">Special Request</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col">
                                            <div class="form-floating">
                                                <%-- Dietary Restrictions --%>
                                                <asp:TextBox runat="server" ID="txtDietaryRestrictions" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtDietaryRestrictions.ClientID%>">Dietary Restrictions</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row my-2">
                                        <div class="col">
                                            <div class="form-floating">
                                                <%-- Purpose of Visit --%>
                                                <asp:TextBox runat="server" ID="txtPurpose" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtPurpose.ClientID%>">Purpose of Visit</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="row">
                                        <div class="col-4 offset-6">
                                            <div class="form-floating">
                                                <%-- Remarks --%>
                                                <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtRemarks.ClientID%>">Remarks</label>
                                            </div>
                                        </div>
                                        <div class="col-2">
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
                            <asp:PostBackTrigger ControlID="btnSave" />
                            <asp:PostBackTrigger ControlID="btnClear" />
                            <asp:AsyncPostBackTrigger ControlID="btnAddRoom" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvReservation" EventName="RowDeleting" />
                            <asp:AsyncPostBackTrigger ControlID="gvReservation" EventName="RowCreated" />
                            <asp:AsyncPostBackTrigger ControlID="gvGuests" EventName="RowDeleting" />
                            <asp:AsyncPostBackTrigger ControlID="gvGuests" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvGuests" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvGuests" EventName="RowUpdating" />
                        </Triggers>
                    </asp:UpdatePanel>
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
                                                    <div class="form-floating">
                                                        <%-- Start Date Filter --%>
                                                        <asp:TextBox runat="server" ID="txtStartDateFilter" TextMode="Date" CssClass="form-control" 
                                                            AutoCompleteType="Disabled" OnTextChanged="txtStartDateFilter_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                        <label for="<%=txtStartDateFilter.ClientID%>">Start Date</label>
                                                    </div>
                                            
                                                </div>
                                                <div class="col-4">
                                                    <div class="form-floating">
                                                        <%-- End Date Filter --%>
                                                        <asp:TextBox runat="server" ID="txtEndDateFilter" TextMode="Date" CssClass="form-control" 
                                                            AutoCompleteType="Disabled" OnTextChanged="txtEndDateFilter_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                        <label for="<%=txtEndDateFilter.ClientID%>">End Date</label>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <%-- Room Filter --%>
                                                    <asp:DropDownList runat="server" ID="ddRoomFilter" CssClass="form-select" 
                                                        OnSelectedIndexChanged="ddRoomFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body overflow-y-auto">
                                            <%-- Reservations GridView --%>
                                            <asp:GridView runat="server" ID="gvListReservations" AutoGenerateColumns="false" DataKeyNames="ReservationCode" 
                                                CssClass="table table-responsive" OnRowDataBound="gvListReservations_RowDataBound">
                                                <Columns>
                                                    <asp:BoundField DataField="Room" HeaderText="Room" ItemStyle-Width="20%"/>
                                                    <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-Width="20%" />
                                                    <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-Width="20%" />
                                                    <asp:TemplateField HeaderText="Guest" ItemStyle-Width="15%">
                                                        <ItemTemplate>
                                                            <%#Eval("LastName")%>, <%#Eval("FirstName")%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="Description" HeaderText="Status" ItemStyle-Width="20%" />
                                                    <asp:TemplateField ItemStyle-Width="5%">
                                                        <ItemTemplate>
                                                            <asp:LinkButton runat="server" ID="btnEditReservation" CssClass="btn btn-green-fill" OnClick="btnEditReservation_Click">
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
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="txtStartDateFilter" EventName="TextChanged" />
                            <asp:AsyncPostBackTrigger ControlID="txtEndDateFilter" EventName="TextChanged" />
                            <asp:AsyncPostBackTrigger ControlID="ddRoomFilter" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                    
                </div>
            </main>
        </div>
    </div>
    <div class="modal fade" id="guest-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="h6">Guest Information</p>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel runat="server" ID="upGuestList" UpdateMode="Conditional" ChildrenAsTriggers="false">
                        <ContentTemplate>
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-6">
                                        <div class="card" style="height:40vh;">
                                            <div class="card-header">
                                                <div class="row">
                                                    <input type="text" id="guest-search" class="form-control" 
                                                        placeholder="Search" />
                                                </div>
                                            </div>
                                            <div class="card-body overflow-y-auto">
                                                <%-- Recorded Guest List --%>
                                                <asp:GridView runat="server" ID="gvGuestList" CssClass="table table-responsive" DataKeyNames="GuestCode" AutoGenerateColumns="false">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Name" ItemStyle-Width="20%">
                                                            <ItemTemplate>
                                                                <%#Eval("FirstName")%> <%#Eval("LastName")%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Birthdate" HeaderText="Birthdate" 
                                                            DataFormatString="{0:MM/dd/yyyy}" ItemStyle-Width="20%" />
                                                        <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-Width="15%" />
                                                        <asp:BoundField DataField="DI" HeaderText="Date Recorded" ItemStyle-Width="20%" />
                                                        <asp:TemplateField ItemStyle-Width="5%">
                                                            <ItemTemplate>
                                                                <asp:LinkButton runat="server" ID="btnSelectGuest" CssClass="btn btn-green-fill" OnClick="btnSelectGuest_Click">
                                                                    <span class="fa fa-edit"></span>
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <div class="row mb-2">
                                            <%-- Guest Code --%>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtGuestCode" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                    <label for="<%=this.txtGuestCode.ClientID%>">Guest Code</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mb-2">
                                            <%-- First Name --%>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                    <label for="<%=this.txtFirstName.ClientID%>" class="form-label">First Name</label>
                                                </div>
                                            </div>
                                            <%-- Last Name --%>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"
                                                        AutoCompleteType="Disabled"></asp:TextBox>
                                                    <label for="<%=this.txtLastName%>" class="form-label">Last Name</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mb-2">
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <%-- Birthdate --%>
                                                    <asp:TextBox runat="server" ID="txtBirthdate" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Date"></asp:TextBox>
                                                    <label for="<%=this.txtBirthdate.ClientID%>">Birthdate</label>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="form-floating">
                                                    <%-- Gender --%>
                                                    <asp:RadioButtonList runat="server" ID="rblGender">
                                                        <asp:ListItem Value="M">Male</asp:ListItem>
                                                        <asp:ListItem Value="F">Female</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Notes / Remarks -->
                                        <div class="row mb-2">
                                            <div class="form-floating">
                                                <asp:TextBox runat="server" ID="txtNotes" CssClass="form-control" TextMode="MultiLine" Rows="2"
                                                    AutoCompleteType="Disabled"></asp:TextBox>
                                                <label for="<%=this.txtNotes.ClientID%>">Remarks / Notes</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton runat="server" ID="btnRecordGuest" CssClass="btn btn-green-fill" OnClick="btnRecordGuest_Click">
                        Record
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Customers
            $('[id*=guest-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvGuestList] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
</asp:Content>
