Imports System.IO
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class UsersRequests
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sessionUserID As Integer = GetSessionUserID()
        DisplayRequestsExcludeUser(sessionUserID)

        If Not IsPostBack Then
            ListRequestor.AppendDataBoundItems = True
            ListRequestor.Items.Insert(0, New ListItem("Requested By User", "0"))

            PriorityType.AppendDataBoundItems = True
            PriorityType.Items.Insert(0, New ListItem("Priority", "0"))

            PurposeType.AppendDataBoundItems = True
            PurposeType.Items.Insert(0, New ListItem("Purpose", "0"))
        End If
    End Sub

    Protected Sub BtnExportToExcel(ByVal sender As Object, ByVal e As EventArgs)
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment;filename=RequestDirectoryExport.xls")
        Response.Charset = ""
        Response.ContentType = "application/vnd.ms-excel"
        Using writeContent As New StringWriter()
            Dim writeHtmlContent As New HtmlTextWriter(writeContent)
            BindGridWithFilters()

            GridViewUsersRequests.RenderControl(writeHtmlContent)
            Response.Output.Write(writeContent.ToString())
            Response.Flush()
            Response.End()
        End Using
    End Sub

    Public Sub BindGridWithFilters()
        Dim sessionUserID As Integer = GetSessionUserID()
        Dim sql As String = "SELECT Requests.RequestID, Requests.ClientFirstName, Requests.ClientLastName, " &
                            "       Requests.ClientLastFourSSN, Requests.Comment, Requests.CommentLastUpdatedDate, " &
                            "       Requests.PriorityID, PriorityType.Priority, Requests.PurposeID, PurposeType.Purpose, " &
                            "       Convert(varchar, Requests.RequestDate, 22) As RequestDate, " &
                            "       Requestor.FirstName + ' ' + Requestor.LastName AS UserRequested, " &
                            "       CONVERT (varchar, Requests.CheckOutDate, 22) AS CheckOutDate, Requests.CheckedOutByUserID, " &
                            "       CheckedOuter.FirstName + ' ' + CheckedOuter.LastName AS UserCheckedOuter, " &
                            "       Requests.IsPickUpRequested, CONVERT (varchar, Requests.PickUpRequestDate, 22) AS PickUpRequestDate, " &
                            "       Requests.CheckedInByUserID, CONVERT (varchar, Requests.CheckedInDate, 22) AS CheckedInDate, " &
                            "       CheckedInner.FirstName + ' ' + CheckedInner.LastName AS UserCheckedInner " &
                            "FROM Requests " &
                            "INNER JOIN Priority AS PriorityType On Requests.PriorityID = PriorityType.PriorityID " &
                            "INNER JOIN Purpose AS PurposeType On Requests.PurposeID = PurposeType.PurposeID " &
                            "LEFT OUTER JOIN Users AS Requestor ON Requests.RequestedByUserID = Requestor.UserID " &
                            "LEFT OUTER JOIN Users AS CheckedOuter ON Requests.CheckedOutByUserID = CheckedOuter.UserID " &
                            "LEFT OUTER JOIN Users AS CheckedInner ON Requests.CheckedInByUserID = CheckedInner.UserID " &
                            "WHERE Requests.RequestedByUserID != '" & sessionUserID & "'"

        Dim firstName As String = clientFirstName.Text
        Dim lastName As String = clientLastName.Text
        Dim dateRequested As String = RequestDate.Text
        Dim priorityID As Integer = PriorityType.SelectedValue
        Dim purposeID As Integer = PurposeType.SelectedValue
        Dim userRequested As Integer = ListRequestor.SelectedValue

        If Not String.IsNullOrEmpty(firstName) Then
            sql += " AND Requests.ClientFirstName LIKE '" + firstName.ToString() + "%'"
        End If

        If Not String.IsNullOrEmpty(lastName) Then
            sql += " AND Requests.ClientLastName LIKE '" + lastName.ToString() + "%'"
        End If

        If Not String.IsNullOrEmpty(dateRequested) Then
            sql += " AND Requests.RequestDate >= '" + dateRequested + " 12:00:00 AM' AND Requests.RequestDate <= '" + dateRequested + " 11:59:00 PM'"
        End If

        If (priorityID > 0) Then
            sql += " AND Requests.PriorityID = " + priorityID.ToString()
        End If

        If (purposeID > 0) Then
            sql += " AND Requests.PurposeID = " + purposeID.ToString()
        End If

        If (userRequested > 0) Then
            sql += " AND Requests.RequestedByUserID = " + userRequested.ToString()
        End If

        sql += " ORDER By RequestDate DESC, ClientFirstName ASC"

        SqlUsersRequests.SelectCommand = sql
        SqlUsersRequests.DataBind()
        GridViewUsersRequests.DataBind()
    End Sub

    Protected Sub BtnFilterRequests(ByVal sender As Object, ByVal e As EventArgs)
        BindGridWithFilters()
    End Sub

    Public Function DisplayCancelledDate(ByVal requestID As Integer) As String
        Dim cancelledDate As Date
        Dim haveDate As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT CancelledDate 
                                    FROM Requests
                                    WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            haveDate = IsDBNull((reader("CancelledDate")))

            If Not haveDate = True Then
                cancelledDate = CStr(reader("CancelledDate"))
            End If
        End While
        conn.Close()

        If haveDate = True Then
            Return ""
        Else
            Return cancelledDate
        End If
    End Function

    Public Function DisplayCancelled(ByVal sessionUserID As Integer, ByVal requestID As Integer) As String
        Dim isCancelled As Boolean = IsRequestCancelled(requestID)

        If isCancelled Then
            Return "Cancelled"
        Else
            Return "Not Cancelled"
        End If
    End Function

    Public Function DisplayCheckInLink(ByVal sessionUserID As Integer, ByVal requestID As Integer) As String
        Const ADMIN As Integer = 1
        Const PROJECT_SPECIALIST As Integer = 2
        Const FILE_ROOM_CLERK As Integer = 4

        Dim isRequestedForPickUp As Boolean = IsPickUpRequested(requestID)
        Dim isCheckedIn As Boolean = IsRequestCheckedIn(requestID)
        Dim roleID As Integer = GetUserRoleID(sessionUserID)

        If Not isRequestedForPickUp Then
            Return "<i class='fa fa-sign-in' aria-hidden='true'></i> Check In"
        ElseIf isCheckedIn Then
            Return "<i class='fa fa-arrow-left' aria-hidden='true'></i> Check In"
        Else
            If roleID = ADMIN Or roleID = PROJECT_SPECIALIST Or roleID = FILE_ROOM_CLERK Then
                Return "<a href=CheckInRequestedFile.ashx?SessionUserID=" & sessionUserID & "&RequestID=" & requestID & ">" +
                 "<i class='fa fa-sign-in' aria-hidden='true'></i> Check In</a>"
            Else
                Return "<i class='fa fa-sign-in' aria-hidden='true'></i> Check In"
            End If
        End If
    End Function

    Public Sub DisplayRequestsExcludeUser(ByVal userID As Integer)
        Dim sql As String = "SELECT Requests.RequestID, Requests.ClientFirstName, Requests.ClientLastName, " &
                            "       Requests.ClientLastFourSSN, Requests.Comment, Requests.CommentLastUpdatedDate, " &
                            "       Requests.PriorityID, PriorityType.Priority, Requests.PurposeID, PurposeType.Purpose, " &
                            "       Convert(varchar, Requests.RequestDate, 22) As RequestDate, " &
                            "       Requestor.FirstName + ' ' + Requestor.LastName AS UserRequested, " &
                            "       CONVERT (varchar, Requests.CheckOutDate, 22) AS CheckOutDate, Requests.CheckedOutByUserID, " &
                            "       CheckedOuter.FirstName + ' ' + CheckedOuter.LastName AS UserCheckedOuter, " &
                            "       Requests.IsPickUpRequested, CONVERT (varchar, Requests.PickUpRequestDate, 22) AS PickUpRequestDate, " &
                            "       Requests.CheckedInByUserID, CONVERT (varchar, Requests.CheckedInDate, 22) AS CheckedInDate, " &
                            "       CheckedInner.FirstName + ' ' + CheckedInner.LastName AS UserCheckedInner " &
                            "FROM Requests " &
                            "INNER JOIN Priority AS PriorityType On Requests.PriorityID = PriorityType.PriorityID " &
                            "INNER JOIN Purpose AS PurposeType On Requests.PurposeID = PurposeType.PurposeID " &
                            "LEFT OUTER JOIN Users AS Requestor ON Requests.RequestedByUserID = Requestor.UserID " &
                            "LEFT OUTER JOIN Users AS CheckedOuter ON Requests.CheckedOutByUserID = CheckedOuter.UserID " &
                            "LEFT OUTER JOIN Users AS CheckedInner ON Requests.CheckedInByUserID = CheckedInner.UserID " &
                            "WHERE Requestor.UserID != '" & userID & "' " &
                            "ORDER By RequestDate DESC, ClientFirstName ASC"

        SqlUsersRequests.SelectCommand = sql
        SqlUsersRequests.DataBind()
        GridViewUsersRequests.DataBind()
    End Sub

    Public Function GetSessionUserID() As Integer
        Dim sessionUserID As String
        If Not Web.HttpContext.Current.Session("SessionUserID") Is Nothing Then
            sessionUserID = Web.HttpContext.Current.Session("SessionUserID").ToString()
        End If

        If sessionUserID = Nothing Then
            sessionUserID = Request.QueryString("SessionUserID")
            Web.HttpContext.Current.Session("SessionUserID") = sessionUserID
        End If

        Return Convert.ToInt32(sessionUserID)
    End Function

    Public Function GetUserRoleID(ByVal sessionUserID As Integer) As Integer
        Dim roleID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT RoleID 
                                     FROM Users 
                                     WHERE UserID = '" & sessionUserID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            roleID = CStr(reader("RoleID"))
        End While
        conn.Close()

        Return roleID
    End Function

    Public Function IsPickUpRequested(ByVal requestID As Integer) As Boolean
        Dim isRequsted As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT IsPickUpRequested 
                                     FROM Requests 
                                     WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            isRequsted = CStr(reader("IsPickUpRequested"))
        End While
        conn.Close()

        If isRequsted Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function IsRequestCancelled(ByVal requestID As Integer) As Boolean
        Dim isCancelled As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT IsCancelled 
                                     FROM Requests 
                                     WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            isCancelled = CStr(reader("IsCancelled"))
        End While
        conn.Close()

        If isCancelled Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Function IsRequestCheckedIn(ByVal requestID As Integer) As Boolean
        Const USER_ID As Integer = 0
        Dim checkedInByUserID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT CheckedInByUserID 
                                     FROM Requests 
                                     WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            checkedInByUserID = CStr(reader("CheckedInByUserID"))
        End While
        conn.Close()

        If checkedInByUserID = USER_ID Then
            Return False
        Else
            Return True
        End If
    End Function

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        ' Confirms that an HtmlForm control is rendered for the specified ASP.NET
        '     server control at run time. 
    End Sub
End Class