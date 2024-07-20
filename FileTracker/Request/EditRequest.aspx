<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="EditRequest.aspx.vb" Inherits="FileTracker.EditRequest" %>
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
        <h3 class="page-title"><i class="fa fa-cart-plus" aria-hidden="true"></i> Edit Request</h3>
        <hr />
       	<div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                  	<h3 class="page-title"><i class="fa fa-cart-plus" aria-hidden="true"></i> Edit Request</h3>
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
                            <label class="col-sm-2 control-label">Client Last Four SSN *</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="clientLastFourSSN" runat="server" class="input-medium form-control" placeholder="Client Last Four SSN" maxlength="4"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="requiredclientLastFourSSN" runat="server" controltovalidate="clientLastFourSSN"></asp:RequiredFieldValidator>
                            </div>
                            <label class="col-sm-2 control-label">Priority *</label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="PriorityType" runat="server" DataSourceID="SqlPriorityTypes" 
                                    class="form-control" DataTextField="Priority" DataValueField="PriorityID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlPriorityTypes" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>"   
                                    SelectCommand="SELECT PriorityID, Priority 
                                                   FROM Priority 
                                                   ORDER BY Priority">
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="requiredPriorityType" runat="server" controltovalidate="PriorityType"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Purpose *</label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="PurposeType" runat="server" DataSourceID="SqlPurposeTypes"
                                    class="form-control" DataTextField="Purpose" DataValueField="PurposeID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlPurposeTypes" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>"  
                                    SelectCommand="SELECT PurposeID, Purpose 
                                                   FROM Purpose 
                                                   ORDER BY Purpose">
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="requiredPurposeType" runat="server" controltovalidate="PurposeType"></asp:RequiredFieldValidator>
                            </div>
                            <label class="col-sm-2 control-label">Comment about Edit *</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="commentAboutEdit" runat="server" class="input-medium form-control" placeholder="Comment about Edit" maxlength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredComment" runat="server" controltovalidate="commentAboutEdit"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <button id="button" type="button" class="btn btn-theme btn-lg btn-block" runat="server" onserverclick="btnEditRequest">
                         <i class="fa fa-cart-plus" aria-hidden="true"></i> Edit Request
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
