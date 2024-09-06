<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="RentalData.aspx.cs" Inherits="WebMenu.RentalData" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="card my-2">
            <div class="card-body">
                <%-- Rentals --%>
                <asp:GridView runat="server" ID="gvRentals" EmptyDataText="No rentals found." AutoGenerateColumns="false" CssClass="table table-responsive"
                    DataKeyNames="ID" EmptyDataRowStyle-CssClass="text-center" OnRowEditing="gvRentals_RowEditing" OnRowUpdating="gvRentals_RowUpdating" 
                    OnRowCancelingEdit="gvRentals_RowCancelingEdit">
                    <Columns>
                        <%-- Name --%>
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="true" ItemStyle-Width="25%" />
                        <%-- Price --%>
                        <asp:TemplateField HeaderText="Price" ItemStyle-Width="25%">
                            <ItemTemplate>
                                <%#Eval("Price","{0:N2}")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtPrice" CssClass="form-control" TextMode="Number" Text='<%#Eval("Price")%>' 
                                    AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>    
                        </asp:TemplateField>
                        <%-- Status --%>
                        <asp:TemplateField ItemStyle-Width="25%" HeaderText="Active">
                            <ItemTemplate>
                                <%#Eval("Status")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:CheckBox runat="server" ID="cbIsActive" Text="Is Active?" Checked='<%#Eval("Status")%>' />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <%-- Buttons --%>
                        <asp:TemplateField ItemStyle-Width="25%">
                            <ItemTemplate>
                                <%-- Edit --%>
                                <asp:LinkButton runat="server" ID="btnEdit" CssClass="btn btn-yellow-fill" CommandName="Edit">
                                    <span class="fa fa-edit"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <div class="col-6">
                                        <%-- Remarks --%>
                                        <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled" placeholder="Remarks"></asp:TextBox>
                                    </div>
                                    <div class="col-6">
                                        <%-- Update --%>
                                        <asp:LinkButton runat="server" ID="btnUpdate" CssClass="btn btn-green-fill" CommandName="Update">
                                            <span class="fa fa-check"></span>
                                        </asp:LinkButton>
                                        <%-- Cancel --%>
                                        <asp:LinkButton runat="server" ID="btnCancel" CssClass="btn btn-dark" CommandName="Cancel">
                                            <span class="fa fa-close"></span>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <%-- Modal Button --%>
        <button class="btn btn-green-fill position-fixed bottom-0 end-0 mb-2 me-5" type="button" data-bs-toggle="modal"
            data-bs-target="#room-modal">
            New Rental <span class="fa fa-plus-circle"></span>
        </button>
        <div class="modal fade" id="room-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="h6 modal-title">Rental Information</p>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row my-2">
                            <div class="col-8">
                                <div class="form-floating">
                                    <%-- Name --%>
                                    <asp:TextBox runat="server" ID="txtRentalName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=this.txtRentalName.ClientID%>">Name</label>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-floating">
                                    <%-- Price --%>
                                    <asp:TextBox runat="server" ID="txtRentalPrice" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                                    <label for="<%=this.txtRentalPrice.ClientID%>">Rate</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%-- Submit --%>
                        <asp:LinkButton runat="server" ID="btnSubmit" CssClass="btn btn-green-fill">Submit</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
