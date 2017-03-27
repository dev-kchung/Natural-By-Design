<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DesignBudget.aspx.cs" Inherits="NBDSite.DesignBudget" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Design Budget</title>
    <script src="../../jquery-3.1.1.min.js"></script>
    <script src="../../NBD_jquery.js"></script>

    <link rel="stylesheet" href="../../unsemantic-grid-responsive-tablet.css"/>
    <link rel="stylesheet" href="../../style.css"/>

    <link href="../../images/NBD.ico" rel="shortcut icon" type="image/x-icon" />
    <link href="../../images/NBD.png" rel="nbd" />
    <style type="text/css">
        .auto-style1 {
            width: 149px;
        }
        .auto-style2 {
            width: 956px;
        }
        .auto-style3 {
            width: 158px;
        }
        .auto-style4 {
            width: 157px;
        }
        .auto-style6 {
            width: 309px;
        }
        .auto-style7 {
            width: 310px;
        }
        .auto-style8 {
            width: 315px;
        }
        .auto-style9 {
            width: 120px;
        }
        .auto-style10 {
            width: 84px;
        }
        .auto-style11 {
            width: 130px;
        }
        .auto-style12 {
            width: 238px;
        }
        .auto-style13 {
            width: 115px;
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
            <h1>Design Budget</h1>
            <fieldset>
                <legend>Client</legend>
                    <table class="auto-style19">
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label32" runat="server" Text="Client Name:"></asp:Label>
                            </td>
                            <td class="auto-style8"><strong>
                                <asp:DropDownList ID="ddlClientInfo" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="ObjectDataSource1" DataTextField="cliName" DataValueField="ID" OnSelectedIndexChanged="ddlClientInfo_SelectedIndexChanged" Width="230px">
                                    <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                                </asp:DropDownList>
                                </strong></td>
                            <td class="auto-style9">
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
                            <td class="auto-style8">
                                <asp:TextBox ID="txtClientAdd" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style9">
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
                            <td class="auto-style8">
                                <asp:TextBox ID="txtContact" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style9">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
            </fieldset>
            <br />
            <fieldset>
                <legend>NBD Staff</legend>
                <table class="auto-style19">
                    <tr>
                        <td class="auto-style1">
                            <asp:Label ID="Label36" runat="server" Text="Sales Assoc:"></asp:Label>
                        </td>
                        <td class="auto-style8">
                        <asp:DropDownList ID="ddlSalesAssoc" runat="server" AppendDataBoundItems="True" DataSourceID="SalesAssoc" DataTextField="wrkFull" DataValueField="ID" Width="225px">
                            <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                        </asp:DropDownList>
                        </td>
                        <td class="auto-style9">
                            <asp:Label ID="Label9" runat="server" Text="Phone:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSalesPhone" runat="server" Width="225px" placeholder ="(123) 123-1234"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:Label ID="Label37" runat="server" Text="Designer:"></asp:Label>
                        </td>
                        <td class="auto-style8">
                        <asp:DropDownList ID="ddlDesigner" runat="server" AppendDataBoundItems="True" DataSourceID="Designer" DataTextField="wrkFull" DataValueField="ID" Width="225px">
                            <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                        </asp:DropDownList>
                        </td>
                        <td class="auto-style9">
                            <asp:Label ID="Label11" runat="server" Text="Phone:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDesignPhone" runat="server" Width="225px" placeholder="(123) 123-1234"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <fieldset>
                <legend>Project</legend>
                <table class="auto-style19">
                    <tr>
                        <td class="auto-style13">Project Name:</td>
                        <td class="auto-style12"><strong>
                            <asp:DropDownList ID="ddlProjectInfo" runat="server" AppendDataBoundItem="True" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="ODSProject" DataTextField="projName" DataValueField="ID" OnSelectedIndexChanged="ddlProjectInfo_SelectedIndexChanged" Width="230px">
                                <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                            </asp:DropDownList>
                            </strong></td>
                        <td class="auto-style11">
                            <asp:Label ID="Label38" runat="server" Text="Budget Submitted:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtBudSub" runat="server" Width="225px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style13">
                            <asp:Label ID="Label40" runat="server" Text="Est. Begin Date:"></asp:Label>
                        </td>
                        <td class="auto-style12">
                            <asp:TextBox ID="txtBeginDate" runat="server" Width="225px"></asp:TextBox>
                        </td>
                        <td class="auto-style11">
                            <asp:Label ID="Label39" runat="server" Text="Project Site:"></asp:Label>
                        </td>
                        <td class="auto-style10">
                            <asp:TextBox ID="txtProjSite" runat="server" Width="225px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style13">
                            <asp:Label ID="Label42" runat="server" Text="Est. Compl. Date:"></asp:Label>
                        </td>
                        <td class="auto-style12">
                            <asp:TextBox ID="txtComplDate" runat="server" Width="225px"></asp:TextBox>
                        </td>
                        <td class="auto-style11">
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
                         <td class="auto-style3">&nbsp;</td>
                         <td class="auto-style6">&nbsp;</td>
                         <td class="auto-style7">&nbsp;</td>
                         <td>&nbsp;</td>
                     </tr>
                     <tr>
                         <td class="auto-style15">&nbsp;</td>
                         <td class="auto-style3">
                             <asp:Label ID="Label30" runat="server" Text="Estimated Hours"></asp:Label>
                         </td>
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
                         <td class="auto-style3">&nbsp;</td>
                         <td class="auto-style6">&nbsp;</td>
                         <td class="auto-style7">&nbsp;</td>
                         <td>&nbsp;</td>
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
            
            <br />
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <br />
            <br />
            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
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
        </div>
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
        <asp:SqlDataSource ID="SalesAssoc" runat="server" ConnectionString="Data Source=(LocalDB)\ncLocalDb;AttachDbFilename=|DataDirectory|\NBD_SB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ID, wrkFName + ' ' + wrkLName AS wrkFull FROM WORKER WHERE wrkTypeID = 7"></asp:SqlDataSource>
        <asp:SqlDataSource ID="Designer" runat="server" ConnectionString="Data Source=(LocalDB)\ncLocalDb;AttachDbFilename=|DataDirectory|\NBD_SB.mdf;Integrated Security=True" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ID, wrkFName + ' ' + wrkLName AS wrkFull FROM WORKER WHERE (wrkTypeID = 2)"></asp:SqlDataSource>
    </form>
    <footer>
		<small>Copyright © 2016 Natural By Design. All rights reserved. <a href="#">Terms of Use</a> | <a href="#">Privacy Policy</a></small>
	</footer>
    </div>
</asp:PlaceHolder>
</body>
</html>
