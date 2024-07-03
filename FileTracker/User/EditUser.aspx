<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="EditUser.aspx.vb" Inherits="FileTracker.EditUser" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <%
        Dim sessionUserID As String
        Dim sessionRoleID As String
        If Not Web.HttpContext.Current.Session("SessionUserID") Is Nothing Then
            sessionUserID = Web.HttpContext.Current.Session("SessionUserID").ToString()
        End If

        If Not Web.HttpContext.Current.Session("SessionRoleID") Is Nothing Then
            sessionRoleID = Web.HttpContext.Current.Session("SessionRoleID").ToString()
        End If

        If sessionUserID = Nothing Then
            sessionUserID = Request.QueryString("SessionUserID")
            Web.HttpContext.Current.Session("SessionUserID") = sessionUserID
        End If

        If sessionRoleID = Nothing Then
            sessionRoleID = Request.QueryString("SessionRoleID")
            Web.HttpContext.Current.Session("SessionRoleID") = sessionRoleID
        End If
    %>
    <section id="main-content">
        <section class="wrapper site-min-height">
            <h3 class="page-title"><i class="fa fa-user" aria-hidden="true"></i> Update User</h3>
            <hr />
            <div class="row st">
                <div class="col-lg-12">
                    <div class="form-panel">
                        <h3 class="page-title"><i class="fa fa-user" aria-hidden="true"></i> Update User</h3>
                        <hr />
                        <br />
                        <div class="form-horizontal style-form">
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">First Name</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="userFirstName" runat="server" MaxLength="50" placeholder="First Name" class="form-control"></asp:TextBox>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Client Last Name</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="userLastName" runat="server" MaxLength="50" placeholder="Last Name" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 col-sm-2 control-label">Email</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="userEmail" runat="server" MaxLength="50" placeholder="Email" class="form-control"></asp:TextBox>
                                </div>
                                <label class="col-sm-2 col-sm-2 control-label">Password</label>
                                <div class="col-sm-4">
                                    <asp:TextBox ID="userPassword" runat="server" MaxLength="15" placeholder="Password" class="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <button type="button" class="btn btn-theme btn-lg btn-block" runat="server" onserverclick="BtnEditUser">
                                <i class="fa fa-user" aria-hidden="true"></i> Update User
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
