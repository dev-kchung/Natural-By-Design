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
    public partial class ProjectAdminReport : System.Web.UI.Page
    {
        private static NBDLibrary.NBDDataSet dsNBD;
        private static DataRow[] rows;
        private static DataRow[] projects;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Admin") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Design Manager"))
            {
                PlaceHolder1.Visible = true;

                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "! | ";

                if (txtBidProject1.Text == "")
                {
                    LoadBidProjects();
                    LoadProdProjects();
                }

                if (User.IsInRole("Admin"))
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

        static ProjectAdminReport()
        {
            dsNBD = new NBDDataSet();
            PROJECTTableAdapter daProjects = new PROJECTTableAdapter();
            LABOUR_SUMMARYTableAdapter daLabourSummary = new LABOUR_SUMMARYTableAdapter();

            try
            {
                daProjects.Fill(dsNBD.PROJECT);
                daLabourSummary.Fill(dsNBD.LABOUR_SUMMARY);
            }
            catch { }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("../Account/Login.aspx", true);
        }

        public void LoadBidProjects()
        {
            projects = dsNBD.PROJECT.Select("projCurrentPhase='D'");
            foreach (DataRow proj in projects)
            {
                if (txtBidProject1.Text == "")
                {
                    txtBidProject1.Text = proj.ItemArray[1].ToString();
                    txtBidEstBid1.Text = "$" + proj.ItemArray[8].ToString();
                    rows = dsNBD.LABOUR_SUMMARY.Select("projectID=" + proj.ItemArray[0].ToString() + " AND workerTypeID=2");
                    foreach (DataRow row in rows)
                        txtBidActEstDesignH1.Text = "5/" + row.ItemArray[3].ToString();
                    txtBidActEstDesignC1.Text = "$200/$600";
                    txtBidHCRemaining1.Text = "15/$400";
                }
                else
                {
                    txtBidProject2.Text = proj.ItemArray[1].ToString();
                    txtBidEstBid2.Text = "$" + proj.ItemArray[8].ToString();
                    rows = dsNBD.LABOUR_SUMMARY.Select("projectID=" + proj.ItemArray[0].ToString() + " AND workerTypeID=2");
                    foreach (DataRow row in rows)
                        txtBidActEstDesignH2.Text = "5/" + row.ItemArray[3].ToString();
                    txtBidActEstDesignC2.Text = "$200/$600";
                    txtBidHCRemaining2.Text = "15/$400";
                }
            }
        }

        public void LoadProdProjects()
        {
            projects = dsNBD.PROJECT.Select("projCurrentPhase='P'");
            foreach (DataRow proj in projects)
            {
                if (txtProdProject1.Text == "")
                {
                    txtProdProject1.Text = proj.ItemArray[1].ToString();
                    txtProdC1.Text = "$" + proj.ItemArray[8].ToString();
                    txtProdProdPlanEst1.Text = "$" + proj.ItemArray[9].ToString();
                    txtProdTotalCost1.Text = "$2154";
                    txtProdActMat1.Text = "$220";
                    txtProdEstMat1.Text = "$657";
                    txtProdActLabor1.Text = "$300";
                    txtProdEstLabor1.Text = "$700";
                    txtProdActDesign1.Text = "$300";
                    txtProdEstDesign1.Text = "$500";
                }
                else
                {
                    txtProdProject2.Text = proj.ItemArray[1].ToString();
                    txtProdC2.Text = "$" + proj.ItemArray[8].ToString();
                    txtProdProdPlanEst2.Text = "$" + proj.ItemArray[9].ToString();
                    txtProdTotalCost2.Text = "$2154";
                    txtProdActMat2.Text = "$220";
                    txtProdEstMat2.Text = "$657";
                    txtProdActLabor2.Text = "$300";
                    txtProdEstLabor2.Text = "$700";
                    txtProdActDesign2.Text = "$300";
                    txtProdEstDesign2.Text = "$500";
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Project Admin Report Sent for Approval');window.location ='../Home.aspx';",
                true);
        }
    }
}