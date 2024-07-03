Imports System.Web
Imports System.Data.SqlClient
Imports System.Net
Imports System.Net.Mail
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security

Public Class CheckOutRequestedFile
    Implements System.Web.IHttpHandler
    Dim conn As New SqlConnection("Server=HANOAPPS1;Database=File_Tracker;User Id=filetuser;Password=P@55w0rd17")

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim sessionUserID As Integer = Integer.Parse(context.Request.QueryString("SessionUserID"))
        Dim requestID As Integer = Integer.Parse(context.Request.QueryString("RequestID"))

        CheckOutFile(sessionUserID, requestID)
        EmailCheckInConfirmation(sessionUserID, requestID)
        context.Response.Redirect(context.Request.UrlReferrer.ToString())
    End Sub

    Public Sub CheckOutFile(ByVal sessionUserID As Integer, ByVal requestID As Integer)
        conn.Open()
        Dim query As New SqlCommand("UPDATE Requests SET fk_CheckedOutByUserID = '" & sessionUserID & "', CheckOutDate = '" & DateTime.Now & "' WHERE pk_RequestID = '" & requestID & "'", conn)
        query.ExecuteNonQuery()
        conn.Close()
    End Sub

    Private Shared Function CustomCertValidation(ByVal sender As Object, ByVal cert As X509Certificate, ByVal chain As X509Chain, ByVal errors As SslPolicyErrors) As Boolean
        Return True
    End Function

    Public Sub EmailCheckInConfirmation(ByVal sessionUserID As Integer, ByVal requestID As Integer)
        Try
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

            Dim priorityID As Integer = GetPriorityForRequest(requestID)
            Dim priority As String = GetPriority(priorityID)
            Dim purposeID As Integer = GetPurpsoeForRequest(requestID)
            Dim purpose As String = GetPurpose(purposeID)
            Dim info() As String = GetClientInfo(requestID)

            msg.Subject = "File Tracker :: Request Number - " + requestID.ToString() + ", Checked Out by - " + sessionUserName
            msg.IsBodyHtml = True

            msg.Body = "<!DOCTYPE HTML><html><head></head><body>" + _
                        "<strong>Checked Out By </strong> " + sessionUserName + " <br />" + _
                        "<strong>Request Order Number</strong> " + requestID.ToString() + "<br /> " + _
                        "<strong>Checked Out On Date</strong> " + DateTime.Now.ToString + "<br /> " + _
                         "<strong>Client First Name</strong> " + info(0) + "<br /> " + _
                        "<strong>Client First Name</strong> " + info(1) + "<br /> " + _
                        "<strong>Client Last Four SSN</strong> " + info(2) + "<br /> " + _
                        "<strong>Priority</strong> " + priority + "<br /> " + _
                        "<strong>Purpose</strong> " + purpose + "<br /> " + _
                        "</body></html>"

            Try
                HttpCallForFailCertificate()
                client.Send(msg)
            Catch ex As Exception

            End Try
        Catch ex2 As Exception

        End Try
    End Sub

    Public Function GetClientInfo(ByVal requestID As Integer) As Array
        Dim info(2) As String
        Dim clientFirstName As String
        Dim clientLastName As String
        Dim clientLastFourSSN As String

        conn.Open()
        Dim query As New SqlCommand("SELECT ClientFirstName, ClientLastName, ClientLastFourSSN FROM Requests WHERE pk_RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            clientFirstName = CStr(reader("ClientFirstName")).Trim
            clientLastName = CStr(reader("ClientLastName")).Trim
            clientLastFourSSN = CStr(reader("ClientLastFourSSN")).Trim
        End While
        conn.Close()

        info(0) = clientFirstName
        info(1) = clientLastName
        info(2) = CStr(clientLastFourSSN)

        Return info
    End Function

    Public Function GetPriorityForRequest(ByVal requestID As Integer) As Integer
        conn.Open()
        Dim priorityID As Integer

        Dim query As New SqlCommand("SELECT fk_PriorityID FROM Requests WHERE pk_RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            priorityID = CStr(reader("fk_PriorityID")).Trim
        End While
        conn.Close()

        Return priorityID
    End Function

    Public Function GetPriority(ByVal priorityID As Integer) As String
        conn.Open()
        Dim priority As String

        Dim query As New SqlCommand("SELECT Priority FROM Priority WHERE pk_PriorityID = '" & priorityID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            priority = CStr(reader("Priority")).Trim
        End While
        conn.Close()

        Return priority
    End Function

    Public Function GetPurpsoeForRequest(ByVal requestID As Integer) As Integer
        conn.Open()
        Dim purposeID As Integer

        Dim query As New SqlCommand("SELECT fk_PurposeID FROM Requests WHERE pk_RequestID = '" & requestID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            purposeID = CStr(reader("fk_PurposeID")).Trim
        End While
        conn.Close()

        Return purposeID
    End Function

    Public Function GetPurpose(ByVal purposeID As Integer) As String
        conn.Open()
        Dim purpose As String

        Dim query As New SqlCommand("SELECT Purpose FROM Purpose WHERE pk_PurposeID = '" & purposeID & "'", conn)
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

        Dim query As New SqlCommand("SELECT Email FROM Users WHERE pk_UserID = '" & userID & "'", conn)
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

        Dim query As New SqlCommand("SELECT (FirstName + ' ' + LastName) As FullName FROM Users WHERE pk_UserID = '" & userID & "'", conn)
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

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property
End Class