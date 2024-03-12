<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="ProjectSpecialistDashboard.aspx.vb" Inherits="FileTracker.ProjectSpecialistDashboard" %>

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
        'Files
        conn.Open()
        Dim queryFiles As New SqlCommand("SELECT (SELECT COUNT(FileID) FROM Files) As countFiles,  " &
                                         "(SELECT COUNT(PurgeTypeID) FROM Files WHERE PurgeTypeID = '1') As countFilesEOP, " &
                                         "(SELECT COUNT(PurgeTypeID) FROM Files WHERE PurgeTypeID = '2') As countFilesDenialWithdrawal, " &
                                         "(SELECT COUNT(PurgeTypeID) FROM Files WHERE PurgeTypeID = '3') As countFilesPortOut, " &
                                         "(SELECT COUNT(LocationID) FROM Files WHERE LocationID = '1') As countFilesOnSite " &
                                         "FROM Files", conn)
        Dim readerFiles As SqlDataReader = queryFiles.ExecuteReader()

        Dim countFiles As Integer
        Dim countFilesEndOfParticpation As Integer
        Dim countFilesDenialWithdrawal As Integer
        Dim countFilesPortOut As Integer
        Dim countFilesOnSite As Integer
        While readerFiles.Read
            countFiles = CStr(readerFiles("countFiles"))
            countFilesEndOfParticpation = CStr(readerFiles("countFilesEOP"))
            countFilesDenialWithdrawal = CStr(readerFiles("countFilesDenialWithdrawal"))
            countFilesPortOut = CStr(readerFiles("countFilesPortOut"))
            countFilesOnSite = CStr(readerFiles("countFilesOnSite"))
        End While
        conn.Close()

        'Boxes
        conn.Open()
        Dim queryBoxes As New SqlCommand("SELECT (SELECT COUNT(BoxID) FROM Boxes) As countBoxes, " &
                                         " (SELECT COUNT(BoxID) FROM Boxes WHERE LocationID = '1') As countBoxesOnSite, " &
                                         " (SELECT COUNT(BoxID) FROM Boxes WHERE LocationID = '2') As countBoxesAtWarehouse  " &
                                         "FROM Boxes", conn)
        Dim readerBoxes As SqlDataReader = queryBoxes.ExecuteReader()
        Dim countBoxes As Integer
        Dim countBoxesOnSite As Integer
        Dim countBoxesAtWarehouse As Integer
        While readerBoxes.Read
            countBoxes = CStr(readerBoxes("countBoxes"))
            countBoxesOnSite = CStr(readerBoxes("countBoxesOnSite"))
            countBoxesAtWarehouse = CStr(readerBoxes("countBoxesAtWarehouse"))
        End While
        conn.Close()


        'Requests
        conn.Open()
        Dim queryRequests As New SqlCommand("SELECT (SELECT COUNT(RequestID) FROM Requests WHERE RequestedByUserID = '" & sessionUserID & "') As countRequests, " &
                                            "       (SELECT COUNT(RequestID) FROM Requests WHERE CheckOutDate != '1900-01-01' AND RequestedByUserID = '" & sessionUserID & "') As countCheckOuts, " &
                                            "       (SELECT COUNT(RequestID) FROM Requests WHERE CheckedInDate != '1900-01-01' AND RequestedByUserID = '" & sessionUserID & "') As countCheckIns " &
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
                <div class="col-md-3 col-sm-2 col-md-offset-3 box0">
                  	<div class="box1">
					  	<span class="li_note"></span>
					  	<h3><% Response.Write(countFiles)%></h3>
                  	</div>
					<p><% Response.Write(countFiles) %>  Files</p>
                </div>
                <div class="col-md-3 col-sm-2 box0">
                  	<div class="box1">
					  	<span class="li_stack"></span>
					  	<h3><% Response.Write(countBoxes) %></h3>
                  	</div>
					<p><% Response.Write(countBoxes) %> Boxes</p>
                </div>
                <div class="col-md-3 col-sm-2 box0">
                  	<div class="box1">
					  	<span class="li_mail"></span>
					  	<h3><% Response.Write(countRequests)%></h3>
                  	</div>
					<p><% Response.Write(countRequests)%> Your Requests</p>
                </div>
            </div>
         </div>
       </div>

       <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-3 mb">
			<div class="weather-3 pn centered">
				<i class="fa fa-sticky-note-o"></i>
				<h1>Files</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">
                            <a href="">
                                Files
                            </a>
                        </h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><% Response.Write(countFilesEndOfParticpation)%> EOP</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><% Response.Write(countFilesDenialWithdrawal)%> DN or WD</p>
						</div>
					</div>
				</div>
			</div>		
	    </div>
        <div class="col-lg-3 col-md-3 col-sm-3 mb">
			<div class="weather-3 pn centered">
				<i class="fa fa-archive"></i>
				<h1>Boxes</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">
                            <a href="">
                                Boxes
                            </a>
                        </h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><% Response.Write(countBoxesOnSite)%> On Site</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><% Response.Write(countBoxesAtWarehouse)%> At Warehouse</p>
						</div>
					</div>
				</div>
			</div>		
	    </div>
        <div class="col-lg-3 col-md-3 col-sm-3 mb">
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
							<p class="goleft"><% Response.Write(countRequests)%> Total</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><% Response.Write(countRequests)%> Requests</p>
						</div>
					</div>
				</div>
			</div>		
	    </div>
       </div>

       <div class="row">
        <div class="col-lg-3 col-md-3 col-sm-3 mb">
			<div class="weather-3 pn centered">
				<i class="fa fa-sticky-note-o"></i>
				<h1>Files</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">
                            <a href="">
                                Files
                            </a>
                        </h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><% Response.Write(countFilesPortOut)%> Port Out</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><% Response.Write(countFilesOnSite)%> On Site</p>
						</div>
					</div>
				</div>
			</div>		
	    </div>
        <div class="col-lg-3 col-md-3 col-sm-3 mb"></div>

        <div class="col-lg-3 col-md-3 col-sm-3 mb">
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
							<p class="goleft"><% Response.Write(countCheckOuts)%> Check Outs</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><% Response.Write(countCheckIns)%> Check Ins</p>
						</div>
					</div>
				</div>
			</div>		
	    </div>
       </div>
     </section>
    </section>
</asp:Content>
