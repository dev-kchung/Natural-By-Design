<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clients.aspx.cs" Inherits="NBDSite.Clients" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Clients</title>
    <script src="../../jquery-3.1.1.min.js"></script>
    <script src="../../NBD_jquery.js"></script>

    <link rel="stylesheet" href="../../unsemantic-grid-responsive-tablet.css"/>
    <link rel="stylesheet" href="../../style.css"/>

    <link href="../../images/NBD.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../../images/NBD.png" rel="nbd" />
</head>
<body>
<asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible="False">
    <div id="wrapper">
    <div class="clear-me">
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
    <div id="projects">
        <div class="grid-100 grid-parent">
        <p>
            <asp:HyperLink ID="hlNewClient" runat="server" NavigateUrl="~/Views/FormEntry/ClientEntry.aspx" style="border:1px solid black;padding:7px 9px 7px 9px; margin-right:20px" Font-Underline="False" ForeColor="Black">+ New Client</asp:HyperLink>
            <asp:LinkButton ID="lbClientSearch" runat="server" style="border:1px solid black;padding:7px 9px 7px 9px;text-decoration:none" ForeColor="Black" OnClick="lbClientSearch_Click">Search Clients</asp:LinkButton>
        </p>
        </div>
        <div class="grid-50 grid-parent">
        <h1>Clients</h1>
        <asp:Panel ID="pnSearch" runat="server" Visible="False">
            <table>
                <tr>
                    <th style="text-align:left;border:none;padding-bottom:5px">Search By...</th>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblName" runat="server" Text="Name:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                    <td>
                        <asp:Label ID="lblAddress" runat="server" Text="Address: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCity" runat="server" Text="City:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlCities" runat="server" DataSourceID="odsCities" DataTextField="city" DataValueField="ID" AppendDataBoundItems="True">
                            <asp:ListItem Selected="True" Value="-1">Select a city...</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td></td>
                    <td>
                        <asp:Label ID="lblPhone" runat="server" Text="Phone:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblProvince" runat="server" Text="Province:"></asp:Label>
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
                    <td></td>
                    <td>
                        <asp:Label ID="lblContact" runat="server" Text="Contact:"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlContacts" runat="server" AppendDataBoundItems="True" DataSourceID="odsContacts" DataTextField="Full Name" DataValueField="Full Name">
                            <asp:ListItem Selected="True" Value="-1">Select contact...</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
            <asp:Button ID="btnClear" runat="server" OnClick="btnClear_Click" style="margin-left:20px" Text="Clear" />
            <br />
            <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <br />
                    <asp:ListBox ID="lbSearchResults" runat="server" AutoPostBack="True" Height="100px" OnSelectedIndexChanged="lbSearchResults_SelectedIndexChanged" Width="300px"></asp:ListBox>
        <br />
            <br />
        </asp:Panel>
        
        <div id="client">
            <asp:DetailsView ID="dvClients" runat="server" AllowPaging="True" AutoGenerateRows="False" BackColor="#CCCCCC" BorderColor="Green" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" DataKeyNames="ID" DataSourceID="odsClients" ForeColor="Black" Height="50px" Width="300px" style="float:left; margin-right:20px" OnPageIndexChanging="dvClients_PageIndexChanging">
                <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <Fields>
                    <asp:BoundField DataField="cliName" HeaderText="Name" SortExpression="cliName" />
                    <asp:BoundField DataField="cliAddress" HeaderText="Address" SortExpression="cliAddress" />
                    <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
                    <asp:BoundField DataField="cliProvince" HeaderText="Province" SortExpression="cliProvince" />
                    <asp:BoundField DataField="cliPCode" HeaderText="Postal Code" SortExpression="cliPCode" />
                    <asp:BoundField DataField="cliPhone" HeaderText="Phone Number" SortExpression="cliPhone" />
                    <asp:BoundField DataField="ContactName" HeaderText="Contact Name" ReadOnly="True" SortExpression="ContactName" />
                    <asp:BoundField DataField="cliConPosition" HeaderText="Contact Position" SortExpression="cliConPosition" />
                </Fields>
                <FooterStyle BackColor="LightGreen" />
                <HeaderStyle BackColor="Green" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="LightGreen" ForeColor="DarkGreen" HorizontalAlign="Left" />
                <RowStyle BackColor="White" />
            </asp:DetailsView>
        </div>
        </div>
            <div id="designBids" class="grid-50 grid-parent">
                <asp:Label ID="lblDesignBid" runat="server" Text="Design Bids" Font-Bold="True"></asp:Label>
                <br />
                <br />
                <asp:PlaceHolder ID="phClientBids" runat="server"></asp:PlaceHolder>
            </div>
        
        <asp:ObjectDataSource ID="odsClients" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.CLIENTWITHCITYTableAdapter"></asp:ObjectDataSource>
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
        <asp:ObjectDataSource ID="odsContacts" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.ContactsTableAdapter"></asp:ObjectDataSource>
        </div>
        </form>
        </div>
        <footer class="grid-100">
		    <small>Copyright © 2016 Natural By Design. All rights reserved. <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
	    </footer>  
        </div>
</asp:PlaceHolder>
</body>
</html>
