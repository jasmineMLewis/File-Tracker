Imports System.Data.SqlClient
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Web.Configuration

Public Class UserRequests
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            PriorityType.AppendDataBoundItems = True
            PriorityType.Items.Insert(0, New ListItem("Priority", "0"))

            PurposeType.AppendDataBoundItems = True
            PurposeType.Items.Insert(0, New ListItem("Purpose", "0"))
        End If

        Dim sessionUserID As Integer = GetSessionUserID()
        DisplayRequestsForUser(sessionUserID)
    End Sub

    Protected Sub BtnFilterRequests(ByVal sender As Object, ByVal e As EventArgs)
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
                            "WHERE Requests.fk_RequestedByUserID = '" & sessionUserID & "'"

        Dim firstName As String = clientFirstName.Text
        Dim lastName As String = clientLastName.Text
        Dim dateRequested As String = RequestDate.Text
        Dim priorityID As Integer = PriorityType.SelectedValue
        Dim purposeID As Integer = PurposeType.SelectedValue

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

        sql += "ORDER By RequestDate DESC, ClientFirstName ASC"

        SqlUserRequests.SelectCommand = sql
        SqlUserRequests.DataBind()
        GridViewUserRequests.DataBind()
    End Sub

    Private Shared Function CustomCertValidation(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal errors As SslPolicyErrors) As Boolean
        Return True
    End Function

    Public Function DisplayCancelLink(ByVal sessionUserID As Integer, ByVal requestID As Integer) As String
        Dim isCancelled As Boolean = IsRequestCancelled(requestID)
        Dim isCheckedOut As Boolean = IsRequestCheckedOut(requestID)

        If isCheckedOut Then
            Return "Cannot Cancel"
        ElseIf isCancelled Then
            Return "Cancelled"
        Else
            Return "<a href=CancelRequestedFile.ashx?SessionUserID=" & sessionUserID & "&RequestID=" & requestID & ">" + _
                "<i class='fa fa-hand-stop-o' aria-hidden='true'></i> Cancel</a>"
        End If
    End Function

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

    Public Function DisplayCheckOutDate(ByVal requestID As Integer) As String
        Dim checkedOutDate As Date
        Dim haveDate As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT CheckOutDate 
                                     FROM Requests 
                                     WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            haveDate = IsDBNull((reader("CheckOutDate")))

            If Not haveDate = True Then
                checkedOutDate = CStr(reader("CheckOutDate"))
            End If
        End While
        conn.Close()

        If haveDate = True Then
            Return ""
        Else
            Return checkedOutDate
        End If
    End Function

    Public Function DisplayCheckOutLink(ByVal sessionUserID As Integer, ByVal requestID As Integer) As String
        Dim isCancelled As Boolean = IsRequestCancelled(requestID)
        Dim isCheckedOut As Boolean = IsRequestCheckedOut(requestID)

        If isCancelled Then
            Return "Cancelled"
        ElseIf isCheckedOut Then
            Return "Checked Out"
        Else
            Return "<a href=CheckOutRequestedFile.ashx?SessionUserID=" & sessionUserID & "&RequestID=" & requestID & ">" + _
                        "<i class='fa fa-sign-out' aria-hidden='true'></i> Check Out</a>"
        End If
    End Function

    Public Function DisplayEditLink(ByVal sessionUserID As Integer, ByVal requestID As Integer) As String
        Dim isCancelled As Boolean = IsRequestCancelled(requestID)

        If isCancelled Then
            Return "Cancelled"
        Else
            Return "<a href=EditRequest.aspx?SessionUserID=" & sessionUserID & "&RequestID=" & requestID & ">" + _
                            "<i class='fa fa-pencil' aria-hidden='true'></i></a>"
        End If
    End Function

    Public Function DisplayRequestPickUpLink(ByVal sessionUserID As Integer, ByVal requestID As Integer) As String
        Dim isCancelled As Boolean = IsRequestCancelled(requestID)
        Dim isCheckOutCompleted As Boolean = IsCheckedOutComplete(requestID)
        Dim isRequestedForPickUp As Boolean = IsPickUpRequested(requestID)

        If isCancelled Then
            Return "Cancelled"
        ElseIf Not isCheckOutCompleted Then
            Return "Pick Up"
        ElseIf isRequestedForPickUp Then
            Return "Picked Up"
        Else
            Return "<a href=RequestFilePickUp.ashx?SessionUserID=" & sessionUserID & "&RequestID=" & requestID & "><i class='fa fa-play' aria-hidden='true'></i> Pick Up</a>"
        End If
    End Function

    Public Sub DisplayRequestsForUser(ByVal userID As Integer)
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
                            "WHERE Requestor.UserID = '" & userID & "' " &
                            "ORDER By RequestDate DESC, ClientFirstName ASC"

        SqlUserRequests.SelectCommand = sql
        SqlUserRequests.DataBind()
        GridViewUserRequests.DataBind()
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

    Public Function IsCheckedOutComplete(ByVal requestID As Integer) As Boolean
        Dim haveDate As Boolean

        conn.Open()
        Dim query As New SqlCommand("SELECT CheckOutDate 
                                     FROM Requests 
                                     WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            haveDate = IsDBNull((reader("CheckOutDate")))
        End While
        conn.Close()

        If haveDate = True Then
            Return False
        Else
            Return True
        End If
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

    Public Function IsRequestCheckedOut(ByVal requestID As Integer) As Boolean
        Const USER_ID As Integer = 0
        Dim checkedOutByUserID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT CheckedOutByUserID 
                                     FROM Requests 
                                     WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            checkedOutByUserID = CStr(reader("CheckedOutByUserID"))
        End While
        conn.Close()

        If checkedOutByUserID = USER_ID Then
            Return False
        Else
            Return True
        End If
    End Function
End Class