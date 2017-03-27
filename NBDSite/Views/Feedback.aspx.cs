using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NBDSite
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                PlaceHolder1.Visible = true;
                DateTime today = DateTime.Now;
                lblDate.Text = today.ToLongDateString();// + "  |  " + today.ToShortTimeString();
                lblWelcome.Text = "Welcome, " + User.Identity.Name + "! | ";

                if (User.IsInRole("Production Worker") || User.IsInRole("Designer"))
                {
                    hlNewProject.Visible = false;
                    hlClients.Visible = false;
                }
                if (User.IsInRole("Admin"))
                {
                    hlNewProject.Visible = false;
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

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
            Session.Abandon();
            Response.Redirect("Account/Login.aspx", true);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "alert",
                "alert('Your Feedback Has Been Sent! Thank You!');window.location ='Home.aspx';",
                true);
        }
    }
}