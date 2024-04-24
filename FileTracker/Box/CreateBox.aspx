<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master"
    CodeBehind="CreateBox.aspx.vb" Inherits="FileTracker.CreateBox" %>

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
           <h3 class="page-title"><i class="fa fa-archive" aria-hidden="true"></i> Create Box</h3>
        <hr />
       	<div class="row mt">
          	<div class="col-lg-12">
                <div class="form-panel">
                  	<h3 class="page-title"><i class="fa fa-archive" aria-hidden="true"></i> Create Box</h3>
                    <hr />
                    <br />
                    <div class="form-horizontal style-form">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Box Number *</label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="BoxNumber" runat="server" class="form-control"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="requiredBoxNumber" runat="server" controltovalidate="BoxNumber"></asp:RequiredFieldValidator>
                            </div>
                            <label class="col-sm-2 col-sm-2 control-label">Year *</label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="BoxYear" runat="server" class="form-control"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="requiredBoxYear" runat="server" controltovalidate="BoxYear"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">Anticipated Delivery To Warehouse Date *</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="AnticipatedDeliveryToWarehouseDate" runat="server" class="input-medium form-control"></asp:TextBox>
<%--                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="AnticipatedDeliveryToWarehouseDate" Format="MM/dd/yyyy"></ajaxToolkit:CalendarExtender>--%>
                                <asp:RequiredFieldValidator ID="requiredAnticipatedDeliveryToWarehouseDate" runat="server" controltovalidate="AnticipatedDeliveryToWarehouseDate"></asp:RequiredFieldValidator>
                            </div>
                             <label class="col-sm-2 col-sm-2 control-label">Location *</label>
                             <div class="col-sm-4">
                                <asp:DropDownList ID="BoxLocation" runat="server" DataSourceID="SqlLocation" class="form-control"
                                    DataTextField="Location" DataValueField="LocationID"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlLocation" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT LocationID, Location FROM Location ORDER BY Location">
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="requiredBoxLocation" runat="server" controltovalidate="BoxLocation"></asp:RequiredFieldValidator>
                             </div>
                        </div>
                        <button type="button" class="btn btn-theme btn-lg btn-block" runat="server" 
                         onserverclick="BtnCreateBox"><i class="fa fa-archive" aria-hidden="true"></i> Create Box
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