<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DesignBidApproval.aspx.cs" Inherits="NBDSite.Views.Approval.DesignBidApproval" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Natural By Design | Design Bid Approval</title>
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
                <a href="#" class="toggle-me">+ New Form</a>
                <asp:HyperLink ID="hlNewProject" runat="server" NavigateUrl="~/Views/FormEntry/NewProject.aspx">+ New Project</asp:HyperLink>
                <asp:HyperLink ID="hlForms" runat="server" NavigateUrl="~/Views/Forms.aspx">Forms</asp:HyperLink>
                <asp:HyperLink ID="hlProjects" runat="server" NavigateUrl="~/Views/Projects.aspx">Projects</asp:HyperLink>
                <asp:HyperLink ID="hlClients" runat="server" NavigateUrl="~/Views/Clients.aspx">Clients</asp:HyperLink>
                <asp:HyperLink ID="hlFeedback" runat="server" NavigateUrl="~/Views/Feedback.aspx">Feedback</asp:HyperLink>
                <asp:HyperLink ID="hlSettings" runat="server" NavigateUrl="~/Views/Settings.aspx">Settings</asp:HyperLink>
            </nav>
            <div class="panel center-me">
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Views/FormEntry/ClientEntry.aspx">New Client</asp:HyperLink>
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Views/FormEntry/NewProject.aspx">New Project</asp:HyperLink>
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Views/FormEntry/DesignBid.aspx">Design Bid</asp:HyperLink>
                <asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Views/FormEntry/DesignBudget.aspx">Design Budget</asp:HyperLink>
                <asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/Views/FormEntry/ProductionPlan.aspx">Production Plan</asp:HyperLink>
                <asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/Views/FormEntry/DailyWorkReport.aspx">Daily Work Report</asp:HyperLink>
            </div>
        </div>
    </div>
    
        <h1>Design Bid Approval</h1>
                <asp:Label ID="Label32" runat="server" Text="Project:"></asp:Label>
                <asp:DropDownList ID="ddlProject" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="ObjectDataSource1" DataTextField="projName" DataValueField="ID" Width="200px">
                <asp:ListItem Selected="True" Value="-1">Select...</asp:ListItem>
                </asp:DropDownList>
                <br />
                <fieldset>
                    <legend>Client</legend>
                    <table class="auto-style19">
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label3" runat="server" Text="Client Name:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtClientName" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:Label ID="Label5" runat="server" Text="Contact:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtContact" runat="server" Width="225px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label4" runat="server" Text="Client Address:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtClientAdd" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:Label ID="Label6" runat="server" Text="Phone:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtClientPhone" runat="server" Width="225px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <br />
                <fieldset>
                    <legend>NBD Staff</legend>
                    <table class="auto-style19">
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label8" runat="server" Text="Sales Assoc:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtSalesAssoc" runat="server" ReadOnly="True" Width="225px"></asp:TextBox>
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
                                <asp:Label ID="Label10" runat="server" Text="Designer:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtDesigner" runat="server" ReadOnly="True" Width="225px"></asp:TextBox>
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
                            <td class="auto-style4">
                                <asp:Label ID="Label13" runat="server" Text="Bid Date:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtBidDate" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:Label ID="Label14" runat="server" Text="Project Site:"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtProjSite" runat="server" Width="225px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style8">
                                <asp:Label ID="Label17" runat="server" Text="Est. Begin Date:"></asp:Label>
                            </td>
                            <td class="auto-style9">
                                <asp:TextBox ID="txtBeginDate" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style22">
                                <asp:Label ID="Label16" runat="server" Text="Bid Amount:"></asp:Label>
                            </td>
                            <td class="auto-style10">
                                <asp:TextBox ID="txtBidAmount" runat="server" Width="225px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label15" runat="server" Text="Est. Compl. Date:"></asp:Label>
                            </td>
                            <td class="auto-style20">
                                <asp:TextBox ID="txtComplDate" runat="server" Width="225px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </fieldset>
                <br />
                <fieldset>
                    <legend>Material Requirements</legend>
                    <table class="auto-style19">
                        <tr>
                            <td class="auto-style12">&nbsp;</td>
                            <td class="auto-style13"><strong>
                                <asp:Label ID="Label20" runat="server" Text="Qnty"></asp:Label>
                            </strong></td>
                            <td class="auto-style14"><strong>
                                <asp:Label ID="Label21" runat="server" Text="Description"></asp:Label>
                            </strong></td>
                            <td class="auto-style15"><strong>
                                <asp:Label ID="Label22" runat="server" Text="Size"></asp:Label>
                            </strong></td>
                            <td class="auto-style15"><strong>
                                <asp:Label ID="Label23" runat="server" Text="Unit Price"></asp:Label>
                            </strong></td>
                            <td><strong>
                                <asp:Label ID="Label24" runat="server" Text="Extended Price"></asp:Label>
                            </strong></td>
                        </tr>
                        <tr>
                            <td class="auto-style12"><strong>
                                <asp:Label ID="Label19" runat="server" Text="Plants:"></asp:Label>
                            </strong></td>
                            <td class="auto-style13">&nbsp;</td>
                            <td class="auto-style14">&nbsp;</td>
                            <td class="auto-style15">&nbsp;</td>
                            <td class="auto-style15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style12">&nbsp;</td>
                            <td class="auto-style13">
                                <asp:TextBox ID="txtPlantQ" runat="server" Width="50px"></asp:TextBox>
                            </td>
                            <td class="auto-style14">
                                <asp:TextBox ID="txtPlantD" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:TextBox ID="txtPlantS" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:TextBox ID="txtPlantU" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPlantE" runat="server" Width="100px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style12"><strong>
                                <asp:Label ID="Label25" runat="server" Text="Pottery:"></asp:Label>
                            </strong></td>
                            <td class="auto-style13">&nbsp;</td>
                            <td class="auto-style14">&nbsp;</td>
                            <td class="auto-style15">&nbsp;</td>
                            <td class="auto-style15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style12">&nbsp;</td>
                            <td class="auto-style13">
                                <asp:TextBox ID="txtPotteryQ" runat="server" Width="50px"></asp:TextBox>
                            </td>
                            <td class="auto-style14">
                                <asp:TextBox ID="txtPotteryD" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:TextBox ID="txtPotteryS" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:TextBox ID="txtPotteryU" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPotteryE" runat="server" Width="100px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style12"><strong>
                                <asp:Label ID="Label26" runat="server" Text="Materials:"></asp:Label>
                            </strong></td>
                            <td class="auto-style13">&nbsp;</td>
                            <td class="auto-style14">&nbsp;</td>
                            <td class="auto-style15">&nbsp;</td>
                            <td class="auto-style15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style12">&nbsp;</td>
                            <td class="auto-style13">
                                <asp:TextBox ID="txtMaterialQ" runat="server" Width="50px"></asp:TextBox>
                            </td>
                            <td class="auto-style14">
                                <asp:TextBox ID="txtMaterialD" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:TextBox ID="txtMaterialS" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td class="auto-style15">
                                <asp:TextBox ID="txtMaterialU" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:TextBox ID="txtMaterialE" runat="server" Width="100px"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <br />
                <fieldset>
                    <legend>Labour Requirements</legend>
                        <table class="auto-style19">
                            <tr>
                                <td class="auto-style12">&nbsp;</td>
                                <td class="auto-style13">
                                    <asp:Label ID="Label28" runat="server" Text="Hours"></asp:Label>
                                </td>
                                <td class="auto-style17">
                                    <asp:Label ID="Label29" runat="server" Text="Description"></asp:Label>
                                </td>
                                <td class="auto-style15">
                                    <asp:Label ID="Label30" runat="server" Text="Unit Price"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="Label31" runat="server" Text="Extended Price"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style12">&nbsp;</td>
                                <td class="auto-style13">
                                    <asp:TextBox ID="txtLaborH" runat="server" Width="50px"></asp:TextBox>
                                </td>
                                <td class="auto-style17">
                                    <asp:TextBox ID="txtLaborD" runat="server" Width="200px"></asp:TextBox>
                                </td>
                                <td class="auto-style15">
                                    <asp:TextBox ID="txtLaborU" runat="server" Width="100px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtLaborE" runat="server" Width="100px"></asp:TextBox>
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
            <br />
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="NBDLibrary.NBDDataSetTableAdapters.PROJECTTableAdapter" UpdateMethod="Update">
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
    </form>
    </div>
</asp:PlaceHolder>    
</body>
</html>
