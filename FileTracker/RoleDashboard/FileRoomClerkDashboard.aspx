<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="FileRoomClerkDashboard.aspx.vb" Inherits="FileTracker.FileRoomClerk" %>

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

        'Requests
        conn.Open()
        Dim queryRequests As New SqlCommand("SELECT (SELECT COUNT(RequestID) FROM Requests) As countRequests, " &
                                            "       (SELECT COUNT(RequestID) FROM Requests WHERE CheckOutDate != '1900-01-01' AND CheckedOutByUserID = '" & sessionUserID & "') As countCheckOuts, " &
                                            "       (SELECT COUNT(RequestID) FROM Requests WHERE CheckedInDate != '1900-01-01' AND CheckedInByUserID = '" & sessionUserID & "') As countCheckIns " &
                                            "FROM Requests", conn)
        Dim readerRequests As SqlDataReader = queryRequests.ExecuteReader()
        Dim countRequests As Integer
        Dim countCheckOuts As Integer
        Dim countCheckIns As Integer
        While readerRequests.Read
            countRequests = CStr(readerRequests("countRequests"))
            countCheckOuts = CStr(readerRequests("countCheckOuts"))
            countCheckIns = CStr(readerRequests("countCheckIns"))
        End While
        conn.Close()
    %>
    <section id="main-content">
     <section class="wrapper">
       <div class="row">
         <div class="col-lg-9 main-chart">
            <div class="row mtbox">
                <div class="col-md-4 col-sm-2 col-md-offset-6 box0">
                  	<div class="box1">
					  	<span class="li_mail"></span>
					  	<h3><% Response.Write(countRequests)%></h3>
                  	</div>
					<p><% Response.Write(countRequests)%> Total Requests</p>
                </div>
            </div>
         </div>
       </div>

       <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-4 mb">
			<div class="weather-3 pn centered">
				<i class="fa fa-envelope"></i>
				<h1>Requests</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">
                            <a href="">
                                Requests
                            </a>
                        </h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><% Response.Write(countRequests)%> Total Requests</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><% Response.Write(countRequests)%> Total Requests</p>
						</div>
					</div>
				</div>
			</div>		
	    </div>

        <div class="col-lg-4 col-md-4 col-sm-4 mb"></div>
       
        <div class="col-lg-4 col-md-4 col-sm-4 mb">
			<div class="weather-3 pn centered">
				<i class="fa fa-envelope"></i>
				<h1>Requests</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">
                            <a href="">
                                Requests
                            </a>
                        </h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><% Response.Write(countCheckOuts)%> Your Check Outs</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><% Response.Write(countCheckIns)%> Your Check Ins</p>
						</div>
					</div>
				</div>
			</div>		
	    </div>
       </div>
     </section>
    </section>
</asp:Content>
