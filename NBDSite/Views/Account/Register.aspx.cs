//Arden Metcalfe-Roach
//Kim Chung
//Baljit Bharaj
//PROG 1210
//12/16/2016
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Owin;

namespace NBDSite
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            //updating database
            UserStore<IdentityUser> userStore = new UserStore<IdentityUser>();
            UserManager<IdentityUser> manager = new UserManager<IdentityUser>(userStore);

            IdentityUser user = new IdentityUser(txtUsername.Text);
            IdentityResult idResult = manager.Create(user, txtPassword.Text);
            //sending sucess message
            if (idResult.Succeeded)
                lblMessage.Text = "User " + user.UserName + " was created successfully!";
            //error handling
            else
                lblMessage.Text = idResult.Errors.FirstOrDefault();

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            try
            {
                var userIdentity = manager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);

                authenticationManager.SignIn(userIdentity);

                Response.Redirect("../Home.aspx");
            }
            catch
            {
                lblMessage.Text = "Invalid credentials.";
            }
            

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}