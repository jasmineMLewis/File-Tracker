<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="UsersRequests.aspx.vb" Inherits="FileTracker.UsersRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta http-equiv="Refresh" content="30" />
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
      Const FILE_ROOM_CLERK As Integer = 4
    %>

    <section id="main-content">
      <section class="wrapper site-min-height">
        <h3 class="page-title"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Users' Requests</h3>
        <hr />
        <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Users' Requests</h3>
                    <hr />
                    <br />
                    <div class="form-horizontal style-form">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="form-group">
                            <label class="col-sm-1 control-label">Client First Name</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="clientFirstName" runat="server" maxlength="50" placeholder="Client First Name" class="form-control"></asp:TextBox>
                            </div>
                            <label class="col-sm-1 control-label">Client Last Name</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="clientLastName" runat="server" maxlength="50" placeholder="Client Last Name" class="form-control"></asp:TextBox>
                            </div>
                            <label class="col-sm-1 control-label">Request Date</label>
                            <div class="col-sm-3">
                                <asp:TextBox ID="RequestDate" runat="server" class="input-medium form-control" textmode="Date"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="requiredRequestDate" runat="server" controltovalidate="RequestDate"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                        <%
                            If sessionRoleID = ADMIN  Or sessionRoleID = PROJECT_SPECIALIST Or sessionRoleID = FILE_ROOM_CLERK Then
                         %>
                        
                            <label class="col-sm-1 control-label">Requestor</label>
                            <div class="col-sm-3">
                                <asp:DropDownList ID="ListRequestor" runat="server" class="form-control" DataSourceID="SqlRequestor" 
                                       DataTextField="FullName" DataValueField="UserID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlRequestor" runat="server" 
                                       ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                       SelectCommand="SELECT UserID, FirstName + ' ' + LastName AS FullName 
                                                      FROM Users 
                                                      WHERE RoleID != '4' AND IsEnabled = '1'
                                                      ORDER BY FullName">
                                </asp:SqlDataSource>
                            </div>
                        <%
                        End If
                         %>

                            <label class="col-sm-1 control-label">Priority</label>
                            <div class="col-sm-3">
                                    <asp:DropDownList ID="PriorityType" runat="server" 
                                        DataSourceID="SqlPriorityTypes" class="form-control"
                                        DataTextField="Priority" DataValueField="PriorityID">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlPriorityTypes" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                        SelectCommand="SELECT PriorityID, Priority 
                                                       FROM Priority 
                                                       ORDER BY Priority">
                                    </asp:SqlDataSource>
                            </div>
                            <label class="col-sm-1 control-label">Purpose</label>
                            <div class="col-sm-3">
                                    <asp:DropDownList ID="PurposeType" runat="server" 
                                        DataSourceID="SqlPurposeTypes" class="form-control"
                                        DataTextField="Purpose" DataValueField="PurposeID">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlPurposeTypes" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                        SelectCommand="SELECT PurposeID, Purpose 
                                                       FROM Purpose 
                                                       ORDER BY Purpose">
                                    </asp:SqlDataSource>
                            </div>
                        </div>
                        <button type="button" class="btn btn-theme btn-lg btn-block" runat="server" onserverclick="BtnFilterRequests">
                            <i class="fa fa-filter"></i> Filter Users' Requests
                        </button>
                    </div>
                </div>
            </div>   	
        </div>

        <%
            If sessionRoleID = ADMIN Or sessionRoleID = PROJECT_SPECIALIST Or sessionRoleID = FILE_ROOM_CLERK Then
        %>
         <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-shopping-cart" aria-hidden="true"></i> Export Request Directory</h3>
                    <hr />
                     <button id="ButtonExport" type="button" class="btn btn-theme btn-lg btn-block" runat="server" 
                        onserverclick="BtnExportToExcel">
                        <i class="fa fa-file-excel-o" aria-hidden="true"></i> Export Requests To Excel
                     </button>
                </div>
            </div>
         </div>
         <%
         End If
         %>
        <div class="row st">
            <div class="col-lg-12">
              <div class="form-panel">
                <h3 class="page-title"><i class="fa fa-shopping-cart"></i> Users' Requests</h3>
                <hr />
                <br />
                <asp:SqlDataSource ID="SqlUsersRequests" runat="server" 
                      ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                      SelectCommand="SELECT Requests.RequestID, Requests.ClientFirstName, Requests.ClientLastName, Requests.ClientLastFourSSN, 
                                             Requests.PriorityID, PriorityType.Priority, Requests.PurposeID, PurposeType.Purpose, 
                                             Requests.Comment, Requests.CommentLastUpdatedDate,
                                            CONVERT (varchar, Requests.RequestDate, 22) AS RequestDate, Requests.RequestedByUserID, 
                                            Requestor.FirstName + ' ' + Requestor.LastName AS UserRequested, 
                                            CONVERT (varchar, Requests.CheckOutDate, 22) AS CheckOutDate, Requests.CheckedOutByUserID, 
                                            CheckedOuter.FirstName + ' ' + CheckedOuter.LastName AS UserCheckedOuter, 
                                            Requests.IsPickUpRequested, CONVERT (varchar, Requests.PickUpRequestDate, 22) AS PickUpRequestDate, 
                                            Requests.CheckedInByUserID, CONVERT (varchar, Requests.CheckedInDate, 22) AS CheckedInDate, 
                                            CheckedInner.FirstName + ' ' + CheckedInner.LastName AS UserCheckedInner 
                                      FROM Requests 
                                      INNER JOIN Priority AS PriorityType On Requests.PriorityID = PriorityType.PriorityID
                                      INNER JOIN Purpose AS PurposeType On Requests.PurposeID = PurposeType.PurposeID
                                      LEFT OUTER JOIN Users AS Requestor ON Requests.RequestedByUserID = Requestor.UserID 
                                      LEFT OUTER JOIN Users AS CheckedOuter ON Requests.CheckedOutByUserID = CheckedOuter.UserID 
                                      LEFT OUTER JOIN Users AS CheckedInner ON Requests.CheckedInByUserID = CheckedInner.UserID
                                      ORDER By RequestDate DESC, ClientFirstName ASC">
                </asp:SqlDataSource>
                <div class="table-responsive">
                    <asp:GridView ID="GridViewUsersRequests" runat="server" AutoGenerateColumns="False" PageSize="20" 
                                  DataSourceID="SqlUsersRequests" CssClass="table table-hover" GridLines="None" 
                                  AllowPaging="True" DataKeyNames="RequestID">
                     <Columns>
                        <asp:BoundField DataField="ClientFirstName" SortExpression="ClientFirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="ClientLastName" SortExpression="ClientLastName" HeaderText="Last Name" />
                        <asp:BoundField DataField="ClientLastFourSSN" SortExpression="ClientLastFourSSN" HeaderText="Last Four SSN" />
                         <asp:BoundField DataField="Priority" SortExpression="Priority" HeaderText="Priority" />
                        <asp:BoundField DataField="Purpose" SortExpression="Purpose" HeaderText="Purpose" />
                        <asp:BoundField DataField="Comment" SortExpression="Comment" HeaderText="Comment" />
                        <asp:BoundField DataField="CommentLastUpdatedDate" SortExpression="CommentLastUpdatedDate" HeaderText="Comment Updated Date" />
                        <asp:TemplateField HeaderText="Cancelled">
                            <ItemTemplate>
                              <%# DisplayCancelled(Request.QueryString("SessionUserID"), Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Cancelled Date">
                            <ItemTemplate>
                              <%# DisplayCancelledDate(Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:BoundField DataField="RequestDate" SortExpression="RequestDate" HeaderText="Request Date" />
                        <asp:BoundField DataField="UserRequested" SortExpression="UserRequested" HeaderText="Requested By" />
                        <asp:BoundField DataField="UserCheckedOuter" SortExpression="UserCheckedOuter" HeaderText="Checked Out By" />
                        <asp:BoundField DataField="CheckOutDate" SortExpression="CheckOutDate" HeaderText="Check Out Date" />
                        <asp:BoundField DataField="PickUpRequestDate" SortExpression="PickUpRequestDate" HeaderText="Pick Up Request Date" />
                        <asp:TemplateField HeaderText="Check In">
                            <ItemTemplate>
                             <%# DisplayCheckInLink(Request.QueryString("SessionUserID"), Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UserCheckedInner" SortExpression="UserCheckedInner" HeaderText="Checked In By" />
                        <asp:BoundField DataField="CheckedInDate" SortExpression="CheckedInDate" HeaderText="Check In Date" />
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