Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class CreateUser
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Role.AppendDataBoundItems = True
            Role.Items.Insert(0, New ListItem("Role", ""))
        End If
    End Sub

    Protected Sub BtnCreateUser(ByVal sender As Object, ByVal e As EventArgs)
        Const DEFAULT_PASSWORD As String = "Qwerty1"
        Const DEFAULT_ENABLED As Boolean = True

        'Dim firstName As String = Request.Form("firstName")
        'Dim lastName As String = Request.Form("lastName")
        'Dim email As String = Request.Form("email")
        'Dim password As String = Request.Form("password")
        'Dim userRoleID As String = Role.SelectedValue

        Dim firstName As String = StrConv(Request.Form("firstName").Trim, VbStrConv.ProperCase)
        Dim lastName As String = StrConv(Request.Form("lastName").Trim, VbStrConv.ProperCase)
        Dim email As String = StrConv(Request.Form("email").Trim, VbStrConv.ProperCase)
        Dim password As String = StrConv(Request.Form("password").Trim, VbStrConv.ProperCase)

        Dim userRoleID As String = Role.SelectedValue

        Dim query As String = String.Empty
        query &= "INSERT INTO Users (FirstName, LastName, Email, Password, IsEnabled, RoleID)"
        query &= "VALUES (@FirstName, @LastName, @Email, @Password, @IsEnabled, @RoleID)"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@FirstName", firstName)
                .Parameters.AddWithValue("@LastName", lastName)
                .Parameters.AddWithValue("@Email", email)
                .Parameters.AddWithValue("@Password", DEFAULT_PASSWORD)
                .Parameters.AddWithValue("@IsEnabled", DEFAULT_ENABLED)
                .Parameters.AddWithValue("@RoleID", userRoleID)
            End With
            conn.Open()
            comm.ExecuteNonQuery()
            conn.Close()
            lblMsg.Text = "Successful User Submission"
        End Using
    End Sub
End Class