﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="PurchaseOrderLogs.aspx.cs" Inherits="GraciaResto.PurchaseOrderLogs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function displayReason(msg) {
            $('#reason').text(msg);
            bootstrap.Modal.getOrCreateInstance($('#reason-modal')).show();
        }

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
                <asp:GridView runat="server" ID="gvLogs" CssClass="table table-responsive" AutoGenerateColumns="false" DataKeyNames="POCode">
                    <Columns>
                        <asp:BoundField DataField="POCode" HeaderText="Code" ItemStyle-Width="15%" />
                        <asp:BoundField DataField="InCharge" HeaderText="In Charge" ItemStyle-Width="15%"/>
                        <asp:BoundField DataField="DI" HeaderText="Date and Time" ItemStyle-Width="20%" />
                        <asp:BoundField DataField="ActionMade" HeaderText="Action" ItemStyle-Width="15%" />
                        <asp:BoundField DataField="Username" HeaderText="Employee" ItemStyle-Width="15%" />
                        <asp:TemplateField ItemStyle-Width="15%">
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
</asp:Content>
