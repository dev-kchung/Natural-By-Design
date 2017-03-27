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


    public partial class DailyWorkReport : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;

        private static DataRow[] rows;

        static DailyWorkReport()
        {
            dsNBD = new NBDDataSet();
            LABOUR_SUMMARYTableAdapter daLabSum = new LABOUR_SUMMARYTableAdapter();
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            TASKTableAdapter daTask = new TASKTableAdapter();
            LABOUR_REQUIREMENTTableAdapter daLabourReq = new LABOUR_REQUIREMENTTableAdapter();
            PROD_TEAMTableAdapter daProdTeam = new PROD_TEAMTableAdapter();

            try
            {
                daLabSum.Fill(dsNBD.LABOUR_SUMMARY);
                daProject.Fill(dsNBD.PROJECT);
                daTask.Fill(dsNBD.TASK);
                daLabourReq.Fill(dsNBD.LABOUR_REQUIREMENT);
                daProdTeam.Fill(dsNBD.PROD_TEAM);
            }
            catch { }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Designer") || User.IsInRole("Production Worker") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Design Manager"))
            {
                PlaceHolder.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";

                txtDate.Text = DateTime.Now.Date.ToShortDateString();

                productionWorker.Visible = false;
                designer.Visible = false;

                if (!User.IsInRole("Sales and Finance Manager"))
                {
                    hlNewProject.Visible = false;
                    hlClients.Visible = false;
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

                if(User.IsInRole("Designer"))
                {
                    ddlWorkerType.SelectedValue = "2";
                    ddlWorkerType.Enabled = false;
                    designer.Visible = true;
                }
                else if(User.IsInRole("Production Worker"))
                {
                    ddlWorkerType.SelectedValue = "1";
                    ddlWorkerType.Enabled = false;
                    productionWorker.Visible = true;
                }
            }
        }


        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                ////Get Worker ID
                //int wrkID = 3;
                //int prodTeamID = 0;

                ////Get Prod_Team ID
                //rows = dsNBD.PROD_TEAM.Select("workerID=" + wrkID.ToString());
                //foreach(DataRow row in rows)
                //{
                //    prodTeamID = Convert.ToInt32(row.ItemArray[0]);
                //}




                //NBDDataSet.LABOUR_SUMMARYRow r = dsNBD.LABOUR_SUMMARY.NewLABOUR_SUMMARYRow();
                //r.projectID = Convert.ToInt32(ddlProjectName.SelectedValue);
                //r.workerTypeID = Convert.ToInt32(ddlWorkerType.SelectedValue);
                //r.lsHours = Convert.ToInt16(txtHours.Text);

                //NBDDataSet.PROJECTRow p = dsNBD.PROJECT.NewPROJECTRow();
                //p.projCurrentPhase = this.txtStage.Text;

                //NBDDataSet.TASKRow t = dsNBD.TASK.NewTASKRow();
                //t.ID = Convert.ToInt32(ddlDTask.SelectedValue);

                //dsNBD.LABOUR_SUMMARY.Rows.Add(r);

                //LABOUR_SUMMARYTableAdapter daLabSum = new LABOUR_SUMMARYTableAdapter();
                //daLabSum.Update(dsNBD.LABOUR_SUMMARY);

                //PROJECTTableAdapter daProject = new PROJECTTableAdapter();
                //daProject.Update(dsNBD.PROJECT);

                //TASKTableAdapter daTask = new TASKTableAdapter();
                //daTask.Update(dsNBD.TASK);
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Work Report Submitted!');window.location ='../Home.aspx';",
                true);
            }
            catch (Exception ex)
            {
                this.lblMessage.Text = "Unable to submit daily work report.";
            }
        }

        protected void ddlWorkerType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlWorkerType.SelectedValue == "1")
            {
                productionWorker.Visible = true;

            }
            else if (ddlWorkerType.SelectedValue == "2")
            {
                designer.Visible = true;
            }
            else
            {
                productionWorker.Visible = false;
                designer.Visible = false;
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