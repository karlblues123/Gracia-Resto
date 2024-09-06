<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="SalesPrint.aspx.cs" Inherits="WebMenu.SalesPrint" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                                <asp:LinkButton runat="server" ID="btnSubmit" CssClass="btn btn-sm btn-green-fill" OnClick="btnSubmit_Click">Submit</asp:LinkButton>
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
</asp:Content>
