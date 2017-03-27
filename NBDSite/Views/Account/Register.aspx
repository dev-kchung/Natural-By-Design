<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="NBDSite.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Register</title>

    <link rel="stylesheet" href="../../style.css"/>

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
                    <legend>Register New User</legend>
                    <asp:Label ID="lblFirst" runat="server" Text="First Name:"></asp:Label>
                    <asp:TextBox ID="txtFirst" runat="server"></asp:TextBox>

                    <asp:Label ID="lblLast" runat="server" Text="Last Name:"></asp:Label>
                    <asp:TextBox ID="txtLast" runat="server"></asp:TextBox>

                    <asp:Label ID="lblWorkerType" runat="server" Text="Type of Worker:"></asp:Label>
                    <asp:DropDownList ID="ddlWorkerType" class="ddl" runat="server" AppendDataBoundItems="True" DataSourceID="odsWorkerType" DataTextField="wrkTypeDesc" DataValueField="ID">
                        <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                    </asp:DropDownList>
                    
                    <asp:Label ID="lblUsername" runat="server" Text="Username:"></asp:Label>
                    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>

                    <asp:Label ID="lblPassword" runat="server" Text="Password:"></asp:Label>
                    &nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="* Password must be at least 6 characters" ForeColor="Red" ControlToValidate="txtPassword" ValidationExpression="^[a-zA-Z0-9]{6,}$"></asp:RegularExpressionValidator>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <br />
                    <asp:Label ID="lblConfirm" runat="server" Text="Confirm:"></asp:Label>
                    &nbsp;<asp:CompareValidator ID="cvPassword" runat="server" ErrorMessage="* Passwords must match" ControlToCompare="txtPassword" ControlToValidate="txtConfirm" ForeColor="red"></asp:CompareValidator>
                    
                    <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password"></asp:TextBox>
                    
                    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" />
                    
                    <hr />

                    <p>Already registered?</p>
                    
                    <asp:Button ID="btnLogin" runat="server" Text="Back to Login" OnClick="btnLogin_Click" />
                    
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                </fieldset>
            </form>
        </div>
    <footer>
		<small>Copyright © 2016 NATURALBYDESIGN.COM. All rights reserved.<br /><a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
	</footer>
    </div>
    <asp:ObjectDataSource ID="odsWorkerType" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.WORKER_TYPETableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_ID" Type="Int32" />
            <asp:Parameter Name="Original_wrkTypeDesc" Type="String" />
            <asp:Parameter Name="Original_wrkTypePrice" Type="Decimal" />
            <asp:Parameter Name="Original_wrkTypeCost" Type="Decimal" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="wrkTypeDesc" Type="String" />
            <asp:Parameter Name="wrkTypePrice" Type="Decimal" />
            <asp:Parameter Name="wrkTypeCost" Type="Decimal" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="wrkTypeDesc" Type="String" />
            <asp:Parameter Name="wrkTypePrice" Type="Decimal" />
            <asp:Parameter Name="wrkTypeCost" Type="Decimal" />
            <asp:Parameter Name="Original_ID" Type="Int32" />
            <asp:Parameter Name="Original_wrkTypeDesc" Type="String" />
            <asp:Parameter Name="Original_wrkTypePrice" Type="Decimal" />
            <asp:Parameter Name="Original_wrkTypeCost" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</body>
</html>
