<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="TableLogs.aspx.cs" Inherits="WebMenu.TableLogs" %>
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
                        <asp:BoundField DataField="TableNumber" HeaderText="Table" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Customer" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="Username" HeaderText="Employee" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="TYPE" HeaderText="Action" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="DI" HeaderText="Date" ItemStyle-Width="20%" />
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
