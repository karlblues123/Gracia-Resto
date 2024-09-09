<%@ Page Title="Restaurant Management System" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="webKitchen.aspx.cs" Inherits="GraciaResto.webKitchen" %>

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
                 <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="10000"></asp:Timer>
                       
            

            <%--<div class="card">
                <div class="card-header bg-gradient bg-light text-black-75">
                    <div class="row">
                        <div class="col-md-6">
                            <h4 class="navbar-brand"><img src="Content/images/Cafe%20Gracia.png" style="width:75px; height:50px;" />  Kitchen Orders Monitoring <span class="fa fa-desktop"></span></h4>
                        </div>
                        
                    </div>
                  
                </div>

                <div class="card-body">--%>
            <div class="container-fluid my-2">
                <div class="row">
                    <div class="col-4">
                        <div class="card">
                            <div class="card-header bg-blue"> 
                                <div class="row">
                                      
                                            <h5> <span class="fa fa-envelope text-white"></span> Order(s) Request  <asp:Label runat="server" CssClass="badge bg-red" ID="lblRequestOrderCount"></asp:Label> </h5>
                                        
                                        
                                </div>
                                

                            </div>
                            <div class="card-body">
                                <asp:Repeater runat="server" ID="rptRequest" OnItemDataBound="rptRequest_ItemDataBound" OnItemCommand="rptRequest_ItemCommand">
                                    <ItemTemplate>
                                            
                                        <div class="card">
                                            <div class="card-header"> 
                                                <div class="row">
                                                <div class="col-9">
                                                <p><span class="fa fa-user"></span> Customer Name: <b><%# Eval("Customer")%></b></p>
                                                <span class="fa fa-clock-o"></span> Time: <b><%# Eval("DI") %></b><br />
                                                <span class="fa fa-location-arrow"></span> Table: <b><%#Eval("Room") %></b>
                                                <asp:HiddenField runat="server" ID="hfSalesCode" Value='<%# Eval("SalesCode") %>' />
                                                    </div>
                                                <div class="col-3">
                                                    <asp:LinkButton runat="server" ID="lnkAccept" CssClass="btn btn-sm btn-blue-fill" CommandName="ACCEPT"><span class="fa fa-thumbs-up"></span> Accept</asp:LinkButton>
                                                </div>
                                                    </div>
                                            </div>

                                            <div class="card-body">
                                                    <asp:Repeater runat="server" ID="rptRequestChild">
                                                    <ItemTemplate>
                                                        <div class="row">
                                                            <div class="col-3">
                                                                <asp:Image runat="server" ID="iSoupImage" CssClass="img-thumbnail" ImageURL='<%#this.GetImage(Eval("Name").ToString())%>' Width="100px" Height="85px" />
                                                            </div>
                                                            <div class="col">
                                                                <ul class="list-group">
                                                                    <li class="list-group-item border-0"><h5><%# Eval("Name") %></h5></li>
                                                                    <li class="list-group-item border-0"><h6>Quantity: <b><%# Eval("Quantity") %></b></h6></li>
                                                                </ul>
                                                            </div>
                                                        </div>

                                                        <p></p>

                                                      
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            </div>

                                        </div>
                                        <hr />

                                        
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>

                    </div>

                    <!--PREPARING STAGE -->
                    <div class="col-4">
                            <div class="card">
                            <div class="card-header bg-yellow">
                                    <h5> <span class="fa fa-gear fa-spin"></span>  </span> Orders Preparing <asp:Label runat="server" CssClass="badge bg-primary" ID="lblOrdersPreparingCount"></asp:Label>  </h5></div>
                            <div class="card-body">
                                    
                                    <asp:Repeater runat="server" ID="rptPreparation" OnItemDataBound="rptPreparation_ItemDataBound" OnItemCommand="rptPreparation_ItemCommand">
                                    <ItemTemplate>
                                            
                                        <div class="card">
                                            <div class="card-header bg-yellow"> 
                                                <div class="row">
                                                <div class="col-9">
                                                    <p><span class="fa fa-user"></span> Customer Name: <b><%# Eval("Customer")%></b></p>
                                                    <span class="fa fa-clock-o"></span> Time: <b><%# Eval("DI") %></b><br />
                                                    <span class="fa fa-location-arrow"></span> Table: <b><%#Eval("Room") %></b>
                                                    <asp:HiddenField runat="server" ID="hfSalesCode" Value='<%# Eval("SalesCode") %>' />
                                                </div>
                                                <div class="col-3">
                                                    <asp:LinkButton runat="server" ID="lnkComplete" CssClass="btn btn-sm btn-green-fill" CommandName="COMPLETE"><span class="fa fa-check-square"></span> Ready</asp:LinkButton>
                                                </div>
                                                </div>
                                            </div>

                                            <div class="card-body">
                                                    <asp:Repeater runat="server" ID="rptPreparingChild">
                                                    <ItemTemplate>
                                                        <div class="row">
                                                            <div class="col-3">
                                                                <asp:Image runat="server" ID="iSoupImage" CssClass="img-thumbnail" ImageURL='<%#this.GetImage(Eval("Name").ToString())%>>' Width="100px" Height="85px" />
                                                            </div>
                                                            <div class="col">
                                                                <ul class="list-group">
                                                                    <li class="list-group-item border-0"><h5><%# Eval("Name") %></h5></li>
                                                                    <li class="list-group-item border-0"><h6>Quantity: <b><%# Eval("Quantity") %></b></h6></li>
                                                                </ul>
                                                            </div>
                                                        </div>

                                                        <p></p>

                                                      
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            </div>

                                        </div>
                                        <hr />

                                        
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>

                    </div>

                    <!-- Order Summary -->
                    <div class="col-4"> <div class="card">
                            <div class="card-header"> <h5> <span class="fa fa-pie-chart text-danger"></span> Orders Completion Summary </h5></div>
                            <div class="card-body">
                                <asp:GridView runat="server" ID="gvOrdersCompleted" AutoGenerateColumns="false" CssClass="table table-responsive">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image runat="server" ID="iSoupImage" CssClass="img-thumbnail" ImageURL='<%#this.GetImage(Eval("Name").ToString())%>' Width="50px" Height="50px" />
                                            </ItemTemplate>
                                                
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Name" HeaderText="Dish" />
                                        <asp:BoundField DataField="TotalOrdersQty" HeaderText="Total Quantity" ItemStyle-CssClass="text-center" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
                    


              


                
                               

           <%-- </div> --%>

                
                <div class="alert small position-absolute bottom-0 end-0">
                   <i class="text-black-50">Restaurant Management System Version 1.0 ™</i>
                </div>
            

        </ContentTemplate>

          <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                    </Triggers>
    </asp:UpdatePanel>


</asp:Content>
