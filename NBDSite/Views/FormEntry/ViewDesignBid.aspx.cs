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
    public partial class ViewDesignBid : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;
        private static DataRow[] rows;

        protected void Page_Load(object sender, EventArgs e)
        {
            string projID = Request.QueryString["projID"].Trim();
            Page.MaintainScrollPositionOnPostBack = true;
            if (User.IsInRole("Design Manager") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Production Manager") || User.IsInRole("Admin"))
            {
                PlaceHolder1.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";

                FillGeneralInfo();
                FillProjectInfo();
                Summary();

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

        static ViewDesignBid()
        {
            dsNBD = new NBDDataSet();
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            TASKTableAdapter daTask = new TASKTableAdapter();
            WORKER_TYPETableAdapter daWorkerType = new WORKER_TYPETableAdapter();
            MATERIALTableAdapter daMaterial = new MATERIALTableAdapter();
            INVENTORYTableAdapter daInventory = new INVENTORYTableAdapter();
            MATERIAL_REQTableAdapter daMaterialReq = new MATERIAL_REQTableAdapter();
            CLIENTTableAdapter daClient = new CLIENTTableAdapter();
            LABOUR_SUMMARYTableAdapter daLabourSummary = new LABOUR_SUMMARYTableAdapter();

            try
            {
                daProject.Fill(dsNBD.PROJECT);
                daTask.Fill(dsNBD.TASK);
                daWorkerType.Fill(dsNBD.WORKER_TYPE);
                daMaterial.Fill(dsNBD.MATERIAL);
                daInventory.Fill(dsNBD.INVENTORY);
                daMaterialReq.Fill(dsNBD.MATERIAL_REQ);
                daClient.Fill(dsNBD.CLIENT);
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

        public void FillGeneralInfo()
        {
            string projID = Request.QueryString["projID"].Trim();

            // Worker Cost txt
            GetWorkerPriceByType("Designer", txtDesignC);
            GetWorkerPriceByType("Production Worker", txtProductionC);
            GetWorkerPriceByType("Equipment Operator", txtHeoC);

            //Project Team
            GetWorkerByType(projID, 7, txtSalesAssoc, null);
            GetWorkerByType(projID, 2, txtDesigner, null);

        }

        public void FillProjectInfo()
        {
            // Project ID
            string projectID = Request.QueryString["projID"].Trim();
            string clientID = "";

            // Project Info
            rows = dsNBD.PROJECT.Select("ID=" + projectID);
            foreach (DataRow row in rows)
            {
                txtProjectName.Text = row.ItemArray[1].ToString();
                txtProjectStart.Text = row.ItemArray[6].ToString();
                txtProjectEnd.Text = row.ItemArray[5].ToString();
                txtProjectSite.Text = row.ItemArray[2].ToString();
                txtProjectBid.Text = row.ItemArray[8].ToString();
                txtProjectBidDate.Text = row.ItemArray[3].ToString();
                clientID = row.ItemArray[14].ToString();
            }

            // Client Info
            rows = dsNBD.CLIENT.Select("ID=" + clientID);
            foreach (DataRow row in rows)
            {
                txtClientName.Text = row.ItemArray[1].ToString();
                txtClientPhone.Text = row.ItemArray[6].ToString();
                txtClientContact.Text = row.ItemArray[7].ToString() + " " + row.ItemArray[8].ToString();
                txtClientAddress.Text = row.ItemArray[2].ToString();
            }

            // Plants
            FillProjectMaterialsByType(projectID, "Plant");
            // Pottery
            FillProjectMaterialsByType(projectID, "Pottery");
            // Material
            FillProjectMaterialsByType(projectID, "Materials");
            // Tools
            GetTools(projectID);

            // Work Summary Info
            rows = dsNBD.LABOUR_SUMMARY.Select("projectID=" + projectID);
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[2].ToString() == "1")
                {
                    txtProductionH.Text = row.ItemArray[3].ToString();
                    GetWorkerPriceByType("Production Worker", txtProductionC);
                    txtProductionE.Text = CalcExtCost(txtProductionH.Text, txtProductionC.Text).ToString();
                }
                else if (row.ItemArray[2].ToString() == "2")
                {
                    txtDesignH.Text = row.ItemArray[3].ToString();
                    GetWorkerPriceByType("Designer", txtDesignC);
                    txtDesignE.Text = CalcExtCost(txtDesignH.Text, txtDesignC.Text).ToString();
                }
                else if (row.ItemArray[2].ToString() == "3")
                {
                    txtHeoH.Text = row.ItemArray[3].ToString();
                    GetWorkerPriceByType("Equipment Operator", txtHeoC);
                    txtHeoE.Text = CalcExtCost(txtHeoH.Text, txtHeoC.Text).ToString();
                }
            }

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
                    txtPlantType.Text = row.ItemArray[7].ToString();
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
                    txtPotteryType.Text = row.ItemArray[7].ToString();
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
                    txtMaterialType.Text = row.ItemArray[7].ToString();
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
                txtToolType.Text = row.ItemArray[6].ToString();
                txtToolDeliverFrom.Text = row.ItemArray[4].ToString();
                txtToolDeliverTo.Text = row.ItemArray[5].ToString();
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
            try
            {
                // Total Hours
                List<decimal> totalHours = new List<decimal>();
                totalHours.Add(Convert.ToDecimal(txtDesignH.Text));
                totalHours.Add(Convert.ToDecimal(txtProductionH.Text));
                totalHours.Add(Convert.ToDecimal(txtHeoH.Text));

                lblSumTotalH.Text = totalHours.Sum().ToString();

                // Total Cost
                List<decimal> totalCost = new List<decimal>();
                List<TextBox> totalCostTextboxes = new List<TextBox>() { txtPlantE, txtPotteryE, txtMaterialE, txtDesignE, txtProductionE, txtHeoE };
                foreach (TextBox txt in totalCostTextboxes)
                    totalCost.Add(Convert.ToDecimal(txt.Text));

                decimal tc = totalCost.Sum();
                lblSumTotalC.Text = tc.ToString("c");

                // Percentage
                try
                {
                    decimal b = Convert.ToDecimal(txtProjectBid.Text);
                    decimal p = (tc / b) * 100;
                    lblSumTotalP.Text = "(" + p.ToString("F") + "% of bid currently spent)";
                    if (p > 70 || p < 50)
                    {
                        lblSumTotalP.ForeColor = System.Drawing.Color.Red;
                        if (p > 70)
                            lblSumTotalP.Text += " [50%-70% LIMIT EXCEEDED]";
                        if (p < 50)
                            lblSumTotalP.Text += " [50%-70% LIMIT NOT MET]";
                    }


                }
                catch { }

                // Designer Hours & Cost
                List<TextBox> h = new List<TextBox>() { txtDesignH };
                List<TextBox> c = new List<TextBox>() { txtDesignE };
                CalcHoursAndCost(h, c, lblSumDesignH, lblSumDesignC);

                // Production Hours & Cost
                h = new List<TextBox>() { txtProductionH };
                c = new List<TextBox>() { txtProductionE };
                CalcHoursAndCost(h, c, lblSumProdH, lblSumProdC);

                // HEO Hours & Cost
                h = new List<TextBox>() { txtHeoH };
                c = new List<TextBox>() { txtHeoE };
                CalcHoursAndCost(h, c, lblSumHeoH, lblSumHeoC);

                // Materials Cost
                c = new List<TextBox>() { txtPlantE, txtPotteryE, txtMaterialE };
                CalcHoursAndCost(null, c, null, lblSumMaterialsC);
            }
            catch { }
            


        }

        public void CalcHoursAndCost(List<TextBox> hourBoxes, List<TextBox> costBoxes, Label th, Label tc)
        {
            List<decimal> hours = new List<decimal>();
            List<decimal> cost = new List<decimal>();

            if (hourBoxes != null)
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
                tc.Text = "$" + cost.Sum().ToString("F");
            }
            else
            {
                foreach (TextBox t in costBoxes)
                {
                    if (t.Text != "")
                        cost.Add(Convert.ToDecimal(t.Text));
                }

                tc.Text = "$" + cost.Sum().ToString("F");
            }

        }

        protected void ddlPlant_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlPottery_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void ddlMaterial_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void txtProjectName_TextChanged(object sender, EventArgs e)
        {

        }
    }
}