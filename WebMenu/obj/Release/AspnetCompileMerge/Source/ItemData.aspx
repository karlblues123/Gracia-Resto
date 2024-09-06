<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="ItemData.aspx.cs" Inherits="WebMenu.ItemData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid my-2">
        <div class="card" style="max-height:85vh;">
            <div class="card-header">
                <div class="row">
                    <div class="col-6">
                        <%-- Search Textbox --%>
                        <input id="search-textbox" type="text" aria-label="Search" class="form-control" placeholder="Search" autocomplete="off" />
                    </div>
                </div>
            </div>
            <div class="card-body overflow-y-auto">
                <%-- Item GridView --%>
                <asp:GridView runat="server" ID="gvItems" CssClass="table table-responsive" AutoGenerateColumns="false" OnRowEditing="gvItems_RowEditing" 
                    OnRowCancelingEdit="gvItems_RowCancelingEdit" OnRowUpdating="gvItems_RowUpdating" DataKeyNames="ItemCode">
                    <Columns>
                        <%-- Item Name --%>
                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblItemName" Text='<%#Eval("Name")%>' CssClass="card-text"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtItemName" CssClass="form-control" Text='<%#Eval("Name")%>' 
                                    AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- Item Price --%>
                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblItemPrice" Text='<%#Eval("Price")%>' CssClass="card-text"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtItemPrice" CssClass="form-control" Text='<%#Eval("Price")%>' 
                                    TextMode="Number" AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- Item Unit of Measure --%>
                        <asp:TemplateField HeaderText="UM">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblItemUM" Text='<%#Eval("UM")%>' CssClass="card-text"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtItemUM" CssClass="form-control" Text='<%#Eval("UM")%>' 
                                    AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- GridView Buttons --%>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <%-- Edit Button --%>
                                <asp:LinkButton runat="server" ID="btnEdit" CssClass="btn btn-green-fill" CommandName="Edit"><span class="fa fa-edit"></span></asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <div class="col-6">
                                        <%-- Remarks --%>
                                        <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled" placeholder="Remarks"></asp:TextBox>
                                    </div>
                                    <div class="col-6">
                                        <%-- Update Button --%>
                                        <asp:LinkButton runat="server" ID="btnUpdate" CssClass="btn btn-green-fill" CommandName="Update"><span class="fa fa-check"></span></asp:LinkButton>
                                        <%-- Cancel Button --%>
                                        <asp:LinkButton runat="server" ID="btnCancel" CssClass="btn btn-dark" CommandName="Cancel"><span class="fa fa-close"></span></asp:LinkButton>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <%-- Add Modal Trigger Button --%>
        <button class="btn btn-green-fill position-fixed bottom-0 end-0 mb-2 me-5" type="button" data-bs-toggle="modal" 
            data-bs-target="#add-item-modal">New Item <span class="fa fa-plus-circle"></span></button>
        <%-- Add Item Modal --%>
        <div class="modal fade" id="add-item-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title">Add New Item</h3>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row m-2 m-md-2">
                            <div class="form-floating">
                                <%-- Name Textbox --%>
                                <asp:TextBox runat="server" ID="txtNewItemName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                <label for="<%=txtNewItemName.ClientID%>" class="ms-2">Name</label>
                            </div>
                        </div>
                        <div class="row m-2 m-md-2">
                            <div class="col-6 col-md-6">
                                <div class="form-floating">
                                    <%-- Price Textbox --%>
                                    <asp:TextBox runat="server" ID="txtNewItemPrice" CssClass="form-control" 
                                    AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                                    <label for="<%=txtNewItemPrice.ClientID %>">Price</label>
                                </div>
                            </div>
                            <div class="col-6 col-md-6">
                                <div class="form-floating">
                                    <%-- UM Textbox --%>
                                    <asp:TextBox runat="server" ID="txtNewItemUM" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=txtNewItemUM.ClientID %>">Unit of Measure</label>
                                </div>
                            </div>
                        </div>
                        <div class="row m-2 m-md-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Remarks --%>
                                    <asp:TextBox runat="server" ID="txtNewItemRemarks" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=txtNewItemRemarks.ClientID%>">Remarks</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%-- Add Item Submit Button --%>
                        <asp:LinkButton runat="server" ID="btnAddNewItem" CssClass="btn btn-green-fill" OnClick="btnAddNewItem_Click"><span class="fa fa-check-circle"></span></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function pageLoad() {
            //Search function for Items
            $('[id*=search-textbox]').off().on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $('[id*=gvItems] tr').filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        }
    </script>
</asp:Content>
