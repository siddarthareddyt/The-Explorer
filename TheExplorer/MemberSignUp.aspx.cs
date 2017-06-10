using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExplorerLibrary;
using System.Web.Security;
using System.Net;
using System.Runtime.Serialization.Json;
using System.IO;
using System.Xml;

namespace TheExplorer
{
    public partial class MemberSignUp : System.Web.UI.Page
    {
        private const string capSecretKey = "6LeGfAwUAAAAANgnS2Y72-U7yZMh_PlY7gTwkiQx";
        string captchaImage = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Logout any logged in users before starting signup
            if (User != null && User.Identity.IsAuthenticated)
                FormsAuthentication.SignOut();

            
            String verifyImageUrl = "http://venus.eas.asu.edu/WSRepository/Services/ImageVerifier/Service.svc/GetVerifierString/5";
            if (string.IsNullOrEmpty(inputImgVerify.Text)) {
                //url is built
                WebRequest stringRequest = WebRequest.Create(verifyImageUrl);
                //georequest is the request made to obtain user current location details
                stringRequest.Credentials = CredentialCache.DefaultCredentials;
                WebResponse stringResponse = stringRequest.GetResponse();
                Stream stringDataStream = stringResponse.GetResponseStream();
                XmlDocument stringXmlDoc = new XmlDocument();
                stringXmlDoc.Load(stringDataStream);

                XmlNodeList stringNode = stringXmlDoc.GetElementsByTagName("string");
                captchaImage = stringNode[0].FirstChild.InnerText;
                verifyImage.ImageUrl = "http://venus.eas.asu.edu/WSRepository/Services/ImageVerifier/Service.svc//GetImage/" + captchaImage;
            }else
            {
                int index = verifyImage.ImageUrl.LastIndexOf('/');
                captchaImage = verifyImage.ImageUrl.Substring(index+1);
            }
            
        }

        /*
         Creates a new user 
             */
        protected void CreateUser_Click(object sender, EventArgs e)
        {
            ErrorMessage.Visible = false;
            ErrorMessage.Text = null;
            string memberName = MemberName.Text;
            string userName = Email.Text;
            string password = Password.Text;
            string confirmPass = ConfirmPassword.Text;

            bool status =false;

            //If the page validation is susscessfull
            if (IsValid) {
                if (inputImgVerify.Text.Trim() ==captchaImage)
                {
                    //Use the DLL library to hash
                    ExLibrary explorerLibrary = new ExLibrary();
                    string hashPassword = explorerLibrary.hash(password);
                    //Use the XmlOperations to add a new user to Members.Xml. 
                    status = XmlOperations.createMember(memberName, userName, hashPassword);
                }else
                {
                    ErrorMessage.Text = "Please enter correct Captcha.";
                    ErrorMessage.Visible = true;
                    return;
                }
                
            }

            if (status)
            {
                //If addition is successfull, navigate user to Login
                Response.Redirect("Login.aspx");
            }
            else {
                ErrorMessage.Text = "Unable to create a User. Please try again.";
                ErrorMessage.Visible = true;
            }
        }
    }
}