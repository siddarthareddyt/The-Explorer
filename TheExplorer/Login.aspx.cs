using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExplorerLibrary;

namespace TheExplorer
{
    public partial class Login : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User!=null && User.Identity.IsAuthenticated)
            {
                //If authenticated already, Redirect to appropriate Page depending on role
                if (User.IsInRole("Member"))
                {
                    Response.Redirect("Members/Members.aspx");
                }
                else if(User.IsInRole("Staff")){
                    Response.Redirect("Staff/Staff.aspx");
                }
            }

        }

        
        //LogsIn the User
        protected void Login_User(object sender, EventArgs e)
        {
            ErrorMessage.Text = null;
            ErrorMessage.Visible = false;
            ExLibrary library = new ExLibrary();
            string userName = UserName.Text.Trim();
            string pass = password.Text.Trim();
            //Authenticates an user gets the corresponding Role
            string role = XmlOperations.authenticateMember(userName, library.hash(pass));

            //If login successfull
            if (!role.Equals("INVALID"))
            {
                var roles = new[] { role};

                //Set an authorisation cookie used for consequent logins
                FormsAuthentication.SetAuthCookie(userName, true);

                //Ticket store userdata in the cookie
               FormsAuthenticationTicket ticket1 = new FormsAuthenticationTicket(1, userName, DateTime.Now, DateTime.Now.AddMinutes(10), true, string.Join(",", roles), FormsAuthentication.FormsCookiePath);

               HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, FormsAuthentication.Encrypt(ticket1));
                if (!Persistent.Checked)
                    cookie.Expires = ticket1.Expiration;

                //Add the encrypted cookie to the Response
               Response.Cookies.Add(cookie);

                //If there isn't a redirection to login page
                string returnUrl = Request.QueryString["returnUrl"];
                if (string.IsNullOrEmpty(returnUrl))
                    Response.Redirect("Default.aspx");
                else
                    Response.Redirect(returnUrl, true);
            }
            else {
                ErrorMessage.Text = "Invalid UserName and Password. Try Again.";
                ErrorMessage.Visible = true;
            }
        }

    }
}