<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master"
    CodeBehind="RequestDashboard.aspx.vb" Inherits="FileTracker.RequestDashboard" %>

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

        Const ADMIN As Integer = 1
        Const PROJECT_SPECIALIST As Integer = 2
        Const HOUSING_SPECIALIST As Integer = 3

        Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)
        conn.Open()
        Dim queryRequests As New SqlCommand("SELECT DISTINCT " &
                                                "(SELECT COUNT(RequestID) FROM Requests WHERE RequestedByUserID = '" & sessionUserID & "') As countYourRequests, " &
                                                "(SELECT COUNT(RequestID) FROM Requests WHERE CheckOutDate != '1900-01-01' AND CheckedOutByUserID = '" & sessionUserID & "') As countCheckOuts, " &
                                                "(SELECT COUNT(RequestID) FROM Requests WHERE CheckedInDate != '1900-01-01' AND CheckedInByUserID = '" & sessionUserID & "') As countCheckIns, " &
                                                "(SELECT COUNT(RequestID) FROM Requests WHERE IsPickUpRequested = '1' AND RequestedByUserID = '" & sessionUserID & "') As countPickUpRequests " &
                                            "FROM Requests", conn)
        Dim readerRequests As SqlDataReader = queryRequests.ExecuteReader()
        Dim countYourRequests As Integer
        Dim countCheckOuts As Integer
        Dim countCheckIns As Integer
        Dim countPickUpRequests As Integer
        While readerRequests.Read
            countYourRequests = CStr(readerRequests("countYourRequests"))
            countCheckOuts = CStr(readerRequests("countCheckOuts"))
            countCheckIns = CStr(readerRequests("countCheckIns"))
            countPickUpRequests = CStr(readerRequests("countPickUpRequests"))
        End While
        conn.Close()
    %>
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <div class="col-lg-12 main-chart">
                    <div class="row mtbox">
                        <div class="col-md-2 col-sm-1 col-md-offset-2 box0">
                            <div class="box1">
                                <span class="li_note"></span>
                                <h3><% Response.Write(countYourRequests)%> </h3>
                            </div>
                            <p><% Response.Write(countYourRequests)%>  Total Your Requests</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_tag"></span>
                                <h3><% Response.Write(countCheckOuts)%></h3>
                            </div>
                            <p><% Response.Write(countCheckOuts)%> Total Check Outs</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_mail"></span>
                                <h3><% Response.Write(countPickUpRequests)%></h3>
                            </div>
                            <p><% Response.Write(countPickUpRequests)%> Total Request Pick Ups</p>
                        </div>
                        <div class="col-md-2 col-sm-1 box0">
                            <div class="box1">
                                <span class="li_clip"></span>
                                <h3><% Response.Write(countCheckIns)%></h3>
                            </div>
                            <p><% Response.Write(countCheckIns)%> Total Check Ins</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <%
                    If sessionRoleID = ADMIN Or sessionRoleID = PROJECT_SPECIALIST Or sessionRoleID = HOUSING_SPECIALIST Then
                %>
                <div class="col-lg-4 col-md-4 col-sm-4 mb">
                    <div class="weather-3 pn centered">
                        <a href="CreateRequest.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
                            <i class="fa fa-cart-plus"></i>
                            <h1>Create Request</h1>
                            <div class="info">
                                <div class="row">
                                    <h3 class="centered">Create</h3>
                                    <div class="col-sm-6 col-xs-6 pull-left">
                                        <p class="goleft"><i class="fa fa-cart-plus"></i> Create</p>
                                    </div>
                                    <div class="col-sm-6 col-xs-6 pull-right">
                                        <p class="goright"><i class="fa fa-cart-plus"></i> Create</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 mb">
                    <div class="weather-3 pn centered">
                        <a href="UserRequests.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
                            <i class="fa fa-cart-arrow-down"></i>
                            <h1>Your Requests</h1>
                            <div class="info">
                                <div class="row">
                                    <h3 class="centered">Your Requests</h3>
                                    <div class="col-sm-6 col-xs-6 pull-left">
                                        <p class="goleft"><i class="fa fa-cart-arrow-down"></i> Yours</p>
                                    </div>
                                    <div class="col-sm-6 col-xs-6 pull-right">
                                        <p class="goright"><i class="fa fa-cart-arrow-down"></i> Yours</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>

                <%
                    End If
                %>
                <div class="col-lg-4 col-md-4 col-sm-4 mb">
                    <div class="weather-3 pn centered">
                        <a href="UsersRequests.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
                        <i class="fa fa-shopping-cart"></i>
                            <h1>Users' Requests</h1>
                            <div class="info">
                                <div class="row">
                                    <h3 class="centered">Users' Requests </h3>
                                    <div class="col-sm-6 col-xs-6 pull-left">
                                        <p class="goleft"><i class="fa fa-shopping-cart"></i> Requests</p>
                                    </div>
                                    <div class="col-sm-6 col-xs-6 pull-right">
                                        <p class="goright"><i class="fa fa-shopping-cart"></i> Requests</p>
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
