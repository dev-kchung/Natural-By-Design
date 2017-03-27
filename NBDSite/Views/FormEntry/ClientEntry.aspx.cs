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
using System.Data.SqlClient;

namespace NBDSite
{
    public partial class ClientEntry : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;
        private static DataRow[] rows;
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check for user roles
            if (User.IsInRole("Sales Associate") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Design Manager"))
            {
                // Enable placeholder
                PlaceHolder1.Visible = true;

                // Load date and welcome message
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "! | ";

                // Hide Link from Sales Associate
                if (User.IsInRole("Sales Associate"))
                {
                    hlNewProject.Visible = false;
                }

                // New Form Permissions
                List<HyperLink> hls;

                if (User.IsInRole("Designer") || User.IsInRole("Production Worker"))
                {
                    hls = new List<HyperLink>() { HyperLink1, HyperLink2, HyperLink3, HyperLink7, HyperLink5, HyperLink8 };
                    foreach (HyperLink hl in hls)
                        hl.Visible = false;

                    if (User.IsInRole("Production Worker"))
                        HyperLink4.Visible = false;
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

            }
        }

        static ClientEntry()
        {
            dsNBD = new NBDDataSet();
            CITYTableAdapter daCities = new CITYTableAdapter();
            CLIENTTableAdapter daClients = new CLIENTTableAdapter();

            try
            {
                daCities.Fill(dsNBD.CITY);
                daClients.Fill(dsNBD.CLIENT);
            }
            catch { }
        }

        public List<string> CitiesList()
        {
            // Makes list of cities
            List<string> cities = new List<string>();
            rows = dsNBD.CITY.Select();
            foreach (DataRow row in rows)
            {
                if (!cities.Contains(row.ItemArray[1].ToString()))
                    cities.Add(row.ItemArray[1].ToString());
            }

            return cities;

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            AddClient();
        }

        public void AddClient()
        {
            try
            {
                // Make new client row
                NBDDataSet.CLIENTRow r = dsNBD.CLIENT.NewCLIENTRow();
                r.cliName = txtName.Text.ToString();
                r.cliAddress = txtAddress.Text.ToString();
                if (ddlProvinces.SelectedValue != "-1")
                    r.cliProvince = ddlProvinces.SelectedValue.ToString();
                r.cliPCode = txtPostal.Text.ToString();
                r.cliPhone = txtPhone.Text.ToString();
                r.cliConFName = txtFirst.Text.ToString();
                r.cliConLName = txtLast.Text.ToString();
                r.cliConPosition = txtPosition.Text.ToString();

                // If city already exists...
                if (ddlCities.SelectedValue != "-2" && ddlCities.SelectedValue != "-1")
                    r.cityID = Convert.ToInt32(ddlCities.SelectedValue.ToString());

                // If city is new, add new row to city
                else if (ddlCities.SelectedValue != "-1")
                {
                    NBDDataSet.CITYRow city = dsNBD.CITY.NewCITYRow();
                    city.city = txtCities.Text.ToString();

                    dsNBD.CITY.Rows.Add(city);
                    CITYTableAdapter daCities = new CITYTableAdapter();
                    daCities.Update(dsNBD.CITY);

                    r.cityID = city.ID;
                }

                // Add row
                dsNBD.CLIENT.Rows.Add(r);

                CLIENTTableAdapter daClients = new CLIENTTableAdapter();
                daClients.Update(dsNBD.CLIENT);

                // Pop up alert
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('New Client Added!');window.location ='../Clients.aspx';",
                true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Unable to add client: " + ex.Message;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("../Account/Login.aspx", true);
        }

        protected void ddlCities_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Remove select option upon selection
            if (ddlCities.Items[0].Value == "-1")
                ddlCities.Items.RemoveAt(0);
            // Make new city textbox appear/disappear upon choosing new city
            if (ddlCities.SelectedValue == "-2")
            {
                txtCities.Visible = true;
                lblEnterCity.Visible = true;
            }
            else
            {
                txtCities.Visible = false;
                lblEnterCity.Visible = false;
            }

        }
    }
}