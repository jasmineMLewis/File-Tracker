<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="BoxDashboard.aspx.vb" Inherits="FileTracker.BoxDashboard" %>

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
     Dim queryBoxes As New SqlCommand("SELECT (SELECT COUNT(BoxID) FROM Boxes) As countBoxes, " &
                               "(SELECT COUNT(BoxID) FROM Boxes WHERE LocationID = '1') As countBoxesOnSite, " &
                               "(SELECT COUNT(BoxID) FROM Boxes WHERE LocationID = '2') As countBoxesAtWarehouse, " &
                               "(SELECT COUNT(BoxID) FROM Boxes WHERE LocationID = '3') As countBoxesUnknownLocation " &
                               "FROM Boxes", conn)
     Dim readerBoxes As SqlDataReader = queryBoxes.ExecuteReader()
     Dim countBoxes As Integer
     Dim countBoxesOnSite As Integer
     Dim countBoxesAtWarehouse As Integer
     Dim countBoxesUnknownLocation As Integer
     While readerBoxes.Read
         countBoxes = CStr(readerBoxes("countBoxes"))
         countBoxesOnSite = CStr(readerBoxes("countBoxesOnSite"))
         countBoxesAtWarehouse = CStr(readerBoxes("countBoxesAtWarehouse"))
         countBoxesUnknownLocation = CStr(readerBoxes("countBoxesUnknownLocation"))
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
					  	<span class="li_stack"></span>
					  	<h3><% Response.Write(countBoxes)%></h3>
                  	</div>
					<p><% Response.Write(countBoxes)%>&nbsp; Total</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class="li_shop"></span>
					  	<h3><% Response.Write(countBoxesOnSite)%></h3>
                  	</div>
					<p><% Response.Write(countBoxesOnSite)%>&nbsp; On Site</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class="li_location"></span>
					  	<h3><% Response.Write(countBoxesAtWarehouse)%></h3>
                  	</div>
					<p><% Response.Write(countBoxesAtWarehouse)%>&nbsp; At Warehouse</p>
                </div>
                <div class="col-md-2 col-sm-1 box0">
                  	<div class="box1">
					  	<span class="li_search"></span>
					  	<h3><% Response.Write(countBoxesUnknownLocation)%></h3>
                  	</div>
					<p><% Response.Write(countBoxesUnknownLocation)%>&nbsp; Unknown Lcoation</p>
                </div>
            </div>
		 </div>
       </div>

         <div class="row">
             <div class="col-lg-4 col-md-4 col-sm-4 mb">
                 <div class="weather-3 pn centered">
                     <a href="BoxInfo.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
                         <i class="fa fa-info"></i>
                         <h1>Info</h1>
                         <div class="info">
                             <div class="row">
                                 <h3 class="centered">Info</h3>
                                 <div class="col-sm-6 col-xs-6 pull-left">
                                     <p class="goleft"><i class="fa fa-archive"></i>Info</p>
                                 </div>
                                 <div class="col-sm-6 col-xs-6 pull-right">
                                     <p class="goright"><i class="fa fa-archive"></i>Info</p>
                                 </div>
                             </div>
                         </div>
                     </a>
                 </div>
             </div>

             <div class="col-lg-4 col-md-4 col-sm-4 mb"></div>

             <div class="col-lg-4 col-md-4 col-sm-4 mb">
                 <div class="weather-3 pn centered">
                     <a href="CreateBox.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
                         <i class="fa fa-inbox"></i>
                         <h1>Create</h1>
                         <div class="info">
                             <div class="row">
                                 <h3 class="centered">Create</h3>
                                 <div class="col-sm-6 col-xs-6 pull-left">
                                     <p class="goleft"><i class="fa fa-archive"></i>Create</p>
                                 </div>
                                 <div class="col-sm-6 col-xs-6 pull-right">
                                     <p class="goright"><i class="fa fa-archive"></i>Create</p>
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
                <a href="OnSiteBoxes.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-building"></i>
				<h1>On Site</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">On Site</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-archive"></i> On Site</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-archive"></i> On Site</p>
						</div>
					</div>
				</div>
                </a>
			</div>		
	    </div>

        <div class="col-lg-4 col-md-4 col-sm-4 mb">
            <div class="weather-3 pn centered">
                <a href="UnknownBoxes.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-search"></i>
				<h1>Unknown</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">Unkown</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-archive"></i> Unknown</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-archive"></i> Unknown</p>
						</div>
					</div>
				</div>
			    </a>
            </div>		
        </div>

        <div class="col-lg-4 col-md-4 col-sm-4 mb">
			<div class="weather-3 pn centered">
                <a href="WarehouseBoxes.aspx?SessionUserID=<% Response.Write(sessionUserID) %>&SessionRoleID=<% Response.Write(sessionRoleID) %>">
				<i class="fa fa-map-marker"></i>
				<h1>Warehouse</h1>
				<div class="info">
					<div class="row">
                        <h3 class="centered">Warehouse</h3>
						<div class="col-sm-6 col-xs-6 pull-left">
							<p class="goleft"><i class="fa fa-archive"></i> Warehouse</p>
						</div>
						<div class="col-sm-6 col-xs-6 pull-right">
							<p class="goright"><i class="fa fa-archive"></i> Warehouse</p>
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