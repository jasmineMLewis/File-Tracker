<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="DenialOrWithdrawalFiles.aspx.vb" Inherits="FileTracker.DenialOrWithdrawalFiles" %>
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
    %>
  <section id="main-content">
      <section class="wrapper site-min-height">
        <h3 class="page-title"><i class="fa fa-paper-plane-o" aria-hidden="true"></i> Denial or Withdrawal Files</h3>
        <hr />
   	    <div class="row st">
          	<div class="col-lg-12">
                <div class="form-panel">
                  	<h3 class="page-title"><i class="fa fa-paper-plane-o" aria-hidden="true"></i> Denial or Withdrawal Files</h3>
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
                                    DataTextField="Box" DataValueField="pk_BoxID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlBoxes" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT [pk_BoxID], (BoxNumber + ' | ' + Year) AS [Box] FROM [Boxes] ORDER BY [Year], [BoxNumber]">
                                </asp:SqlDataSource>
                            </div>
                            <label class="col-sm-2 control-label">Location </label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="Location" runat="server" DataSourceID="SqlLocation" class="form-control"
                                    DataTextField="Location" DataValueField="pk_LocationID"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlLocation" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT [pk_LocationID], [Location] FROM [Location] ORDER BY [Location]">
                                </asp:SqlDataSource>
                            </div>
                        </div>
                        <button id="Button" type="button" class="btn btn-theme btn-lg btn-block" runat="server" onserverclick="BtnFilterFiles"><i class="fa fa-filter"></i> Filter EOP Files</button>
                    </div>
                </div>
            </div>   	
        </div>

        <asp:SqlDataSource ID="SqlFiles" runat="server" 
            ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
            SelectCommand="SELECT Files.pk_FileID, Files.ClientFirstName, Files.ClientLastName, Files.LastFourSSN, 
                                CONVERT (varchar(MAX), CAST(Files.PurgeTypeDate AS date), 101) AS PurgeTypeDate, 
                                Files.IsDestroyed, Files.Notes, Files.fk_PurgeTypeID, PurgeType.PurgeType, Files.fk_BoxID, 
                                (Boxes.BoxNumber + ' | ' + Boxes.Year) AS Box, Files.fk_LocationID, Location.Location,
                                Files.fk_SubmittedByUserID, Users.FirstName + ' ' + Users.LastName AS SubmittedByUser,
                                CONVERT (varchar(MAX), CAST(Files.DateSubmitted AS date), 101) AS DateSubmitted
                        FROM Files 
                        INNER JOIN Boxes ON Files.fk_BoxID = Boxes.pk_BoxID 
                        INNER JOIN PurgeType ON Files.fk_PurgeTypeID = PurgeType.pk_PurgeTypeID
                        INNER JOIN Location ON Files.fk_LocationID = Location.pk_LocationID
                        INNER JOIN Users ON Files.fk_SubmittedByUserID = Users.pk_UserID
                        WHERE Files.fk_PurgeTypeID = '2'
                        ORDER BY Files.pk_FileID">
        </asp:SqlDataSource>

        <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-paper-plane-o" aria-hidden="true"></i> Denial or Withdrawal Files</h3>
                    <hr />
                    <br />
                    <div class="table-responsive">
                        <asp:GridView ID="GridViewFiles" runat="server" AutoGenerateColumns="False"  DataSourceID="SqlFiles" 
                                    CssClass="table table-hover" GridLines="None" AllowPaging="True" PageSize="20"
                                    DataKeyNames="pk_FileID, fk_PurgeTypeID, fk_BoxID">
                            <Columns>
                                <asp:BoundField DataField="ClientFirstName" SortExpression="ClientFirstName" HeaderText="Client First Name" />
                                <asp:BoundField DataField="ClientLastName" SortExpression="ClientLastName" HeaderText="Client Last Name" />
                                <asp:BoundField DataField="LastFourSSN" SortExpression="LastFourSSN" HeaderText="Last Four SSN" />
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
                                        <%# DisplayEditFileLink(Request.QueryString("SessionUserID"), Request.QueryString("SessionRoleID"), Eval("pk_FileID"))%>
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
