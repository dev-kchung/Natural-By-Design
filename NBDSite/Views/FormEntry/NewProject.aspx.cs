using NBDLibrary;
using NBDLibrary.NBDDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NBDSite.Views.FormEntry
{
    public partial class NewProject : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;

        private static DataRow[] rows;

        static NewProject()
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Design Manager") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Production Manager"))
            {
                PlaceHolder1.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";

                txtProjBidDate.Text = DateTime.Now.Date.ToShortDateString();

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

        protected void btnCreateProj_Click(object sender, EventArgs e)
        {
            try
            {
                NBDDataSet.PROJECTRow r = dsNBD.PROJECT.NewPROJECTRow();
                //r.ID = Convert.ToInt32(this.txtID.Text);
                r.projName = this.txtProjectName.Text;
                r.projSite = this.txtProjectSite.Text;
                r.projBidDate = DateTime.Parse(this.txtProjBidDate.Text);
                r.clientID = Convert.ToInt32(ddlClient.SelectedValue);
                r.designerID = 3;
                dsNBD.PROJECT.Rows.Add(r);

                PROJECTTableAdapter daProject = new PROJECTTableAdapter();
                daProject.Update(dsNBD.PROJECT);

                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('New Project Created!');window.location ='../Home.aspx';",
                true);
            }
            catch (Exception ex)
            {
                this.lblMessage.Text = "Unable to create new project." + ex.ToString();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("../Account/Login.aspx", true);
        }
    }
}