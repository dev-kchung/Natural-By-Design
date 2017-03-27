<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DailyWorkReport.aspx.cs" Inherits="NBDSite.Views.FormEntry.DailyWorkReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Daily Work Report</title>
    <script src="../../jquery-3.1.1.min.js"></script>
    <script src="../../NBD_jquery.js"></script>

    <link rel="stylesheet" href="../../unsemantic-grid-responsive-tablet.css"/>
    <link rel="stylesheet" href="../../style.css"/>
    <style type="text/css">
        .auto-style3 {
            width: 150px;
        }
        .auto-style4 {
            width: 265px;
        }
    </style>
</head>
<body>
     <asp:PlaceHolder ID="PlaceHolder" runat="server" Visible="False">
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
        <br />
    <fieldset>
        <legend>Daily Work Report</legend>
        <table>
                <tr>
                    <td class="auto-style3">Date:</td>
                    <td>
                        <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Project:</td>
                    <td><asp:DropDownList ID="ddlProjectName" runat="server" AppendDataBoundItems="True" DataSourceID="Projects" DataTextField="projName" DataValueField="ID" Width="200px">
                <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
            </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Worker:</td>
                    <td>
            <asp:DropDownList ID="ddlWorkerType" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="WorkType" DataTextField="wrkTypeDesc" DataValueField="ID" OnSelectedIndexChanged="ddlWorkerType_SelectedIndexChanged" Width="200px">
                <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
            </asp:DropDownList>
                    </td>
                </tr>
            </table>
        <br />
        <asp:Panel ID="designer" runat="server">
            <table class="auto-style2">
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Stage"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Task"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="Label3" runat="server" Text="Hours"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:TextBox ID="txtStage" runat="server"></asp:TextBox>
                    </td>
                    <td class="auto-style2">
                        <asp:DropDownList ID="ddlDTask" runat="server" AppendDataBoundItems="True" DataSourceID="Tasks" DataTextField="taskDesc" DataValueField="ID" Width="200px">
                            <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style1">
                        <asp:TextBox ID="txtHours" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="productionWorker" runat="server">
            <table class="auto-style2">
                <tr>
                    <td class="auto-style4">
                        <asp:Label ID="lblMatUsed" runat="server" Font-Bold="True" Text="Materials Used:"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">
                        <asp:Label ID="Label1" runat="server" Text="Code"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label11" runat="server" Text="Qnty"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">
                        <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtQnty" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">
                        <asp:Label ID="lblLabor" runat="server" Font-Bold="True" Text="Labor:"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">
                        <asp:Label ID="Label10" runat="server" Text="Task"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="Hours"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style4">
                        <asp:DropDownList ID="ddlPTask" runat="server" AppendDataBoundItems="True" DataSourceID="Tasks" DataTextField="taskDesc" DataValueField="ID" Width="200px">
                            <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:TextBox ID="txtHours0" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </fieldset>            
        <br />
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        <br />
        <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
        <br />
        <asp:SqlDataSource ID="Projects" runat="server" ConnectionString="Data Source=(LocalDB)\nclocaldb;AttachDbFilename=|DataDirectory|\NBD_SB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ID], [projName] FROM [PROJECT] ORDER BY [projName]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="WorkType" runat="server" ConnectionString="Data Source=(LocalDB)\ncLocalDb;AttachDbFilename=|DataDirectory|\NBD_SB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ID, wrkTypeDesc FROM WORKER_TYPE WHERE (ID = 1) or (ID = 2)"></asp:SqlDataSource>
        <asp:SqlDataSource ID="Tasks" runat="server" ConnectionString="Data Source=(LocalDB)\nclocaldb;AttachDbFilename=|DataDirectory|\NBD_SB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT [ID], [taskDesc] FROM [TASK] ORDER BY [taskDesc]"></asp:SqlDataSource>
    </form>
    <div id="footer">
        <footer>
		    <small>Copyright © 2016 Natural By Design. All rights reserved. <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
	    </footer>
    </div>
    </div>
    </asp:PlaceHolder>
</body>
</html>
