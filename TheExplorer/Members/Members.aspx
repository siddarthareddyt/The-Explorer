<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Members.aspx.cs" Inherits="TheExplorer.Members.Members" %>

<%@ Register TagPrefix="EX" TagName="LogOutControl" Src="~/LogoutControl.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TheExplorer</title>
    <link rel="stylesheet" type="text/css" href="~/Content/bootstrap.min.css" />
    <style type="text/css">
 .topcorner{
   position:absolute;
   top:1;
   right:0;
  }
  .checkboxStyle {
    font-family:cursive;
    color:floralwhite;
    font-size:large;

   }
</style>
</head>
<body style="background-image: url(../Images/tempe2.jpg) ; background-position: left top; background-repeat: no-repeat; background-size:cover; opacity:1">
    <form id="form1" runat="server">

    <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="../Default.aspx">TheExplorer</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="../Default.aspx">Home</a></li>
      <li class="active"><a href="../Members/Members.aspx">Members</a></li>
      <li><asp:Label runat="server" AssociatedControlID="UserName" ID="UserName" CssClass="col-md-2 control-label" ForeColor="White"></asp:Label></li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
      
      <li><a href="../MemberSignUp.aspx"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li><EX:LogOutControl runat="server" ID="LogOutControl1" OnLogOutClicked="LogoutClicked"></EX:LogOutControl></li>
    </ul>
  </div>
