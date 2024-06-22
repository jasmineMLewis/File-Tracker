<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" 
CodeBehind="WarehouseBoxes.aspx.vb" Inherits="FileTracker.WarehouseBoxes" %>

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
                                    DataTextField="Box" DataValueField="pk_BoxID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlBoxes" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT [pk_BoxID], (BoxNumber + ' | ' + Year) AS [Box] 
                                                   FROM [Boxes]
                                                   WHERE [fk_LocationID] = '2'
                                                   ORDER BY [Year], [BoxNumber]">
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
            SelectCommand="SELECT Boxes.pk_BoxID, Boxes.BoxNumber, Boxes.Year, Boxes.BoxNumber + ' | ' + Boxes.Year AS Box, 
                                  Boxes.fk_LocationID, Location.Location, 
                                  CAST(MONTH(Boxes.AnticipatedDeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(Boxes.AnticipatedDeliveryToWarehouseDate) AS varchar) AS AnticipatedDeliveryToWarehouseDate,
                                  CAST(MONTH(Boxes.DeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(Boxes.DeliveryToWarehouseDate) AS varchar) AS DeliveryToWarehouseDate, 
                                  CAST(MONTH(Boxes.ActualDestructionDate) AS varchar) + '-' + CAST(YEAR(Boxes.ActualDestructionDate) AS varchar) AS ActualDestructionDate, 
                                  (SELECT COUNT(pk_FileID) AS Expr1 FROM Files WHERE (fk_BoxID = Boxes.pk_BoxID)) AS FileCountPerBox 
                            FROM Boxes 
                            LEFT JOIN Location ON Boxes.fk_LocationID = Location.pk_LocationID
                            WHERE fk_LocationID = '2'">
        </asp:SqlDataSource>

       <div class="row st">
           <div class="col-lg-12">
              <div class="form-panel">
                <h3 class="page-title"><i class="fa fa-map-marker"></i> Warehouse Boxes</h3>
                <hr />
                <br />
                <div class="table-responsive">
                    <asp:GridView ID="GridViewWarehouseBoxes" runat="server" AutoGenerateColumns="False" DataSourceID="SqlWarehouseBoxes" 
                                  CssClass="table table-hover" GridLines="None" AllowPaging="True" PageSize="40" DataKeyNames="pk_BoxID, Box">
                      <Columns>
                        <asp:TemplateField HeaderText="Box">
                        <ItemTemplate>
                            <%# DisplayBoxNumber(Request.QueryString("SessionUserID"), Request.QueryString("SessionRoleID"), Eval("pk_BoxID"), Eval("Box")) %>
                        </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:BoundField DataField="BoxNumber" HeaderText="Box Number" SortExpression="BoxNumber" />
                        <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                        <asp:BoundField DataField="Location" HeaderText="Location" 
                            SortExpression="Location" />
                        <asp:TemplateField HeaderText="Anticipated Delivery To Warehouse Date">
                            <ItemTemplate>
                             <%# DisplayAnticipatedDeliveryToWarehouseDate(Eval("pk_BoxID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Delivery To Warehouse Date">
                            <ItemTemplate>
                             <%# DisplayDeliveryToWarehouseDate(Eval("pk_BoxID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actual Destruction Date">
                            <ItemTemplate>
                             <%# DisplayActualDestructionDate(Eval("pk_BoxID"))%>
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
