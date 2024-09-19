<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="KitchenLogs.aspx.cs" Inherits="GraciaResto.KitchenLogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                <asp:GridView runat="server" ID="gvLogs" CssClass="table table-responsive" AutoGenerateColumns="false" DataKeyNames="ID">
                    <Columns>
                        <asp:BoundField DataField="Customer" HeaderText="Customer" />
                        <asp:BoundField DataField="Username" HeaderText="Employee" />
                        <asp:BoundField DataField="ActionMade" HeaderText="Action" />
                        <asp:BoundField DataField="DI" HeaderText="Date" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Items
            $('[id*=log-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvLogs] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
</asp:Content>