</nav>
        
        <h4 style="font-family:cursive;color:floralwhite">A member can explore an area of his choice by giving a zip code. Select user preferences and fill the text boxes where ever necessary to test all the features of application</h4>
        

        <div style="width:100%">
            <div style="float:left; width:20%; overflow:auto" >

                <strong>

                <asp:Label ID="Label1" runat="server" Text="Label" style="font-family:cursive;color:floralwhite">Select Place</asp:Label>
                </strong>

                <br />
                <asp:TextBox ID="zipCodeTxt" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Button ID="locationButton" runat="server" Height="32px" Text="Current Location" Width="130px" CssClass="btn btn-primary" OnClick="OnLocationClick"/>

                <br />

                <strong>
                <asp:Label ID="currentLocationError" runat="server" Text="Label" style="font-family:cursive;color:floralwhite" Visible="false"></asp:Label>
                </strong>

                <strong>
                <asp:Label ID="preferenceLabel" runat="server" Text="Query" style="font-family:cursive;color:floralwhite" Visible="false">Preferences</asp:Label>
                </strong>
                <br />
                <asp:TextBox ID="queryBox" runat="server" CssClass="form-control" placeholder="Saloon, Food,etc" Visible="false"></asp:TextBox>

                <br />
                <asp:TextBox ID="eventBox" runat="server" CssClass="form-control" Visible="false" placeholder="Music, Sports, etc"></asp:TextBox>

                <br/>
                <br />
                <strong>
                
                <asp:CheckBox ID="weatherCheck" Text="Weather" runat="server" Checked="false" CssClass="checkboxStyle"/><br />

                <asp:CheckBox ID="nearestStoreCheck" Text="Nearest Stores" runat="server" Checked="false" OnCheckedChanged="chkLinked_CheckedChanged" AutoPostBack="true" CssClass="checkboxStyle"/><br />
                <asp:CheckBox ID="dealsCheck" Text="Deals" runat="server" Checked="false" CssClass="checkboxStyle" OnCheckedChanged="chkLinked_CheckedChanged" AutoPostBack="true"/><br />
                <asp:CheckBox ID="eventCheck" Text="Events" runat="server" Checked="false" CssClass="checkboxStyle" OnCheckedChanged="event_CheckedChanged" AutoPostBack="true"/><br/>
                <asp:CheckBox ID="instaCheck" Text="Instagram Pictures" runat="server" Checked="false" CssClass="checkboxStyle"/><br />
                <asp:CheckBox ID="crimeCheck" Text="Crime Index" runat="server" Checked="false" CssClass="checkboxStyle"/><br />
                <asp:CheckBox ID="tripCheck" Text="Trip Estimation" runat="server" OnCheckedChanged="trip_CheckedChanged" AutoPostBack="true" Checked="false" CssClass="checkboxStyle"/><br />

                <asp:TextBox ID="fromId" runat="server" CssClass="form-control" Visible="false" placeholder="From. Ex:Tempe"></asp:TextBox><br />
                <asp:TextBox ID="toId" runat="server" CssClass="form-control" Visible="false" placeholder="To. Ex:Chandler"></asp:TextBox>


                    <br />

                <asp:Button ID="Button1" runat="server" Height="32px" Text="Search" Width="68px" CssClass="btn btn-info" OnClick="Button1_Click"/>

                </strong>

            </div>
            <div style="float:right; width:80%">

                

                

                <div class="panel panel-success" id="weatherDisplay">
                    <div class="panel-body" >

                        <strong>
                         <asp:Label ID="NoResultsWeather" runat="server" Text="Label" Visible="false" style="font-family:cursive">No results found for Zip Code.</asp:Label>
                         <asp:Label ID="ErrorWeather" runat="server" Text="Label" Visible="false" style="font-family:cursive"></asp:Label>
                        </strong>

                        <asp:Label ID="FirstMessage" runat="server" Text="Label" Visible="true" style="font-family:cursive">Select your preferences to Know.</asp:Label>
                        <asp:Table ID="WeatherTable" runat="server" CssClass="table table-hover" Visible="False" Font-Bold="True">
                    <asp:TableRow ID="row1">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="row2">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="row3">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="row4">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="row5">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="row6">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="row7">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>

                     </asp:Table>
                    </div>
                </div>



                <div class="panel panel-success" runat="server" id="nearestStoreDisplay" visible="false">
                    <div class="panel-body" >

                        <strong>
                         <asp:Label ID="NoresultsStores" runat="server" Text="Label" Visible="false" style="font-family:cursive">No results found for Zip Code.</asp:Label>
                         <asp:Label ID="ErrorStores" runat="server" Text="Label" Visible="false" style="font-family:cursive"></asp:Label>
                        </strong>

                        <asp:Table ID="storesTable" runat="server" CssClass="table table-hover" Visible="False" Font-Bold="True">
                    <asp:TableRow ID="store1">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="store2">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="store3">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="store4">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="store5">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>

                     </asp:Table>
                    </div>
                </div>

                <div class="panel panel-success" runat="server" id="eventsDisplay" visible="false">
                    <div class="panel-body" >

                        <strong>
                         <asp:Label ID="NoresultsEvents" runat="server" Text="Label" Visible="false" style="font-family:cursive">No results found for Zip Code.</asp:Label>
                         <asp:Label ID="ErrorEvents" runat="server" Text="Label" Visible="false" style="font-family:cursive"></asp:Label>
                        </strong>

                        <asp:Table ID="EventTable" runat="server" CssClass="table table-hover" Visible="False" Font-Bold="True">
                    <asp:TableRow ID="event1">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="event2">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="event3">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="event4">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="event5">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>

                     </asp:Table>
                    </div>
                </div>


                <div class="panel panel-success" runat="server" id="instaDisplay" visible="false">
                    <div class="panel-body" >

                        <strong>
                         <asp:Label ID="NoresultsInsta" runat="server" Text="Label" Visible="false" style="font-family:cursive">No results found for Zip Code.</asp:Label>
                         <asp:Label ID="ErrorInsta" runat="server" Text="Label" Visible="false" style="font-family:cursive"></asp:Label>
                        </strong>
                        <div runat="server" id="instaPics">

                        </div>
                        
                    </div>
                </div>

                 <div class="panel panel-success" runat="server" id="crimeDisplay" visible="false">
                    <div class="panel-body" >

                        <strong>
                         <asp:Label ID="NoresultsCrime" runat="server" Text="Label" Visible="false" style="font-family:cursive">No results found for Zip Code.</asp:Label>
                         <asp:Label ID="ErrorCrime" runat="server" Text="Label" Visible="false" style="font-family:cursive"></asp:Label>
                        </strong>
                        <div runat="server" id="crimeData">

                        </div>
                        
                    </div>
                </div>
                
                <div class="panel panel-success" runat="server" id="tripDisplay" visible="false">
                    <div class="panel-body" >

                        <strong>
                         <asp:Label ID="NoresultsTrip" runat="server" Text="Label" Visible="false" style="font-family:cursive">No results found for Zip Code.</asp:Label>
                         <asp:Label ID="ErrorTrip" runat="server" Text="Label" Visible="false" style="font-family:cursive"></asp:Label>
                        </strong>

                        <asp:Table ID="tripTable" runat="server" CssClass="table table-hover" Visible="False" Font-Bold="True">
                    <asp:TableRow ID="trip1">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trip2">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trip3">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trip4">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trip5">
                        <asp:TableCell style="font-family:cursive"></asp:TableCell>
                    </asp:TableRow>

                     </asp:Table>
                    </div>
                </div>

            </div>
        </div>        

    </form>
</body>
</html>
