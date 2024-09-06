<%@ Page Title="" Language="C#" MasterPageFile="~/Employee.Master" AutoEventWireup="true" CodeBehind="Rooms.aspx.cs" Inherits="WebMenu.Rooms" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="card my-2">
            <div class="card-body">
                <%-- Rooms --%>
                <asp:GridView runat="server" ID="gvRooms" EmptyDataText="No rooms found." AutoGenerateColumns="false" CssClass="table table-responsive"
                    DataKeyNames="Name" EmptyDataRowStyle-CssClass="text-center" OnRowEditing="gvRooms_RowEditing" OnRowCancelingEdit="gvRooms_RowCancelingEdit"
                    OnRowUpdating="gvRooms_RowUpdating">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Name" ReadOnly="true" ItemStyle-Width="25%" />
                        <asp:TemplateField HeaderText="Occupancy" ItemStyle-Width="25%">
                            <ItemTemplate>
                                <%#Eval("Occupancy")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtOccupancy" CssClass="form-control" Text='<%#Eval("Occupancy")%>' TextMode="Number" 
                                    AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Rate" ItemStyle-Width="25%">
                            <ItemTemplate>
                                <%#Eval("Rate","{0:N2}")%>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox runat="server" ID="txtRate" CssClass="form-control" TextMode="Number" Text='<%#Eval("Rate")%>' 
                                    AutoCompleteType="Disabled"></asp:TextBox>
                            </EditItemTemplate>    
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="25%">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="btnEdit" CssClass="btn btn-yellow-fill" CommandName="Edit">
                                    <span class="fa fa-edit"></span>
                                </asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <div class="row">
                                    <div class="col-6">
                                        <asp:TextBox runat="server" ID="txtRemarks" CssClass="form-control" AutoCompleteType="Disabled" placeholder="Remarks"></asp:TextBox>
                                    </div>
                                    <div class="col-6">
                                        <asp:LinkButton runat="server" ID="btnUpdate" CssClass="btn btn-green-fill" CommandName="Update">
                                            <span class="fa fa-check"></span>
                                        </asp:LinkButton>
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
            New Room <span class="fa fa-plus-circle"></span>
        </button>
        <div class="modal fade" id="room-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="h6 modal-title">Room Information</p>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row my-2">
                            <div class="col">
                                <div class="form-floating">
                                    <%-- Name --%>
                                    <asp:TextBox runat="server" ID="txtRoomName" CssClass="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                    <label for="<%=this.txtRoomName.ClientID%>">Name</label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <div class="form-floating">
                                    <%-- Occupancy --%>
                                    <asp:TextBox runat="server" ID="txtRoomOccupancy" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                                    <label for="<%=this.txtRoomOccupancy.ClientID%>">Occupancy</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating">
                                    <%-- Rate --%>
                                    <asp:TextBox runat="server" ID="txtRoomRate" CssClass="form-control" AutoCompleteType="Disabled" TextMode="Number"></asp:TextBox>
                                    <label for="<%=this.txtRoomRate.ClientID%>">Rate</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <%-- Submit --%>
                        <asp:LinkButton runat="server" ID="btnSubmit" CssClass="btn btn-green-fill" OnClick="btnSubmit_Click">Submit</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
