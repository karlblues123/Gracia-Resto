<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="GraciaResto.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row my-3">
            <div class="col-6 offset-3">
                <div class="card">
                    <div class="card-body">
                        <div class="row my-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Current Password Textbox --%>
                                    <asp:TextBox runat="server" ID="txtCurrentPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtCurrentPassword.ClientID%>">Current Password</label>
                                </div>
                                
                            </div>
                        </div>
                        <div class="row my-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Repeat Current Password Textbox --%>
                                    <asp:TextBox runat="server" ID="txtRepeatCurrent" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtRepeatCurrent.ClientID%>">Repeat Current Password</label>
                                </div>
                            </div>
                        </div>
                        <div class="row my-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- New Password Textbox --%>
                                    <asp:TextBox runat="server" ID="txtNewPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtNewPassword.ClientID%>">New Password</label>
                                </div>
                            </div>
                        </div>
                        <div class="row my-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Repeat New Password Textbox --%>
                                    <asp:TextBox runat="server" ID="txtRepeatNew" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                    <label for="<%=txtRepeatNew.ClientID%>">Repeat New Password</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <%-- Submit Button --%>
                        <asp:LinkButton runat="server" ID="btnSubmit" CssClass="btn btn-green-fill" OnClick="btnSubmit_Click">Submit</asp:LinkButton>
                        <%-- Cancel Button --%>
                        <asp:LinkButton runat="server" ID="btnCancel" CssClass="btn btn-dark" OnClick="btnCancel_Click">Cancel</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
