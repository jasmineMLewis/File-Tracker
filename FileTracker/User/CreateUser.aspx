<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="CreateUser.aspx.vb" Inherits="FileTracker.CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <%
        Dim sessionUserID As String = Session("SessionUserID")
        Dim sessionRoleID As String = Session("SessionRoleID")

        If Not Web.HttpContext.Current.Session("SessionUserID") Is Nothing Then
            sessionUserID = Web.HttpContext.Current.Session("SessionUserID").ToString()
        End If

        If Not Web.HttpContext.Current.Session("SessionRoleID") Is Nothing Then
            sessionRoleID = Web.HttpContext.Current.Session("SessionRoleID").ToString()
        End If

        If sessionUserID = Nothing Or String.IsNullOrEmpty(sessionUserID) Then
            sessionUserID = Request.QueryString("SessionUserID")
            Web.HttpContext.Current.Session("SessionUserID") = sessionUserID
        End If

        If sessionRoleID = Nothing Or String.IsNullOrEmpty(sessionRoleID) Then
            sessionRoleID = Request.QueryString("SessionRoleID")
            Web.HttpContext.Current.Session("SessionRoleID") = sessionRoleID
        End If
    %>
    <section id="main-content">
        <section class="wrapper site-min-height">
            <h3 class="page-title"><i class="fa fa-user-plus" aria-hidden="true"></i> Create User</h3>
            <hr />
            <div class="row st">
                <div class="col-lg-12">
                    <div class="form-panel">
                        <h3 class="page-title"><i class="fa fa-user-plus" aria-hidden="true"></i> Create User</h3>
                        <hr />
                        <br />
                        <div class="form-horizontal style-form">
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">First Name *</label>
                                <div class="col-sm-4">
                                     <asp:TextBox ID="userFirstName" runat="server" class="input-medium form-control" placeholder="First Name" maxlength="50"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="requiredUserFirstName" runat="server" controltovalidate="userFirstName"></asp:RequiredFieldValidator>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Last Name *</label>
                                <div class="col-sm-4">
                                     <asp:TextBox ID="userLastName" runat="server" class="input-medium form-control" placeholder="Last Name" maxlength="50"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="requiredUserLastName" runat="server" controltovalidate="userLastName"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">Email *</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="userEmail" runat="server" class="input-medium form-control" placeholder="Email" maxlength="100"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="requiredUserEmail" runat="server" controltovalidate="userEmail"></asp:RequiredFieldValidator>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Password *</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="userPassword" runat="server" class="input-medium form-control" placeholder="Qwerty1" maxlength="50" disabled="disabled"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="requiredUserPassword" runat="server" controltovalidate="userPassword"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">Role *</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="Role" runat="server" DataSourceID="SqlRole"
                                        DataTextField="FullDescrip" DataValueField="RoleID" class="form-control">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlRole" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>"
                                        SelectCommand="SELECT RoleID, Role + '  : ' + Description AS FullDescrip 
                                                       FROM Role 
                                                       ORDER BY Role">
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                            <button type="button" class="btn btn-theme btn-lg btn-block" runat="server" onserverclick="BtnCreateUser">
                                <i class="fa fa-user-plus" aria-hidden="true"></i> Create User
                            </button>
                            <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700; color: #1A926A"
                                EnableViewState="False">
                            </asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </section>
</asp:Content>
