<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="OrderSummary.aspx.cs" Inherits="GraciaResto.OrderSummary" %>
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
            document.getElementById('<%=txtDishOrderQty.ClientID%>').value = qty;
        }

        function incrementDishOrderQty() {
            var qty = document.getElementById('<%=txtDishOrderQty.ClientID%>').value;
            qty = ++qty;
            document.getElementById('<%=txtDishOrderQty.ClientID%>').value = qty;
        }
    </script>
        <asp:Panel runat="server" ID="pOrder">
            <div class="row m-5">
                <%-- Back Button --%>
                <div class="col-1">
                    <asp:LinkButton runat="server" ID="lnkBack" CssClass="fs-1 btn" OnClick="lnkBack_Click"><span class="fa fa-arrow-left"/></asp:LinkButton>
                </div>
            </div>
            <div class="row m-2">
                <div class="col">
                    <%-- Order Summary --%>
                    <div class="card">
                        <div class="card-header bg-transparent m-2">
                            <p class="card-title h2">Order Summary</p>
                        </div>
                        <div class="card-body">
                            <%-- Order GridView --%>
                            <asp:GridView runat="server" ID="gvOrder" CssClass="table table-responsive" AutoGenerateColumns="false" 
                                EmptyDataText="Your Order is Empty" GridLines="Horizontal" EmptyDataRowStyle-CssClass="text-center fs-2" ShowHeader="false" 
                                DataKeyNames="DishCode" OnRowCreated="gvOrder_RowCreated" ShowFooter="true">
                                <Columns>
                                    <asp:BoundField DataField="Name" ItemStyle-Width="60%" ItemStyle-CssClass="card-text fs-2" />
                                    <asp:TemplateField ItemStyle-Width="20%">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="btnQty" CssClass="btn btn-green-fill fs-2" OnClick="btnQty_Click">
                                                <%#Eval("Quantity")%>
                                            </asp:LinkButton>
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
                        <div class="card-footer" style="background-color:transparent !important;">
                            <div class="row m-2 m-md-2">
                                <div class="col-6 offset-3">
                                    <div class="form-floating">
                                        <%-- Customer Code --%>
                                        <asp:TextBox runat="server" ID="txtCustomerCode" CssClass="form-control fs-1" AutoCompleteType="Disabled"></asp:TextBox>
                                        <label for="<%=txtCustomerCode.ClientID %>">Code</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row m-2 m-md-2">
                                <div class="col-6 offset-3">
                                    <div class="form-floating">
                                        <%-- Customer Location --%>
                                        <asp:TextBox runat="server" ID="txtCustomerLocation" CssClass="form-control fs-1" ReadOnly="true"></asp:TextBox>
                                        <label for="<%=txtCustomerLocation.ClientID%>">Location</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row m-2 m-md-2">
                                <div class="col">
                                    <div class="card-body text-center">
                                        <%-- Place Order Button --%>
                                        <asp:LinkButton runat="server" ID="lnkPlaceOrder" CssClass="btn btn-green-fill fs-2" OnClick="lnkPlaceOrder_Click">Place Order</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:Label runat="server" ID="lblErrorAlert" CssClass="alert alert-danger position-fixed bottom-0 end-0 text-center" style="width:98vw;" Visible="false">Error</asp:Label>
        </asp:Panel>
        <%-- Selected Dish --%>
        <asp:Panel runat="server" ID="pSelectedDish" Visible="false">
            <asp:HiddenField runat="server" ID="hiddenSelectedDish"/>
            <div class="row m-2">
                <div class="col">
                    <asp:LinkButton runat="server" ID="btnClose" CssClass="btn btn-close fs-2" OnClick="btnClose_Click"></asp:LinkButton>
                </div>
            </div>
            <div class="row m-2">
                <%-- Selected Dish Name --%>
                <div class="col-4">
                    <asp:Label runat="server" ID="lblSelectedDishName" CssClass="h1" />
                </div>
                <%-- Selected Dish Price and Serving --%>
                <div class="col-4 offset-4">
                    <asp:Label runat="server" ID="lblSelectedDishPrice" CssClass="h1"></asp:Label>
                    <p class="fs-2">Good for <asp:Label runat="server" ID="lblSelectedDishServing" /></p>
                </div>
            </div>
            <%-- Selected Dish Quantity Control --%>
            <div class="d-flex flex-column align-items-center">
                <div class="input-group input-group-sm mb-md-3 mb-3" style="width:300px">
                    <button class="btn btn-lg btn-green-fill fs-2" type="button" role="button" onclick="decrementDishOrderQty()"><span class="fa fa-minus"></span></button>
                    <asp:TextBox runat="server" ID="txtDishOrderQty" CssClass="form-control form-control-lg fs-2" TextMode="Number" min="0" Text="0"></asp:TextBox>
                    <button class="btn btn-lg btn-green-fill fs-2" type="button" role="button" onclick="incrementDishOrderQty()"><span class="fa fa-plus"></span></button>
                </div> 
                <%-- Confirm Changes Button --%>
                <asp:LinkButton runat="server" ID="lnkConfirmChanges" CssClass="btn btn-lg btn-green-fill fs-2" OnClick="lnkConfirmChanges_Click">Confirm Changes</asp:LinkButton>
            </div>
        </asp:Panel>
</asp:Content>
