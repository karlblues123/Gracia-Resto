<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="GraciaResto.UserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Items
            $('[id*=user-search]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvUsers] tr').filter(function () {
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
                        <input type="text" id="user-search" class="form-control" placeholder="Search" autocomplete="off" />
                    </div>
                </div>
            </div>
            <div class="card-body overflow-y-auto">
                <%-- Logs GridView --%>
                <asp:GridView runat="server" ID="gvUsers" CssClass="table table-responsive" AutoGenerateColumns="false" DataKeyNames="ID" 
                    OnRowEditing="gvUsers_RowEditing" OnRowCancelingEdit="gvUsers_RowCancelingEdit" OnRowUpdating="gvUsers_RowUpdating">
                    <Columns>
                        <asp:BoundField DataField="Username" ReadOnly="true" />
                        <asp:TemplateField HeaderText="Type">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblType" CssClass="card-text"><%#Eval("TypeName")%></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList runat="server" ID="ddType" CssClass="form-select"></asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Enabled">
                            <ItemTemplate>
                                <p class="card-text"><%#Eval("IsActive")%></p>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox runat="server" ID="cbActive" Checked='<%#Eval("IsActive")%>' />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnEdit" CommandName="Edit" CssClass="btn btn-green">
                                    <span class="fa fa-edit"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <%-- Update Button --%>
                                <asp:LinkButton runat="server" ID="btnUpdate" CssClass="btn btn-green-fill" CommandName="Update"><span class="fa fa-check-circle"></span></asp:LinkButton>
                                <%-- Cancel Button --%>
                                <asp:LinkButton runat="server" ID="btnCancel" CssClass="btn btn-dark" CommandName="Cancel"><span class="fa fa-times-circle"></span></asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
