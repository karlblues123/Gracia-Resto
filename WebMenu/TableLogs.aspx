<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="TableLogs.aspx.cs" Inherits="GraciaResto.TableLogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid my-2">
        <div class="row">
            <aside class="col-auto col-md-1 col-xl-1">
                <div class="d-flex flex-column align-items-center">
                        <ul class="nav nav-pills flex-column">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link btn-blue active" id="audit-tab" data-bs-toggle="pill" data-bs-target="#audit-pane" type="button" 
                                    role="tab" aria-controls="form-pane" aria-selected="true">
                                    <p class="d-none d-xxl-inline">Audit</p>
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link btn-blue" id="info-tab" data-bs-toggle="pill" data-bs-target="#info-pane" type="button" 
                                    role="tab" aria-controls="history-pane" aria-selected="false">
                                    <p class="d-none d-xxl-inline">Information</p> 
                                </button>
                            </li>
                        </ul>
                    </div>
            </aside>
            <main class="col tab-content">
                <div class="tab-pane fade show active" id="audit-pane">
                    <div class="card" style="max-height:85vh;">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-6">
                                    <%-- Search Textbox --%>
                                    <input type="text" id="audit-search" class="form-control" placeholder="Search" />
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-y-auto">
                            <%-- Logs GridView --%>
                            <asp:GridView runat="server" ID="gvAuditLogs" CssClass="table table-responsive" AutoGenerateColumns="false" DataKeyNames="ID">
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
                <div class="tab-pane fade" id="info-pane">
                    <div class="card" style="max-height:85vh;">
                        <div class="card-header">
                            <div class="row">
                                <div class="col-6">
                                    <%-- Search Textbox --%>
                                    <input type="text" id="info-search" class="form-control" placeholder="Search" />
                                </div>
                            </div>
                        </div>
                        <div class="card-body overflow-y-auto">
                            <%-- Logs GridView --%>
                            <asp:GridView runat="server" ID="gvInfoLogs" CssClass="table table-responsive" AutoGenerateColumns="false" DataKeyNames="ID">
                                <Columns>
                                    <asp:BoundField DataField="TableNumber" HeaderText="Table" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="ActionMade" HeaderText="Action" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="Username" HeaderText="Employee" ItemStyle-Width="20%" />
                                    <asp:BoundField DataField="DI" HeaderText="Date" ItemStyle-Width="20%" />
                                    <asp:TemplateField ItemStyle-Width="20%">
                                        <ItemTemplate>
                                            <button class="btn btn-blue" role="button" onclick="displayReason('<%#Eval("Notes")%>');return false;" data-bs-toggle="modal" data-bs-target="#reason-modal">
                                                <span class="fa fa-search"></span>
                                            </button>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </main>
        </div>
         <%-- Reason Modal --%>
        <div class="modal fade" id="reason-modal" tabindex="-1" aria-labelledby="reasonModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p class="h5" id="reason"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Audit Logs
            $('[id*=audit-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvAuditLogs] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            //Search function for IInfo Logs
            $('[id*=info-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvInfoLogs] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }

        function displayReason(msg) {
            $('#reason').text(msg);
            bootstrap.Modal.getOrCreateInstance($('#reason-modal')).show();
        }
    </script>
</asp:Content>
