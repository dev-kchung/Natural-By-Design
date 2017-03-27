<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="NBDSite.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Login</title>

    <link rel="stylesheet" href="../../style.css" />
    <link href="https://fonts.googleapis.com/css?family=Cabin" rel="stylesheet" />

    <link href="../../images/NBD.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../../images/NBD.png" rel="nbd" />
</head>
<body>
    <div id="wrapper" class="center-me">
    <div id="logo">
        <img alt="NBD" src="../../images/NBD_Logo.png" />
    </div>
    <div>
    <form id="form1" runat="server">
        <fieldset id="login">
            <legend>Login</legend>

            <asp:Label ID="lblUser" runat="server" Text="Username:"></asp:Label>
            <asp:TextBox ID="txtUser" runat="server"></asp:TextBox>
            <asp:Label ID="lblPass" runat="server" Text="Password:"></asp:Label>
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox>
            
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"/>

            <hr />

            <p>New to Natural By Design?</p>

            <asp:Button ID="btnRegister" runat="server" Text="Register User" OnClick="btnRegister_Click"/>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </fieldset>
    </form>
    </div>
        <div id="footer">
        <footer>
		   <small>Copyright © 2016 Natural By Design. All rights reserved.<br /><a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
        </footer>
        </div>
    </div>
</body>
</html>
