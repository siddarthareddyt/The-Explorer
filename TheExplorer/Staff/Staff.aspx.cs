using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExplorerLibrary;

namespace TheExplorer.Staff
{
    public partial class Staff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Check whether the user is Authenticated and has appropriate role before displaying the page
            if (User.Identity.IsAuthenticated && User.IsInRole("Staff"))
            {
                UserName.Text = "Welcome "+User.Identity.Name;

            }
            else {
                //Else  Redirect to Login page for login
                Response.Redirect("~/Login.aspx");
            }

        }

        //Logout
        protected void LogoutClicked(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Response.Redirect("~/Default.aspx");
        }

        protected void hashFunction(object sender, EventArgs e) {
            string plain = plainText.Text;
            ExLibrary lib = new ExLibrary();
            if (!string.IsNullOrEmpty(plain))
            {
                HashText.Text=lib.hash(plain);
                HashText.Visible = true;
            }
            else {
                HashText.Text = "Please enter a text to convert into hash";
                HashText.Visible = true;
            }

        }
    }
}