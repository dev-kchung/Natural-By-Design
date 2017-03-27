using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NBDSite.Views.Approval
{
    public partial class DesignBudgetApproval : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.IsInRole("Design Manager") || User.IsInRole("Sales and Finance Manager"))
            {
                PlaceHolder1.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "!";
            }



        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("Account/Login.aspx", true);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (chkApproved.Checked == true)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Design Budget Has Been Approved!');window.location ='../Home.aspx';",
                true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Design Bid Has Been Marked As Unapproved!');window.location ='../Home.aspx';",
                true);
            }
        }
    }
}