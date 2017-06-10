<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberSignUp.aspx.cs" Inherits="TheExplorer.MemberSignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SignUp</title>
    <link rel="stylesheet" type="text/css" href="Content/bootstrap.min.css" />
</head>
<body style="background-image: url(Images/Image1.jpg) ; background-position: left top; background-repeat: no-repeat; background-size:cover; opacity:1">

    <form id="form1" runat="server" method="post">
 <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="Default.aspx">TheExplorer</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="Default.aspx">Home</a></li>
      <li><a href="Members/Members.aspx">Members</a></li>
      <li><a href="Staff/Staff.aspx">Staff</a></li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
      <li class="active"><a href="MemberSignUp.aspx"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li><a href="Login.aspx"><span class="glyphicon glyphicon-user"></span> Login</a></li>
    </ul>
  </div>
</nav>
    <div class="container">
     <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
     </p>
        <h3 style="align-content:center; color:ghostwhite">Create a new account</h3>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="MemberName" CssClass="col-md-2 control-label" ForeColor="White">Name</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="MemberName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="MemberName"
                    CssClass="text-danger" ErrorMessage="The MemberName field is required." />
            </div>
        </div>

                <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label" ForeColor="White">Email</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="The email field is required." />
            </div>
        </div>

                <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label" ForeColor="White">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>

                <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label" ForeColor="White">Confirm password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
            </div>
        </div>
        <br/>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Image ID="verifyImage" runat="server" /><br />
                <asp:TextBox runat="server" ID="inputImgVerify" placeholder="Enter Captcha" CssClass="form-control" />

            </div>
        </div>
         <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-primary" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
