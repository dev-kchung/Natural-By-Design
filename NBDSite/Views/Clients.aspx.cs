//Arden Metcalfe-Roach
//Kim Chung
//Baljit Bharaj
//PROG 1210
//12/16/2016
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NBDLibrary.NBDDataSetTableAdapters;
using NBDLibrary;
using System.Data;

namespace NBDSite
{
    public partial class Clients : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;
        private static DataRow[] rows;
        private static List<int> indexes = new List<int>();
        protected void Page_Load(object sender, EventArgs e)
        {
            // If user is logged in...
            if (User.Identity.IsAuthenticated)
            {
                // Make page visible
                PlaceHolder1.Visible = true;
                // Load date and welcome message
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "! | ";

                // Trigger page change so bids will load
                dvClients_PageIndexChanging(null, null);

                // User permissions
                if (!User.IsInRole("Sales Associate") && !User.IsInRole("Sales and Finance Manager"))
                {
                    hlNewClient.Visible = false;
                }
                if (User.IsInRole("Production Worker") || User.IsInRole("Designer"))
                {
                    hlNewProject.Visible = false;
                    hlClients.Visible = false;
                }
                if (User.IsInRole("Admin"))
                {
                    hlNewProject.Visible = false;
                }

                // New Form Permissions
                List<HyperLink> hls;

                if (User.IsInRole("Designer") || User.IsInRole("Production Worker"))
                {
                    hls = new List<HyperLink>() { HyperLink1, HyperLink2, HyperLink7, HyperLink5, HyperLink8 };
                    foreach (HyperLink hl in hls)
                        hl.Visible = false;

                    if (User.IsInRole("Production Worker"))
                    {
                        HyperLink3.Visible = false;
                        HyperLink4.Visible = false;
                    }
                }

                if (User.IsInRole("Admin"))
                {
                    hls = new List<HyperLink>() { HyperLink1, HyperLink2, HyperLink3, HyperLink4, HyperLink5, HyperLink6, HyperLink7 };
                    foreach (HyperLink hl in hls)
                        hl.Visible = false;
                }

                if (User.IsInRole("Sales Associate"))
                {
                    hls = new List<HyperLink>() { HyperLink2, HyperLink3, HyperLink4, HyperLink5, HyperLink6, HyperLink7, HyperLink8 };
                    foreach (HyperLink hl in hls)
                        hl.Visible = false;
                }

                if (User.IsInRole("Production Manager"))
                {
                    hls = new List<HyperLink>() { HyperLink1, HyperLink2, HyperLink3, HyperLink4, HyperLink6, HyperLink7, HyperLink8 };
                    foreach (HyperLink hl in hls)
                        hl.Visible = false;
                }

                if (!User.IsInRole("Design Manager") && !User.IsInRole("Sales and Finance Manager") && !User.IsInRole("Production Manager") && !User.IsInRole("Admin"))
                {
                    phClientBids.Visible = false;
                    lblDesignBid.Visible = false;
                }
            }
        }

        static Clients()
        {
            dsNBD = new NBDDataSet();
            CLIENTTableAdapter daClient = new CLIENTTableAdapter();
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            try
            {
                daClient.Fill(dsNBD.CLIENT);
                daProject.Fill(dsNBD.PROJECT);
            }
            catch { }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("Account/Login.aspx", true);
        }

