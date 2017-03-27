using NBDLibrary;
using NBDLibrary.NBDDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NBDSite
{
    public partial class DesignBid : System.Web.UI.Page
    {
        //reference to the client data that remains in memory for the user's entire session
        private static NBDDataSet dsNBD;

        //reference to the current search records
        private static DataRow[] rows;

        static DesignBid()
        {

            //load data at the beginning of the session
            dsNBD = new NBDDataSet();
            CLIENTTableAdapter daClient = new CLIENTTableAdapter();
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            MATERIAL_REQTableAdapter daMatReq = new MATERIAL_REQTableAdapter();
            MATERIALTableAdapter daMaterial = new MATERIALTableAdapter();
            try
            {
                daClient.Fill(dsNBD.CLIENT);
                daProject.Fill(dsNBD.PROJECT);
                daMatReq.Fill(dsNBD.MATERIAL_REQ);
                daMaterial.Fill(dsNBD.MATERIAL);
            }
            catch { }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Design Manager") || User.IsInRole("Sales and Finance Manager") || User.IsInRole("Designer"))
            {
                PlaceHolder.Visible = true;
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

        //method to display Client information
        private void DisplayClientInfo()
        {
            rows = dsNBD.CLIENT.Select();
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[0].ToString() == ddlProjectName.SelectedValue.ToString())
                {
                    this.txtClientName.Text = row.ItemArray[1].ToString();
                    this.txtClientAdd.Text = row.ItemArray[2].ToString();
                    this.txtClientPhone.Text = row.ItemArray[6].ToString();
                    this.txtContact.Text = row.ItemArray[7].ToString() + " " + row.ItemArray[8].ToString() + ", " + row.ItemArray[9].ToString();
                }
            }
        }

        //method to display Project information
        private void DisplayProjectInfo()
        {
            rows = dsNBD.PROJECT.Select();
            foreach (DataRow row in rows)
            {
                if (row.ItemArray[0].ToString() == ddlProjectName.SelectedValue.ToString())
                {
                    this.txtProjSite.Text = row.ItemArray[2].ToString();
                    this.txtBidDate.Text = row.ItemArray[3].ToString();

                    DateTime temp;
                    if (DateTime.TryParse(txtBidDate.Text, out temp))
                    {
                        txtBidDate.Text = temp.ToShortDateString();
                    }
                }
            }
        }

        //display Client and Project Information
        protected void ddlProjectName_SelectedIndexChanged(object sender, EventArgs e)
        {
            DisplayClientInfo();
            DisplayProjectInfo();
        }

        private static int id = 1;

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (id != -1)
            {
                try
                {
                    //dsNBD.PROJECT.FindByID(id).projEstStart = this.txtBeginDate.Text;
                    //dsNBD.PROJECT.FindByID(id).projEstEnd = this.txtComplDate.Text;
                    //dsNBD.PROJECT.FindByID(id).projEstCost = this.txtBidAmount.Text;
                    //dsNBD.MATERIAL_REQ.FindByID(id).mreqEstQty = Convert.ToInt16(this.txtPlantQ.Text);
                    //dsNBD.MATERIAL.FindByID(id).matDesc = this.txtPlantD.Text;
                    Save();
                }
                catch
                {
                    this.lblMessage.Text = "Unable to update - Invalid Input";
                }
            }
            else
                lblMessage.Text = "Ready";
        }

        //method to save changes back to the database
        private void Save()
        {
            PROJECTTableAdapter daProject = new PROJECTTableAdapter();
            try
            {
                //daProject.Update(dsNBD.PROJECT);
                //dsNBD.AcceptChanges();
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Design Bid Submitted!');window.location ='../Home.aspx';",
                true);
            }
            catch
            {
                this.lblMessage.Text = "Unable to update";
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