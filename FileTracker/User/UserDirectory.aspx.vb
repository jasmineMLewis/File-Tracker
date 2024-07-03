Imports System.Data.SqlClient
Imports System.Text.Json
Imports System.Web.Configuration

Public Class Users
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Role.AppendDataBoundItems = True
            Role.Items.Insert(0, New ListItem("Role", "0"))
        End If
    End Sub

    Protected Sub BtnFilterUsers(ByVal sender As Object, ByVal e As EventArgs)
        Dim sql As String = "SELECT UserID, FirstName, LastName, Email, IsEnabled, Roles.Role " &
                            "FROM Users " &
                            "INNER JOIN Roles ON Users.RoleID = Roles.RoleID " &
                            "WHERE UserID != '0' "

        Dim firstName As String = userFirstName.Text
        Dim lastName As String = userLastName.Text
        Dim roleID As Integer = Role.SelectedValue

        If Not String.IsNullOrEmpty(firstName) Then
            sql += " AND FirstName LIKE '" + firstName.ToString() + "%'"
        End If

        If Not String.IsNullOrEmpty(lastName) Then
            sql += " AND LastName LIKE '" + lastName.ToString() + "%'"
        End If

        If (roleID > 0) Then
            sql += " AND Users.RoleID = " + roleID.ToString()
        End If


        sql += " ORDER BY FirstName ASC"

        SqlUsers.SelectCommand = sql
        SqlUsers.DataBind()
        GridViewUsers.DataBind()
    End Sub

    Public Function DisplayEditUserLink(ByVal sessionUserID As Integer, ByVal sessionRoleID As Integer, ByVal userD As Integer) As String
        Return "<a href=EditUser.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & "&UserID=" & userD & "><i class='fa fa-pencil' aria-hidden='true'></i></a>"
    End Function

    Public Function DisplayEnableness(ByVal userID As Integer) As String
        Dim isEnabled As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT IsEnabled FROM Users WHERE UserID = '" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            isEnabled = CStr(reader("IsEnabled"))
        End While
        conn.Close()

        If isEnabled Then
            Return "<i class='fa fa-check text-success' aria-hidden='true'></i>"
        Else
            Return "<i class='fa fa-times text-danger' aria-hidden='true'></i>"
        End If
    End Function

    Public Function DisplayDeleteUserLink(ByVal sessionUserID As Integer, ByVal userD As Integer) As String
        Return "<a href=DeleteUser.ashx?SessionUserID=" & sessionUserID & "&UserID=" & userD & "><i class='fa fa-trash' aria-hidden='true'></i></a>"
    End Function
End Class