using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Threading;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace TheExplorer
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        /*
         Handler to authenticate every incoming request
             */
        void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            //Get the cookie from the request
            HttpCookie cookie =
                Context.Request.Cookies[FormsAuthentication.FormsCookieName];

            if (cookie != null)
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(cookie.Value);

                //Get the userdata, i.e Role from the cookie
                string[] roles = ticket.UserData.Split(new[] { "," }, StringSplitOptions.RemoveEmptyEntries);

                //Get the User and set in the context
                var identity = new GenericIdentity(ticket.Name);
                var user = new GenericPrincipal(identity, roles);

                HttpContext.Current.User = user;
                Thread.CurrentPrincipal = HttpContext.Current.User;
            }
        }
    }
}