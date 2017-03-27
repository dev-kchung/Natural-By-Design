using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;
using Microsoft.Owin.Security.Cookies;
using Microsoft.AspNet.Identity;

[assembly: OwinStartup(typeof(NBDSite.Startup))]

namespace NBDSite
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            // For more information on how to configure your application, visit http://go.microsoft.com/fwlink/?LinkID=316888
            app.UseCookieAuthentication(new CookieAuthenticationOptions
            {
                AuthenticationType = DefaultAuthenticationTypes.ApplicationCookie,
                CookieName = "MovieCookie",
                LoginPath = new PathString("/LogIn"),
                LogoutPath = new PathString("/LogIn"),
                ExpireTimeSpan = System.TimeSpan.FromMinutes(5)
            });


        }
    }
}
