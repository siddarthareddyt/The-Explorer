<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TheExplorer._Default" %>
<%@ Register TagPrefix="EX" TagName="LogOutControl" Src="~/LogoutControl.ascx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>The Explorer</title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.min.css" />
    <style>

html, body, .container {
    height: 100%;
}
.container-table {
        display: flex;
    justify-content: center;
    align-items: center;
}


    </style>

</head>
<body style="background-image: url(Images/travel1.jpg) ; background-position: left top; background-repeat: no-repeat; background-size:cover; opacity:1">

    <form id="form1" runat="server">

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">TheExplorer</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="Default.aspx">Home</a></li>
      <li><a href="Members/Members.aspx">Members</a></li>
      <li><a href="Staff/Staff.aspx">Staff</a></li>
      <li><asp:Label runat="server" AssociatedControlID="UserName" ID="UserName" CssClass="col-md-2 control-label" ForeColor="White" Visible="false"></asp:Label></li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
      
      <li><a href="MemberSignUp.aspx"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li><a href="Login.aspx"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      <li><EX:LogOutControl runat="server" ID="logout" OnLogOutClicked="LogoutClicked" Visible="false"></EX:LogOutControl></li>
    </ul>
  </div>
</nav>


<div class="container">
    <h4 style="font-family:cursive">New to a Place? We are here to help You! TheExplorer helps you in exploring the place with information like Weather, Crime, Latest News of the place and helps you locate Nearest stores, Deals around, Events.</h4>
    <h3><strong>Functionality: </strong>The Explorer helps users explore a place to find information and services in a place by providing the Zip Code of the Place. The users must singup by clicking <strong>SignUp</strong> button at top right corner inorder to use the services of TheExplorer. By signedup user can get weather information, search for interested events, deals on local stores, travel estimates, etc.</h3>
    <h3></h3>
                <br/>

</div>

<div class="panel panel-success" style="position:absolute;right:30px;width:60%;overflow:scroll;height:500px">
            <div class="panel-body" >
                
                <p style="font-family:cursive">Service Directory: The application has following components:</p><br />
  <table>
   <tr>
    <th colspan="5">This page is deployed at: http://group17.mobicloud.asu.edu/page1 </th>
  </tr>
  <tr>
    <td colspan="5">Team Name: TEAM_SHARP_445 </td>
  </tr>
  <tr>
    <td><b>Provider Name<b /></td>
	<td><b>Component Type<b/></td>
    <td><b>Operation, Parameters<b/></td>
	<td><b>Component Description<b/></td>
  </tr>
    <tr>
    <td>Siddartha, Venu, Akshay</td>
	<td>XML Manipulations</td>
    <td>XMLOperation Class: string(Role) authenticateMember(string username,string password)<br/>bool(status) createMember(string name, username, password)</td>
	<td>This component is used to create and authenticate users of the application.</td>
  </tr>
  <tr>
    <td>Siddartha, Venu, Akshay</td>
	<td>DLL</td>
    <td>ExplorerLibrary Class: string(hashedstring) hash(string plaintext)</td>
	<td>This component is used to hash the user password before storing in XML</td>
  </tr>
  <tr>
    <td>Siddartha</td>
	<td>Global.asax</td>
    <td>Global.asax Class: void Application_AuthenticateRequest(obj sender)</td>
	<td>This component is used to authenticate the incoming request and user. It gets the user from cookie and puts in Context.</td>
  </tr>
  <tr>
    <td>Siddartha</td>
	<td>User control</td>
    <td>LogOutControl: void Image1_Click(object sender, event args)</td>
	<td>This component is reused across multiple pages(default.aspx, members.aspx, staff.aspx). This is used to provide logout functionality.</td>
  </tr>
  <tr>
    <td>Akshay,Venu,Siddartha</td>
	<td>Cookies and state</td>
    <td>Login.aspx, Global.asx: Login_User() method creates a cookie for a authenticated user.</td>
	<td>This component is used to manage a user session. Create a cookie and a ticket for the cookie to identify himself on consequent requests and holds user role information.<br/> So, we donot explicitly needed to use Session for holding user data, as application doesnot need to hold any user state excepet user identity which is in cookie's ticket./</td>
  </tr>
   <tr>
    <td>Akshay</td>
	<td>Web Service</td>
    <td>Instagram Pictures: string[] GetImages(string zipCode). Returns an array of image urls.</td>
	<td>This service gives the images from instagram for a particular place.</td>
  </tr>
  <tr>
    <td>Akshay</td>
	<td>Web Service</td>
    <td>CrimeData: string GetCrimeData(string zipCode). Returns a string containing crime index.</td>
	<td>This service gives the crime index for a particular place.</td>
  </tr>
  <tr>
    <td>venu</td>
	<td>Web Service</td>
    <td>GetCurrentLocation: string[] getCurrentLocation(). Takes no parameter and returns an array containing locatio details.</td>
	<td>This service is used to get the current location of the user instead of taking user's zipcode manually.</td>
  </tr>
  <tr>
    <td>venu</td>
	<td>Web Service</td>
    <td>GetTripDetails: string[] GetTripDetails(string from, string to)<br/>Returns an array of strings containing trip details.</td>
	<td>This service is used to find the fare estimate from one place to another</td>
  </tr>
  <tr>
    <td>venu</td>
	<td>Web Service</td>
    <td>GetTripDetails: string[] GetTripDetails(string from, string to)<br/>Returns an array of strings containing trip details.</td>
	<td>This service is used to find the fare estimate from one place to another</td>
  </tr>
  <tr>
    <td>Siddartha</td>
	<td>Web Service</td>
    <td>WeatherData: string[] GetWeatherData(string zipCode)<br/>Returns an array of strings containing future weather details.</td>
	<td>This service is used to weather predictions for a place.</td>
  </tr>
  <tr>
    <td>Siddartha</td>
	<td>Web Service</td>
    <td>WeatherData: string[] GetWeatherData(string zipCode)<br/>Returns an array of strings containing future weather details.</td>
	<td>This service is used to weather predictions for a place.</td>
  </tr>
  <tr>
    <td>Siddartha</td>
	<td>Web Service</td>
    <td>NearestStores and Deals: string[] GetDeals(Preferece preferece, string zipCode)<br/>Returns an array of strings containing deals and nearest stores.</td>
	<td>This service is used to get deals and Nearest stores information</td>
  </tr>
  <tr>
    <td>Siddartha</td>
	<td>Web Service</td>
    <td>Events: string[] GetEvents(string query, string zipCode)<br/>Returns an array of strings containing local events and detials.</td>
	<td>This service is used to local events based on his interests</td>
  </tr>


</table>
            </div>
    </div>


    </form>
</body>
</html>

