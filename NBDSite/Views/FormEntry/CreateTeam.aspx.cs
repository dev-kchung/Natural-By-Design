using NBDLibrary;
using NBDLibrary.NBDDataSetTableAdapters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NBDSite.Views.FormEntry
{
    public partial class CreateTeam : System.Web.UI.Page
    {
        private static NBDDataSet dsNBD;
        //dsNBD = new NBDDataSet();
        //PRODTableAdapter daClient = new CLIENTTableAdapter();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Design Manager") || User.IsInRole("Sales and Finance Manager"))
            {
                PlaceHolder.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";

            }
        }

        protected void btnCreateTeam_Click(object sender, EventArgs e)
        {
            Create();
        }


        public void Create()
        {
            if (2==2)
            {
                // Project Row #
                //int n = Convert.ToInt32(ddlProjName.SelectedValue) - 1;

                try
                {
                    // Project Start Date
                    //dsNBD.PROD_TEAM[n].projectID = ;




                    //PROJECTTableAdapter daProjects = new PROJECTTableAdapter();
                    //daProjects.Update(dsNBD.PROJECT);

                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                    "alert",
                    "alert('Team Created!');window.location ='../Home.aspx';",
                    true);
                }
                catch { }
            }
            else
            {
                lblMessage.Text = "Please select a project before attempting to submit.";
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