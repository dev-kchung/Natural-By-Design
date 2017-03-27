<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClientEntry.aspx.cs" Inherits="NBDSite.ClientEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | New Client</title>
    <%--<script>
        function removeFirst()
        {
            var select = document.getElementById('<%= ddlCities.ClientID %>');

            for (i = 0; i < select.length; i++)
            {
                if (select.options[i].value == '-1')
                {
                    select.remove(i);
                }
            }
            select.removeAttribute('onClick');   
        }
    </script>--%>
    <script src="../../jquery-3.1.1.min.js"></script>
    <script src="../../NBD_jquery.js"></script>

    <link rel="stylesheet" href="../../unsemantic-grid-responsive-tablet.css"/>
    <link rel="stylesheet" href="../../style.css"/>

    <link href="../../images/NBD.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../../images/NBD.png" rel="nbd" />
    <style type="text/css">
        .auto-style1 {
            height: 46px;
        }
        .auto-style2 {
            width: 175px;
        }
        .auto-style3 {
            height: 46px;
            width: 175px;
        }
    </style>
</head>
<body>
<asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="False">
    <div id="wrapper">
    <form id="form1" runat="server">
    <div>
        <div>
            <div class="go-left">
                <asp:HyperLink ID="NBDHome" runat="server" NavigateUrl="~/Views/Home.aspx">
                    <img alt="NBD" src="../../images/NBD_Logo.png" width="175"/>
                </asp:HyperLink>
            </div>
            <div class="go-right outter" style="text-align: right">
                <asp:Label ID="lblWelcome" runat="server" Text="Welcome, "></asp:Label>
                <asp:Button ID="btnLogout" runat="server" OnClick="btnLogout_Click" Text="Logout"/>
                <br />
                <div class="inner">
                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                </div>
                
            </div>
        </div>
        <div class="clear-me">
            <nav class="center-me">
                <asp:HyperLink ID="hlHome" runat="server" NavigateUrl="~/Views/Home.aspx">Home</asp:HyperLink>
                <a href="#" class="toggle-me">New Form</a>
                <asp:HyperLink ID="hlNewProject" runat="server" NavigateUrl="~/Views/FormEntry/NewProject.aspx">New Project</asp:HyperLink>
                <asp:HyperLink ID="hlClients" runat="server" NavigateUrl="~/Views/Clients.aspx">Clients</asp:HyperLink>
                <asp:HyperLink ID="hlFeedback" runat="server" NavigateUrl="~/Views/Feedback.aspx">Feedback</asp:HyperLink>
            </nav>
            <div class="panel center-me">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Views/FormEntry/ClientEntry.aspx">New Client</asp:HyperLink>
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Views/FormEntry/NewProject.aspx">New Project</asp:HyperLink>
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Views/FormEntry/DesignBid.aspx">Design Bid</asp:HyperLink>
                <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Views/FormEntry/DesignBudget.aspx">Design Budget</asp:HyperLink>
                <asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="~/Views/FormEntry/CreateTeam.aspx">Create Team</asp:HyperLink>
                <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/Views/FormEntry/ProductionPlan.aspx">Production Plan</asp:HyperLink>
                <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/Views/FormEntry/DailyWorkReport.aspx">Daily Work Report</asp:HyperLink>
                <asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="~/Views/FormEntry/ProjectAdminReport.aspx">Project Admin Report</asp:HyperLink>
            </div>
        </div>
    </div>
        <div>
        <h1>Client Entry</h1>
        <fieldset>
            <legend>General Information</legend>
            <table>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lblName" runat="server" Text="Name:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtName" runat="server" Width="225px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtName"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lblAddress" runat="server" Text="Address:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtAddress" runat="server" Width="225px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lblCity" runat="server" Text="City"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlCities" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCities_SelectedIndexChanged" AppendDataBoundItems="True" DataSourceID="odsCities" DataTextField="city" DataValueField="ID">
                        <asp:ListItem Selected="True" Value="-1">Select a city...</asp:ListItem>
                        <asp:ListItem Value="-2">+ NEW CITY</asp:ListItem>
                    </asp:DropDownList>
                    &nbsp;<asp:Label ID="lblEnterCity" runat="server" Text="Enter city:" Visible="False"></asp:Label>
                    <asp:TextBox ID="txtCities" runat="server" Visible="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lblProvince0" runat="server" Text="Province:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlProvinces" runat="server">
                        <asp:ListItem Selected="True" Value="-1">Select a province...</asp:ListItem>
                        <asp:ListItem>British Columbia</asp:ListItem>
                        <asp:ListItem>Alberta</asp:ListItem>
                        <asp:ListItem>Sasaktchewan</asp:ListItem>
                        <asp:ListItem>Manitoba</asp:ListItem>
                        <asp:ListItem>Ontario</asp:ListItem>
                        <asp:ListItem>Quebec</asp:ListItem>
                        <asp:ListItem>Newfoundland</asp:ListItem>
                        <asp:ListItem>Prince Edward Island</asp:ListItem>
                        <asp:ListItem>New Brunswick</asp:ListItem>
                        <asp:ListItem>Nova Scotia</asp:ListItem>
                        <asp:ListItem>Yukon</asp:ListItem>
                        <asp:ListItem>Northwest Territories</asp:ListItem>
                        <asp:ListItem>Nunavut</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="lblPostal" runat="server" Text="Postal Code:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPostal" runat="server" Width="225px" placeholder =" X1X1X1"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtPostal" ErrorMessage="* Postal Code must be 6 valid characters long (i.e. L2E7B5)" ForeColor="Red" ValidationExpression="[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]|^$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="lblPhone" runat="server" Text="Phone:"></asp:Label>
                </td>
                <td class="auto-style1">
                    <asp:TextBox ID="txtPhone" runat="server" Width="225px" placeholder ="1231231234"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtPhone"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Phone # must be 10 digits (i.e. 1234567890)" ForeColor="Red" ValidationExpression="^\d{10}$" ControlToValidate="txtPhone"></asp:RegularExpressionValidator>
                </td>
            </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <legend>Client Contact Information</legend>
            <table>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblFirst" runat="server" Text="First Name:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtFirst" runat="server" Width="225px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtFirst"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblLast" runat="server" Text="Last Name:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtLast" runat="server" Width="225px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Required" ForeColor="Red" ControlToValidate="txtLast"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lblPosition" runat="server" Text="Position:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPosition" runat="server" Width="225px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
    
    </div>
    <footer>
		<small>Copyright © 2016 Natural By Design. All rights reserved. <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
	</footer>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <asp:ObjectDataSource ID="odsCities" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.CITYTableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_ID" Type="Int32" />
                <asp:Parameter Name="Original_city" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="city" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="city" Type="String" />
                <asp:Parameter Name="Original_ID" Type="Int32" />
                <asp:Parameter Name="Original_city" Type="String" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    </form>
    </div>
</asp:PlaceHolder>
</body>
</html>
