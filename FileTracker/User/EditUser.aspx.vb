Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class EditUser
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetTextBoxes(Request.QueryString("UserID"))
        End If
    End Sub

    Protected Sub BtnEditUser(ByVal sender As Object, ByVal e As EventArgs)
        EditUser(Request.QueryString("UserID"))
    End Sub

    Protected Sub EditUser(ByVal userID As Integer)
        Dim firstName As String = userFirstName.Text.Trim
        Dim lastName As String = userLastName.Text.Trim
        Dim email As String = userEmail.Text.Trim
        Dim password As String = userPassword.Text.Trim

        Dim queryStr As String = String.Empty
        queryStr &= "UPDATE [User] "
        queryStr &= "SET FirstName = '" & firstName & "', LastName = '" & lastName & "', Email = '" & email & "', "
        queryStr &= "    Password = '" & password & "' "
        queryStr &= "WHERE UserID = '" & userID & "'"

        conn.Open()
        Dim query As New SqlCommand(queryStr, conn)
        query.ExecuteNonQuery()
        conn.Close()

        lblMsg.Text = "Successful User Update"
    End Sub

    Public Sub SetTextBoxes(ByVal userID As Integer)
        Dim firstName As String
        Dim lastName As String
        Dim email As String
        Dim password As String

        conn.Open()
        Dim queryUser As New SqlCommand("SELECT FirstName, LastName, Email, Password 
                                         FROM [User] 
                                         WHERE UserID  = '" & userID & "'", conn)
        Dim readerUser As SqlDataReader = queryUser.ExecuteReader()
        While readerUser.Read
            firstName = CStr(readerUser("FirstName")).Trim
            lastName = CStr(readerUser("LastName")).Trim
            email = CStr(readerUser("Email")).Trim
            password = CStr(readerUser("Password")).Trim
        End While
        conn.Close()

        userFirstName.Text = StrConv(firstName, VbStrConv.ProperCase)
        userLastName.Text = StrConv(lastName, VbStrConv.ProperCase)
        userEmail.Text = email
        userPassword.Text = password
    End Sub
End Class