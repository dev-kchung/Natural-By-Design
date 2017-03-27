<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="NBDSite.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Home</title>
    <script src="../../jquery-3.1.1.min.js"></script>
    <script src="../../NBD_jquery.js"></script>

    <link rel="stylesheet" href="../../unsemantic-grid-responsive-tablet.css"/>
    <link rel="stylesheet" href="../../style.css"/>

    <link href="../../images/NBD.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../../images/NBD.png" rel="nbd" />
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 500px;
        }
        .auto-style3 {
            width: 51%;
            height: 204px;
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
    <div id="projects">
        <h1>Current Projects</h1>
        
        <table class="auto-style1">
            <tr>
                <td class="auto-style2">
                    <fieldset style="width:490px; height:300px">
                        <%--<legend>Current Projects</legend>--%>
                        <asp:Panel ID="pProject" runat="server" Width="313px">
                            <h2><asp:Label ID="lblProject" runat="server"></asp:Label></h2>
                            <p style="text-align:left"><asp:Label ID="lblStart" runat="server" Text="Start: "></asp:Label></p>
                            <p style="text-align:left"><asp:Label ID="lblEnd" runat="server" Text="End: "></asp:Label></p>
                            <p style="text-align:left"><asp:Label ID="lblBudget" runat="server" Text=""></asp:Label></p>
                            <p style="text-align:left"><asp:Label ID="lblTeam" runat="server" Text=""></asp:Label></p>
                            <br />
                        </asp:Panel>
                    </fieldset>
                        
                </td>
                <td>
                    <fieldset style="width:490px;margin-left:10px; height:300px">
                        <%--<legend>Notifications</legend>--%>
                        <%--THIS IS CODE I ADDED IN --%>
                    <asp:PlaceHolder ID="PHLiveProject" runat="server" Visible="false">
                    <div id="project2">
                        <div id="p2">
                            <asp:Panel ID="pProject2" runat="server">
                                <h2>LS Mall</h2>
                                <p style="text-align:left">Start: 11/2/2016</p>
                                <p style="text-align:left">End: TBA</p>
                                <p style="text-align:left">Budget: 36% Used</p>
                                <p style="text-align:left">Team: 7 workers in project team</p>
                                <br />
                            </asp:Panel>
                        </div>
                    </div>
                        </asp:PlaceHolder>
                    <asp:PlaceHolder ID="PHApprovalPAR" runat="server" Visible="false">
                        <div id="p3">
                            <asp:Panel ID="pPARApproval" runat="server">
                                <h2>Notifications</h2>
                                <p style="color:red">5 Days until you must submit a PAR</p>
                                <p style="color:red">Molly's Salon is over budget</p>
                                <br />
                            </asp:Panel>
                        </div>
                    </asp:PlaceHolder>
                            <asp:PlaceHolder ID="PHApprovedPAR" runat="server" Visible="false">
                        <div id="p4">
                            <asp:Panel ID="Panel1" runat="server">
                                <h2>Notifications</h2>
                                <asp:HyperLink ID="hlPAR" runat="server" ForeColor="Red" NavigateUrl="~/Views/Approval/ProjectAdminReportApproval.aspx">1 NEW PROJECT ADMINISTRATION REPORT - APPROVAL NEEDED</asp:HyperLink>
                                <p style="color:red">Molly's Salon is over budget</p>
                                <br />
                            </asp:Panel>
                        </div>
                    </asp:PlaceHolder>
                            <asp:PlaceHolder ID="PHDesignApproval" runat="server" Visible="false">
                        <div id="p5">
                            <asp:Panel ID="Panel2" runat="server">
                                <h2>Notifications</h2>
                                <asp:HyperLink ID="hlDesignBid" runat="server" ForeColor="Red" NavigateUrl="~/Views/Approval/DesignBidApproval.aspx">1 Design bid - APPROVAL NEEDED</asp:HyperLink>
                                <br />
                                <asp:HyperLink ID="HyperLink9" runat="server" ForeColor="Red" NavigateUrl="~/Views/Approval/ProductionPlanApproval.aspx">1 Production Plan - APPROVAL NEEDED</asp:HyperLink>
                                <p style="color:red">Molly's Salon is over budget</p>
                                <br />
                            </asp:Panel>
                        </div>
                    </asp:PlaceHolder>
                 <%--   THE END OF THE CODE I ADDED--%>
                    </fieldset>
                    
                </td>
            </tr>
            </table>        
    </div>
    <div id="footer">
        <footer>
		    <small>Copyright © 2016 Natural By Design. All rights reserved. <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
	    </footer>
    </div>
    </form>
    
    </div>
</asp:PlaceHolder>
</body>
</html>
