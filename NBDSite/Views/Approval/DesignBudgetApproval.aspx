<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DesignBudgetApproval.aspx.cs" Inherits="NBDSite.Views.Approval.DesignBudgetApproval" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Design Budget Approval</title>
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
            <h1>Design Budget Approval</h1>
            <fieldset>
                <legend>Client</legend>
                    <table class="auto-style19">
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label32" runat="server" Text="Client Name:"></asp:Label>
                            </td>
                            <td class="auto-style20"><strong>
                                <asp:DropDownList ID="ddlClientInfo" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="ObjectDataSource1" DataTextField="cliName" DataValueField="ID" OnSelectedIndexChanged="ddlClientInfo_SelectedIndexChanged" Width="230px">
                                    <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                                </asp:DropDownList>
                                </strong></td>
                            <td class="auto-style15">
                                <asp:Label ID="Label35" runat="server" Text="Phone:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtClientPhone" runat="server" Width="225px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label34" runat="server" Text="Client Address:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtClientAdd" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:Label ID="Label43" runat="server" Text="Contact Date:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtContactDate" runat="server" Width="225px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label33" runat="server" Text="Contact:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtContact" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
            </fieldset>
            <br />
            <fieldset>
                <legend>NBD Staff</legend>
                <table class="auto-style19">
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="Label36" runat="server" Text="Sales Assoc:"></asp:Label>
                        </td>
                        <td class="auto-style20">
                        <asp:DropDownList ID="ddlSalesAssoc" runat="server" AppendDataBoundItems="True" DataSourceID="SalesAssoc" DataTextField="wrkFull" DataValueField="ID" Width="225px">
                            <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                        </asp:DropDownList>
                        </td>
                        <td class="auto-style15">
                            <asp:Label ID="Label9" runat="server" Text="Phone:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSalesPhone" runat="server" Width="225px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="Label37" runat="server" Text="Designer:"></asp:Label>
                        </td>
                        <td class="auto-style20">
                        <asp:DropDownList ID="ddlDesigner" runat="server" AppendDataBoundItems="True" DataSourceID="Designer" DataTextField="wrkFull" DataValueField="ID" Width="225px">
                            <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                        </asp:DropDownList>
                        </td>
                        <td class="auto-style15">
                            <asp:Label ID="Label11" runat="server" Text="Phone:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDesignPhone" runat="server" Width="225px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <fieldset>
                <legend>Project</legend>
                <table class="auto-style19">
                    <tr>
                        <td class="auto-style4">Project Name:</td>
                        <td class="auto-style20"><strong>
                            <asp:DropDownList ID="ddlProjectInfo" runat="server" AppendDataBoundItem="True" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="ODSProject" DataTextField="projName" DataValueField="ID" OnSelectedIndexChanged="ddlProjectInfo_SelectedIndexChanged" Width="230px">
                                <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                            </asp:DropDownList>
                            </strong></td>
                        <td class="auto-style23">
                            <asp:Label ID="Label38" runat="server" Text="Budget Submitted:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBudSub" runat="server" Width="225px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style8">
                            <asp:Label ID="Label40" runat="server" Text="Est. Begin Date:"></asp:Label>
                        </td>
                        <td class="auto-style9">
                            <asp:TextBox ID="txtBeginDate" runat="server" Width="225px"></asp:TextBox>
                        </td>
                        <td class="auto-style22">
                            <asp:Label ID="Label39" runat="server" Text="Project Site:"></asp:Label>
                        </td>
                        <td class="auto-style10">
                            <asp:TextBox ID="txtProjSite" runat="server" Width="225px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:Label ID="Label42" runat="server" Text="Est. Compl. Date:"></asp:Label>
                        </td>
                        <td class="auto-style20">
                            <asp:TextBox ID="txtComplDate" runat="server" Width="225px"></asp:TextBox>
                        </td>
                        <td class="auto-style23">
                            <asp:Label ID="Label41" runat="server" Text="Bid Amount:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBidAmount" runat="server" Width="225px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
             <fieldset>
                <legend>Design Budget</legend>
                <table class="auto-style2">
                    <tr>
                        <td class="auto-style15">&nbsp;</td>
                        <td class="auto-style3">&nbsp;</td>
                        <td class="auto-style6">
                            <asp:Label ID="Label26" runat="server" Text="Task"></asp:Label>
                        </td>
                        <td class="auto-style7">
                            <asp:Label ID="Label27" runat="server" Text="Date"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="Label28" runat="server" Text="Hours"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style15">&nbsp;</td>
                        <td class="auto-style3">
                            <asp:Label ID="Label29" runat="server" Text="Hours To Date"></asp:Label>
                        </td>
                        <td class="auto-style6">&nbsp;</td>
                        <td class="auto-style7">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style15">&nbsp;</td>
                        <td class="auto-style3">&nbsp;</td>
                        <td class="auto-style6">
                            <asp:TextBox ID="txtHTDTask" runat="server" Width="225px"></asp:TextBox>
                        </td>
                        <td class="auto-style7">
                            <asp:TextBox ID="txtHTDDate" runat="server" Width="125px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtHTDHours" runat="server" Width="50px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style15">&nbsp;</td>
                        <td class="auto-style3">
                            <asp:Label ID="Label30" runat="server" Text="Estimated Hours"></asp:Label>
                        </td>
                        <td class="auto-style6">&nbsp;</td>
                        <td class="auto-style7">&nbsp;</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style15">&nbsp;</td>
                        <td class="auto-style3">&nbsp;</td>
                        <td class="auto-style6">
                            <asp:TextBox ID="txtEHTask" runat="server" Width="225px"></asp:TextBox>
                        </td>
                        <td class="auto-style7">
                            <asp:TextBox ID="txtEHDate" runat="server" Width="125px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEHHours" runat="server" Width="50px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style15">&nbsp;</td>
                        <td class="auto-style3">
                            <asp:Label ID="Label31" runat="server" Text="Total Hours"></asp:Label>
                        </td>
                        <td class="auto-style6">&nbsp;</td>
                        <td class="auto-style7">&nbsp;</td>
                        <td>
                            <asp:TextBox ID="txtTotalHours" runat="server" Width="50px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br /><br />
            <asp:CheckBox ID="chkApproved" runat="server" Text="Approved" />
            &nbsp;<asp:CheckBox ID="chkUnapproved" runat="server" Text="Unapproved" />
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
        </div>
    </form>
        </div>
</asp:PlaceHolder>
</body>
</html>
