using NBDLibrary;
using NBDLibrary.NBDDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Odbc;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NBDSite
{
    public partial class ProductionPlanApproval : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;
        private static DataRow[] rows;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Sales and Finance Manager") || User.IsInRole("Production Manager") || User.IsInRole("Design Manager"))
            {
                PlaceHolder1.Visible = true;
                Page.MaintainScrollPositionOnPostBack = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";

                if (ddlPlant.Items.Count == 1)
                    FillGeneralInfo();

            }

        }

        static ProductionPlanApproval()
        {
            dsNBD = new NBDDataSet();
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            TASKTableAdapter daTask = new TASKTableAdapter();
            WORKER_TYPETableAdapter daWorkerType = new WORKER_TYPETableAdapter();
            MATERIALTableAdapter daMaterial = new MATERIALTableAdapter();

            try
            {
                daProject.Fill(dsNBD.PROJECT);
                daTask.Fill(dsNBD.TASK);
                daWorkerType.Fill(dsNBD.WORKER_TYPE);
                daMaterial.Fill(dsNBD.MATERIAL);
            }
            catch { }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("../Account/Login.aspx", true);
        }

        public void FillGeneralInfo()
        {
            // Plants, Pottery, Materials ddls
            GetMaterialsByType("Plant", ddlPlant);
            GetMaterialsByType("Pottery", ddlPottery);
            GetMaterialsByType("Materials", ddlMaterial);

            // Labour ddls
            GetWorkerByType(null, 2, null, ddlDesign);
            GetWorkerByType(null, 1, null, ddlProduction);
            GetWorkerByType(null, 3, null, ddlHEO);

            // Worker Cost txt
            GetWorkerPriceByType("Designer", txtDesignC);
            GetWorkerPriceByType("Production Worker", txtProductionC);
            GetWorkerPriceByType("Equipment Operator", txtHeoC);

        }

        protected void ddlProjects_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlProjects.SelectedValue.ToString() != "-2")
            {
                ClearProjectInfo();
                FillProjectInfo();
                Summary();
                lblMessage.Text = "";
            }
            else
                ClearProjectInfo();
        }

        public void FillProjectInfo()
        {
            // Project ID
            string projectID = ddlProjects.SelectedValue;

            // Project Info
            rows = dsNBD.PROJECT.Select();
            foreach (DataRow row in rows)
            {
                if (projectID == row.ItemArray[0].ToString())
                {
                    txtProjectName.Text = row.ItemArray[1].ToString();
                    txtProjectStart.Text = row.ItemArray[6].ToString();
                    txtProjectEnd.Text = row.ItemArray[5].ToString();
                    txtProjectSite.Text = row.ItemArray[2].ToString();
                    txtProjectBid.Text = row.ItemArray[8].ToString();
                }
            }

            // Sales Associate
            GetWorkerByType(projectID, 7, txtSalesAssoc, null);
            // Designer
            GetWorkerByType(projectID, 2, txtDesigner, null);

            // Plants
            FillProjectMaterialsByType(projectID, "Plant");
            // Pottery
            FillProjectMaterialsByType(projectID, "Pottery");
            // Material
            FillProjectMaterialsByType(projectID, "Materials");
            // Tools
            GetTools(projectID);
            // Labour
            GetLabourInfo(Convert.ToInt32(projectID), 2);
            GetLabourInfo(Convert.ToInt32(projectID), 1);
            GetLabourInfo(Convert.ToInt32(projectID), 3);

        }

        public void ClearProjectInfo()
        {
            var t = Form.Controls.OfType<TextBox>().AsEnumerable<TextBox>();
            List<TextBox> neededTextboxes = new List<TextBox>() { txtDesignC, txtProductionC, txtHeoC };
            foreach (TextBox item in t)
            {
                if (!neededTextboxes.Contains(item))
                    item.Text = "";

            }

            var d = Form.Controls.OfType<DropDownList>().AsEnumerable<DropDownList>();
            foreach (DropDownList item in d)
                try { item.SelectedValue = "-1"; } catch { }

            lblSumBidC.Text = "0";
            lblSumBidH.Text = "0";
            lblSumDesignProdC.Text = "0";
            lblSumDesignProdH.Text = "0";
            lblSumProdC.Text = "0";
            lblSumProdH.Text = "0";
            lblSumMaterialsC.Text = "0";
            lblSumTotalC.Text = "0";
            lblSumTotalH.Text = "0";
            lblSumTotalP.Text = "(0% of bid)";
        }

        public void FillProjectMaterialsByType(string p, string t)
        {
            MATERIAL_REQTableAdapter daMaterialReq = new MATERIAL_REQTableAdapter();

            try { daMaterialReq.FillBy(dsNBD.MATERIAL_REQ, Convert.ToInt32(p), t); }
            catch { }

            rows = dsNBD.MATERIAL_REQ.Select();
            foreach (DataRow row in rows)
            {
                if (t == "Plant")
                {
                    txtPlantQ.Text = row.ItemArray[3].ToString();
                    ddlPlant.SelectedValue = row.ItemArray[7].ToString();
                    txtPlantS.Text = row.ItemArray[8].ToString();
                    lblPlantSU.Text = " " + row.ItemArray[9].ToString();
                    txtPlantU.Text = row.ItemArray[10].ToString();
                    txtPlantD.Text = row.ItemArray[1].ToString();
                    txtPlantI.Text = row.ItemArray[2].ToString();
                    txtPlantE.Text = row.ItemArray[6].ToString();
                    int extCost = Convert.ToInt32(row.ItemArray[10]);
                    int qty = Convert.ToInt32(row.ItemArray[3]);
                    txtPlantE.Text = (extCost * qty).ToString();
                }
                else if (t == "Pottery")
                {
                    txtPotteryQ.Text = row.ItemArray[3].ToString();
                    ddlPottery.SelectedValue = row.ItemArray[7].ToString();
                    txtPotteryS.Text = row.ItemArray[8].ToString();
                    lblPotterySU.Text = row.ItemArray[9].ToString();
                    txtPotteryU.Text = row.ItemArray[10].ToString();
                    txtPotteryD.Text = row.ItemArray[1].ToString();
                    txtPotteryI.Text = row.ItemArray[2].ToString();
                    txtPotteryE.Text = row.ItemArray[6].ToString();
                    int extCost = Convert.ToInt32(row.ItemArray[10]);
                    int qty = Convert.ToInt32(row.ItemArray[3]);
                    txtPotteryE.Text = (extCost * qty).ToString();
                }
                else if (t == "Materials")
                {
                    txtMaterialQ.Text = row.ItemArray[3].ToString();
                    ddlMaterial.SelectedValue = row.ItemArray[7].ToString();
                    txtMaterialS.Text = row.ItemArray[8].ToString();
                    lblMaterialSU.Text = row.ItemArray[9].ToString();
                    txtMaterialU.Text = row.ItemArray[10].ToString();
                    txtMaterialD.Text = row.ItemArray[1].ToString();
                    txtMaterialI.Text = row.ItemArray[2].ToString();
                    txtMaterialE.Text = row.ItemArray[6].ToString();
                    int extCost = Convert.ToInt32(row.ItemArray[10]);
                    int qty = Convert.ToInt32(row.ItemArray[3]);
                    txtMaterialE.Text = (extCost * qty).ToString();
                }
            }
        }



        public void GetWorkerByType(string p, int t, TextBox txt, DropDownList ddl)
        {
            WORKERTableAdapter daWorker = new WORKERTableAdapter();

            if (p != null)
            {
                try { daWorker.FillBy(dsNBD.WORKER, t, Convert.ToInt32(p)); }
                catch { }

                rows = dsNBD.WORKER.Select();
            }
            else
            {
                try { daWorker.Fill(dsNBD.WORKER); }
                catch { }
                rows = dsNBD.WORKER.Select("wrkTypeID=" + t);
            }

            foreach (DataRow row in rows)
            {
                if (txt != null)
                    txt.Text = row.ItemArray[1].ToString() + " " + row.ItemArray[2].ToString();
                else if (ddl != null)
                    ddl.Items.Add(row.ItemArray[1].ToString() + " " + row.ItemArray[2].ToString());
            }

        }

        public void GetWorkerPriceByType(string type, TextBox txt)
        {
            rows = dsNBD.WORKER_TYPE.Select();
            foreach (DataRow row in rows)
            {
                decimal p;
                if (row.ItemArray[1].ToString() == type)
                {
                    p = Convert.ToDecimal(row.ItemArray[3]);
                    txt.Text = p.ToString("F");
                }
            }
        }

        public void GetTools(string p)
        {
            PROD_TOOLTableAdapter daProdTool = new PROD_TOOLTableAdapter();

            try { daProdTool.FillBy(dsNBD.PROD_TOOL, Convert.ToInt32(p)); }
            catch { }

            rows = dsNBD.PROD_TOOL.Select();
            foreach (DataRow row in rows)
            {
                txtToolQ.Text = row.ItemArray[3].ToString();
                ddlTools.SelectedValue = row.ItemArray[2].ToString();
                txtToolDeliverFrom.Text = row.ItemArray[4].ToString();
                txtToolDeliverTo.Text = row.ItemArray[5].ToString();
            }
        }

        public void GetMaterialsByType(string type, DropDownList ddl)
        {
            rows = dsNBD.MATERIAL.Select();
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[2].ToString() == type)
                    ddl.Items.Add(row.ItemArray[1].ToString());
            }
        }

        public void GetLabourInfo(int projectID, int type)
        {
            PROD_TEAMTableAdapter daProdTeam = new PROD_TEAMTableAdapter();
            try { daProdTeam.FillBy(dsNBD.PROD_TEAM, projectID, type); }
            catch { }

            rows = dsNBD.PROD_TEAM.Select();
            foreach (DataRow row in rows)
            {
                if (type == 2)
                {
                    ddlDesign.SelectedValue = row.ItemArray[4].ToString() + " " + row.ItemArray[5].ToString();
                    txtDesignH.Text = row.ItemArray[9].ToString();
                    GetWorkerPriceByType("Designer", txtDesignC);
                    txtDesignTime.Text = row.ItemArray[10].ToString();
                    ddlDesignTasks.SelectedIndex = Convert.ToInt32(row.ItemArray[8].ToString());
                    txtDesignE.Text = CalcExtCost(txtDesignH.Text, txtDesignC.Text).ToString();

                }
                else if (type == 1)
                {
                    ddlProduction.SelectedValue = row.ItemArray[4].ToString() + " " + row.ItemArray[5].ToString();
                    txtProductionH.Text = row.ItemArray[9].ToString();
                    GetWorkerPriceByType("Production Worker", txtProductionC);
                    txtProductionTime.Text = row.ItemArray[10].ToString();
                    ddlProdTasks.SelectedIndex = Convert.ToInt32(row.ItemArray[8].ToString());
                    txtProductionE.Text = CalcExtCost(txtProductionH.Text, txtProductionC.Text).ToString();
                }
                else if (type == 3)
                {
                    ddlHEO.SelectedValue = row.ItemArray[4].ToString() + " " + row.ItemArray[5].ToString();
                    txtHeoH.Text = row.ItemArray[9].ToString();
                    GetWorkerPriceByType("Heavy Equipment Operator", txtHeoC);
                    txtHeoTime.Text = row.ItemArray[10].ToString();
                    ddlHEOTasks.SelectedIndex = Convert.ToInt32(row.ItemArray[8].ToString());
                    txtHeoE.Text = CalcExtCost(txtHeoH.Text, txtHeoC.Text).ToString();
                }
            }
        }

        protected void txtDesignH_TextChanged(object sender, EventArgs e)
        {
            txtDesignE.Text = CalcExtCost(txtDesignH.Text, txtDesignC.Text).ToString();
            Summary();
        }

        protected void txtProductionH_TextChanged(object sender, EventArgs e)
        {
            txtProductionE.Text = CalcExtCost(txtProductionH.Text, txtProductionC.Text).ToString();
            Summary();
        }

        protected void txtHeoH_TextChanged(object sender, EventArgs e)
        {
            txtHeoE.Text = CalcExtCost(txtHeoH.Text, txtHeoC.Text).ToString();
            Summary();
        }

        public decimal CalcExtCost(string hrs, string cost)
        {
            decimal h = Convert.ToDecimal(hrs);
            decimal c = Convert.ToDecimal(cost);
            decimal extCost = h * c;

            return extCost;
        }

        protected void txtPlantE_TextChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void txtPotteryE_TextChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void txtMaterialE_TextChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void txtDesignE_TextChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void txtProductionE_TextChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void txtHeoE_TextChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void ddlDesignTasks_SelectedIndexChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void ddlProdTasks_SelectedIndexChanged(object sender, EventArgs e)
        {
            Summary();
        }

        protected void ddlHEOTasks_SelectedIndexChanged(object sender, EventArgs e)
        {
            Summary();
        }

        public void Summary()
        {
            // Total Hours
            List<decimal> totalHours = new List<decimal>();
            if (txtDesignH.Text != "")
                totalHours.Add(Convert.ToDecimal(txtDesignH.Text));
            if (txtProductionH.Text != "")
                totalHours.Add(Convert.ToDecimal(txtProductionH.Text));
            if (txtHeoH.Text != "")
                totalHours.Add(Convert.ToDecimal(txtHeoH.Text));

            lblSumTotalH.Text = totalHours.Sum().ToString();

            // Total Cost
            List<decimal> totalCost = new List<decimal>();
            List<TextBox> totalCostTextboxes = new List<TextBox>() { txtPlantE, txtPotteryE, txtMaterialE, txtDesignE, txtProductionE, txtHeoE };
            foreach (TextBox txt in totalCostTextboxes)
            {
                if (txt.Text != "")
                    totalCost.Add(Convert.ToDecimal(txt.Text));
            }

            decimal tc = totalCost.Sum();
            lblSumTotalC.Text = tc.ToString("c");

            // Percentage
            try
            {
                decimal b = Convert.ToDecimal(txtProjectBid.Text);
                decimal p = (tc / b) * 100;
                lblSumTotalP.Text = "(" + p.ToString("F") + "% of bid)";
                if (p > 70)
                {
                    lblSumTotalP.ForeColor = System.Drawing.Color.Red;
                    lblSumTotalP.Text += " [50%-70% LIMIT EXCEEDED]";
                }
                else if (p < 50)
                {
                    lblSumTotalP.ForeColor = System.Drawing.Color.Red;
                    lblSumTotalP.Text += " [50%-70% LIMIT NOT MET]";
                }
            }
            catch { }

            // Designer Bid Process Hours & Cost
            List<TextBox> h = new List<TextBox>() { txtDesignH };
            List<TextBox> c = new List<TextBox>() { txtDesignE };
            List<string> t = new List<string>() { "Bid Process" };
            CalcHoursAndCost(h, c, lblSumBidH, lblSumBidC, t);

            // Designer Production Hours & Cost
            h = new List<TextBox>() { txtDesignH };
            c = new List<TextBox>() { txtDesignE };
            t = new List<string>()
            {
                "Complete Final Blueprints", "Oversee Installation of Fountain and Pots", "Inspect Contouring", "Inspect Finished Site"
            };
            CalcHoursAndCost(h, c, lblSumDesignProdH, lblSumDesignProdC, t);

            // Production Hours & Cost
            h = new List<TextBox>() { txtProductionH, txtHeoH };
            c = new List<TextBox>() { txtProductionE, txtHeoE };
            CalcHoursAndCost(h, c, lblSumProdH, lblSumProdC, null);

            // Materials Cost
            c = new List<TextBox>() { txtPlantE, txtPotteryE, txtMaterialE };
            CalcHoursAndCost(null, c, null, lblSumMaterialsC, null);


        }

        public void CalcHoursAndCost(List<TextBox> hourBoxes, List<TextBox> costBoxes, Label th, Label tc, List<string> tasks)
        {
            List<decimal> hours = new List<decimal>();
            List<decimal> cost = new List<decimal>();

            if (hourBoxes != null)
            {
                if (tasks == null)
                {
                    foreach (TextBox t in hourBoxes)
                    {
                        if (t.Text != "")
                            hours.Add(Convert.ToDecimal(t.Text));
                    }

                    foreach (TextBox t in costBoxes)
                    {
                        if (t.Text != "")
                            cost.Add(Convert.ToDecimal(t.Text));
                    }

                    th.Text = hours.Sum().ToString();
                    tc.Text = cost.Sum().ToString("F");
                }
                else
                {
                    if (tasks.Contains(ddlDesignTasks.SelectedItem.ToString()))
                    {
                        foreach (TextBox t in hourBoxes)
                        {
                            if (t.Text != "")
                                hours.Add(Convert.ToDecimal(t.Text));
                        }

                        foreach (TextBox t in costBoxes)
                        {
                            if (t.Text != "")
                                cost.Add(Convert.ToDecimal(t.Text));
                        }

                        th.Text = hours.Sum().ToString();
                        tc.Text = cost.Sum().ToString("F");
                    }
                }
            }
            else
            {
                foreach (TextBox t in costBoxes)
                {
                    if (t.Text != "")
                        cost.Add(Convert.ToDecimal(t.Text));
                }

                tc.Text = cost.Sum().ToString("F");
            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (ddlProjects.SelectedValue != "-2")
                SubmitProductionPlan(chkApprove.Checked, chkUnapproved.Checked);
            else
                lblMessage.Text = "Please select a project to approve before attempting to submit.";

        }

        public void SubmitProductionPlan(bool approved, bool Unapproved)
        {
            // Project Row #
            int n = Convert.ToInt32(ddlProjects.SelectedValue) - 1;

            try
            {
                // Project Start Date
                dsNBD.PROJECT[n].projActStart = txtProjectStart.Text;

                if (approved == true)
                {
                    dsNBD.PROJECT[n].projCurrentPhase = "P";
                }
                if (Unapproved == true)
                {
                    dsNBD.PROJECT[n].projCurrentPhase = "D";
                }

                PROJECTTableAdapter daProjects = new PROJECTTableAdapter();
                daProjects.Update(dsNBD.PROJECT);

                if (approved == true)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Production Plan Has Been Approved!');window.location ='../Home.aspx';",
                true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Work Report Has Been Marked As Unapproved!');window.location ='../Home.aspx';",
                true);
                }
            }
            catch { }
        }

        protected void chkApprove_CheckedChanged(object sender, EventArgs e)
        {
            if (chkApprove.Checked && chkUnapproved.Checked)
                chkUnapproved.Checked = false;
        }

        protected void chkUnapproved_CheckedChanged(object sender, EventArgs e)
        {
            if (chkApprove.Checked && chkUnapproved.Checked)
                chkApprove.Checked = false;
        }
    }
}