<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="BoxInfo.aspx.vb" Inherits="FileTracker.BoxInfo" %>

<%@ Import Namespace="System.Data.SqlClient" %>

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
       <h3 class="page-title"><i class="fa fa-archive" aria-hidden="true"></i> Box Information</h3>
       <hr />
       <div class="row st">
        <div class="col-lg-12">
            <div class="form-panel">
                <h3 class="page-title"><i class="fa fa-filter" aria-hidden="true"></i> Filter Box</h3>
                <hr />
                <br />
                <div class="form-horizontal style-form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Box</label>
                        <div class="col-sm-10">
                            <asp:DropDownList ID="BoxList" runat="server" DataSourceID="SqlBoxes" class="form-control"
                                DataTextField="Box" DataValueField="BoxID"></asp:DropDownList>
                            <asp:SqlDataSource ID="SqlBoxes" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                SelectCommand="SELECT BoxID, (BoxNumber + ' | ' + BoxYear) AS Box FROM Boxes ORDER BY BoxYear, BoxNumber">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                    <button id="ButtonFilterBoxes" type="button" class="btn btn-theme btn-lg btn-block" runat="server"
                        onserverclick="BtnFilterBoxes"><i class="fa fa-filter"></i> Filter Boxes
                    </button>
                </div>
            </div>
        </div>   	
       </div>

       <%
           If BoxList.SelectedValue <> 0 Or (Request.QueryString("BoxID") IsNot Nothing) Then
        %>
        <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-archive" aria-hidden="true"></i> Update Box Information</h3>
                    <hr />
                    <br />
                    <div class="form-horizontal style-form">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">Number *</label>
                            <div class="col-sm-3">
                                    <asp:DropDownList ID="BoxNumberList" runat="server" DataSourceID="SqlBoxNumber" class="form-control"
                                        DataTextField="BoxNumber" DataValueField="BoxNumber"></asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlBoxNumber" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                        SelectCommand="SELECT DISTINCT RTRIM(LTRIM(BoxNumber)) AS BoxNumber FROM Boxes">
                                    </asp:SqlDataSource>
                            </div>
                            <label class="col-sm-1 control-label">Year *</label>
                            <div class="col-sm-3">
                                <asp:DropDownList ID="YearList" runat="server" DataSourceID="SqlYear" class="form-control"
                                    DataTextField="BoxYear" DataValueField="BoxYear"></asp:DropDownList>
                                 <asp:SqlDataSource ID="SqlYear" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                        SelectCommand="SELECT DISTINCT BoxYear FROM Boxes">
                                 </asp:SqlDataSource>
                            </div>
                            <label class="col-sm-1 control-label">Location *</label>
                            <div class="col-sm-3">
                                <asp:DropDownList ID="LocationList" runat="server" DataSourceID="SqlLocation" class="form-control"
                                    DataTextField="Location" DataValueField="LocationID"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlLocation" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT LocationID, Location FROM Location">
                                </asp:SqlDataSource>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">Anticipated Warehouse Delivery *</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="AnticipatedDeliveryToWarehouseDate" runat="server" class="form-control" 
                                      textmode="Date">
                                </asp:TextBox>
                            </div>
                            <label class="col-sm-1 control-label">Warehouse Delivery</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="DeliveryToWarehouseDate" runat="server" class="form-control" placeholder="Delivery To Warehouse Date" type="date"></asp:TextBox>
                            </div>
                            <label class="col-sm-1 control-label">Actual Destruction</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="ActualDestuctionDate" runat="server" class="form-control" placeholder="Actual Destruction Date" type="date"></asp:TextBox>
                            </div>
                        </div>
                        <button id="ButtonUpdateBox" type="button" class="btn btn-theme btn-lg btn-block" runat="server" 
                            onserverclick="BtnUpdateBox"><i class="fa fa-archive" aria-hidden="true"></i> Update Box
                        </button>
                        <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700;
                            color: #1A926A" EnableViewState="False">
                        </asp:Label>
                    </div>
                </div>
            </div>   	
        </div>

        <asp:SqlDataSource ID="SqlFilesInBox" runat="server" 
                ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                SelectCommand="SELECT Files.FileID, Files.ClientFirstName, Files.ClientLastName, Files.LastFourSSN, 
                                  CONVERT (varchar(MAX), CAST(Files.PurgeTypeDate AS date), 101) AS PurgeTypeDate, 
                                  Files.IsDestroyed, Files.Notes, Files.PurgeTypeID, PurgeType.PurgeType, Files.BoxID, 
                                  Boxes.BoxNumber, Boxes.BoxYear, Files.LocationID, Location.Location,
                                  Files.SubmittedByUserID, Users.FirstName + ' ' + Users.LastName AS SubmittedByUser,
                                  CONVERT (varchar(MAX), CAST(Files.DateSubmitted AS date), 101) AS DateSubmitted
                           FROM Files 
                           INNER JOIN Boxes ON Files.BoxID = Boxes.BoxID 
                           INNER JOIN PurgeType ON Files.PurgeTypeID = PurgeType.PurgeTypeID
                           INNER JOIN Location ON Files.LocationID = Location.LocationID
                           INNER JOIN Users ON Files.SubmittedByUserID = Users.UserID">
        </asp:SqlDataSource>

        <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-file" aria-hidden="true"></i> Files in Box</h3>
                    <hr />
                    <br />
                    <asp:GridView ID="GridViewFilesInBox" runat="server" AutoGenerateColumns="False"  DataSourceID="SqlFilesInBox" 
                                    CssClass="table table-hover" GridLines="None" AllowPaging="True" PageSize="20"
                                    DataKeyNames="FileID, PurgeTypeID, BoxID, LocationID">
                        <Columns>
                            <asp:BoundField DataField="ClientFirstName" SortExpression="ClientFirstName" HeaderText="Client First Name" />
                            <asp:BoundField DataField="ClientLastName" SortExpression="ClientLastName" HeaderText="Client Last Name" />
                            <asp:BoundField DataField="LastFourSSN" SortExpression="LastFourSSN" HeaderText="Last Four SSN" />
                            <asp:BoundField DataField="PurgeTypeDate" SortExpression="PurgeTypeDate" HeaderText="Purge Type Date" />
                            <asp:BoundField DataField="PurgeType" SortExpression="PurgeType" HeaderText="Purge Type" />
                            <asp:BoundField DataField="BoxNumber" SortExpression="BoxNumber" HeaderText="Box Number" />
                            <asp:BoundField DataField="BoxYear" SortExpression="BoxYear" HeaderText="Box Year" />
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
       <% 
           End If
       %>
      </section>
    </section>
    <br />
</asp:Content>
