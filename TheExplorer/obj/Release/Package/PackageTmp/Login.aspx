<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TheExplorer.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
        <link rel="stylesheet" type="text/css" href="Content/bootstrap.min.css" />

</head>
<body>
     <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
    <form id="form1" runat="server">

    <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="Default.aspx">TheExplorer</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="Default.aspx">Home</a></li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
      <li><a href="MemberSignUp.aspx"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li class="active"><a href="Login.aspx"><span class="glyphicon glyphicon-user"></span> Login</a></li>
    </ul>
  </div>
</nav>
    <div class="container">
    
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">UserName</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                    CssClass="text-danger" ErrorMessage="The UserName field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="password" CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="password" CssClass="form-control" TextMode="Password"/>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-0 col-md-4">
                <asp:CheckBox ID="Persistent" runat="server" Text="Remember Me?"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-5 col-md-10">
                <asp:Button runat="server" OnClick="Login_User" Text="Login" CssClass="btn btn-primary" />
            </div>
        </div>
    
    </div>
    </form>
</body>
</html>
