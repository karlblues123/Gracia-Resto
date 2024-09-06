<%@ Page Title="Restaurant Management System" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="webTables.aspx.cs" Inherits="WebMenu.webTables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Logs
            $('[id*=guest-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvGuests] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
            <%--<hr />--%>
            <div class="container-fluid my-2">
                <div class="row flex-nowrap my-2">
                    <aside class="col-auto col-md-1 col-xl-1">
                        <ul class="list-group">
                            <li class="list-group-item border-0"> 
                                <button class="btn btn-green-fill">
                                    <p class="d-xxl-inline d-none">Available</p> <span class="fa fa-thumbs-up d-xxl-none d-inline"></span> <asp:Label runat="server" ID="lnkCountAvailable" CssClass="badge bg-red"></asp:Label></button>
                            </li>
                            <li class="list-group-item border-0">
                                <button class="btn btn-yellow-fill">
                                    <p class="d-xxl-inline d-none">Reserve</p> <span class="fa fa-book d-xxl-none d-inline"></span> <asp:Label runat="server" ID="lnkCountReserve" CssClass="badge bg-dark"></asp:Label></button>
                            </li>
                            <li class="list-group-item border-0">
                                <button class="btn btn-secondary">
                                    <p class="d-xxl-inline d-none">Occupied</p> <span class="fa fa-ban d-xxl-none d-inline"></span> <asp:Label runat="server" ID="lnkCountOccupied" CssClass="badge bg-red"></asp:Label></button>
                            </li>
                        </ul>
                    </aside>
                    <main class="col">
                        <asp:UpdatePanel runat="server" ID="upMain" UpdateMode="Always">
                            <ContentTemplate>
                                <div class="row">
                                    <asp:Repeater runat="server" ID="rpt" OnItemCommand="rpt_ItemCommand" OnItemDataBound="rpt_ItemDataBound">

                                            <ItemTemplate>
                                                <div class="col-md-3 col-sm-3">
                                     
                                                    <asp:Panel runat="server" ID="panelAvailable" Visible="false">
                                                        <div class="card">
                                                            <div class="card-header bg-green text-light">
                                                               <div class="row">
                                                                   <div class="col-md-4">
                                                                        <h3>
                                                                       T-<asp:Label runat="server" ID="lblTableNumber" Font-Bold="true" Text='<%# Eval("TableNumber") %>'></asp:Label>
                                                                        </h3>
                                                                    </div>
                                                                   <div class="col-md-6"><span class="fa fa-thumbs-up text-dark"></span> AVAILABLE</div>
                                                                 <%--  <div class="col-md-2 text-end">
                                                                       <asp:LinkButton runat="server" ID="lnkAssigned" CssClass="btn btn-sm btn-outline-light" CommandName="GET"></asp:LinkButton>
                                                                   </div>--%>
                                                                   <%-- Edit Button --%>
                                                                   <div class="col-md-2">
                                                                       <asp:LinkButton runat="server" ID="btnEdit" CssClass="btn btn-sm btn-dark" CommandName="EDIT"><span class="fa fa-edit"></span></asp:LinkButton>
                                                                   </div>
                                                               </div>
                                                         
                                                            </div>
                                                            <div class="card-body">

                                                                <table class="table table-responsive-sm table-responsive-sm small">
                                                                    <tr>
                                                                        <td><span class="fa fa-users"></span>Capacity:  </td>
                                                                        <td>
                                                                    
                                                                           <strong> <asp:Label runat="server" ID="lblTableCapacity"  Text='<%# Eval("Capacity") %>'  onkeypress="return(event.charCode == 8 || event.charCode == 0) ? null: event.charCode >= 46 && event.charCode <=57" MaxLength="2"></asp:Label></strong>
                                                                               </td>
                                                                    
                                                                    </tr>

                                                          
                                                                    <tr>
                                                                        <td>
                                                                            <span class="fa fa-bookmark"></span>Desc: 
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label runat="server" ID="lblTableName" Text='<%# Eval("TableName") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                            
                                                                      <tr>
                                                                        <td><span class="fa fa-location-arrow"></span>Location :</td>
                                                                        <td>
                                                                            <asp:Label runat="server" ID="lblLocation" CssClass="text-wrap" Text='<%# Eval("Location") %>'></asp:Label>
                                                                            </td>


                                                                    </tr>
                                                                        <tr>
                                                                            <td></td>
                                                                            <td>
                                                                                <asp:LinkButton runat="server" CssClass="btn btn-blue-fill btn-sm form-control" ID="lnkAssignTable" CommandName="GET"><span class="fa fa-pencil-square"></span> Assign Table</asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                </table>



                                                                <%--<asp:Label runat="server" ID="lblStatus" Visible="false" Text='<%# Eval("IsOccupied") %>'></asp:Label>--%>
                                                        




                                                            </div>

                                                        </div>
                                                    </asp:Panel>

                                                    <asp:Panel runat="server" ID="panelOccupied" Visible="false">
                                                        <div class="card">
                                                            <div class="card-header bg-secondary text-dark">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <h4>
                                                                            T-  <asp:Label runat="server" ID="lblOccupiedTableNumber" Font-Bold="true" Text='<%# Eval("TableNumber") %>'></asp:Label></td>

                                                                        </h4>
                                                                    </div>
                                                                    <div class="col-md-6"> OCCUPIED</div>
                                                                    <div class="col-md-2 text-end"></div>
                                                                </div>
                                                       
                                                            </div>
                                                            <div class="card-body">
                                                               <table class="table table-responsive-md table-light small">
                                                                   <%-- <tr>
                                                                        <td><span class="fa fa-puzzle-piece"></span>Table #:</td>
                                                                        <td>
                                                                  

                                                                    </tr>--%>
                                                                   <tr>
                                                                       <td><span class="fa fa-user"></span> Customer: </td><td><asp:Label runat="server" ID="lblCustomerName" Text='<%#Eval("FirstName") + " " + Eval("LastName")%>'></asp:Label></td>
                                                                 
                                                                   </tr>
                                                                   <tr>
                                                                    <td>Number of Guest:</td> 
                                                                       <td><asp:Label runat="server" ID="lblGuestNumber" Text=''></asp:Label></td>
                                                            
                                                                   </tr>
                                                                   <tr>
                                                                       <td><span class="fa fa-clock-o"></span> Date|Time</td>
                                                                       <td><asp:Label runat="server" ID="lblTimeOccupied" CssClass="text-wrap" Text='<%# Eval("LastUpdate") %>'></asp:Label></td>
                                                                   </tr>
                                                                   <tr>
                                                                       <td>Notes:</td><td><asp:Label runat="server" ID="lblNotes" CssClass="text-wrap" Text=''></asp:Label></td>
                                                                   </tr>
                                                                   <tr>
                                                                        <tr>
                                                                            <td></td>
                                                                            <td>
                                                                                <asp:LinkButton runat="server" CssClass="btn btn-dark btn-sm form-control" ID="LinkButton1" CommandName="OPEN"><span class="fa fa-folder-open-o"></span> Open Table</asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                   </tr>
                                                               </table>
                                                            </div>
                                                         </div>
                                                    </asp:Panel>

                                                    <asp:Panel runat="server" ID="panelReserved" Visible="false">
                                                        <div class="card">
                                                            <div class="card-header bg-yellow text-light">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <h4>
                                                                            T-  <asp:Label runat="server" ID="lblreserveTableNumber" Font-Bold="true" Text='<%# Eval("TableNumber") %>'></asp:Label></td>

                                                                        </h4>
                                                                    </div>
                                                                    <div class="col-md-6"> RESERVED</div>
                                                                    <div class="col-md-2 text-end"></div>
                                                                </div>
                                                       
                                                            </div>
                                                            <div class="card-body">
                                                               <table class="table table-responsive-md table-light small">
                                                                  <%--  <tr>
                                                                        <td><span class="fa fa-puzzle-piece"></span>Table #:</td>
                                                                        <td>
                                                                  

                                                                    </tr>--%>
                                                                   <tr>
                                                                       <td><span class="fa fa-user"></span> Customer: </td><td><asp:Label runat="server" ID="Label2" Text='<%#Eval("FirstName") + " " + Eval("LastName")%>'></asp:Label></td>
                                                                 
                                                                   </tr>
                                                                   <tr>
                                                                    <td>Number of Guest: </td><td><asp:Label runat="server" ID="Label3" Text=''></asp:Label></td>
                                                          
                                                                   </tr>
                                                                   <tr>
                                                                       <td><span class="fa fa-clock-o"></span> Date|Time</td><td><asp:Label runat="server" ID="Label1" CssClass="text-wrap" Text='<%# Eval("LastUpdate") %>'></asp:Label></td>
                                                                   </tr>
                                                                   <tr>
                                                                       <td>Notes:</td><td><asp:Label runat="server" ID="Label5" CssClass="text-wrap" Text=''></asp:Label></td>
                                                                   </tr>

                                                                     <tr>
                                                                         <td>
                                                                             <asp:LinkButton runat="server" CssClass="btn btn-green-fill btn-sm form-control" ID="lnkConfirmReserved" CommandName="CONFIRM"><span class="fa fa-check-square"></span> Confirm</asp:LinkButton>
                                                                         </td>
                                                                            <td>
                                                                                <asp:LinkButton runat="server" CssClass="btn btn-red-fill  btn-sm form-control" ID="lnkCancelReserved" CommandName="OPEN"><span class="fa fa-times-rectangle"></span> Cancel</asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                               </table>
                                                            </div>
                                                         </div>
                                                    </asp:Panel>

                                                    <asp:Panel runat="server" ID="panelUnavailable" Visible="false">
                                                        <div class="card">
                                                            <div class="card-header bg-red text-dark">
                                                                <div class="row">
                                                                    <div class="col-md-4">
                                                                        <h4>
                                                                            T-  <asp:Label runat="server" ID="lblUnavailableTableNumber" Font-Bold="true" Text='<%# Eval("TableNumber") %>'></asp:Label></td>
                                                                        </h4>
                                                                    </div>
                                                                    <div class="col-md-6"> UNAVAILABLE</div>
                                                                    <div class="col-md-2 text-end">
                                                                        <asp:LinkButton runat="server" ID="btnUnavailableEdit" CssClass="btn btn-sm btn-dark" CommandName="EDIT"><span class="fa fa-edit"></span></asp:LinkButton>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card-body">
                                                                <table class="table table-responsive-sm table-responsive-sm small">
                                                                    <tr>
                                                                        <td><span class="fa fa-users"></span>Capacity:  </td>
                                                                        <td>
                                                                    
                                                                           <strong> <asp:Label runat="server" ID="Label4"  Text='<%# Eval("Capacity") %>'  onkeypress="return(event.charCode == 8 || event.charCode == 0) ? null: event.charCode >= 46 && event.charCode <=57" MaxLength="2"></asp:Label></strong>
                                                                               </td>
                                                                    
                                                                    </tr>

                                                          
                                                                    <tr>
                                                                        <td>
                                                                            <span class="fa fa-bookmark"></span>Desc: 
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label runat="server" ID="Label6" Text='<%# Eval("TableName") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                            
                                                                      <tr>
                                                                        <td><span class="fa fa-location-arrow"></span>Location :</td>
                                                                        <td>
                                                                            <asp:Label runat="server" ID="Label7" CssClass="text-wrap" Text='<%# Eval("Location") %>'></asp:Label>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>

                                                    </asp:Panel>

                                                   <%-- <asp:HiddenField runat="server" ID="hfIsOccupied" Value='<%# Eval("IsOccupied") %>'></asp:HiddenField>
                                                    <asp:HiddenField runat="server" ID="hfIsReserve" Value='<%# Eval("IsReserve") %>'></asp:HiddenField>--%>
                                                     <asp:Label runat="server" ID="lblTableStatusCode" Visible="false" Text='<%# Eval("TableStatusCode") %>' />
                                                    <br />
                                                </div>

                                            </ItemTemplate>

                                        </asp:Repeater>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <button type="button" class="btn btn-green-fill position-fixed bottom-0 end-0 mb-5 mb-xxl-2 me-5" 
                            data-bs-toggle="modal" data-bs-target="#table-modal">New Table</button>
                        <!-- ENTRY TO DINE OR RESERVE -->
                        <div class="modal fade" id="modalCustomerEntry" data-bs-backdrop="static" tabindex="-1" data-bs-keyboard="false">
                            <div class="modal-dialog modal-xl" role="document">
                                <div class="modal-content">
                                    <div class="modal-header bg-green">
                                        <h5 class="modal-title" id="staticBackdropLabel">Restaurant Management System</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!--Display all Suppliers -->
                                        <div class="card">
                                            <div class="card-header">
                                                <h5><span class="fa fa-users"></span> Customer Dine / Reservation Entry</h5>
                                            </div>
                                            <div class="card-body">
                                                <asp:UpdatePanel runat="server" ID="upGuestList" UpdateMode="Conditional" ChildrenAsTriggers="false">
                                                    <ContentTemplate>
                                                        <%-- Table Number Hidden Field --%>
                                                        <asp:HiddenField runat="server" ID="hfTableNumber" />
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
                                                                            <asp:GridView runat="server" ID="gvGuests" CssClass="table table-responsive" DataKeyNames="GuestCode" AutoGenerateColumns="false">
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
                                                                                            <asp:LinkButton runat="server" ID="btnSelect" CssClass="btn btn-green-fill" OnClick="btnSelect_Click">
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
                                                                    <div class="row">
                                                                        <div class="col-6">Table #: <b><asp:Label runat="server" ID="lblTableNumberDisplay"></asp:Label></b></div>
                                                                        <div class="col-6">Table Description: 
                                                                            <asp:Label runat="server" ID="lblSendRoom"> </asp:Label>
                                                                        </div>
                                                                    </div>
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
                                                                    <!-- Guest Number -->
                                                                    <%--<div class="mb-2">
                                                                        <label for="txtNewCustomerAddress" class="form-label">Number of Guest</label>
                                                                        <asp:TextBox runat="server" ID="txtNumberOfGuest" CssClass="form-control"
                                                                            AutoCompleteType="Disabled" TextMode="Number" Text="1" onkeypress="return(event.charCode == 8 || event.charCode == 0) ? null: event.charCode >= 46 && event.charCode <=57" MaxLength="2"></asp:TextBox>
                                                                    </div>--%>
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
                                                                        <label for="txtNotes" class="form-label">Remarks / Notes</label>
                                                                        <asp:TextBox runat="server" ID="txtNotes" CssClass="form-control" TextMode="MultiLine" Rows="2"
                                                                            AutoCompleteType="Disabled"></asp:TextBox>
                                                                    </div>
                                                                    <!-- Notes / Remarks -->
                                                                    <div class="row mb-2">
                                                                        <div class="col-md-2"><asp:RadioButton runat="server" GroupName="ACC" ID="radDine" Checked="true" CssClass="form-check-input" Text="Dine" /></div>
                                                                        <div class="col-md-4"><asp:RadioButton runat="server" GroupName="ACC" ID="radReserve" CssClass="form-check-input" Text= "Reserve"/></div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">      
                                        <div class="justify-content-md-end">
                                            <asp:LinkButton runat="server" ID="lnkNewCustomer" CssClass="btn btn-green-fill" OnClick="lnkNewCustomer_Click">Submit</asp:LinkButton>
                                        </div>            
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- Table Information Modal --%>
                        <div class="modal fade" id="table-modal" tabindex="-1" aria-labelledby="tableModal">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <asp:UpdatePanel runat="server" ID="upTableInformation" ChildrenAsTriggers="false" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <div class="modal-header">
                                                <p class="h6">Table Information</p>
                                                <button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row mb-2">
                                                    <%-- Number --%>
                                                    <div class="col-4">
                                                        Table Number: <asp:Label runat="server" ID="lblSelectedTableNumber"></asp:Label>
                                                    </div>
                                                    <%-- Name --%>
                                                    <div class="col-8">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtTableName" AutoCompleteType="Disabled" 
                                                                CssClass="form-control"></asp:TextBox>
                                                            <label for="<%=this.txtTableName.ClientID%>">Name</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <%-- Capacity --%>
                                                    <div class="col-4">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtCapacity" TextMode="Number" CssClass="form-control" 
                                                                AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=this.txtCapacity.ClientID%>">Capacity</label>
                                                        </div>
                                                    </div>
                                                    <%-- Location --%>
                                                    <div class="col-8">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtLocation" AutoCompleteType="Disabled" 
                                                                CssClass="form-control"></asp:TextBox>
                                                            <label for="<%=this.txtLocation.ClientID%>">Location</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row mb-2">
                                                    <%-- Available --%>
                                                    <div class="col-4">
                                                        <div class="form-check-inline">
                                                            <asp:CheckBox runat="server" ID="cbAvailable" Text="Active?" />
                                                        </div>
                                                    </div>
                                                    <div class="col-8">
                                                        <div class="form-floating">
                                                            <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <label for="<%=this.txtRemarks.ClientID%>">Remarks</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <%-- Save Button --%>
                                            <div class="modal-footer">
                                                <asp:LinkButton runat="server" ID="btnSave" CssClass="btn btn-green-fill" OnClick="btnSave_Click">Save</asp:LinkButton>
                                            </div>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="btnSave" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </div>
                            </div>

                        </div>
                    </main>
                </div>
            </div>
            <%--<div class="card">
                <div class="card-header bg-gradient bg-light text-black-75">
                    <div class="row">
                        <div class="col-md-6">
        
                            <h4 class="navbar-brand"><img src="Content/images/Cafe%20Gracia.png" style="width:75px; height:50px;" />  Table Assignment and Monitoring <span class="fa fa-desktop"></span></h4>
                        </div>
                        <div class="col-md-6 text-end">
                            
                            
                           
                        </div>
                        
                    </div>
                  
                </div>

                <div class="card-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">

                                 <!-- End of Repeater -->


                            </div>
                        </div>





                    </div>


                
                                   

            </div>

            
            </div>--%>

       

        
</asp:Content>
