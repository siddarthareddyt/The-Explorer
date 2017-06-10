<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="TheExplorer.Staff.Staff" %>
<%@ Register TagPrefix="EX" TagName="LogOutControl" Src="~/LogoutControl.ascx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Staff</title>
    <link rel="stylesheet" type="text/css" href="~/Content/bootstrap.min.css" />

</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="../Default.aspx">TheExplorer</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="../Default.aspx">Home</a></li>
      <li class="active"><a href="#">Staff</a></li>
      <li><asp:Label runat="server" AssociatedControlID="UserName" ID="UserName" CssClass="col-md-2 control-label" ForeColor="White"></asp:Label></li>
    </ul>

    <ul class="nav navbar-nav navbar-right">
      
      <li><a href="../MemberSignUp.aspx"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li><EX:LogOutControl runat="server" ID="logout" OnLogOutClicked="LogoutClicked"></EX:LogOutControl></li>
    </ul>
  </div>
</nav>
    <div>
    <h4>The application does not require any maintenance by an admin or other centralised user, thus, limiting the features of this page. To test all the functionalities, please login as a Member.</h4>
        <p>Test DLL Component:</p>
    <div class="container">
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="PlainText" CssClass="col-md-2 control-label">Plain Text</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="plainText" CssClass="form-control"/>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-5 col-md-10">
                <asp:Button runat="server" OnClick="hashFunction" Text="Convert" CssClass="btn btn-primary" />
            </div>
        </div>
        <asp:Label runat="server" AssociatedControlID="HashText" ID="HashText" CssClass="col-md-2 control-label" Visible="false"></asp:Label>
    </div>
</div>
    </form>
</body>
</html>
