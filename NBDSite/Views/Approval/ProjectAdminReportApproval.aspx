<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectAdminReportApproval.aspx.cs" Inherits="NBDSite.Views.Approval.ProjectAdminReportApproval" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design</title>
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
        <h1>Project Administrative Report</h1>
        <fieldset>
            <legend>Bid Stage Projects</legend>
            <table>
                <tr>
                    <th class="auto-style2">Project</th>
                    <th class="auto-style2">Est. Bid</th>
                    <th class="auto-style2">Actual/Est Design Hrs</th>
                    <th class="auto-style2">Actual/Est Design Costs</th>
                    <th class="auto-style2">Hrs/$ Remaining</th>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtBidProject1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidEstBid1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidActEstDesignH1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidActEstDesignC1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidHCRemaining1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtBidProject2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidEstBid2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidActEstDesignH2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidActEstDesignC2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidHCRemaining2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtBidProject3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidEstBid3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidActEstDesignH3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidActEstDesignC3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtBidHCRemaining3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset>
            <legend>Production Stage Projects</legend>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style3">Project</td>
                    <td class="auto-style3">Bid $</td>
                    <td class="auto-style3">Prod. Plan Est.</td>
                    <td class="auto-style3">Total Cost to Date</td>
                    <td class="auto-style3">Actual Mtl $</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtProdProject1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdC1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdProdPlanEst1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdTotalCost1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActMat1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtProdProject2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdC2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdProdPlanEst2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdTotalCost2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActMat2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtProdProject3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdC3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdProdPlanEst3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdTotalCost3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActMat3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style3">Est. Mtl $</td>
                    <td class="auto-style3">Actual Labor $ Prod</td>
                    <td class="auto-style3">Est. Labor $ Prod</td>
                    <td class="auto-style3">Actual Labor $ Design</td>
                    <td class="auto-style3">Est. Labor $ Design</td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtProdEstMat1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActLabor1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdEstLabor1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActDesign1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdEstDesign1" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtProdEstMat2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActLabor2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdEstLabor2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActDesign2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdEstDesign2" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:TextBox ID="txtProdEstMat3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActLabor3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdEstLabor3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdActDesign3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                    <td>
                        <asp:TextBox ID="txtProdEstDesign3" runat="server" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br /><br />
        <asp:CheckBox ID="chkApproved" runat="server" Text="Approved by Manager" AutoPostBack="True" OnCheckedChanged="chkApproved_CheckedChanged" />
        <asp:CheckBox ID="chkUnapproved" runat="server" Text="Unapproved" AutoPostBack="True" OnCheckedChanged="chkUnapproved_CheckedChanged" />
        <br />
        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        <br />
    </div>
    <footer>
		<small>Copyright © 2016 Natural By Design. All rights reserved. <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
	</footer>
    </form>
    </div>
    </asp:PlaceHolder>
</body>
</html>
