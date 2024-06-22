<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master"
    CodeBehind="FileDashboard.aspx.vb" Inherits="FileTracker.FileDashboard" %>

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
                                         "(SELECT COUNT(LocationID) FROM Files WHERE LocationID = '1') As countFilesOnSite, " &
                                         "(SELECT COUNT(LocationID) FROM Files WHERE LocationID = '2') As countFilesOffSite " &
                                         "FROM Files", conn)
        Dim readerFiles As SqlDataReader = queryFiles.ExecuteReader()

        Dim countFiles As Integer
        Dim countEndOfParticpation As Integer
        Dim countDenialWithdrawal As Integer
        Dim countPortOut As Integer
        Dim countOnSite As Integer
        Dim countOffSite As Integer
        While readerFiles.Read
            countFiles = CStr(readerFiles("countFiles"))
            countEndOfParticpation = CStr(readerFiles("countFilesEOP"))
            countDenialWithdrawal = CStr(readerFiles("countFilesDenialWithdrawal"))
            countPortOut = CStr(readerFiles("countFilesPortOut"))
            countOnSite = CStr(readerFiles("countFilesOnSite"))
            countOffSite = CStr(readerFiles("countFilesOffSite"))
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
					  	<span class="li_note"></span>
					  	<h3><% Response.Write(countFiles)%></h3>
                  	</div>
					<p><% Response.Write(countFiles)%>  &nbsp; Total Files</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class=" li_calendar"></span>
					  	<h3><% Response.Write(countEndOfParticpation)%></h3>
                  	</div>
					<p><% Response.Write(countEndOfParticpation)%> &nbsp; EOP Files</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class="li_paperplane"></span>
					  	<h3><% Response.Write(countDenialWithdrawal)%></h3>
                  	</div>
					<p><% Response.Write(countDenialWithdrawal)%> &nbsp;Denial or Withdrawal Files</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class="li_truck"></span>
					  	<h3><% Response.Write(countPortOut)%></h3>
                  	</div>
					<p><% Response.Write(countPortOut)%> &nbsp;Port Out Files</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class="li_shop"></span>
					  	<h3><% Response.Write(countOnSite)%></h3>
                  	</div>
					<p><% Response.Write(countOnSite)%> &nbsp; On Site Files</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class="li_location"></span>
					  	<h3><% Response.Write(countOffSite)%></h3>
                  	</div>
					<p><% Response.Write(countOffSite)%> &nbsp; Off Site Files</p>
                </div>
            </div>
		 </div>
       </div>

       <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-4 mb">
			<div class="weather-3 pn centered">
                <a href="CreateFile.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-file-text-o"></i>
				<h1>Create File</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">Create</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-file"></i> Create</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-file"></i> Create</p>
						</div>
					</div>
				</div>
                </a>
			</div>		
	    </div>
        <div class="col-lg-4 col-md-4 col-sm-4 mb">
            <div class="weather-3 pn centered">
                <a href="SearchFile.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-search"></i>
				<h1>Search File</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">Search</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-file"></i> Search</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-file"></i> Search</p>
						</div>
					</div>
				</div>
              </a>
			</div>		
        </div>
        <div class="col-lg-4 col-md-4 col-sm-4 mb">
			<div class="weather-3 pn centered">
                <a href="EOPFiles.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-calendar"></i>
				<h1>End Of Participation</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">End Of Participation</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-file"></i> EOP</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-file"></i> EOP</p>
						</div>
					</div>
				</div>
               </a>
			</div>		
	    </div>
       </div>

       <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-4 mb">
			<div class="weather-3 pn centered">
                <a href="DenialOrWithdrawalFiles.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-paper-plane-o"></i>
				<h1>Denial or Withdrawal</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">Denial or Withdrawal</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-file"></i> D or W</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-file"></i> D or W</p>
						</div>
					</div>
				</div>
               </a>
			</div>		
	    </div>
        <div class="col-lg-4 col-md-4 col-sm-4 mb"></div>
        <div class="col-lg-4 col-md-4 col-sm-4 mb">
			<div class="weather-3 pn centered">
                <a href="PortOut.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-truck"></i>
				<h1>Port Out</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">Port Out</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-file"></i> Port Out</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-file"></i> Port Out</p>
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