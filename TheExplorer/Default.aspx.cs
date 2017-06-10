using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TheExplorer
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //   If the user is already logged in, show his name and logout option
            if (User != null && User.Identity.IsAuthenticated)
            {
                UserName.Text = User.Identity.Name;
                UserName.Visible = true;
                logout.Visible = true;
            }

        }

        //Logout from application
        protected void LogoutClicked(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Response.Redirect("~/Default.aspx");
        }

        //Redirect to Members page
        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Members/Members.aspx");
        }

        // Redirect to SignUp page
        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("MemberSignUp.aspx");
        }
    }
}