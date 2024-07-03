<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master"
    CodeBehind="UserDashboard.aspx.vb" Inherits="FileTracker.UserDashboard" %>

<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

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

        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)
        conn.Open()
        Dim queryUsers As New SqlCommand("SELECT (SELECT COUNT(UserID) FROM Users) As countUsers, " &
                                        " (SELECT COUNT(UserID) FROM Users WHERE RoleID = '1') As countAdmins, " &
                                        " (SELECT COUNT(UserID) FROM Users WHERE RoleID = '2') As countProjectSpecialist, " &
                                        " (SELECT COUNT(UserID) FROM Users WHERE RoleID = '3') As countHousingSpecailist, " &
                                        " (SELECT COUNT(UserID) FROM Users WHERE RoleID = '4') As countFileRoomClerk, " &
                                        " (SELECT COUNT(UserID) FROM Users WHERE RoleID = '5') As countViewers", conn)
        Dim readerUsers As SqlDataReader = queryUsers.ExecuteReader()
        Dim countUsers As Integer
        Dim countAdmins As Integer
        Dim countProjectSpecialist As Integer
        Dim countHousingSpecailist As Integer
        Dim countFileRoomClerk As Integer
        Dim countViewers As Integer
        While readerUsers.Read
            countUsers = CStr(readerUsers("countUsers"))
            countAdmins = CStr(readerUsers("countAdmins"))
            countProjectSpecialist = CStr(readerUsers("countProjectSpecialist"))
            countHousingSpecailist = CStr(readerUsers("countHousingSpecailist"))
            countFileRoomClerk = CStr(readerUsers("countFileRoomClerk"))
            countViewers = CStr(readerUsers("countViewers"))
        End While
        conn.Close()
    %>
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 main-chart">
                    <div class="row mtbox">
                        <div class="col-md-2 col-sm-1 col-md-offset-0 box0">
                            <div class="box1">
                                <span class="li_user"></span>
                                <h3><% Response.Write(countUsers)%></h3>
                            </div>
                            <p><% Response.Write(countUsers)%> Users</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_data"></span>
                                <h3><% Response.Write(countAdmins)%></h3>
                            </div>
                            <p><% Response.Write(countAdmins)%> Admins</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_lab"></span>
                                <h3><% Response.Write(countProjectSpecialist)%></h3>
                            </div>
                            <p><% Response.Write(countProjectSpecialist)%> Project Specialists</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_tag"></span>
                                <h3><% Response.Write(countHousingSpecailist)%></h3>
                            </div>
                            <p><% Response.Write(countHousingSpecailist)%>  Housing Specialists</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_news"></span>
                                <h3><% Response.Write(countFileRoomClerk)%></h3>
                            </div>
                            <p><% Response.Write(countFileRoomClerk)%> File Room Clerks</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_tv"></span>
                                <h3><% Response.Write(countViewers)%></h3>
                            </div>
                            <p><% Response.Write(countViewers)%> Viewers</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-md-4 col-sm-4 mb">
                    <div class="weather-3 pn centered">
                        <a href="CreateUser.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
                            <i class="fa fa-user-plus"></i>
                            <h1>Create User</h1>
                            <div class="info">
                                <div class="row">
                                    <h3 class="centered">Create</h3>
                                    <div class="col-sm-6 col-xs-6 pull-left">
                                        <p class="goleft"><i class="fa fa-user"></i> Create</p>
                                    </div>
                                    <div class="col-sm-6 col-xs-6 pull-right">
                                        <p class="goright"><i class="fa fa-user"></i> Create</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="col-lg-4 col-md-4 col-sm-4 mb"></div>

                <div class="col-lg-4 col-md-4 col-sm-4 mb">
                    <div class="weather-3 pn centered">
                        <a href="UserDirectory.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
                            <i class="fa fa-users"></i>
                            <h1>User Directory</h1>
                            <div class="info">
                                <div class="row">
                                    <h3 class="centered">Directory</h3>
                                    <div class="col-sm-6 col-xs-6 pull-left">
                                        <p class="goleft"><i class="fa fa-user"></i> Directory</p>
                                    </div>
                                    <div class="col-sm-6 col-xs-6 pull-right">
                                        <p class="goright"><i class="fa fa-user"></i> Directory</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </section>
</asp:Content>
