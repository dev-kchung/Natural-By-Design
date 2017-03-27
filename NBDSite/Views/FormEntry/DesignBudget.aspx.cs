using NBDLibrary;
using NBDLibrary.NBDDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Odbc;

namespace NBDSite
{
    public partial class DesignBudget : System.Web.UI.Page
    {
        //reference to the client data that remains in memory for the user's entire session
        private static NBDDataSet dsNBD;

        //reference to the current search records
        private static DataRow[] rows;

        //List<string> controlIDList = new List<string>(); //List to store Control IDs
        //int counter = 0;

        //protected override void LoadViewState(object savedState) //LoadViewState must come before Page_Load
        //{
        //    base.LoadViewState(savedState);

        //    controlIDList = (List<string>)ViewState["controlIDList"]; //Retrieving stored control ID

        //    foreach (string Id in controlIDList)
        //    {
        //        counter++;

        //        List<TextBox> txts = new List<TextBox>();
        //        List<PlaceHolder> phs = new List<PlaceHolder>() { phHTDTask, phHTDDate, phHTDHours, phEHTask,
        //        phEHDate, phEHHours};

        //        CreateTextboxes(txts, phs.Count());

        //        AddTextboxes(Id, phs, txts, false);
        //    }

        //}
        ////Add Hours to Date Button
        //protected virtual void btnAddHTD_Click(object sender, EventArgs e)
        //{

        //    counter++;

        //    List<TextBox> txts = new List<TextBox>();
        //    List<PlaceHolder> phs = new List<PlaceHolder>() { phHTDTask, phHTDDate, phHTDHours};

        //    CreateTextboxes(txts, phs.Count());

        //    foreach (PlaceHolder p in phs)
        //        AddTextboxes(p.ID, phs, txts, true);

        //    ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state

        //}

        ////Add Estimated Hours to Date button
        //protected void btnAddEH_Click(object sender, EventArgs e)
        //{
        //    counter++;

        //    List<TextBox> txts = new List<TextBox>();
        //    List<PlaceHolder> phs = new List<PlaceHolder>() {  phEHTask, phEHDate, phEHHours};

        //    CreateTextboxes(txts, phs.Count());

        //    foreach (PlaceHolder p in phs)
        //        AddTextboxes(p.ID, phs, txts, true);

        //    ViewState["controlIDList"] = controlIDList; //Storing ID of newly generated textboxes into view state
        //}

        //public void CreateTextboxes(List<TextBox> txts, int txtNumber)
        //{
        //    TextBox[] textboxes = new TextBox[txtNumber];

        //    for (int i = 0; i < txtNumber; i++)
        //    {
        //        textboxes[i] = new TextBox();
        //    }

        //    foreach (TextBox t in textboxes)
        //    {
        //        txts.Add(t);
        //    }
        //}

        //public void AddTextboxes(string Id, List<PlaceHolder> phs, List<TextBox> txts, bool btn)
        //{
        //    for (int i = 0; i < phs.Count(); i++)
        //    {
        //        if (Id.Contains(phs[i].ID.Substring(2)))
        //        {
        //            txts[i].ID = Id;
        //            if (btn == true)
        //                txts[i].ID += counter.ToString();
        //            LiteralControl lineBreak = new LiteralControl("<br /><br />");
        //            phs[i].Controls.Add(lineBreak);
        //            phs[i].Controls.Add(txts[i]);
        //            phs[i].Controls.Add(lineBreak);

        //            if (btn == true)
        //            {
        //                controlIDList.Add(txts[i].ID);
        //            }
        //        }
        //}
        //}

        static DesignBudget()
        {
            //load data at the beginning of the session
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
            if (User.IsInRole("Designer") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Design Manager"))
            {
                PlaceHolder1.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";

                if (User.IsInRole("Designer"))
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
            }

        }

        //Display Required Client Info
        private void DisplayClientInfo()
        {
            rows = dsNBD.CLIENT.Select();
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[0].ToString() == ddlClientInfo.SelectedValue.ToString())
                {
                    this.txtClientAdd.Text = row.ItemArray[2].ToString();
                    this.txtClientPhone.Text = row.ItemArray[6].ToString();
                    this.txtContact.Text = row.ItemArray[7].ToString() + " " + row.ItemArray[8].ToString() + ", " + row.ItemArray[9].ToString();
                }
            }
        }

        //Display Required Project Info
        private void DisplayProjectInfo()
        {
            rows = dsNBD.PROJECT.Select();
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[0].ToString() == ddlProjectInfo.SelectedValue.ToString())
                {
                    this.txtBudSub.Text = row.ItemArray[9].ToString();
                    this.txtProjSite.Text = row.ItemArray[2].ToString();
                    this.txtBeginDate.Text = row.ItemArray[4].ToString();
                    this.txtComplDate.Text = row.ItemArray[5].ToString();
                    //fix this
                    this.txtBidAmount.Text = row.ItemArray[8].ToString();
                }
            }
        }

        //Displaying selected client
        protected void ddlClientInfo_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayClientInfo();
        }

        //Displaying selected project
        protected void ddlProjectInfo_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayProjectInfo();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            AddDesignBudget();
        }

        public void AddDesignBudget()
        {
            try
            {
                //calculating 10 % of the Bid Amount
                var tenPercent = double.Parse(txtBidAmount.Text) * 0.10;
                //calculating cost of the designers (SHOULD WE HARD CODE THE COST?)
                var designerCost = double.Parse(txtTotalHours.Text) * 40;

                //comparing 10% to the designers budget
                if (designerCost <= tenPercent)
                {
                    //display pop up and redirect to home page
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert",
                    "alert('Design Budget Sent for Approval');window.location ='../Home.aspx';",
                    true);
                }

                else
                {
                    Response.Write("<script>alert('" + "Design Budget must be equal to or less than 10% of total bid amount" + "')</script>");
                }

            }

            catch (Exception ex)
            {
                lblMessage.Text = "Unable to create Design Budget: " + ex.Message;
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

