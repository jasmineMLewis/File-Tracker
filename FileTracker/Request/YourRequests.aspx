<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" 
CodeBehind="YourRequests.aspx.vb" Inherits="FileTracker.UserRequests" %>

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
    %>
    <section id="main-content">
      <section class="wrapper site-min-height">
        <h3 class="page-title"><i class="fa fa-cart-arrow-down" aria-hidden="true"></i> Your Requests</h3>
        <hr />
        <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-cart-arrow-down" aria-hidden="true"></i> Your Requests</h3>
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
                            <label class="col-sm-1 control-label">Priority</label>
                            <div class="col-sm-3">
                                <asp:DropDownList ID="PriorityType" runat="server" DataSourceID="SqlPriorityTypes" 
                                    class="form-control" DataTextField="Priority" DataValueField="PriorityID">
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
                                <asp:DropDownList ID="PurposeType" runat="server" DataSourceID="SqlPurposeTypes" 
                                    class="form-control" DataTextField="Purpose" DataValueField="PurposeID">
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
                            <i class="fa fa-filter"></i> Filter Your Requests
                        </button>
                    </div>
                </div>
            </div>   	
        </div>
        <div class="row st">
            <div class="col-lg-12">
              <div class="form-panel">
                <h3 class="page-title"><i class="fa fa-cart-arrow-down"></i> Your Requests</h3>
                <hr />
                <br />
                <asp:SqlDataSource ID="SqlUserRequests" runat="server" 
                      ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                      SelectCommand="SELECT Request.RequestID, Request.ClientFirstName, Request.ClientLastName, Request.ClientLastFourSSN, 
                                            Request.PriorityID, Priority.Priority, Request.PurposeID, Purpose.Purpose, 
                                            Request.Comment, Request.CommentLastUpdatedDate,
                                            CONVERT (varchar, Request.RequestDate, 0) AS RequestDate, Request.RequestedByUserID, 
                                            Requestor.FirstName + ' ' + Requestor.LastName AS UserRequested, 
                                            CONVERT (varchar, Request.CheckOutDate, 0) AS CheckOutDate, Request.CheckedOutByUserID, 
                                            CheckedOuter.FirstName + ' ' + CheckedOuter.LastName AS UserCheckedOuter, 
                                            Request.IsPickUpRequested, CONVERT (varchar, Request.PickUpRequestDate, 0) AS PickUpRequestDate, 
                                            Request.CheckedInByUserID, CONVERT (varchar, Request.CheckedInDate, 0) AS CheckedInDate, 
                                            CheckedInner.FirstName + ' ' + CheckedInner.LastName AS UserCheckedInner 
                                      FROM Request 
                                      INNER JOIN Priority AS Priority On Request.PriorityID = Priority.PriorityID
                                      INNER JOIN Purpose AS Purpose On Request.PurposeID = Purpose.PurposeID
                                      LEFT OUTER JOIN [User] AS Requestor ON Request.RequestedByUserID = Requestor.UserID 
                                      LEFT OUTER JOIN [User] AS CheckedOuter ON Request.CheckedOutByUserID = CheckedOuter.UserID 
                                      LEFT OUTER JOIN [User] AS CheckedInner ON Request.CheckedInByUserID = CheckedInner.UserID
                                      ORDER By RequestDate DESC, ClientFirstName ASC">
                </asp:SqlDataSource>
                <div class="table-responsive">
                    <asp:GridView ID="GridViewUserRequests" runat="server" AutoGenerateColumns="False" PageSize="20" 
                                  DataSourceID="SqlUserRequests" CssClass="table table-hover" GridLines="None" 
                                  AllowPaging="True" DataKeyNames="RequestID">
                     <Columns>
                        <asp:BoundField DataField="ClientFirstName" SortExpression="ClientFirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="ClientLastName" SortExpression="ClientLastName" HeaderText="Last Name" />
                        <asp:BoundField DataField="ClientLastFourSSN" SortExpression="ClientLastFourSSN" HeaderText="Last Four SSN" />
                        <asp:BoundField DataField="Priority" SortExpression="Priority" HeaderText="Priority" />
                        <asp:BoundField DataField="Purpose" SortExpression="Purpose" HeaderText="Purpose" />
                        <asp:BoundField DataField="RequestDate" SortExpression="RequestDate" HeaderText="Request Date" />
                        <asp:BoundField DataField="UserRequested" SortExpression="UserRequested" HeaderText="Requested By" />
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                               <%# DisplayEditLink(Request.QueryString("SessionUserID"), Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Comment" SortExpression="Comment" HeaderText="Comment" />
                        <asp:BoundField DataField="CommentLastUpdatedDate" SortExpression="CommentLastUpdatedDate" HeaderText="Comment Updated Date" />
                        <asp:TemplateField HeaderText="Cancel">
                            <ItemTemplate>
                              <%# DisplayCancelLink(Request.QueryString("SessionUserID"), Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Cancelled Date">
                            <ItemTemplate>
                              <%# DisplayCancelledDate(Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Check Out">
                            <ItemTemplate>
                               <%# DisplayCheckOutLink(Request.QueryString("SessionUserID"), Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Check Out Date">
                            <ItemTemplate>
                             <%# DisplayCheckOutDate(Eval("RequestID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UserCheckedOuter" SortExpression="UserCheckedOuter" HeaderText="Checked Out By" />
                         <asp:TemplateField HeaderText="Request Pick Up">
                                <ItemTemplate>
                                   <%# DisplayRequestPickUpLink(Request.QueryString("SessionUserID"), Eval("RequestID"))%>
                                </ItemTemplate>
                         </asp:TemplateField>
                         <asp:BoundField DataField="PickUpRequestDate" SortExpression="PickUpRequestDate" HeaderText="Pick Up Request Date" />
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
