//Arden Metcalfe-Roach
//Kim Chung
//Baljit Bharaj
//PROG 1210
//12/16/2016

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
    public partial class ProductionPlan : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;
        private static DataRow[] rows;
        // List of controls that need to be added
        List<string> controlIDList = new List<string>(); //List to store Control IDs
        List<int> materialIDList = new List<int>();
        // Counter for textboxes
        int counter = 0;

        protected override void LoadViewState(object savedState) //LoadViewState must come before Page_Load
        {
            // Load viewstate
            base.LoadViewState(savedState);

            // Retrieve controls
            controlIDList = (List<string>)ViewState["controlIDList"]; //Retrieving stored control ID

            // Add controls to page
            foreach (string Id in controlIDList)
            {
                counter++;

                List<TextBox> txts = new List<TextBox>();
                List<DropDownList> ddls = new List<DropDownList>();
                List<Label> lbls = new List<Label>();
                List<PlaceHolder> phsTxt = new List<PlaceHolder>() { phPlantQ, phPlantS, phPlantU, phPlantE, phPlantD, phPlantI,
                        phPotteryQ, phPotteryS, phPotteryU, phPotteryE, phPotteryD, phPotteryI,
                        phMatQ, phMatS, phMatU, phMatE, phMatD, phMatI,
                        phToolQ, phToolDeliverFrom,phToolDeliverTo,
                        phDesignH, phDesignC, phDesignE, phDesignTime,
                        phProdH, phProdC, phProdE, phProdTime,
                        phHeoH, phHeoC, phHeoE, phHeoTime,
                        phPlantChoose, phPlantLbl, phPotteryChoose, phPotteryLbl, phMatChoose, phMatLbl, phToolChoose,
                        phL1Choose, phL1TasksChoose, phProductionChoose, phProdTasksChoose, phHEOChoose, phHeoTasksChoose};

                CreateTextboxes(txts, phsTxt.Count());
                CreateDdls(ddls, 10);
                CreateLbls(lbls, 3);

                AddControlsToPage(Id, phsTxt, txts, ddls, lbls, false);

            }

        }


        protected void Page_Load(object sender, EventArgs e)
        {
            // Stop page from scrolling back up
            Page.MaintainScrollPositionOnPostBack = true;
            // Check permissions
            if (User.IsInRole("Production Manager") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Design Manager"))
            {
                // Makes placeholder visible
                PlaceHolder1.Visible = true;
                // Add date and welcome message
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";

                // Fill basic, non project related info
                if (ddlPlant.Items.Count == 1)
                    FillGeneralInfo();

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

        static ProductionPlan()
        {
            // Set up data adapters/data set
            dsNBD = new NBDDataSet();
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            TASKTableAdapter daTask = new TASKTableAdapter();
            WORKER_TYPETableAdapter daWorkerType = new WORKER_TYPETableAdapter();
            MATERIALTableAdapter daMaterial = new MATERIALTableAdapter();
            INVENTORYTableAdapter daInventory = new INVENTORYTableAdapter();
            MATERIAL_REQTableAdapter daMaterialReq = new MATERIAL_REQTableAdapter();

            try
            {
                daProject.Fill(dsNBD.PROJECT);
                daTask.Fill(dsNBD.TASK);
                daWorkerType.Fill(dsNBD.WORKER_TYPE);
                daMaterial.Fill(dsNBD.MATERIAL);
                daInventory.Fill(dsNBD.INVENTORY);
                daMaterialReq.Fill(dsNBD.MATERIAL_REQ);
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

            // When a new project is selected, clear the old info and fill in the new one
            if (ddlProjects.SelectedValue.ToString() != "-2")
            {
                lblMessage.Text = "";
                ClearProjectInfo();
                FillProjectInfo();
                // Update summary at the bottom
                Summary();
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

        }

        public void ClearProjectInfo()
        {
            // Get all textboxes
            var t = Form.Controls.OfType<TextBox>().AsEnumerable<TextBox>();

            // List of textboxes that shouldn't be empty
            List<TextBox> neededTextboxes = new List<TextBox>() { txtDesignC, txtProductionC, txtHeoC };
            // Loop through textboxes. If not a needed textbox, make empty
            foreach (TextBox item in t)
            {
                if (!neededTextboxes.Contains(item))
                    item.Text = "";

            }

            // Get all drop down lists
            var d = Form.Controls.OfType<DropDownList>().AsEnumerable<DropDownList>();
            // Set each ddl to "select..."
            foreach (DropDownList item in d)
                try { item.SelectedValue = "-1"; } catch { }

            // Reset labels
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

            // Get materials by project ID and type
            try { daMaterialReq.FillBy(dsNBD.MATERIAL_REQ, Convert.ToInt32(p), t); }
            catch { }

            // Select all materials from project
            rows = dsNBD.MATERIAL_REQ.Select();
            foreach (DataRow row in rows)
            {
                // For plants...
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
                    materialIDList.Add(Convert.ToInt32(row.ItemArray[4]));
                }
                // For pottery...
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
                    materialIDList.Add(Convert.ToInt32(row.ItemArray[4]));
                }
                // For materials...
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
                    materialIDList.Add(Convert.ToInt32(row.ItemArray[4]));
                }
            }
        }

        public void GetWorkerByType(string p, int t, TextBox txt, DropDownList ddl)
        {
            // Get a list of workers by their work type
            WORKERTableAdapter daWorker = new WORKERTableAdapter();

            // If a project id exists, search workers by project ID 
            if (p != null)
            {
                try { daWorker.FillBy(dsNBD.WORKER, t, Convert.ToInt32(p)); }
                catch { }

                rows = dsNBD.WORKER.Select();
            }
            // Other wise just select by type
            else
            {
                try { daWorker.Fill(dsNBD.WORKER); }
                catch { }
                rows = dsNBD.WORKER.Select("wrkTypeID=" + t);
            }

            // Check if control is textbox or ddl and fill in accordingly
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
            // Get price of worker by their work type
            rows = dsNBD.WORKER_TYPE.Select();
            foreach (DataRow row in rows)
            {
                decimal p;
                if (row.ItemArray[1].ToString() == type)
                {
                    // Update textbox with worker price
                    p = Convert.ToDecimal(row.ItemArray[3]);
                    txt.Text = p.ToString("F");
                }
            }
        }

        public void GetTools(string p)
        {
            // Get tools by project ID
            PROD_TOOLTableAdapter daProdTool = new PROD_TOOLTableAdapter();

            try { daProdTool.FillBy(dsNBD.PROD_TOOL, Convert.ToInt32(p)); }
            catch { }

            rows = dsNBD.PROD_TOOL.Select();
            foreach (DataRow row in rows)
            {
                // Update necessary textboxes/ddls
                txtToolQ.Text = row.ItemArray[3].ToString();
                ddlTools.SelectedValue = row.ItemArray[2].ToString();
                txtToolDeliverFrom.Text = row.ItemArray[4].ToString();
                txtToolDeliverTo.Text = row.ItemArray[5].ToString();
            }
        }

        public void GetMaterialsByType(string type, DropDownList ddl)
        {
            // Get materials by their type and add to drop down list
            rows = dsNBD.MATERIAL.Select();
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[2].ToString() == type)
                    ddl.Items.Add(row.ItemArray[1].ToString());
            }
        }

        // If worker hours are changed, update overall cost of project
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
            // Calculate overall cost, hours * cost
            decimal h = Convert.ToDecimal(hrs);
            decimal c = Convert.ToDecimal(cost);
            decimal extCost = h * c;

            return extCost;
        }

        // Update cost summary if any of these fields are changed
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
            // Calculate total cost and hours from all relevant textboxes
            List<decimal> hours = new List<decimal>();
            List<decimal> cost = new List<decimal>();

            // If 'hours worked' textboxes list is not empty, get cost of hours
            if (hourBoxes != null)
            {
                // If there are no tasks in tasks list
                if (tasks == null)
                {
                    // Calculate hours and cost
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
                // Otherwise, 
                else
                {
                    // Check what kind of task it is and update the relevant info in summary
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
            // Otherwise, just update cost
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

        // Add new row of textboxes if button is clicked for buttons below
        protected virtual void btnAddPlant_Click(object sender, EventArgs e)
        {
            // Increase counter
            counter++;

            // Makes lists for textboxes, ddls, and labels
            List<TextBox> txts = new List<TextBox>();
            List<DropDownList> ddls = new List<DropDownList>();
            List<Label> lbls = new List<Label>();
            // Makes list of all relevant placeholders for this button
            List<PlaceHolder> phsTxt = new List<PlaceHolder>() { phPlantQ, phPlantS, phPlantU, phPlantE, phPlantD, phPlantI, phPlantChoose, phPlantLbl };



            // Create textboxes for placeholders in list
            CreateTextboxes(txts, phsTxt.Count());
            // Create needed number of drop down lists
            CreateDdls(ddls, 1);
            // Create needed number of labels
            CreateLbls(lbls, 1);

            // Add controls to each place holder
            foreach (PlaceHolder p in phsTxt)
                AddControlsToPage(p.ID, phsTxt, txts, ddls, lbls, true);



            // Update list of controls
            ViewState["controlIDList"] = controlIDList;



        }

        protected void btnAddPottery_Click(object sender, EventArgs e)
        {
            counter++;

            List<TextBox> txts = new List<TextBox>();
            List<DropDownList> ddls = new List<DropDownList>();
            List<Label> lbls = new List<Label>();
            List<PlaceHolder> phs = new List<PlaceHolder>() { phPotteryQ, phPotteryS, phPotteryU, phPotteryE, phPotteryD, phPotteryI, phPotteryChoose, phPotteryLbl };

            CreateTextboxes(txts, phs.Count());
            CreateDdls(ddls, 1);
            CreateLbls(lbls, 1);

            foreach (PlaceHolder p in phs)
                AddControlsToPage(p.ID, phs, txts, ddls, lbls, true);


            ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state
        }

        protected void btnMaterials_Click(object sender, EventArgs e)
        {
            counter++;

            List<TextBox> txts = new List<TextBox>();
            List<DropDownList> ddls = new List<DropDownList>();
            List<Label> lbls = new List<Label>();
            List<PlaceHolder> phs = new List<PlaceHolder>() { phMatQ, phMatS, phMatU, phMatE, phMatD, phMatI, phMatChoose, phMatLbl };

            CreateTextboxes(txts, phs.Count());
            CreateDdls(ddls, 1);
            CreateLbls(lbls, 1);

            foreach (PlaceHolder p in phs)
                AddControlsToPage(p.ID, phs, txts, ddls, lbls, true);

            ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state
        }

        protected void btnAddTool_Click(object sender, EventArgs e)
        {
            counter++;

            List<TextBox> txts = new List<TextBox>();
            List<DropDownList> ddls = new List<DropDownList>();
            List<Label> lbls = new List<Label>();
            List<PlaceHolder> phs = new List<PlaceHolder>() { phToolQ, phToolDeliverFrom, phToolDeliverTo, phToolChoose };

            CreateTextboxes(txts, phs.Count());
            CreateDdls(ddls, 1);

            foreach (PlaceHolder p in phs)
                AddControlsToPage(p.ID, phs, txts, ddls, lbls, true);

            ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state
        }

        protected void btnAddDesign_Click(object sender, EventArgs e)
        {
            counter++;

            List<TextBox> txts = new List<TextBox>();
            List<DropDownList> ddls = new List<DropDownList>();
            List<Label> lbls = new List<Label>();
            List<PlaceHolder> phs = new List<PlaceHolder>() { phDesignH, phDesignC, phDesignE, phDesignTime, phL1Choose, phL1TasksChoose };

            CreateTextboxes(txts, phs.Count());
            CreateDdls(ddls, 2);

            foreach (PlaceHolder p in phs)
                AddControlsToPage(p.ID, phs, txts, ddls, lbls, true);

            ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state
        }

        protected void btnAddProd_Click(object sender, EventArgs e)
        {
            counter++;

            List<TextBox> txts = new List<TextBox>();
            List<DropDownList> ddls = new List<DropDownList>();
            List<Label> lbls = new List<Label>();
            List<PlaceHolder> phs = new List<PlaceHolder>() { phProdH, phProdC, phProdE, phProdTime, phProductionChoose, phProdTasksChoose };

            CreateTextboxes(txts, phs.Count());
            CreateDdls(ddls, 2);

            foreach (PlaceHolder p in phs)
                AddControlsToPage(p.ID, phs, txts, ddls, lbls, true);

            ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state
        }

        protected void btnAddHeo_Click(object sender, EventArgs e)
        {
            counter++;

            List<TextBox> txts = new List<TextBox>();
            List<DropDownList> ddls = new List<DropDownList>();
            List<Label> lbls = new List<Label>();
            List<PlaceHolder> phs = new List<PlaceHolder>() { phHeoH, phHeoC, phHeoE, phHeoTime, phHEOChoose, phHeoTasksChoose };

            CreateTextboxes(txts, phs.Count());
            CreateDdls(ddls, 2);

            foreach (PlaceHolder p in phs)
                AddControlsToPage(p.ID, phs, txts, ddls, lbls, true);

            ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state
        }

        // Create given number of textboxes
        public void CreateTextboxes(List<TextBox> txts, int txtNumber)
        {
            TextBox[] textboxes = new TextBox[txtNumber];

            for (int i = 0; i < txtNumber; i++)
            {
                textboxes[i] = new TextBox();
            }

            foreach (TextBox t in textboxes)
            {
                txts.Add(t);
            }
        }

        //Create given number of drop down lists
        public void CreateDdls(List<DropDownList> ddls, int ddlNumber)
        {
            DropDownList[] dropDownLists = new DropDownList[ddlNumber];

            for (int i = 0; i < ddlNumber; i++)
            {
                dropDownLists[i] = new DropDownList();
                dropDownLists[i].ID = "New";
            }

            foreach (DropDownList d in dropDownLists)
            {
                ddls.Add(d);
            }
        }

        // Create given number of labels
        public void CreateLbls(List<Label> lbls, int lblNumber)
        {
            Label[] labels = new Label[lblNumber];

            for (int i = 0; i < lblNumber; i++)
            {
                labels[i] = new Label();
            }

            foreach (Label l in labels)
            {
                l.ID = "New";
                lbls.Add(l);
            }
        }

        // Add controls to page
        public void AddControlsToPage(string Id, List<PlaceHolder> phs, List<TextBox> txts, List<DropDownList> ddls, List<Label> lbls, bool btn)
        {
            for (int i = 0; i < phs.Count(); i++)
            {
                if (Id.Contains(phs[i].ID.Substring(2)))
                {
                    if (!Id.Contains("Choose") && !Id.Contains("Lbl"))
                    {
                        txts[i].ID = Id;
                        if (btn == true)
                            txts[i].ID += counter.ToString();
                        LiteralControl lineBreak = new LiteralControl("<br /><br />");

                        phs[i].Controls.Add(lineBreak);
                        phs[i].Controls.Add(txts[i]);
                        phs[i].Controls.Add(lineBreak);

                        if (btn == true)
                        {
                            controlIDList.Add(txts[i].ID);
                        }
                    }
                    else if (Id.Contains("Choose"))
                    {
                        foreach (DropDownList d in ddls)
                        {
                            if (d.ID == "New")
                            {
                                d.ID = Id;
                                d.Items.Add("Select...");
                                d.Items[0].Value = "-1";
                                d.Items[0].Selected = true;
                                if (d.ID.Contains("Plant"))
                                    GetMaterialsByType("Plant", d);
                                else if (d.ID.Contains("Pottery"))
                                    GetMaterialsByType("Pottery", d);
                                else if (d.ID.Contains("Mat"))
                                    GetMaterialsByType("Materials", d);
                                else if (d.ID.Contains("Tool"))
                                {
                                    ListItem l = new ListItem();
                                    l.Value = "-1";
                                    l.Text = "Select...";

                                    d.DataSourceID = "odsTools";
                                    d.DataTextField = "toolDesc";
                                    d.DataValueField = "ID";
                                    d.AppendDataBoundItems = true;
                                    d.Items.Add(l);
                                }
                                else
                                    GetMaterialsByType("Plant", d);
                                if (btn == true)
                                    d.ID += counter.ToString();
                                LiteralControl lineBreak = new LiteralControl("<br /><br />");

                                phs[i].Controls.Add(lineBreak);
                                phs[i].Controls.Add(d);
                                phs[i].Controls.Add(lineBreak);
                                if (btn == true)
                                    controlIDList.Add(d.ID);

                                break;
                            }
                        }

                    }
                    else if (Id.Contains("Lbl"))
                    {
                        foreach (Label l in lbls)
                        {
                            if (l.ID == "New")
                            {
                                l.ID = Id;
                                if (btn == true)
                                    l.ID += counter.ToString();
                                LiteralControl lineBreak = new LiteralControl("<br /><br />");

                                phs[i].Controls.Add(lineBreak);
                                phs[i].Controls.Add(l);
                                phs[i].Controls.Add(lineBreak);
                                if (btn == true)
                                    controlIDList.Add(l.ID);

                                break;
                            }
                        }
                    }


                }
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

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            SubmitProductionPlan();
        }

        public void SubmitProductionPlan()
        {
            if (ddlProjects.SelectedValue != "-2")
            {
                //PROJECT ID
                int n = Convert.ToInt32(ddlProjects.SelectedValue) - 1;

                try
                {
                    //Project Start Date
                    dsNBD.PROJECT[n].projActStart = txtProjectStart.Text;

                    PROJECTTableAdapter daProjects = new PROJECTTableAdapter();
                    daProjects.Update(dsNBD.PROJECT);
                }
                catch { }

                //PLANTS LISTS
                List<string> PlantQ = new List<string>();
                List<string> PlantDesc = new List<string>();
                List<string> PlantD = new List<string>();
                List<string> PlantI = new List<string>();

                //POTTERY LISTS
                List<string> PotteryQ = new List<string>();
                List<string> PotteryDesc = new List<string>();
                List<string> PotteryD = new List<string>();
                List<string> PotteryI = new List<string>();

                //MATERIALS LISTS
                List<string> MaterialQ = new List<string>();
                List<string> MaterialDesc = new List<string>();
                List<string> MaterialD = new List<string>();
                List<string> MaterialI = new List<string>();

                //PLANTS
                foreach (TextBox txt in phPlantsOgControls.Controls.OfType<TextBox>())
                {
                    if (txt.ID.Contains("PlantQ"))
                        PlantQ.Add(txt.Text);
                    if (txt.ID.Contains("PlantD"))
                        PlantD.Add(txt.Text);
                    if (txt.ID.Contains("PlantI"))
                        PlantI.Add(txt.Text);
                }
                foreach (DropDownList ddl in phPlantsOgControls.Controls.OfType<DropDownList>())
                {
                    PlantDesc.Add(ddl.SelectedValue);
                }

                for (int i = 0; i < PlantQ.Count(); i++)
                {

                    //ADDS NEW ROW TO MATERIAL_REQ
                    NBDDataSet.MATERIAL_REQRow r = dsNBD.MATERIAL_REQ.NewMATERIAL_REQRow();
                    int matID = 0;
                    int invID = 0;

                    DataRow[] rowMatID = dsNBD.MATERIAL.Select("matDesc='" + PlantDesc[i] + "'");
                    foreach (DataRow row in rowMatID)
                        matID = Convert.ToInt32(row.ItemArray[0].ToString());

                    DataRow[] rowInvID = dsNBD.INVENTORY.Select("materialID=" + matID.ToString());
                    foreach (DataRow row in rowInvID)
                        invID = Convert.ToInt32(row.ItemArray[0].ToString());

                    r.projectID = Convert.ToInt32(ddlProjects.SelectedValue);
                    r.inventoryID = invID;
                    r.mreqDeliver = Convert.ToDateTime(PlantD[i]);
                    r.mreqInstall = Convert.ToDateTime(PlantI[i]);
                    r.mreqActQty = Convert.ToInt16(PlantQ[i]);
                    r.mreqEstQty = Convert.ToInt16(PlantQ[i]);

                    dsNBD.MATERIAL_REQ.Rows.Add(r);
                    MATERIAL_REQTableAdapter daMaterialReq = new MATERIAL_REQTableAdapter();
                    daMaterialReq.Update(dsNBD.MATERIAL_REQ);

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert",
                    "alert('Production Plan Submitted!');window.location ='../Home.aspx';",
                    true);
                }

                //POTTERY
                foreach (TextBox txt in phPotteryOgControls.Controls.OfType<TextBox>())
                {
                    if (txt.ID.Contains("PotteryQ"))
                        PotteryQ.Add(txt.Text);
                    if (txt.ID.Contains("PotteryD"))
                        PotteryD.Add(txt.Text);
                    if (txt.ID.Contains("PotteryI"))
                        PotteryI.Add(txt.Text);
                }
                foreach (DropDownList ddl in phPotteryOgControls.Controls.OfType<DropDownList>())
                {
                    PotteryDesc.Add(ddl.SelectedValue);
                }

                for (int i = 0; i < PotteryQ.Count(); i++)
                {

                    NBDDataSet.MATERIAL_REQRow r = dsNBD.MATERIAL_REQ.NewMATERIAL_REQRow();
                    int matID = 0;
                    int invID = 0;

                    DataRow[] rowMatID = dsNBD.MATERIAL.Select("matDesc='" + PotteryDesc[i] + "'");
                    foreach (DataRow row in rowMatID)
                        matID = Convert.ToInt32(row.ItemArray[0].ToString());

                    DataRow[] rowInvID = dsNBD.INVENTORY.Select("materialID=" + matID.ToString());
                    foreach (DataRow row in rowInvID)
                        invID = Convert.ToInt32(row.ItemArray[0].ToString());

                    r.projectID = Convert.ToInt32(ddlProjects.SelectedValue);
                    r.inventoryID = invID;
                    r.mreqDeliver = Convert.ToDateTime(PotteryD[i]);
                    r.mreqInstall = Convert.ToDateTime(PotteryI[i]);
                    r.mreqActQty = Convert.ToInt16(PotteryQ[i]);
                    r.mreqEstQty = Convert.ToInt16(PotteryQ[i]);

                    dsNBD.MATERIAL_REQ.Rows.Add(r);
                    MATERIAL_REQTableAdapter daMaterialReq = new MATERIAL_REQTableAdapter();
                    daMaterialReq.Update(dsNBD.MATERIAL_REQ);

                    lblMessage.Text = "Production Plan Submitted";
                }

                //MATERIALS
                foreach (TextBox txt in phMaterialsOgControls.Controls.OfType<TextBox>())
                {
                    if (txt.ID.Contains("MaterialQ"))
                        MaterialQ.Add(txt.Text);
                    if (txt.ID.Contains("MaterialD"))
                        MaterialD.Add(txt.Text);
                    if (txt.ID.Contains("MaterialI"))
                        MaterialI.Add(txt.Text);
                }
                foreach (DropDownList ddl in phMaterialsOgControls.Controls.OfType<DropDownList>())
                {
                    MaterialDesc.Add(ddl.SelectedValue);
                }

                for (int i = 0; i < MaterialQ.Count(); i++)
                {
                    NBDDataSet.MATERIAL_REQRow r = dsNBD.MATERIAL_REQ.NewMATERIAL_REQRow();
                    int matID = 0;
                    int invID = 0;

                    DataRow[] rowMatID = dsNBD.MATERIAL.Select("matDesc='" + MaterialDesc[i] + "'");
                    foreach (DataRow row in rowMatID)
                        matID = Convert.ToInt32(row.ItemArray[0].ToString());

                    DataRow[] rowInvID = dsNBD.INVENTORY.Select("materialID=" + matID.ToString());
                    foreach (DataRow row in rowInvID)
                        invID = Convert.ToInt32(row.ItemArray[0].ToString());

                    r.projectID = Convert.ToInt32(ddlProjects.SelectedValue);
                    r.inventoryID = invID;
                    r.mreqDeliver = Convert.ToDateTime(MaterialD[i]);
                    r.mreqInstall = Convert.ToDateTime(MaterialI[i]);
                    r.mreqActQty = Convert.ToInt16(MaterialQ[i]);
                    r.mreqEstQty = Convert.ToInt16(MaterialQ[i]);

                    dsNBD.MATERIAL_REQ.Rows.Add(r);
                    MATERIAL_REQTableAdapter daMaterialReq = new MATERIAL_REQTableAdapter();
                    daMaterialReq.Update(dsNBD.MATERIAL_REQ);

                    lblMessage.Text = "Production Plan Submitted";
                }



            }

            else
            {
                lblMessage.Text = "Please select a project before attempting to submit.";
            }
        }

    }
}