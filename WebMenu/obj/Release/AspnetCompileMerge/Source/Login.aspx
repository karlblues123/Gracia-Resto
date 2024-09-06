<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebMenu.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MaClare Resort System</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/font-awesome.css" rel="stylesheet" />
    <link href="Content/toastr.css" rel="stylesheet" />
    <link href="Content/jquery-ui.css" rel="stylesheet" />
    <link href="Content/EmployeeStyleSheet.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.6.0.min.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.min.js"></script>
    <script src="scripts/toastr.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
    <style>
        #logincard {
            position: absolute;
            background-color:#fffbfc;
            width: 40%;
            top: 10%;
            left: 30%;
        }

    </style>
</head>
<body>
    <script type="text/javascript">
        function showToastSuccess(msg, contentMessage) {
            toastr.options = {
                "closeButton": true,
                "debug": false,
                "progressBar": true,
                "preventDuplicates": false,
                "positionClass": "toast-top-right",
                "showDuration": "400",
                "hideDuration": "1000",
                "timeOut": "3000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
            toastr.success(msg, contentMessage)
        }

        function showToastError(msg, contentMessage) {
            toastr.options = {
                "closeButton": true,
                "debug": false,
                "progressBar": true,
                "preventDuplicates": false,
                "positionClass": "toast-top-right",
                "showDuration": "400",
                "hideDuration": "1000",
                "timeOut": "3000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }
            toastr.error(msg, contentMessage)
        }
    </script>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" ID="scriptManager" />
    <div class="container-fluid">
        <%-- Login --%>
        <div class="card" id="logincard">
            <asp:Image runat="server" ID="iBannerImage" CssClass="card-img-top" ImageUrl="~/Content/images/MaClare Logo PNG.png" />
            <%-- Body --%>
            <div class="card-body">
                <%-- Username Textbox --%>
                <div class="row m-2">
                    <div class="form-floating">
                        <asp:TextBox runat="server" ID="txtUsername" CssClass="form-control" 
                            AutoCompleteType="Disabled"></asp:TextBox>
                        <label for="<%=txtUsername.ClientID%>" class="ms-2">Username</label>
                    </div>
                    
                </div>
                <%-- Password Textbox --%>
                <div class="row m-2">
                    <div class="form-floating">
                        <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" 
                            AutoCompleteType="Disabled" TextMode="Password"></asp:TextBox>
                        <label for="<%=txtPassword.ClientID%>" class="ms-2">Password</label>
                    </div>
                </div>
                <%-- Login Button --%>
                <div class="row m-2">
                    <div class="col-3 offset-9">
                        <asp:LinkButton runat="server" ID="btnLogin" CssClass="btn btn-green-fill float-end" 
                            OnClick="btnLogin_Click">Login</asp:LinkButton>
                    </div>
                </div>
            </div>
            <%-- Footer --%>
            <div class="card-footer">MaClare Resort System</div>
        </div>
    </div>
    </form>
</body>
</html>
