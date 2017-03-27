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
    public partial class Home : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;
        private static DataRow[] rows;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                PlaceHolder1.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "! | ";
                LoadProject();
            }
            //ADDED IN ALL OF THIS CODE

            //designer, production workers, and sales to view active projects they are working on
            if (User.IsInRole("Designer"))
            {
                PHLiveProject.Visible = true;
                hlClients.Visible = false;
                hlNewProject.Visible = false;
            }
            if (User.IsInRole("Production Worker"))
            {
                PHLiveProject.Visible = true;
                hlClients.Visible = false;
                hlNewProject.Visible = false;
            }
            if (User.IsInRole("Sales Associate"))
            {
                PHLiveProject.Visible = true;
                hlNewProject.Visible = false;
            }
            if (User.IsInRole("Production Manager"))
            {
                PHLiveProject.Visible = true;
            }

            //Keri seeing a desgin bid awaiting apprval 
            if (User.IsInRole("Design Manager"))
            {
                PHDesignApproval.Visible = true;
            }

            //Connie to see a PAR is waiting to be approved
            if (User.IsInRole("Admin"))
            {
                PHApprovalPAR.Visible = true;
                hlNewProject.Visible = false;
            }

            //Stan seeing a PAR that has bene submitted
            if (User.IsInRole("Sales and Finance Manager"))
            {
                PHApprovedPAR.Visible = true;
            }
            //END

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
                hls = new List<HyperLink>() { HyperLink1, HyperLink2, HyperLink3, HyperLink4, HyperLink5, HyperLink6, HyperLink7};
                foreach (HyperLink hl in hls)
                    hl.Visible = false;
            }

            if(User.IsInRole("Sales Associate"))
            {
                hls = new List<HyperLink>() { HyperLink2, HyperLink3, HyperLink4, HyperLink5, HyperLink6, HyperLink7, HyperLink8 };
                foreach (HyperLink hl in hls)
                    hl.Visible = false;
            }

            if(User.IsInRole("Production Manager"))
            {
                hls = new List<HyperLink>() { HyperLink1, HyperLink2, HyperLink3, HyperLink4, HyperLink6, HyperLink7, HyperLink8 };
                foreach (HyperLink hl in hls)
                    hl.Visible = false;
            }

        }

        static Home()
        {
            dsNBD = new NBDDataSet();
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            CLIENTTableAdapter daClient = new CLIENTTableAdapter();
            WORKERTableAdapter daWorker = new WORKERTableAdapter();
            PROD_TEAMTableAdapter daProdTeam = new PROD_TEAMTableAdapter();

            try
            {
                daProject.Fill(dsNBD.PROJECT);
                daClient.Fill(dsNBD.CLIENT);
                daWorker.Fill(dsNBD.WORKER);
                daProdTeam.Fill(dsNBD.PROD_TEAM);
            }
            catch { }
        }

        private void LoadProject()
        {
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            try { daProject.Fill(dsNBD.PROJECT); }
            catch { }
            rows = dsNBD.PROJECT.Select();

            foreach (DataRow p in rows)
            {
                if (Convert.ToInt32(p.ItemArray[0].ToString()) == 2)
                {
                    int id = Convert.ToInt32(p.ItemArray[0]);

                    double actBudget = Convert.ToDouble(p.ItemArray[9]);
                    double estBudget = Convert.ToDouble(p.ItemArray[8]);
                    double difBudget = (actBudget - estBudget);

                    DateTime estEnd = Convert.ToDateTime(p.ItemArray[5]);
                    DateTime today = DateTime.Now;
                    double difDate = (today - estEnd).TotalDays;

                    lblProject.Text += p.ItemArray[1].ToString();
                    lblStart.Text += p.ItemArray[6].ToString();
                    lblEnd.Text += p.ItemArray[5].ToString();
                    lblBudget.Text += "$" + actBudget.ToString() + "/$" + estBudget.ToString() + " budget spent";
                    lblTeam.Text += "5 workers in project team";

                    if ((actBudget / estBudget) > 1)
                    {
                        lblBudget.Text += "  [$" + difBudget.ToString("#.##") + " OVER BUDGET]";
                        lblBudget.ForeColor = System.Drawing.Color.Red;
                    }
                    if ((today > estEnd))
                    {
                        lblEnd.Text += "  [" + Math.Floor(difDate) + " DAYS OVERDUE]";
                        lblEnd.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("Account/Login.aspx", true);
        }
    }
}