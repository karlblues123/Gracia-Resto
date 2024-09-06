<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="webTestPrint.aspx.cs" Inherits="WebMenu.webTestPrint" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
          <CR:CrystalReportViewer ID="CRV" runat="server" AutoDataBind="true" 
                            PageZoomFactor="75"
                            HasToggleGroupTreeButton="false" HasToggleParameterPanelButton="False" DisplayToolbar="True" ToolPanelView="None" />

    </div>
</asp:Content>
