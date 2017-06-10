using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TheExplorer
{
    public partial class LogoutControl : System.Web.UI.UserControl
    {
        public event EventHandler LogOutClicked;

        /*
         Provides User a custom event handler to perform custom navigations upon logout
             */
        protected void Image1_Click(object sender, ImageClickEventArgs e)
        {
            if (LogOutClicked!=null) {
                LogOutClicked(this,EventArgs.Empty);
            }
        }
    }
}