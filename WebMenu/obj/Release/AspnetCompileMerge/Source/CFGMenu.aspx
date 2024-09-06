<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CFGMenu.aspx.cs" Inherits="WebMenu.CFGMenu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        input[type=number]::-webkit-inner-spin-button, 
        input[type=number]::-webkit-outer-spin-button { 
          -webkit-appearance: none; 
          margin: 0; 
        }
    </style>
    <script>
        function decrementDishOrderQty() {
            var qty = document.getElementById('<%=txtDishOrderQty.ClientID%>').value;
            if (qty > 0)
                qty = --qty;
            if(qty == 0)
                document.getElementById('<%=lnkAddToOrder.ClientID%>').innerHTML = "Remove from Order";
            document.getElementById('<%=txtDishOrderQty.ClientID%>').value = qty;
        }

        function incrementDishOrderQty() {
            document.getElementById('<%=lnkAddToOrder.ClientID%>').innerHTML = "Add to Order";
            var qty = document.getElementById('<%=txtDishOrderQty.ClientID%>').value;
            if(qty < (<%if(!string.IsNullOrWhiteSpace(this.hiddenDishAvailableStock.Value)) Response.Write(this.hiddenDishAvailableStock.Value);%>))
            qty = ++qty;
            document.getElementById('<%=txtDishOrderQty.ClientID%>').value = qty;
        }
    </script>
    <%-- Navbar --%>
    <nav class="navbar navbar-expand-lg sticky-md-top sticky-top" style="background-color:#fffbfc;">
        <div class="container-fluid">
            <%-- Cafe Gracia logo --%>
            <h5 class="navbar-brand"><img src="Content/images/Cafe%20Gracia.png" style="width:100px; height:75px;" /></h5>
            <%-- Dropdown Navigation --%>
            <div class="d-flex dropstart"> 
                <a class="nav-link dropdown-toggle fs-2" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false"><span class="fa fa-search"></span></a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item fs-2" href="#appetizer">Appetizer</a></li>
                    <li><a class="dropdown-item fs-2" href="#soup">Soup</a></li>
                    <li><a class="dropdown-item fs-2" href="#maindish">Main Course</a></li>
                    <li><a class="dropdown-item fs-2" href="#rice">Rice</a></li>
                    <li><a class="dropdown-item fs-2" href="#desserts">Desserts</a></li>
                    <li><a class="dropdown-item fs-2" href="#beverages">Beverages</a></li>
                </ul>   
            </div>
        </div>
    </nav>
    <asp:Panel runat="server" ID="pMenu" Visible="true">
        <%-- Appetizer Repeater --%>
        <asp:Repeater runat="server" ID="rAppetizer">
            <HeaderTemplate>
                <div class="d-flex flex-column align-items-lg-center align-items-md-center" id="appetizer">
                    <h1>Appetizers</h1>
                    <ul class="list-group list-group-flush">
            </HeaderTemplate>
            <ItemTemplate>
                <%-- Appetizer Select Button --%>
                <asp:LinkButton runat="server" ID="btnAppetizer" CssClass="btn border-0 my-2" 
                    Enabled='<%#(int)Eval("Stock") <= 0 ? false : true %>' CommandName="Display" 
                    CommandArgument='<%#(int)Eval("Stock") <= 0 ? string.Empty : Eval("DishCode").ToString() %>' OnCommand="btnDish_Command">
                    <div class="card dish-card mb-3">
                        <div class="row g-0">
                            <%-- Image --%>
                            <div class="col-md-5 col-5 d-flex align-items-center justify-content-center <%#(int)Eval("Stock") <= 0 ? "opacity-25" : string.Empty %>">
                                <asp:Image runat="server" CssClass="img-thumbnail border-0 object-fit-contain" ImageUrl='<%#this.GetImage(Eval("Name").ToString())%>' />
                            </div>
                            <%-- Details --%>
                            <div class="col-md-7 col-7">
                                <div class="card-body d-flex flex-column align-items-center justify-content-evenly">
                                    <h2 class="card-title"><asp:Label runat="server" ID="lblDishName" Text='<%# Eval("Name").ToString() %>'></asp:Label></h2>
                                    <p class="card-text fs-3 text-center"><asp:Label runat="server" ID="lblDishDescription" Text='<%# Eval("Description").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-3">Good for <asp:Label runat="server" ID="lblDishServing" Text='<%# Eval("Serving").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-2"><asp:Label runat="server" ID="lblDishPrice" Text='<%# Eval("Price").ToString() %>'></asp:Label>PHP</p>
                                    <p class="card-text fs-2"><asp:Label runat="server" ID="lblSoldOut" Visible='<%#(int)Eval("Stock") <= 0%>'>Sold Out</asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:LinkButton>
            </ItemTemplate>
            <FooterTemplate>
                    </ul>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <%-- Soup Repeater --%>
        <asp:Repeater runat="server" ID="rSoup">
            <HeaderTemplate>
                <div class="d-flex flex-column align-items-lg-center align-items-md-center" id="soup">
                    <h1>Soup</h1>
                    <ul class="list-group list-group-flush">
            </HeaderTemplate>
            <ItemTemplate>
                <%-- Soup Select Button --%>
                <asp:LinkButton runat="server" ID="btnSoup" CssClass="btn border-0 my-2"
                    Enabled='<%#(int)Eval("Stock") <= 0 ? false : true %>' CommandName="Display" 
                    CommandArgument='<%#(int)Eval("Stock") <= 0 ? string.Empty : Eval("DishCode").ToString() %>' OnCommand="btnDish_Command">
                    <div class="card dish-card mb-3">
                        <div class="row g-0">
                            <%-- Image --%>
                            <div class="col-md-5 col-5 d-flex align-items-center justify-content-center <%#(int)Eval("Stock") <= 0 ? "opacity-25" : string.Empty %>">
                                <asp:Image runat="server" CssClass="img-thumbnail border-0 object-fit-contain" ImageUrl='<%#this.GetImage(Eval("Name").ToString())%>' />
                            </div>
                            <%-- Details --%>
                            <div class="col-md-7 col-7">
                                <div class="card-body d-flex flex-column align-items-center justify-content-evenly">
                                    <h2 class="card-title"><asp:Label runat="server" ID="lblDishName" Text='<%# Eval("Name").ToString() %>'></asp:Label></h2>
                                    <p class="card-text fs-3 text-center"><asp:Label runat="server" ID="lblDishDescription" Text='<%# Eval("Description").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-3">Good for <asp:Label runat="server" ID="lblDishServing" Text='<%# Eval("Serving").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-2"><asp:Label runat="server" ID="lblDishPrice" Text='<%# Eval("Price").ToString() %>'></asp:Label>PHP</p>
                                    <p class="card-text fs-4"><asp:Label runat="server" ID="lblSoldOut" Visible='<%#(int)Eval("Stock") <= 0%>'>Sold Out</asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:LinkButton>
            </ItemTemplate>
            <FooterTemplate>
                    </ul>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <%-- Main Course Repeater --%>
        <asp:Repeater runat="server" ID="rMainDish">
            <HeaderTemplate>
                <div class="d-flex flex-column align-items-lg-center align-items-md-center" id="maindish">
                    <h1>Main Course</h1>
                    <ul class="list-group list-group-flush">
            </HeaderTemplate>
            <ItemTemplate>
                <%-- Main Course Select Button --%>
                <asp:LinkButton runat="server" ID="btnMainCourse" CssClass="btn border-0 my-2"
                    Enabled='<%#(int)Eval("Stock") <= 0 ? false : true %>' CommandName="Display" 
                    CommandArgument='<%#(int)Eval("Stock") <= 0 ? string.Empty : Eval("DishCode").ToString() %>' OnCommand="btnDish_Command">
                    <div class="card dish-card mb-3">
                        <div class="row g-0">
                            <%-- Image --%>
                            <div class="col-md-5 col-5 d-flex align-items-center justify-content-center <%#(int)Eval("Stock") <= 0 ? "opacity-25" : string.Empty %>">
                                <asp:Image runat="server" CssClass="img-thumbnail border-0 object-fit-contain" ImageUrl='<%#this.GetImage(Eval("Name").ToString())%>' />
                            </div>
                            <%-- Details --%>
                            <div class="col-md-7 col-7">
                                <div class="card-body d-flex flex-column align-items-center justify-content-evenly">
                                    <h2 class="card-title"><asp:Label runat="server" ID="lblDishName" Text='<%# Eval("Name").ToString() %>'></asp:Label></h2>
                                    <p class="card-text fs-3 text-center"><asp:Label runat="server" ID="lblDishDescription" Text='<%# Eval("Description").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-3">Good for <asp:Label runat="server" ID="lblDishServing" Text='<%# Eval("Serving").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-2"><asp:Label runat="server" ID="lblDishPrice" Text='<%# Eval("Price").ToString() %>'></asp:Label>PHP</p>
                                    <p class="card-text fs-4"><asp:Label runat="server" ID="lblSoldOut" Visible='<%#(int)Eval("Stock") <= 0%>'>Sold Out</asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:LinkButton>
            </ItemTemplate>
            <FooterTemplate>
                    </ul>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <%-- Rice Repeater --%>
        <asp:Repeater runat="server" ID="rRice">
            <HeaderTemplate>
                <div class="d-flex flex-column align-items-lg-center align-items-md-center" id="rice">
                    <h1>Rice</h1>
                    <ul class="list-group list-group-flush">
            </HeaderTemplate>
            <ItemTemplate>
                <%-- Rice Select Button --%>
                <asp:LinkButton runat="server" ID="btnRice" CssClass="btn border-0 my-2" 
                    Enabled='<%#(int)Eval("Stock") <= 0 ? false : true %>' CommandName="Display" 
                    CommandArgument='<%#(int)Eval("Stock") <= 0 ? string.Empty : Eval("DishCode").ToString() %>' OnCommand="btnDish_Command">
                    <div class="card dish-card mb-3">
                        <div class="row g-0">
                            <%-- Appetizer Image --%>
                            <div class="col-md-5 col-5 d-flex align-items-center justify-content-center <%#(int)Eval("Stock") <= 0 ? "opacity-25" : string.Empty %>">
                                <asp:Image runat="server" CssClass="img-thumbnail border-0 object-fit-contain" ImageUrl='<%#this.GetImage(Eval("Name").ToString())%>' />
                            </div>
                            <%-- Appetizer Details Labels --%>
                            <div class="col-md-7 col-7">
                                <div class="card-body d-flex flex-column align-items-center justify-content-evenly">
                                    <h2 class="card-title"><asp:Label runat="server" ID="lblDishName" Text='<%# Eval("Name").ToString() %>'></asp:Label></h2>
                                    <p class="card-text fs-3 text-center"><asp:Label runat="server" ID="lblDishDescription" Text='<%# Eval("Description").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-3">Good for <asp:Label runat="server" ID="lblDishServing" Text='<%# Eval("Serving").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-2"><asp:Label runat="server" ID="lblDishPrice" Text='<%# Eval("Price").ToString() %>'></asp:Label>PHP</p>
                                    <p class="card-text fs-4"><asp:Label runat="server" ID="lblSoldOut" Visible='<%#(int)Eval("Stock") <= 0%>'>Sold Out</asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:LinkButton>
            </ItemTemplate>
            <FooterTemplate>
                    </ul>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <%-- Desserts Repeater --%>
        <asp:Repeater runat="server" ID="rDesserts">
            <HeaderTemplate>
                <div class="d-flex flex-column align-items-lg-center align-items-md-center" id="desserts">
                    <h1>Desserts</h1>
                    <ul class="list-group list-group-flush">
            </HeaderTemplate>
            <ItemTemplate>
                <%-- Dessert Select Button --%>
                <asp:LinkButton runat="server" ID="btnDessert" CssClass="btn border-0 my-2" 
                    Enabled='<%#(int)Eval("Stock") <= 0 ? false : true %>' CommandName="Display" 
                    CommandArgument='<%#(int)Eval("Stock") <= 0 ? string.Empty : Eval("DishCode").ToString() %>' OnCommand="btnDish_Command">
                    <div class="card dish-card mb-3">
                        <div class="row g-0">
                            <%-- Image --%>
                            <div class="col-md-5 col-5 d-flex align-items-center justify-content-center <%#(int)Eval("Stock") <= 0 ? "opacity-25" : string.Empty %>">
                                <asp:Image runat="server" CssClass="img-thumbnail border-0 object-fit-contain" ImageUrl='<%#this.GetImage(Eval("Name").ToString())%>' />
                            </div>
                            <%-- Details --%>
                            <div class="col-md-7 col-7">
                                <div class="card-body d-flex flex-column align-items-center justify-content-evenly">
                                    <h2 class="card-title"><asp:Label runat="server" ID="lblDishName" Text='<%# Eval("Name").ToString() %>'></asp:Label></h2>
                                    <p class="card-text fs-3 text-center"><asp:Label runat="server" ID="lblDishDescription" Text='<%# Eval("Description").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-3">Good for <asp:Label runat="server" ID="lblDishServing" Text='<%# Eval("Serving").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-2"><asp:Label runat="server" ID="lblDishPrice" Text='<%# Eval("Price").ToString() %>'></asp:Label>PHP</p>
                                    <p class="card-text fs-4"><asp:Label runat="server" ID="lblSoldOut" Visible='<%#(int)Eval("Stock") <= 0%>'>Sold Out</asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:LinkButton>
            </ItemTemplate>
            <FooterTemplate>
                    </ul>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <%-- Beverages Repeater --%>
        <asp:Repeater runat="server" ID="rBeverages">
            <HeaderTemplate>
                <div class="d-flex flex-column align-items-lg-center align-items-md-center" id="beverages">
                    <h1>Beverages</h1>
                    <ul class="list-group list-group-flush">
            </HeaderTemplate>
            <ItemTemplate>
                <%-- Beverage Select Button --%>
                <asp:LinkButton runat="server" ID="btnBeverage" CssClass="btn border-0 my-2" 
                    Enabled='<%#(int)Eval("Stock") <= 0 ? false : true %>' CommandName="Display" 
                    CommandArgument='<%#(int)Eval("Stock") <= 0 ? string.Empty : Eval("DishCode").ToString() %>' OnCommand="btnDish_Command">
                    <div class="card dish-card mb-3">
                        <div class="row g-0">
                            <%-- Beverage Image --%>
                            <div class="col-md-5 col-5 d-flex align-items-center justify-content-center  <%#(int)Eval("Stock") <= 0 ? "opacity-25" : string.Empty %>">
                                <asp:Image runat="server" CssClass="img-thumbnail border-0 object-fit-contain" ImageUrl='<%#this.GetImage(Eval("Name").ToString())%>' />
                            </div>
                            <%-- Beverage Details Labels --%>
                            <div class="col-md-7 col-7">
                                <div class="card-body d-flex flex-column align-items-center justify-content-evenly">
                                    <h2 class="card-title"><asp:Label runat="server" ID="lblDishName" Text='<%# Eval("Name").ToString() %>'></asp:Label></h2>
                                    <p class="card-text fs-3 text-center"><asp:Label runat="server" ID="lblDishDescription" Text='<%# Eval("Description").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-3">Good for <asp:Label runat="server" ID="lblDishServing" Text='<%# Eval("Serving").ToString() %>'></asp:Label></p>
                                    <p class="card-text fs-2"><asp:Label runat="server" ID="lblDishPrice" Text='<%# Eval("Price").ToString() %>'></asp:Label>PHP</p>
                                    <p class="card-text fs-4"><asp:Label runat="server" ID="lblSoldOut" Visible='<%#(int)Eval("Stock") <= 0%>'>Sold Out</asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:LinkButton>
            </ItemTemplate>
            <FooterTemplate>
                    </ul>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        <%-- View Order Shortcut Button --%>
        <asp:LinkButton runat="server" ID="btnView" CssClass="btn btn-green-fill position-fixed bottom-0 end-0 mb-5 me-5" OnClick="lnkViewOrder_Click" 
            style="--bs-btn-padding-y: 1.25rem; --bs-btn-padding-x: 2.5rem; --bs-btn-font-size: 2.5rem;">
            View Order
        </asp:LinkButton>
    </asp:Panel>
    <%-- Selected Dish Offcanvas --%>
    <asp:Panel runat="server" ID="pSelectedDish" Visible="false">
        <asp:HiddenField runat="server" ID="hiddenSelectedDish"/>
        <asp:HiddenField runat="server" ID="hiddenDishAvailableStock" />
        <div class="row m-2">
            <div class="col">
                <asp:LinkButton runat="server" ID="btnBack" CssClass="btn btn-close" OnClick="btnBack_Click"></asp:LinkButton>
            </div>
        </div>
        <div class="row m-2">
            <%-- Selected Dish Name Label --%>
            <div class="col-4">
                <asp:Label runat="server" ID="lblSelectedDishName" CssClass="h1" />
            </div>
            <%-- Selected Dish Price and Serving Labels --%>
            <div class="col-4 offset-4">
                <asp:Label runat="server" ID="lblSelectedDishPrice" CssClass="h1"></asp:Label>
                <p class="fs-2">Good for <asp:Label runat="server" ID="lblSelectedDishServing" /></p>
            </div>  
        </div>
        <%-- Selected Dish Quantity Controls --%>
        <div class="d-flex flex-column align-items-center">
            <div class="input-group input-group-sm mb-md-3 mb-3" style="width:300px">
                <button class="btn btn-lg btn-green-fill fs-2" type="button" role="button" onclick="decrementDishOrderQty()"><span class="fa fa-minus"></span></button>
                <asp:TextBox runat="server" ID="txtDishOrderQty" CssClass="form-control form-control-lg fs-2" TextMode="Number" min="0" max="5" Text="0"></asp:TextBox>
                <button class="btn btn-lg btn-green-fill fs-2" type="button" role="button" onclick="incrementDishOrderQty()"><span class="fa fa-plus"></span></button>
            </div> 
            <%-- Add to Order Button --%>
            <asp:LinkButton runat="server" ID="lnkAddToOrder" CssClass="btn btn-lg btn-green-fill fs-2 my-5" OnClick="lnkAddToOrder_Click">Add to Order</asp:LinkButton>
            <%-- View Order Button --%>
            <asp:LinkButton runat="server" ID="lnkViewOrder" CssClass="btn btn-lg btn-green-fill fs-2" OnClick="lnkViewOrder_Click">Proceed to Checkout</asp:LinkButton>
        </div>
        <div class="row m-3">
            <div class="col">
                <span class="text-center fs-3">Your Order</span>
                <%-- Order GridView --%>
                <asp:GridView runat="server" ID="gvOrder" CssClass="table table-responsive" AutoGenerateColumns="false" 
                    EmptyDataText="Your Order is Empty" GridLines="Horizontal" EmptyDataRowStyle-CssClass="text-center fs-2" ShowHeader="false" 
                    ShowFooter="true" OnRowCreated="gvOrder_RowCreated">
                    <Columns>
                        <asp:BoundField DataField="Name" ItemStyle-Width="60%" ItemStyle-CssClass="card-text fs-2" />
                        <asp:TemplateField ItemStyle-Width="20%" ItemStyle-CssClass="card-text fs-2">
                        <ItemTemplate>
                            <%#Eval("Quantity")%>
                        </ItemTemplate>
                        <FooterTemplate>
                            <p class="fs-2">Total:</p>
                        </FooterTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="20%" ItemStyle-CssClass="card-text fs-2">
                            <ItemTemplate>
                                <%#Eval("Total")%>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label runat="server" ID="lblTotal" CssClass="card-text fs-2"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </asp:Panel>
</asp:Content>
