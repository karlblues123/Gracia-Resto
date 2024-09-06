﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="GraciaResto.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid my-2 mx-0 mx-lg-auto">
        <div class="row d-flex justify-content-center my-2">
            <%-- CFG Sales --%>
            <div class="col">
                <div class="card" style="max-height:40vh;">
                    <div class="card-header bg-yellow">
                        <div class="row">
                            <div class="col-4">
                                <p class="h6">Orders for Today</p>
                            </div>
                            <div class="col-4 offset-4">
                                <%-- Status Filter DropDownList --%>
                                <asp:DropDownList runat="server" ID="ddStatusFilter" CssClass="form-select" 
                                    OnSelectedIndexChanged="ddStatusFilter_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="card-body overflow-y-auto">
                        <%-- Sales for Today GridView --%>
                        <asp:GridView runat="server" ID="gvTodaySales" CssClass="table table-responsive" AutoGenerateColumns="false" DataKeyNames="SalesCode" 
                            EmptyDataText="No sales found." EmptyDataRowStyle-CssClass="text-center">
                            <Columns>
                                <%-- Customer Name --%>
                                <asp:TemplateField HeaderText="Customer">
                                    <ItemTemplate>
                                        <%#Eval("FirstName")%> <%#Eval("LastName")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Total --%>
                                <asp:BoundField DataField="TotalAmount" HeaderText="Total" />
                                <%-- View Button --%>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton runat="server" ID="btnViewSale" CssClass="btn btn-green-fill" OnClick="btnViewSale_Click">
                                            <span class="fa fa-search"></span>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card" style="max-height:40vh;">
                    <div class="card-header bg-red">
                        <p class="h6">Low Stock</p>
                    </div>
                    <div class="card-body overflow-y-auto">
                        <%-- Low Stock GridView --%>
                        <asp:GridView runat="server" ID="gvMenuStock" CssClass="table table-responsive" AutoGenerateColumns="false" 
                            DataKeyNames="DishCode" EmptyDataText="Stocks are good." EmptyDataRowStyle-CssClass="text-center">
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="Dish" />
                                <asp:BoundField DataField="Stock" HeaderText="Stock" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <div class="row d-flex justify-content-center my-2" style="max-height:40vh;">
            <div class="col">
                <div class="card" style="max-height:40vh;">
                    <div class="card-header bg-yellow">
                        <p class="h6">Dine-Ins and Table Reservations</p>
                    </div>
                    <div class="card-body overflow-y-auto">
                        <%-- Occupied and Reserved Tables GridView --%>
                        <asp:GridView runat="server" ID="gvTables" CssClass="table table-responsive" AutoGenerateColumns="false" 
                            EmptyDataText="All tables are available." EmptyDataRowStyle-CssClass="text-center">
                            <Columns>
                                <asp:TemplateField HeaderText="Table Number">
                                    <ItemTemplate>
                                        T - <%#Eval("TableNumber")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Customer">
                                    <ItemTemplate>
                                        <%#Eval("FirstName")%> <%#Eval("LastName") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card" style="max-height:40vh;">
                    <div class="card-header bg-red">
                        <p class="h6">Price Imbalance</p>
                    </div>
                    <div class="card-body overflow-y-auto">
                        <%-- Menu GridView --%>
                        <asp:GridView runat="server" ID="gvMenuPrice" CssClass="table table-responsive" AutoGenerateColumns="false" 
                            DataKeyNames="DishCode" EmptyDataText="Prices are balanced." EmptyDataRowStyle-CssClass="text-center">
                            <Columns>
                                <asp:BoundField DataField="Name" HeaderText="Dish" />
                                <asp:BoundField DataField="Price" HeaderText="Displayed Price" />
                                <asp:BoundField DataField="ActualPrice" HeaderText="Actual Price" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
