Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Net
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Web.Configuration

Public Class EditRequest
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetTextBoxes(Request.QueryString("RequestID"))
            SetDropdownLists(Request.QueryString("RequestID"))
        End If
    End Sub

    Protected Sub BtnEditRequest(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim requestID As Integer = Request.QueryString("RequestID")
            EditRequest(requestID)
            Dim sessionUserID As Integer = GetSessionUserID()
            Dim sessionUserName As String = GetUserFullName(sessionUserID)
            Dim email As String = GetUserEmail(sessionUserID)

            Dim client As SmtpClient = New SmtpClient()
            client.DeliveryMethod = SmtpDeliveryMethod.Network
            client.EnableSsl = True
            client.Host = ConfigurationManager.AppSettings("MailServer").ToString()
            client.Port = Convert.ToInt32(ConfigurationManager.AppSettings("MailServerPort").ToString())

            'setup Smtp authentication
            Dim credentials As System.Net.NetworkCredential = New System.Net.NetworkCredential(ConfigurationManager.AppSettings("CredentialMail").ToString(), ConfigurationManager.AppSettings("CredentialPassword").ToString())
            client.UseDefaultCredentials = False
            client.Credentials = credentials

            Dim msg As MailMessage = New MailMessage()
            msg.From = New MailAddress(ConfigurationManager.AppSettings("CredentialMail").ToString())
            msg.To.Add(New MailAddress(ConfigurationManager.AppSettings("ToMail").ToString()))

            Dim CC() As String = ConfigurationManager.AppSettings("CCMail").ToString().Split(",")
            Dim BCC() As String = ConfigurationManager.AppSettings("BCCMail").ToString().Split(",")

            For Each cc_copy As String In CC
                If (Not String.IsNullOrEmpty(cc_copy)) Then
                    msg.CC.Add(New MailAddress(cc_copy))
                End If
            Next

            For Each bcc_copy As String In BCC
                If (Not String.IsNullOrEmpty(bcc_copy)) Then
                    msg.Bcc.Add(New MailAddress(bcc_copy))
                End If
            Next

            If (Not (String.IsNullOrEmpty(email))) Then
                msg.To.Add(New MailAddress(email))
            End If

            msg.Subject = "File Tracker :: (Edit) for Request Number - " + requestID.ToString() + ", Requested by - " + sessionUserName
            msg.IsBodyHtml = True

            msg.Body = "<!DOCTYPE HTML><html><head></head><body>" + _
                        "<strong>Requestor</strong> " + sessionUserName + " <br />" + _
                        "<strong>Request Order Number</strong> " + requestID.ToString() + " <br /> " + _
                        "<strong>Date Requsted:</strong> " + DateTime.Now.ToString + "<br /> " + _
                        "<strong>Client First Name</strong> " + clientFirstName.Text.Trim + "<br /> " + _
                        "<strong>Client First Name</strong> " + clientLastName.Text.Trim + "<br /> " + _
                        "<strong>Client Last Four SSN</strong> " + clientLastFourSSN.Text.Trim + "<br /> " + _
                        "<strong>Priority</strong> " + GetPriority(PriorityType.SelectedValue) + "<br /> " + _
                        "<strong>Purpose</strong> " + GetPurpose(PurposeType.SelectedValue) + "<br /> " + _
                        "<strong>Comment</strong> " + commentAboutEdit.Text.Trim + "<br /> " + _
                        "<strong>Comment Last Updated Date </strong> " + DateTime.Now + "<br /> " + _
                        "</body></html>"

            Try
                HttpCallForFailCertificate()
                client.Send(msg)
                lblMsg.Text = "Successful Request Update! Check your Email for a Confirmation."
            Catch ex As Exception
                lblMsg.Text = "Error occured with Email Notification." + ex.Message
            End Try

        Catch ex2 As Exception
            lblMsg.Text = "Error occured with Email Notification. " + ex2.Message
        End Try
    End Sub

    Private Shared Function CustomCertValidation(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal errors As SslPolicyErrors) As Boolean
        Return True
    End Function

    Protected Sub EditRequest(ByVal requestID As Integer)
        Dim firstName As String = StrConv(clientFirstName.Text.Trim, VbStrConv.ProperCase)
        Dim lastName As String = StrConv(clientLastName.Text.Trim, VbStrConv.ProperCase)
        Dim lastFourOfSocial As String = clientLastFourSSN.Text.Trim
        Dim comment As String = commentAboutEdit.Text.Trim
        Dim priorityID As Integer = PriorityType.SelectedValue
        Dim purposeID As Integer = PurposeType.SelectedValue

        Dim queryStr As String = String.Empty
        queryStr &= "UPDATE Request "
        queryStr &= "SET ClientFirstName = '" & firstName & "', ClientLastName = '" & lastName & "', ClientLastFourSSN = '" & lastFourOfSocial & "', "
        queryStr &= "    Comment = '" & comment & "', CommentLastUpdatedDate = '" & DateTime.Now & "', PriorityID = '" & priorityID & "', PurposeID = '" & purposeID & "' "
        queryStr &= "WHERE RequestID = '" & requestID & "'"

        conn.Open()
        Dim query As New SqlCommand(queryStr, conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub

    Public Function GetPriority(ByVal priorityID As Integer) As String
        conn.Open()
        Dim priority As String

        Dim query As New SqlCommand("SELECT Priority 
                                     FROM Priority 
                                     WHERE PriorityID = '" & priorityID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            priority = CStr(reader("Priority")).Trim
        End While
        conn.Close()

        Return priority
    End Function

    Public Function GetPurpose(ByVal purposeID As Integer) As String
        conn.Open()
        Dim purpose As String

        Dim query As New SqlCommand("SELECT Purpose 
                                     FROM Purpose 
                                     WHERE PurposeID = '" & purposeID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            purpose = CStr(reader("Purpose")).Trim
        End While
        conn.Close()

        Return purpose
    End Function

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

    Public Function GetUserEmail(ByVal userID As Integer) As String
        conn.Open()
        Dim email As String

        Dim query As New SqlCommand("SELECT Email 
                                     FROM User 
                                     WHERE UserID = '" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            email = CStr(reader("Email")).Trim
        End While
        conn.Close()

        Return email
    End Function

    Public Function GetUserFullName(ByVal userID As Integer) As String
        conn.Open()
        Dim name As String

        Dim query As New SqlCommand("SELECT (FirstName + ' ' + LastName) As FullName 
                                     FROM [User]
                                     WHERE UserID = '" & userID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            name = CStr(reader("FullName")).Trim
        End While
        conn.Close()

        Return name
    End Function

    Public Sub HttpCallForFailCertificate()
        'CALL THIS BEFORE ANY HTTPS CALLS THAT WILL FAIL WITH CERT ERROR
        ServicePointManager.ServerCertificateValidationCallback = New System.Net.Security.RemoteCertificateValidationCallback(AddressOf CustomCertValidation)
    End Sub

    Public Sub SetDropdownLists(ByVal requestID As Integer)
        Dim priorityID As Integer
        Dim purposeID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT PriorityID, PurposeID 
                                     FROM Request 
                                     WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            priorityID = CStr(reader("PriorityID"))
            purposeID = CStr(reader("PurposeID"))
        End While
        conn.Close()

        If priorityID <> 0 Then
            PriorityType.DataBind()
            PriorityType.Items.FindByValue(priorityID).Selected = True
        Else
            PriorityType.AppendDataBoundItems = True
            PriorityType.Items.Insert(0, New ListItem("Priority", ""))
        End If

        If purposeID <> 0 Then
            PurposeType.DataBind()
            PurposeType.Items.FindByValue(purposeID).Selected = True
        Else
            PurposeType.AppendDataBoundItems = True
            PurposeType.Items.Insert(0, New ListItem("Purpose", ""))
        End If
    End Sub

    Public Sub SetTextBoxes(ByVal requestID As Integer)
        Dim firstName As String
        Dim lastName As String
        Dim lastFourOfSocial As String
        Dim comment As String

        conn.Open()
        Dim sql As New SqlCommand("SELECT ClientFirstName, ClientLastName, ClientLastFourSSN, Comment 
                                   FROM Request
                                   WHERE RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = sql.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("ClientFirstName")).Trim
            lastName = CStr(reader("ClientLastName")).Trim
            lastFourOfSocial = CStr(reader("ClientLastFourSSN")).Trim
            comment = CStr(reader("Comment"))
        End While
        conn.Close()

        clientFirstName.Text = StrConv(firstName, VbStrConv.ProperCase)
        clientLastName.Text = StrConv(lastName, VbStrConv.ProperCase)
        clientLastFourSSN.Text = lastFourOfSocial
        commentAboutEdit.Text = comment
    End Sub
End Class