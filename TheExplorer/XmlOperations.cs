using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Xml.Linq;
using System.Xml;

namespace TheExplorer
{
    public class XmlOperations
    {
        //Path to the Xml file that stores the Members' credentials
        static string MEMBER_FILE = HttpContext.Current.ApplicationInstance.Server.MapPath("~/App_Data/Members.xml");
       

        /*
         Authenticates a logging in user against the Xml file Members.xml
             */
        public static string authenticateMember(string username, string password)
        {
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(MEMBER_FILE);
            //Get the nodes with emailId same as username
            XmlNodeList nodes = xmlDocument.SelectNodes(string.Format("/Members/Member/email[text()='" + username + "']"));
            foreach (XmlNode node in nodes)
            {
                //If the emailId is associated with same password
                if (node.ParentNode.ChildNodes[2].InnerText == password)
                {
                    //Return the Role of the member, i.e Member or Staff
                    return node.ParentNode.ChildNodes[3].InnerText;
                }
            }
            //Return INVALID for unsuccessful logins
            return "INVALID";
        }

        /*
         Creates a member in the Member.xml file. Used to SignUp a Member or Add a staff by admin
             */
        public static bool createMember(string memberName,string username, string password)
        {
            //Check if the user is already existed
            if (MemberAlready(username))
            {
                return false;
            }
            else
            {
                try
                {
                    //Save the User Information
                    XDocument doc = XDocument.Load(MEMBER_FILE);
                    XElement root = new XElement("Member");
                    root.Add(new XElement("name", memberName));
                    root.Add(new XElement("email", username));
                    root.Add(new XElement("password", password));
                    root.Add(new XElement("role", "Member"));
                    doc.Element("Members").Add(root);
                    doc.Save(MEMBER_FILE);
                    return true;
                }
                catch
                {
                    return false;
                }
            }
        }

        /*
         Checks the presence of an already existing user
             */
        public static Boolean MemberAlready(String userName)
        {
            XmlDocument xmlDocument = new XmlDocument();
            xmlDocument.Load(MEMBER_FILE);
            XmlNodeList nodeList = xmlDocument.SelectNodes(string.Format("/Members/Member/email[text()='" + userName + "']"));
            
            if (nodeList.Count!=0)
            {
               return true;
            }
            
            return false;
        }
    }
}