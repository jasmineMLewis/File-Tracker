<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/User.Master" CodeBehind="UserDirectory.aspx.vb" Inherits="FileTracker.Users" %>

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
        <h3 class="page-title"><i class="fa fa-users" aria-hidden="true"></i> User Directory</h3>
        <hr />
        <div class="row st">
            <div class="col-lg-12">
                <div class="form-panel">
                    <h3 class="page-title"><i class="fa fa-users" aria-hidden="true"></i> Filter User Directory</h3>
                    <hr />
                    <br />
                    <div class="form-horizontal style-form">
                     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="form-group">
                            <label class="col-sm-2 col-sm-2 control-label">First Name</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="userFirstName" runat="server" maxlength="50" placeholder="First Name" class="form-control"></asp:TextBox>
                            </div>
                            <label class="col-sm-2 col-sm-2 control-label">Last Name</label>
                            <div class="col-sm-4">
                                <asp:TextBox ID="userLastName" runat="server" maxlength="50" placeholder="Last Name" class="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Role </label>
                            <div class="col-sm-4">
                                <asp:DropDownList ID="Role" runat="server" DataSourceID="SqlRoles" class="form-control"
                                    DataTextField="Role" DataValueField="RoleID">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlRoles" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                                    SelectCommand="SELECT RoleID, Role FROM Roles ORDER BY Role">
                                </asp:SqlDataSource>
                            </div>
                        </div>
                        <button id="ButtonFilter" type="button" class="btn btn-theme btn-lg btn-block" runat="server" 
                            onserverclick="BtnFilterUsers"><i class="fa fa-filter"></i> Filter Users
                        </button>
                    </div>
                </div>
            </div>   	
        </div>
        <div class="row st">
            <div class="col-lg-12">
              <div class="form-panel">
                <h3 class="page-title"><i class="fa fa-users"></i> User Directory</h3>
                <hr />
                <br />
                <asp:SqlDataSource ID="SqlUsers" runat="server" 
                      ConnectionString="<%$ ConnectionStrings:FileTrackerConnectionString %>" 
                      SelectCommand="SELECT UserID, FirstName, LastName, Email, IsEnabled, Roles.Role
                                     FROM Users
                                     INNER JOIN Roles ON Users.RoleID = Roles.RoleID
                                     ORDER BY FirstName ASC">
                </asp:SqlDataSource>  

                <div class="table-responsive">
                    <asp:GridView ID="GridViewUsers" runat="server" AutoGenerateColumns="False" DataSourceID="SqlUsers" 
                                  CssClass="table table-hover" GridLines="None" AllowPaging="True" 
                                  PageSize="40" DataKeyNames="UserID">
                     <Columns>
                        <asp:BoundField DataField="FirstName" SortExpression="FirstName" HeaderText="First Name" />
                        <asp:BoundField DataField="LastName" SortExpression="LastName" HeaderText="Last Name" />
                        <asp:BoundField DataField="Email" SortExpression="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Role" SortExpression="Role" HeaderText="Role" />
                        <asp:TemplateField HeaderText="Enabled">
                            <ItemTemplate>
                                <%# DisplayEnableness(Eval("UserID"))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <%# DisplayEditUserLink(Request.QueryString("SessionUserID"), Request.QueryString("SessionRoleID"), Eval("UserID"))%>
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
