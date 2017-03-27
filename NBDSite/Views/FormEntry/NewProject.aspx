<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewProject.aspx.cs" Inherits="NBDSite.Views.FormEntry.NewProject" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Settings</title>
    <script src="../../jquery-3.1.1.min.js"></script>
    <script src="../../NBD_jquery.js"></script>

    <link rel="stylesheet" href="../../unsemantic-grid-responsive-tablet.css"/>
    <link rel="stylesheet" href="../../style.css"/>

    <link href="../../images/NBD.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../../images/NBD.png" rel="nbd" />
    <style type="text/css">
        .auto-style2 {
            width: 150px;
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
        <br />  
        <div>
            <fieldset id="webform">
                <legend>New Project</legend>
                <table>
                    <tr>
                        <td class="auto-style2">Project ID:</td>
                        <td> <asp:TextBox ID="txtID" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Project Name:
                </td>
                        <td>
                <asp:TextBox ID="txtProjectName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Project Site:</td>
                        <td>
                <asp:TextBox ID="txtProjectSite" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Project Bid Date:
                </td>
                        <td>
                <asp:TextBox ID="txtProjBidDate" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">Client:
                </td>
                        <td>
                <asp:DropDownList ID="ddlClient" runat="server" AppendDataBoundItems="True" DataSourceID="ObjectDataSource1" DataTextField="cliName" DataValueField="ID">
                    <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        
            
        <p>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </p>
        <p>
            <asp:Button ID="btnCreateProj" runat="server" OnClick="btnCreateProj_Click" Text="Create Project" />
        </p>
        <p>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.CLIENTTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_ID" Type="Int32" />
                    <asp:Parameter Name="Original_cliName" Type="String" />
                    <asp:Parameter Name="Original_cliAddress" Type="String" />
                    <asp:Parameter Name="Original_cityID" Type="Int32" />
                    <asp:Parameter Name="Original_cliProvince" Type="String" />
                    <asp:Parameter Name="Original_cliPCode" Type="String" />
                    <asp:Parameter Name="Original_cliPhone" Type="String" />
                    <asp:Parameter Name="Original_cliConFName" Type="String" />
                    <asp:Parameter Name="Original_cliConLName" Type="String" />
                    <asp:Parameter Name="Original_cliConPosition" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="cliName" Type="String" />
                    <asp:Parameter Name="cliAddress" Type="String" />
                    <asp:Parameter Name="cityID" Type="Int32" />
                    <asp:Parameter Name="cliProvince" Type="String" />
                    <asp:Parameter Name="cliPCode" Type="String" />
                    <asp:Parameter Name="cliPhone" Type="String" />
                    <asp:Parameter Name="cliConFName" Type="String" />
                    <asp:Parameter Name="cliConLName" Type="String" />
                    <asp:Parameter Name="cliConPosition" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="cliName" Type="String" />
                    <asp:Parameter Name="cliAddress" Type="String" />
                    <asp:Parameter Name="cityID" Type="Int32" />
                    <asp:Parameter Name="cliProvince" Type="String" />
                    <asp:Parameter Name="cliPCode" Type="String" />
                    <asp:Parameter Name="cliPhone" Type="String" />
                    <asp:Parameter Name="cliConFName" Type="String" />
                    <asp:Parameter Name="cliConLName" Type="String" />
                    <asp:Parameter Name="cliConPosition" Type="String" />
                    <asp:Parameter Name="Original_ID" Type="Int32" />
                    <asp:Parameter Name="Original_cliName" Type="String" />
                    <asp:Parameter Name="Original_cliAddress" Type="String" />
                    <asp:Parameter Name="Original_cityID" Type="Int32" />
                    <asp:Parameter Name="Original_cliProvince" Type="String" />
                    <asp:Parameter Name="Original_cliPCode" Type="String" />
                    <asp:Parameter Name="Original_cliPhone" Type="String" />
                    <asp:Parameter Name="Original_cliConFName" Type="String" />
                    <asp:Parameter Name="Original_cliConLName" Type="String" />
                    <asp:Parameter Name="Original_cliConPosition" Type="String" />
                </UpdateParameters>
            </asp:ObjectDataSource>
        </p>
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