        protected void lbClientSearch_Click(object sender, EventArgs e)
        {
            // Search button toggle visibility
            if (pnSearch.Visible == false)
            {
                pnSearch.Visible = true;
                lbClientSearch.Text = "Close Search";
                lbSearchResults.Items.Add("Search results...");
            }
            else
            {
                pnSearch.Visible = false;
                lbClientSearch.Text = "Search Clients";
                txtName.Text = "";
                txtAddress.Text = "";
                txtPhone.Text = "";
                ddlCities.SelectedValue = "-1";
                ddlContacts.SelectedValue = "-1";
                ddlProvinces.SelectedValue = "-1";
                lbSearchResults.Items.Clear();
                lblMessage.Text = "";
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Search for records
            // Clear results
            lbSearchResults.Items.Clear();
            try
            {
                // Select by search criteria
                rows = dsNBD.CLIENT.Select(SearchCriteria());
                foreach (DataRow row in rows)
                {
                    // Add results to output & store ids
                    lbSearchResults.Items.Add(row.ItemArray[1].ToString());
                    indexes.Add(Convert.ToInt32(row.ItemArray[0]));
                }

            }
            catch { lblMessage.Text = "Invalid search."; }

        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            // Clear all info
            txtName.Text = "";
            txtAddress.Text = "";
            txtPhone.Text = "";
            ddlCities.SelectedValue = "-1";
            ddlContacts.SelectedValue = "-1";
            ddlProvinces.SelectedValue = "-1";
            dvClients.PageIndex = 0;
            lbSearchResults.Items.Clear();
            lbSearchResults.Items.Add("Search results...");
            lblMessage.Text = "";
        }

        public string SearchCriteria()
        {
            // Build search criteria
            // Clear items
            lbSearchResults.Items.Clear();
            // Get worker's first and last name separately
            string[] contact = ddlContacts.SelectedValue.ToString().Split(' ');
            // Build search string
            string criteria = "";
            criteria += (txtName.Text != "") ? "cliName='" + txtName.Text + "'" : "";
            criteria += (ddlCities.SelectedValue != "-1" && criteria.Length > 0) ? "AND cityID=" + ddlCities.SelectedValue
                : (ddlCities.SelectedValue != "-1") ? "cityID=" + ddlCities.SelectedValue : "";
            criteria += (ddlProvinces.SelectedValue != "-1" && criteria.Length > 0) ? "AND cliProvince='" + ddlProvinces.SelectedValue.ToString() + "'"
                : (ddlProvinces.SelectedValue != "-1") ? "cliProvince='" + ddlProvinces.SelectedValue.ToString() + "'" : "";
            criteria += (txtAddress.Text != "" && criteria.Length > 0) ? "AND cliAddress='" + txtAddress.Text + "'"
                : (txtAddress.Text != "") ? "cliAddress='" + txtAddress.Text + "'" : "";
            criteria += (txtPhone.Text != "" && criteria.Length > 0) ? "AND cliPhone='" + txtPhone.Text + "'"
                : (txtPhone.Text != "") ? "cliPhone='" + txtPhone.Text + "'" : "";
            criteria += (ddlContacts.SelectedValue != "-1" && criteria.Length > 0) ? "AND cliConFName='" + contact[0] + "' AND cliConLName='" + contact[1] + "'"
                : (ddlContacts.SelectedValue != "-1") ? "cliConFName='" + contact[0] + "' AND cliConLName='" + contact[1] + "'" : "";

            return criteria;

        }

        // If search item is selected...
        protected void lbSearchResults_SelectedIndexChanged(object sender, EventArgs e)
        {
            // If item is not the default item
            if (lbSearchResults.SelectedValue != "Search results...")
            {
                try
                {
                    // Get id of item
                    int id = indexes[lbSearchResults.SelectedIndex] - 1;
                    dvClients.PageIndex = id;

                    int i = id + 1;

                    string clientName = "";

                    // Clear bids
                    phClientBids.Controls.Clear();

                    // Get client name
                    DataRow[] client = dsNBD.CLIENT.Select("ID=" + i);
                    foreach (DataRow row in client)
                        clientName = row.ItemArray[1].ToString();

                    // Update bids
                    lblDesignBid.Text = "Design Bids for " + clientName;

                    rows = dsNBD.PROJECT.Select();
                    foreach (DataRow row in rows)
                    {
                        // Add links to relevant bids
                        if (row.ItemArray[14].ToString() == i.ToString())
                        {
                            string projID = row.ItemArray[0].ToString();

                            HyperLink bid = new HyperLink();
                            bid.ID = "hlBid" + projID;
                            bid.NavigateUrl = "~/Views/FormEntry/ViewDesignBid.aspx?projID=" + projID;
                            bid.Text = "\t\u2022 " + row.ItemArray[1].ToString() + " (" + row.ItemArray[3].ToString() + ")";

                            LiteralControl linebreak = new LiteralControl("<br></br>");
                            phClientBids.Controls.Add(bid);
                            phClientBids.Controls.Add(linebreak);
                        }
                    }

                    // If there are no bids, just add message
                    if (phClientBids.Controls.Count == 0)
                    {
                        Label lblBidResults = new Label();
                        lblBidResults.Text = "No bids found in records.";
                        lblBidResults.ForeColor = System.Drawing.Color.Red;

                        phClientBids.Controls.Add(lblBidResults);
                    }



                }
                catch { }
            }

        }

        // When new page is selected in the client box
        protected void dvClients_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
        {

            // Get new page index and update bids accordingly
            int i = 1;
            try { i = (e.NewPageIndex) + 1; }
            catch { }

            string clientName = "";

            phClientBids.Controls.Clear();

            DataRow[] client = dsNBD.CLIENT.Select("ID=" + i);
            foreach (DataRow row in client)
                clientName = row.ItemArray[1].ToString();

            lblDesignBid.Text = "Design Bids for " + clientName;

            rows = dsNBD.PROJECT.Select();
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[14].ToString() == i.ToString())
                {
                    string projID = row.ItemArray[0].ToString();

                    HyperLink bid = new HyperLink();
                    bid.ID = "hlBid" + projID;
                    bid.NavigateUrl = "~/Views/FormEntry/ViewDesignBid.aspx?projID=" + projID;
                    bid.Text = "\t\u2022 " + row.ItemArray[1].ToString() + " (" + row.ItemArray[3].ToString() + ")";

                    LiteralControl linebreak = new LiteralControl("<br></br>");
                    phClientBids.Controls.Add(bid);
                    phClientBids.Controls.Add(linebreak);
                }
            }

            if (phClientBids.Controls.Count == 0)
            {
                Label lblBidResults = new Label();
                lblBidResults.Text = "No bids found in records.";
                lblBidResults.ForeColor = System.Drawing.Color.Red;

                phClientBids.Controls.Add(lblBidResults);
            }

        }

    }
}