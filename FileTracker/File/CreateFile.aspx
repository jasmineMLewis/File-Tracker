<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="CreateFile.aspx.vb" Inherits="FileTracker.CreateFile" %>

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
           <h3 class="page-title"><i class="fa fa-file-text-o" aria-hidden="true"></i> Create File</h3>
           <hr />
       	    <div class="row st">
          	    <div class="col-lg-12">
                      <div class="form-panel">
                  	      <h3 class="page-title"><i class="fa fa-file-text-o" aria-hidden="true"></i> Create File</h3>
                          <hr />
                          <br />
                          <div class="form-horizontal style-form">
                             <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                             <div class="form-group">
                                  <label class="col-sm-2 control-label">Client First Name *</label>
                                  <div class="col-sm-4">
                                     <asp:TextBox ID="clientFirstName" runat="server" class="input-medium form-control" placeholder="Client First Name" maxlength="50"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="requiredClientFirstName" runat="server" controltovalidate="clientFirstName"></asp:RequiredFieldValidator>
                                  </div>
                                  <label class="col-sm-2 control-label">Client Last Name *</label>
                                  <div class="col-sm-4">
                                     <asp:TextBox ID="clientLastName" runat="server" class="input-medium form-control" placeholder="Client Last Name" maxlength="50"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="requiredClientLastName" runat="server" controltovalidate="clientLastName"></asp:RequiredFieldValidator>
                                  </div>
                             </div>
                             <div class="form-group">
                                  <label class="col-sm-2 control-label">Last Four of SSN *</label>
                                  <div class="col-sm-4">
                                      <asp:TextBox ID="lastFourSSN" runat="server" class="input-medium form-control" placeholder="Last Four of Social Security Number" maxlength="4"></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="requiredLastFourSSN" runat="server" controltovalidate="lastFourSSN"></asp:RequiredFieldValidator>
                                  </div>
                                  <label class="col-sm-2 control-label">Purge Type Date *</label>
                                  <div class="col-sm-4">
                                     <asp:TextBox ID="purgeTypeDate" runat="server" class="input-medium form-control" placeholder="{NEED TO WORK ON} EOP | Denial/Withdrawal | Port Out Date" maxlength="10"></asp:TextBox>
                                     <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="purgeTypeDate" Format="MM/dd/yyyy"></ajaxToolkit:CalendarExtender>--%>
                                     <asp:RequiredFieldValidator ID="requiredPurgeTypeDate" runat="server" controltovalidate="purgeTypeDate"></asp:RequiredFieldValidator>
                                  </div>
                             </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">Purge Type *</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="PurgeType" runat="server" DataSourceID="SqlPurgeTypes" class="form-control"
                                        DataTextField="PurgeType" DataValueField="PurgeTypeID"></asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlPurgeTypes" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                        SelectCommand="SELECT * FROM PurgeType ORDER BY PurgeType">
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="requiredPurgeType" runat="server" controltovalidate="PurgeType"></asp:RequiredFieldValidator>
                                </div>
                                <label class="col-sm-2 control-label">Box *</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="Boxes" runat="server" DataSourceID="SqlBoxes" class="form-control"
                                        DataTextField="Box" DataValueField="BoxID"></asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlBoxes" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                        SelectCommand="SELECT BoxID, (BoxNumber + ' | ' + BoxYear) AS Box FROM Boxes ORDER BY BoxYear, BoxNumber">
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="requiredBox" runat="server" controltovalidate="Boxes"></asp:RequiredFieldValidator>
                                </div>
                             </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">Location *</label>
                                <div class="col-sm-4">
                                    <asp:DropDownList ID="Location" runat="server" DataSourceID="SqlLocation" class="form-control"
                                        DataTextField="Location" DataValueField="LocationID"></asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlLocation" runat="server" 
                                        ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                        SelectCommand="SELECT [LocationID], [Location] FROM [Location] ORDER BY [Location]">
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="requiredLocation" runat="server" controltovalidate="Location"></asp:RequiredFieldValidator>
                                </div>
                             </div>
                             <div class="form-group">
                                <label class="col-sm-2 control-label">Notes *</label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="notes" runat="server" TextMode="multiline" Columns="50" Rows="5" placeholder="Notes" maxlength="225" class="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="requiredNotes" runat="server" controltovalidate="notes"></asp:RequiredFieldValidator>
                                </div>
                             </div>
                             <button type="button" class="btn btn-theme btn-lg btn-block" runat="server" onserverclick="BtnCreateFile">
                                <i class="fa fa-file" aria-hidden="true"></i> Create File
                             </button>
                            <asp:Label ID="lblMsg" runat="server" Style="font-size: 14px; font-weight: 700;
                                color: #1A926A" EnableViewState="False">
                            </asp:Label>
                          </div>
                      </div>
                </div>   	
            </div>
      </section>
    </section>
</asp:Content>
