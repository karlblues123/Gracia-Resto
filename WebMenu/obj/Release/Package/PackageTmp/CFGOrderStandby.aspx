<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CFGOrderStandby.aspx.cs" Inherits="WebMenu.CFGOrderStandby" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:UpdatePanel runat="server" ID="upMain">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="tickUpdate" EventName="Tick" />
        </Triggers>
        <ContentTemplate>
            <asp:Timer runat="server" ID="tickUpdate" Interval="6000" OnTick="tickUpdate_Tick"></asp:Timer>
            <div class="container container-md">
                <div class="card d-flex flex-column align-items-center justify-content-evenly m-5 p-5 mx-auto">
                    <div class="row">
                        <h1>Your Order is</h1>
                    </div>
                    <div class="row">
                        <h1><asp:Label runat="server" ID="lblOrderNumber"></asp:Label></h1>
                    </div>
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
                    <div class="row my-5">
                        <div class="col-auto">
                            <%-- Order Status --%>
                            <asp:Label runat="server" ID="lblOrderStatus" CssClass="fs-3"></asp:Label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <%-- New Order Button --%>
                            <asp:LinkButton runat="server" ID="btnAdditionalOrder" CssClass="btn btn-green-fill w-100 h-100 fs-2" OnClick="btnAdditionalOrder_Click">New <br> Order</asp:LinkButton>
                        </div>
                        <div class="col-6">
                            <%-- Cancel Modal Button --%>
                            <button type="button" class="btn btn-red w-100 h-100 fs-3" data-bs-toggle="modal" data-bs-target="#cancel-modal">Cancel Order</button>
                        </div>
                    </div>
                </div>
                <%-- Cancel Modal --%>
                <div class="modal fade" id="cancel-modal" tabindex="-1" aria-labelledby="cancelModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <h3>Are you sure you want to cancel your order?</h3>
                            </div>
                            <div class="modal-footer">
                                <div class="row">
                                    <div class="col-2 offset-2 col-md-2 offset-md-2">
                                        <asp:LinkButton runat="server" ID="lnkCancelOrder" CssClass="btn btn-red" OnClick="lnkCancelOrder_Click">Cancel</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
