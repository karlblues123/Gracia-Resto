<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="CustomerLogs.aspx.cs" Inherits="WebMenu.CustomerLogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Logs
            $('[id*=log-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvLogs] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
    <div class="container-fluid my-2">
        <div class="card" style="max-height:85vh;">
            <div class="card-header">
                <div class="row">
                    <div class="col-6">
                        <%-- Search Textbox --%>
                        <input type="text" id="log-search" class="form-control" placeholder="Search" />
                    </div>
                </div>
            </div>
            <div class="card-body overflow-y-auto">
                <%-- Logs GridView --%>
                <asp:GridView runat="server" ID="gvLogs" CssClass="table table-responsive" AutoGenerateColumns="false" DataKeyNames="GuestCode">
                    <Columns>
                        <asp:BoundField DataField="GuestCode" HeaderText="Code" ItemStyle-Width="20%" />
                        <asp:TemplateField ItemStyle-Width="20%" HeaderText="Name">
                            <ItemTemplate>
                                <%#Eval("FirstName")%> <%#Eval("LastName")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Birthdate" HeaderText="Birthdate" DataFormatString="{0:MM/dd/yyyy}" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" ItemStyle-Width="15%" />
                        <asp:BoundField DataField="DI" HeaderText="Date Recorded" ItemStyle-Width="20%" />
                        <asp:TemplateField ItemStyle-Width="5%">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnViewSummary" CssClass="btn btn-blue" OnClick="btnViewSummary_Click">
                                    <span class="fa fa-search"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <%-- Add Modal Trigger Button --%>
    <button class="btn btn-green-fill position-fixed bottom-0 end-0 mb-2 me-5" type="button" data-bs-toggle="modal" 
        data-bs-target="#add-customer-modal">New Customer <span class="fa fa-plus-circle"></span></button>
    <div class="modal fade" id="add-customer-modal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="h6 modal-title">Register Customer</p>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row my-2">
                        <div class="col-6">
                            <div class="form-floating">
                                <%-- Code --%>
                                <asp:TextBox runat="server" ID="txtCustomerCode" CssClass="form-control" AutoCompleteType="Disabled" 
                                    TextMode="Number"></asp:TextBox>
                                <label for="<%=this.txtCustomerCode.ClientID%>">Customer Code</label>
                            </div>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-6">
                            <div class="form-floating">
                                <%-- First Name --%>
                                <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                <label for="<%=this.txtFirstName.ClientID%>">First Name</label>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-floating">
                                <%-- Last Name --%>
                                <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                <label for="<%=this.txtLastName.ClientID%>">Last Name</label>
                            </div>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-6">
                            <div class="form-floating">
                                <%-- Birthdate --%>
                                <asp:TextBox runat="server" ID="txtBirthdate" CssClass="form-control" TextMode="Date" AutoCompleteType="Disabled"></asp:TextBox>
                                <label for="<%=this.txtBirthdate.ClientID%>">Birthdate</label>
                            </div>
                        </div>
                        <div class="col-6">
                            <%-- Gender --%>
                            <asp:RadioButtonList runat="server" ID="rblGender">
                                <asp:ListItem Value="M">Male</asp:ListItem>
                                <asp:ListItem Value="F">Female</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:LinkButton runat="server" ID="btnRecord" CssClass="btn btn-green-fill" OnClick="btnRecord_Click">Record</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
