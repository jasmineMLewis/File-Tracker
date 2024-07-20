Imports System.Data.SqlClient
Imports System.Security.Cryptography.X509Certificates
Imports System.Net
Imports System.Net.Security
Imports System.Net.Mail
Imports System.Web.Configuration

Public Class CreateRequest
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            PriorityType.AppendDataBoundItems = True
            PriorityType.Items.Insert(0, New ListItem("Priority", ""))

            PurposeType.AppendDataBoundItems = True
            PurposeType.Items.Insert(0, New ListItem("Purpose", ""))
        End If
    End Sub

    Protected Sub BtnCreateRequest(ByVal sender As Object, ByVal e As EventArgs)
        Try
            Dim requestID As Integer = CreateRequest()
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

            msg.Subject = "File Tracker :: Request Number - " + requestID.ToString() + ", Requested by - " + sessionUserName
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
                        "</body></html>"

            Try
                HttpCallForFailCertificate()
                client.Send(msg)
                ClearForm()
                lblMsg.Text = "Successful Request Creation! Check your Email for a Confirmation."
            Catch ex As Exception
                lblMsg.Text = "Email Notification Error: " + ex.Message
            End Try
        Catch ex2 As Exception
            lblMsg.Text = "Email Notification Error: " + ex2.Message
        End Try
    End Sub

    Public Sub ClearForm()
        clientFirstName.Text = ""
        clientLastName.Text = ""
        clientLastFourSSN.Text = ""
        PriorityType.SelectedValue = ""
        PurposeType.SelectedValue = ""
    End Sub

    Public Function CreateRequest() As Integer
        Const DEFAULT_USER_ID As Integer = 0
        Const PICK_UP_REQUESTED As Integer = 0
        Const REQUEST_CANCEL As Integer = 0

        Dim requestID As Integer
        Dim firstName As String = StrConv(clientFirstName.Text.Trim, VbStrConv.ProperCase)
        Dim lastName As String = StrConv(clientLastName.Text.Trim, VbStrConv.ProperCase)
        Dim lastFourSocial As String = clientLastFourSSN.Text.Trim
        Dim priorityID As Integer = PriorityType.SelectedValue
        Dim purposeID As Integer = PurposeType.SelectedValue

        Dim query As String = String.Empty
        query &= "INSERT INTO Request (ClientFirstName, ClientLastName, ClientLastFourSSN, Comment, CommentLastUpdatedDate, IsCancelled, CancelledDate, RequestDate, CheckOutDate, IsPickUpRequested, PickUpRequestDate, CheckedInDate, RequestedByUserID, CheckedOutByUserID, CheckedInByUserID, PriorityID, PurposeID)"
        query &= "VALUES (@ClientFirstName, @ClientLastName, @ClientLastFourSSN, @Comment, @CommentLastUpdatedDate, @IsCancelled, @CancelledDate, @RequestDate, @CheckOutDate, @IsPickUpRequested, @PickUpRequestDate, @CheckedInDate, @RequestedByUserID, @CheckedOutByUserID, @CheckedInByUserID, @PriorityID, @PurposeID)"
        query &= "SELECT @@IDENTITY from Request"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@ClientFirstName", StrConv(firstName, VbStrConv.ProperCase))
                .Parameters.AddWithValue("@ClientLastName", StrConv(lastName, VbStrConv.ProperCase))
                .Parameters.AddWithValue("@ClientLastFourSSN", lastFourSocial)
                .Parameters.AddWithValue("@Comment", "")
                .Parameters.AddWithValue("@CommentLastUpdatedDate", DBNull.Value)
                .Parameters.AddWithValue("@IsCancelled", REQUEST_CANCEL)
                .Parameters.AddWithValue("@CancelledDate", DBNull.Value)
                .Parameters.AddWithValue("@RequestDate", DateTime.Now)
                .Parameters.AddWithValue("@CheckOutDate", DBNull.Value)
                .Parameters.AddWithValue("@IsPickUpRequested", PICK_UP_REQUESTED)
                .Parameters.AddWithValue("@PickUpRequestDate", DBNull.Value)
                .Parameters.AddWithValue("@CheckedInDate", DBNull.Value)
                .Parameters.AddWithValue("@RequestedByUserID", GetSessionUserID())
                .Parameters.AddWithValue("@CheckedOutByUserID", DEFAULT_USER_ID)
                .Parameters.AddWithValue("@CheckedInByUserID", DEFAULT_USER_ID)
                .Parameters.AddWithValue("@PriorityID", priorityID)
                .Parameters.AddWithValue("@PurposeID", purposeID)
            End With
            conn.Open()
            requestID = comm.ExecuteScalar()
            conn.Close()
        End Using

        Return requestID
    End Function

    Private Shared Function CustomCertValidation(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal errors As SslPolicyErrors) As Boolean
        Return True
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

    Public Function GetUserEmail(ByVal userID As Integer) As String
        conn.Open()
        Dim email As String

        Dim query As New SqlCommand("SELECT Email 
                                     FROM [User]
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
                                     FROM User
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
End Class