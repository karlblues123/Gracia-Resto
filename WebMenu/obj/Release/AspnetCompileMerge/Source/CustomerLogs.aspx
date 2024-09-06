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
                                <%#Eval("LastName")%>, <%#Eval("FirstName")%>
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
</asp:Content>
