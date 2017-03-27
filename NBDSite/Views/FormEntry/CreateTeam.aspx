<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateTeam.aspx.cs" Inherits="NBDSite.Views.FormEntry.CreateTeam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Create Team</title>
    <script src="../../jquery-3.1.1.min.js"></script>
    <script src="../../NBD_jquery.js"></script>

    <link rel="stylesheet" href="../../unsemantic-grid-responsive-tablet.css"/>
    <link rel="stylesheet" href="../../style.css"/>

    <link href="../../images/NBD.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../../images/NBD.png" rel="nbd" />
</head>
<body>
    <asp:PlaceHolder ID="PlaceHolder" runat="server" Visible="False">
        <div id="wrapper">
            <form id="form2" runat="server">
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
                    <legend>Create Team</legend>
                    <asp:Label ID="Label1" runat="server" Text="Select a project to create a team for"></asp:Label>
                    <asp:DropDownList ID="ddlProjName" runat="server" AutoPostBack="True" DataSourceID="ODSProject" DataTextField="projName" DataValueField="ID">
                    </asp:DropDownList>
                    <br /><br />
                    <asp:Label ID="Label2" runat="server" Text="Number of Designers needed: "></asp:Label>
                    <asp:DropDownList ID="ddlNumDesigner" runat="server" Height="30px" Width="80px">
                        <asp:ListItem>1</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBoxList ID="cbDesignName" runat="server" DataSourceID="DSDesigner" DataTextField="wrkFull" DataValueField="wrkFull">
                    </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label3" runat="server" Text="Number of Production Workers needed:"></asp:Label>
                    <asp:DropDownList ID="ddlNumProd" runat="server" Height="31px" Width="79px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                    </asp:DropDownList>
                <asp:CheckBoxList ID="cbProdName" runat="server" AutoPostBack="True" DataSourceID="DSProd" DataTextField="wrkFull" DataValueField="wrkFull">
                </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label4" runat="server" Text="Number of Equipment Operators"></asp:Label>
                    <asp:DropDownList ID="ddlNumEqp" runat="server" Height="31px" Width="79px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBoxList ID="cbEqupName" runat="server" DataSourceID="DSEqup" DataTextField="wrkFull" DataValueField="wrkFull">
                    </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label5" runat="server" Text="Number of Botanist"></asp:Label>
                    <asp:DropDownList ID="ddlNumBot" runat="server" Height="31px" Width="79px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="DSBot" DataTextField="wrkFull" DataValueField="wrkFull">
                    </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label6" runat="server" Text="Number of Design Managers"></asp:Label>
                    <asp:DropDownList ID="ddlNumBot0" runat="server" Height="31px" Width="79px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBoxList ID="CheckBoxList2" runat="server" DataSourceID="DSDesignMan" DataTextField="wrkFull" DataValueField="wrkFull">
                    </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label7" runat="server" Text="Number of Production Managers"></asp:Label>
                    <asp:DropDownList ID="ddlNumBot1" runat="server" Height="31px" Width="79px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBoxList ID="CheckBoxList3" runat="server" DataSourceID="DSProdMan" DataTextField="wrkFull" DataValueField="wrkFull">
                    </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label8" runat="server" Text="Number of Sales Associates"></asp:Label>
                    <asp:DropDownList ID="ddlNumBot2" runat="server" Height="31px" Width="79px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBoxList ID="CheckBoxList4" runat="server" DataSourceID="DSSales" DataTextField="wrkFull" DataValueField="wrkFull">
                    </asp:CheckBoxList>
                    <br />
                    <asp:Label ID="Label9" runat="server" Text="Number of Sales &amp; Finanace"></asp:Label>
                    <asp:DropDownList ID="ddlNumBot3" runat="server" Height="31px" Width="79px">
                        <asp:ListItem>1</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CheckBoxList ID="CheckBoxList5" runat="server" DataSourceID="DSSaleFin" DataTextField="wrkFull" DataValueField="wrkFull">
                    </asp:CheckBoxList>
                </fieldset>
                <p>
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </p>
                <p>
                    <asp:Button ID="btnCreateTeam" runat="server" OnClick="btnCreateTeam_Click" Text="Create Team" />
                </p>
                <p>
                    <asp:SqlDataSource ID="DSSaleFin" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName], '  ', [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="8" Name="wrkTypeID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <p>
                    <asp:SqlDataSource ID="DSSales" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName], '  ', [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="7" Name="wrkTypeID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <p>
                    <asp:SqlDataSource ID="DSProdMan" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName], '  ', [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="6" Name="wrkTypeID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <p>
                    <asp:SqlDataSource ID="DSDesignMan" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName], '  ', [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="5" Name="wrkTypeID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <p>
                    <asp:SqlDataSource ID="DSBot" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName], '  ', [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="4" Name="wrkTypeID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <p>
                    <asp:SqlDataSource ID="DSEqup" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName], '  ', [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="3" Name="wrkTypeID" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <p>
                    <asp:SqlDataSource ID="DSProd" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName], '  ', [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="wrkTypeID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="DSDesigner" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CONCAT( [wrkFName],  '  ' , [wrkLName]) AS wrkFull FROM [WORKER] WHERE ([wrkTypeID] = @wrkTypeID)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="2" Name="wrkTypeID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </p>
                <asp:ObjectDataSource ID="ODSProject" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.PROJECTTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_ID" Type="Int32" />
                        <asp:Parameter Name="Original_projName" Type="String" />
                        <asp:Parameter Name="Original_projSite" Type="String" />
                        <asp:Parameter Name="Original_projBidDate" Type="DateTime" />
                        <asp:Parameter Name="Original_projEstStart" Type="String" />
                        <asp:Parameter Name="Original_projEstEnd" Type="String" />
                        <asp:Parameter Name="Original_projActStart" Type="String" />
                        <asp:Parameter Name="Original_projActEnd" Type="String" />
                        <asp:Parameter Name="Original_projEstCost" Type="String" />
                        <asp:Parameter Name="Original_projActCost" Type="String" />
                        <asp:Parameter Name="Original_projBidCustAccept" Type="Boolean" />
                        <asp:Parameter Name="Original_projBidMgmtAccept" Type="Boolean" />
                        <asp:Parameter Name="Original_projCurrentPhase" Type="String" />
                        <asp:Parameter Name="Original_projIsFlagged" Type="Boolean" />
                        <asp:Parameter Name="Original_clientID" Type="Int32" />
                        <asp:Parameter Name="Original_designerID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ID" Type="Int32" />
                        <asp:Parameter Name="projName" Type="String" />
                        <asp:Parameter Name="projSite" Type="String" />
                        <asp:Parameter Name="projBidDate" Type="DateTime" />
                        <asp:Parameter Name="projEstStart" Type="String" />
                        <asp:Parameter Name="projEstEnd" Type="String" />
                        <asp:Parameter Name="projActStart" Type="String" />
                        <asp:Parameter Name="projActEnd" Type="String" />
                        <asp:Parameter Name="projEstCost" Type="String" />
                        <asp:Parameter Name="projActCost" Type="String" />
                        <asp:Parameter Name="projBidCustAccept" Type="Boolean" />
                        <asp:Parameter Name="projBidMgmtAccept" Type="Boolean" />
                        <asp:Parameter Name="projCurrentPhase" Type="String" />
                        <asp:Parameter Name="projIsFlagged" Type="Boolean" />
                        <asp:Parameter Name="clientID" Type="Int32" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="projName" Type="String" />
                        <asp:Parameter Name="projSite" Type="String" />
                        <asp:Parameter Name="projBidDate" Type="DateTime" />
                        <asp:Parameter Name="projEstStart" Type="String" />
                        <asp:Parameter Name="projEstEnd" Type="String" />
                        <asp:Parameter Name="projActStart" Type="String" />
                        <asp:Parameter Name="projActEnd" Type="String" />
                        <asp:Parameter Name="projEstCost" Type="String" />
                        <asp:Parameter Name="projActCost" Type="String" />
                        <asp:Parameter Name="projBidCustAccept" Type="Boolean" />
                        <asp:Parameter Name="projBidMgmtAccept" Type="Boolean" />
                        <asp:Parameter Name="projCurrentPhase" Type="String" />
                        <asp:Parameter Name="projIsFlagged" Type="Boolean" />
                        <asp:Parameter Name="clientID" Type="Int32" />
                        <asp:Parameter Name="Original_ID" Type="Int32" />
                        <asp:Parameter Name="Original_projName" Type="String" />
                        <asp:Parameter Name="Original_projSite" Type="String" />
                        <asp:Parameter Name="Original_projBidDate" Type="DateTime" />
                        <asp:Parameter Name="Original_projEstStart" Type="String" />
                        <asp:Parameter Name="Original_projEstEnd" Type="String" />
                        <asp:Parameter Name="Original_projActStart" Type="String" />
                        <asp:Parameter Name="Original_projActEnd" Type="String" />
                        <asp:Parameter Name="Original_projEstCost" Type="String" />
                        <asp:Parameter Name="Original_projActCost" Type="String" />
                        <asp:Parameter Name="Original_projBidCustAccept" Type="Boolean" />
                        <asp:Parameter Name="Original_projBidMgmtAccept" Type="Boolean" />
                        <asp:Parameter Name="Original_projCurrentPhase" Type="String" />
                        <asp:Parameter Name="Original_projIsFlagged" Type="Boolean" />
                        <asp:Parameter Name="Original_clientID" Type="Int32" />
                        <asp:Parameter Name="Original_designerID" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ODSProd" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.PROD_TEAMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_ID" Type="Int32" />
                        <asp:Parameter Name="Original_projectID" Type="Int32" />
                        <asp:Parameter Name="Original_workerID" Type="Int32" />
                        <asp:Parameter Name="Original_teamPhaseIn" Type="String" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="projectID" Type="Int32" />
                        <asp:Parameter Name="workerID" Type="Int32" />
                        <asp:Parameter Name="teamPhaseIn" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="projectID" Type="Int32" />
                        <asp:Parameter Name="workerID" Type="Int32" />
                        <asp:Parameter Name="teamPhaseIn" Type="String" />
                        <asp:Parameter Name="Original_ID" Type="Int32" />
                        <asp:Parameter Name="Original_projectID" Type="Int32" />
                        <asp:Parameter Name="Original_workerID" Type="Int32" />
                        <asp:Parameter Name="Original_teamPhaseIn" Type="String" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <br />
            </form>
            <footer>
                <small>Copyright © 2016 Natural By Design. All rights reserved. <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
            </footer>
        </div>
    </asp:PlaceHolder>
</body>
</html>