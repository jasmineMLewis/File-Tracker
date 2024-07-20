<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" 
CodeBehind="WarehouseBoxes.aspx.vb" Inherits="FileTracker.WarehouseBoxes" %>

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
       <h3 class="page-title"><i class="fa fa-map-marker"></i> Warehouse Boxes</h3>
       <hr />

       <div class="row st">
          	<div class="col-lg-12">
                <div class="form-panel">
                  	<h3 class="page-title"><i class="fa fa-map-marker" aria-hidden="true"></i> Warehouse Boxes</h3>
                    <hr />
                    <br />
                    <div class="form-horizontal style-form">
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Box </label>
                            <div class="col-sm-10">
                                <asp:DropDownList ID="BoxList" runat="server" DataSourceID="SqlBoxes" class="form-control"
                                    DataTextField="Box" DataValueField="BoxID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlBoxes" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT BoxID, (BoxNumber + ' | ' + BoxYear) AS Box 
                                                   FROM Box
                                                   WHERE LocationID = '2'
                                                   ORDER BY BoxYear, BoxNumber">
                                </asp:SqlDataSource>
                            </div>
                        </div>
                        <button id="Button1" type="button" class="btn btn-theme btn-lg btn-block" runat="server"
                            onserverclick="BtnFilterBoxes"><i class="fa fa-filter"></i> Filter Warehouse Boxes
                        </button>
                    </div>
                </div>
            </div>   	
       </div>
       
        <asp:SqlDataSource ID="SqlWarehouseBoxes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
            SelectCommand="SELECT Box.BoxID, Box.BoxNumber, Box.BoxYear, Box.BoxNumber + ' | ' + Box.BoxYear AS Box, 
                                  Box.LocationID, Location.Location, 
                                  CAST(MONTH(Box.AnticipatedDeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(Box.AnticipatedDeliveryToWarehouseDate) AS varchar) AS AnticipatedDeliveryToWarehouseDate,
                                  CAST(MONTH(Box.DeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(Box.DeliveryToWarehouseDate) AS varchar) AS DeliveryToWarehouseDate, 
                                  CAST(MONTH(Box.ActualDestructionDate) AS varchar) + '-' + CAST(YEAR(Box.ActualDestructionDate) AS varchar) AS ActualDestructionDate, 
                                  (SELECT COUNT(FileID) AS FileID FROM [File] WHERE (BoxID = Box.BoxID)) AS FileCountPerBox 
                            FROM Box 
                            LEFT JOIN Location ON Box.LocationID = Location.LocationID
                            WHERE Box.LocationID = '2'">
        </asp:SqlDataSource>

       <div class="row st">
           <div class="col-lg-12">
              <div class="form-panel">
                <h3 class="page-title"><i class="fa fa-map-marker"></i> Warehouse Boxes</h3>
                <hr />
                <br />
                <div class="table-responsive">
                    <asp:GridView ID="GridViewWarehouseBoxes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlWarehouseBoxes" 
                                  CssClass="table table-hover" GridLines="None" AllowPaging="True" 
                                  PageSize="40" DataKeyNames="BoxID, Box">
                      <Columns>
                        <asp:TemplateField HeaderText="Box">
                        <ItemTemplate>
                            <%# DisplayBoxNumber(Request.QueryString("SessionUserID"), Request.QueryString("SessionRoleID"), Eval("BoxID"), Eval("Box")) %>
                        </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:BoundField DataField="BoxNumber" HeaderText="Box Number" SortExpression="BoxNumber" />
                        <asp:BoundField DataField="BoxYear" HeaderText="Box Year" SortExpression="BoxYear" />
                        <asp:BoundField DataField="Location" HeaderText="Location" 
                            SortExpression="Location" />
                        <asp:TemplateField HeaderText="Anticipated Delivery To Warehouse Date">
                            <ItemTemplate>
                             <%# DisplayAnticipatedDeliveryToWarehouseDate(Eval("BoxID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delivery To Warehouse Date">
                            <ItemTemplate>
                             <%# DisplayDeliveryToWarehouseDate(Eval("BoxID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actual Destruction Date">
                            <ItemTemplate>
                             <%# DisplayActualDestructionDate(Eval("BoxID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FileCountPerBox" HeaderText="Files Per Box" ReadOnly="True" />
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
