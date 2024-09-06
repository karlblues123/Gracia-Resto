<%@ Page Title="Restaurant Management System" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="webTables.aspx.cs" Inherits="WebMenu.webTables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

        <script type="text/javascript">
                function showToastSuccess(msg,contentMessage) {
                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "progressBar": true,
                        "preventDuplicates": false,
                        "positionClass": "toast-top-right",
                        "showDuration": "400",
                        "hideDuration": "1000",
                        "timeOut": "3000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }
                    // toastr["success"](contentMessage);
                    toastr.success(msg,contentMessage)
                }

                function showToastError(msg,contentMessage) {
                    toastr.options = {
                        "closeButton": true,
                        "debug": false,
                        "progressBar": true,
                        "preventDuplicates": false,
                        "positionClass": "toast-top-right",
                        "showDuration": "400",
                        "hideDuration": "1000",
                        "timeOut": "3000",
                        "extendedTimeOut": "1000",
                        "showEasing": "swing",
                        "hideEasing": "linear",
                        "showMethod": "fadeIn",
                        "hideMethod": "fadeOut"
                    }
                    //toastr["error"]("Required Product Needed!");
                    toastr.error(msg,contentMessage)
                }

            </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <asp:UpdatePanel runat="server" ID="upMain" UpdateMode="Always">
        <ContentTemplate>

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
                                                               <td><span class="fa fa-user"></span> Customer: </td><td><asp:Label runat="server" ID="lblCustomerName" Text='<%# Eval("CustomerName") %>'></asp:Label></td>
                                                                 
                                                           </tr>
                                                           <tr>
                                                            <td>Number of Guest:</td> 
                                                               <td><asp:Label runat="server" ID="lblGuestNumber" Text='<%# Eval("NumberOfGuest") %>'></asp:Label></td>
                                                            
                                                           </tr>
                                                           <tr>
                                                               <td><span class="fa fa-clock-o"></span> Date|Time</td>
                                                               <td><asp:Label runat="server" ID="lblTimeOccupied" CssClass="text-wrap" Text='<%# Eval("LastUpdate") %>'></asp:Label></td>
                                                           </tr>
                                                           <tr>
                                                               <td>Notes:</td><td><asp:Label runat="server" ID="lblNotes" CssClass="text-wrap" Text='<%# Eval("Remarks") %>'></asp:Label></td>
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
                                                               <td><span class="fa fa-user"></span> Customer: </td><td><asp:Label runat="server" ID="Label2" Text='<%# Eval("CustomerName") %>'></asp:Label></td>
                                                                 
                                                           </tr>
                                                           <tr>
                                                            <td>Number of Guest: </td><td><asp:Label runat="server" ID="Label3" Text='<%# Eval("NumberOfGuest") %>'></asp:Label></td>
                                                          
                                                           </tr>
                                                           <tr>
                                                               <td><span class="fa fa-clock-o"></span> Date|Time</td><td><asp:Label runat="server" ID="Label1" CssClass="text-wrap" Text='<%# Eval("LastUpdate") %>'></asp:Label></td>
                                                           </tr>
                                                           <tr>
                                                               <td>Notes:</td><td><asp:Label runat="server" ID="Label5" CssClass="text-wrap" Text='<%# Eval("Remarks") %>'></asp:Label></td>
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



                                           <%-- <asp:HiddenField runat="server" ID="hfIsOccupied" Value='<%# Eval("IsOccupied") %>'></asp:HiddenField>
                                            <asp:HiddenField runat="server" ID="hfIsReserve" Value='<%# Eval("IsReserve") %>'></asp:HiddenField>--%>
                                             <asp:Label runat="server" ID="lblTableStatusCode" Visible="false" Text='<%# Eval("TableStatusCode") %>' />
                                            <br />
                                        </div>

                                    </ItemTemplate>

                                </asp:Repeater>
                        </div>
                        
                        <!-- ENTRY TO DINE OR RESERVE -->
                                <div class="modal fade" id="modalCustomerEntry" data-bs-backdrop="static" tabindex="-1" data-bs-keyboard="false">
                                    <div class="modal-dialog" role="document">
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
                                                    <div class="card-body small">
                                                        <div class="row">
                                                            <div class="col">Table #: <b><asp:Label runat="server" ID="lblTableNumberDisplay"></asp:Label></b></div>
                                                            <div class="col-6">Table Description: 
                                                                <asp:Label runat="server" ID="lblSendRoom"> </asp:Label>
                                                            </div>

                                                        </div>
                                                        
                                                        <div class="mb-2">
                                                            <label for="txtNewCustomerName" class="form-label">Customer / Guest Name</label>
                                                            <asp:TextBox runat="server" ID="txtNewCustomerName" CssClass="form-control"
                                                                AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                        <!-- Guest Number -->
                                                        <div class="mb-2">
                                                            <label for="txtNewCustomerAddress" class="form-label">Number of Guest</label>
                                                            <asp:TextBox runat="server" ID="txtNumberOfGuest" CssClass="form-control"
                                                                AutoCompleteType="Disabled" TextMode="Number" Text="1" onkeypress="return(event.charCode == 8 || event.charCode == 0) ? null: event.charCode >= 46 && event.charCode <=57" MaxLength="2"></asp:TextBox>
                                                        </div>

                                                        <!-- Notes / Remarks -->
                                                        <div class="mb-2">
                                                            <label for="txtNotes" class="form-label">Remarks / Notes</label>
                                                            <asp:TextBox runat="server" ID="txtNotes" CssClass="form-control" TextMode="MultiLine" Rows="2"
                                                                AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                       <!-- Notes / Remarks -->
                                                        <div class="mb-2">
                                                            <div class="row">
                                                                <div class="col-md-2"><asp:RadioButton runat="server" GroupName="ACC" ID="radDine" Checked="true" CssClass="form-check-input" Text="Dine" /></div>
                                                                <div class="col-md-4"><asp:RadioButton runat="server" GroupName="ACC" ID="radReserve" CssClass="form-check-input" Text= "Reserve"/></div>
                                                            </div>
                                                         
                                                          
                                                        </div>

                                                        <asp:HiddenField runat="server" ID="hfTableNumber" />
                                                        <asp:HiddenField runat="server" ID="hfGUC" />
                                                        
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

        </ContentTemplate>

         
    </asp:UpdatePanel>


</asp:Content>
