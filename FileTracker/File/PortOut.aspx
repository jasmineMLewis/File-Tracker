<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="PortOut.aspx.vb" Inherits="FileTracker.PortOut" %>
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
       <h3 class="page-title"><i class="fa fa-truck" aria-hidden="true"></i> Port Out Files</h3>
        <hr />
   	    <div class="row st">
          	<div class="col-lg-12">
                <div class="form-panel">
                  	<h3 class="page-title"><i class="fa fa-truck" aria-hidden="true"></i> Port Out Files</h3>
                    <hr />
                    <br />
                    <div class="form-horizontal style-form">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Client First Name</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="clientFirstName" runat="server" maxlength="50" placeholder="Client First Name" class="form-control"></asp:TextBox>
                            </div>
                            <label class="col-sm-2 control-label">Client Last Name</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="clientLastName" runat="server" maxlength="50" placeholder="Client Last Name" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Box </label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="Boxes" runat="server" DataSourceID="SqlBoxes" class="form-control"
                                    DataTextField="Box" DataValueField="BoxID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlBoxes" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT BoxID, (BoxNumber + ' | ' + BoxYear) AS Box 
                                                    FROM Box 
                                                    ORDER BY BoxYear, BoxNumber">
                                </asp:SqlDataSource>
                            </div>
                            <label class="col-sm-2 control-label">Location </label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="Location" runat="server" DataSourceID="SqlLocation" class="form-control"
                                    DataTextField="Location" DataValueField="LocationID"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlLocation" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT LocationID, Location 
                                                   FROM Location
                                                   ORDER BY Location">
                                </asp:SqlDataSource>
                            </div>
                        </div>
                       <button id="Button" type="button" class="btn btn-theme btn-lg btn-block" runat="server" 
                                onserverclick="BtnFilterFiles">
                         <i class="fa fa-filter"></i> Filter Port Out Files
                       </button>
                    </div>
                </div>
            </div>   	
        </div>

        <asp:SqlDataSource ID="SqlFiles" runat="server" 
            ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
            SelectCommand="SELECT [File].FileID, [File].ClientFirstName, [File].ClientLastName, [File].ClientLastFourSSN, 
                                CONVERT (varchar(MAX), CAST([File].PurgeTypeDate AS date), 101) AS PurgeTypeDate, 
                                [File].IsDestroyed, [File].Notes, [File].PurgeTypeID, PurgeType.PurgeType, [File].BoxID, 
                                (Box.BoxNumber + ' | ' + Box.BoxYear) AS Box, [File].LocationID, Location.Location,
                                [File].SubmittedByUserID, [User].FirstName + ' ' + [User].LastName AS SubmittedByUser,
                                CONVERT (varchar(MAX), CAST([File].DateSubmitted AS date), 101) AS DateSubmitted
                        FROM [File] 
                        INNER JOIN Box ON [File].BoxID = Box.BoxID 
                        INNER JOIN PurgeType ON [File].PurgeTypeID = PurgeType.PurgeTypeID
                        INNER JOIN Location ON [File].LocationID = Location.LocationID
                        INNER JOIN [User] ON [File].SubmittedByUserID = [User].UserID
                        WHERE [File].PurgeTypeID = '3'
                        ORDER BY [File].FileID">
        </asp:SqlDataSource>

        <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-truck" aria-hidden="true"></i> Port Out Files</h3>
                    <hr />
                    <br />
                    <div class="table-responsive">
                        <asp:GridView ID="GridViewFiles" runat="server" AutoGenerateColumns="False"  DataSourceID="SqlFiles" 
                                    CssClass="table table-hover" GridLines="None" AllowPaging="True" PageSize="20"
                                    DataKeyNames="FileID, PurgeTypeID, BoxID">
                            <Columns>
                                <asp:BoundField DataField="ClientFirstName" SortExpression="ClientFirstName" HeaderText="Client First Name" />
                                <asp:BoundField DataField="ClientLastName" SortExpression="ClientLastName" HeaderText="Client Last Name" />
                                <asp:BoundField DataField="ClientLastFourSSN" SortExpression="ClientLastFourSSN" HeaderText="Client Last Four SSN" />
                                <asp:TemplateField HeaderText="Destroyed">
                                    <ItemTemplate>
                                        <%# DisplayDeleteIcon(Eval("IsDestroyed"))%>
                                    </ItemTemplate>
                                </asp:TemplateField> 
                                <asp:BoundField DataField="PurgeTypeDate" SortExpression="PurgeTypeDate" HeaderText="Purge Type Date" />
                                <asp:BoundField DataField="PurgeType" SortExpression="PurgeType" HeaderText="Purge Type" />
                                <asp:BoundField DataField="Box" SortExpression="Box" HeaderText="Box" />
                                    <asp:BoundField DataField="Location" SortExpression="Location" HeaderText="Location" />
                                <asp:BoundField DataField="Notes" SortExpression="Notes" HeaderText="Notes" />
                                <asp:BoundField DataField="SubmittedByUser" SortExpression="SubmittedByUser" HeaderText="Submitted By" />
                                <asp:BoundField DataField="DateSubmitted" SortExpression="DateSubmitted" HeaderText="Submit Date" />
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <%# DisplayEditFileLink(Request.QueryString("SessionUserID"), Request.QueryString("SessionRoleID"), Eval("FileID"))%>
                                    </ItemTemplate>
                                </asp:TemplateField> 
                            </Columns>
                            <PagerStyle CssClass="bs-pagination text-center"></PagerStyle>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
      </section>
  </section>
  <br />
</asp:Content>
