Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class _Default
    Inherits Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)
    Const ADMIN As Integer = 1
    Const PROJECT_SPECIALIST As Integer = 2
    Const HOUSING_SPECIALIST As Integer = 3
    Const FILE_ROOM_CLERK As Integer = 4

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnLogin(ByVal sender As Object, ByVal e As EventArgs)
        Dim email As String = Request.Form("email").Trim
        Dim password As String = Request.Form("password").Trim
        Dim sessionUserID As Integer
        Dim sessionRoleID As Integer
        Dim isEnabled As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT UserID, IsEnabled, RoleID 
                                    FROM Users 
                                    WHERE Email='" & email & "' AND Password= '" & password & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            While reader.Read
                sessionUserID = CStr(reader("UserID"))
                sessionRoleID = CStr(reader("RoleID"))
                isEnabled = CStr(reader("IsEnabled"))
            End While
            conn.Close()

            If isEnabled Then
                Dim adminDashboard As String = "./RoleDashboard/AdminDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""
                Dim projectSpecialistDashboard As String = "./RoleDashboard/ProjectSpecialistDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""
                Dim housingSpecialistDashboard As String = "./RoleDashboard/HousingSpecialistDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""
                Dim fileRoomClerkDashboard As String = "./RoleDashboard/FileRoomClerkDashboard.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & ""

                If sessionRoleID = ADMIN Then
                    Response.Redirect(adminDashboard)
                ElseIf sessionRoleID = PROJECT_SPECIALIST Then
                    Response.Redirect(projectSpecialistDashboard)
                ElseIf sessionRoleID = HOUSING_SPECIALIST Then
                    Response.Redirect(housingSpecialistDashboard)
                ElseIf sessionRoleID = FILE_ROOM_CLERK Then
                    Response.Redirect(fileRoomClerkDashboard)
                Else
                    lblMsg.Text = "Unable to Identity your User Role."
                End If
            Else
                lblMsg.Text = "Account is Disabled."
            End If
        Else
            lblMsg.Text = "Incorrect Password Combination."
        End If
    End Sub
End Class