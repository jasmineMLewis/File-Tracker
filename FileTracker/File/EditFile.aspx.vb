Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class EditFile
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SetTextBoxes(Request.QueryString("FileID"))
            SetDropdownLists(Request.QueryString("FileID"))
        End If
    End Sub

    Protected Sub BtnEditFile(ByVal sender As Object, ByVal e As EventArgs)
        EditFile(Request.QueryString("FileID"))
    End Sub

    Protected Sub EditFile(ByVal fileID As Integer)
        Dim firstName As String = clientFirstName.Text.Trim
        Dim lastName As String = clientLastName.Text.Trim
        Dim lastFourOfSocial As String = lastFourSSN.Text.Trim
        Dim parsePurgeTypeDate As Date = purgeTypeDate.Text
        Dim note As String = notes.Text.Trim
        Dim isDestroyed As Integer = Destroyed.SelectedValue
        Dim purgeTypeID As Integer = PurgeType.SelectedValue
        Dim boxID As Integer = Boxes.SelectedValue
        Dim locationID As Integer = Location.SelectedValue

        Dim queryStr As String = String.Empty
        queryStr &= "UPDATE Files "
        queryStr &= "SET ClientFirstName = '" & firstName & "', ClientLastName = '" & lastName & "', LastFourSSN = '" & lastFourOfSocial & "', "
        queryStr &= "    PurgeTypeDate = '" & parsePurgeTypeDate & "', Notes = '" & note & "', IsDestroyed = '" & isDestroyed & "', "
        queryStr &= "    PurgeTypeID = '" & purgeTypeID & "', BoxID = '" & boxID & "', LocationID = '" & locationID & "' "
        queryStr &= "WHERE FileID = '" & fileID & "'"

        conn.Open()
        Dim query As New SqlCommand(queryStr, conn)
        query.ExecuteNonQuery()
        conn.Close()

        lblMsg.Text = "Successful File Update"
    End Sub

    Public Sub SetDropdownLists(ByVal fileID As Integer)
        Dim isDestroyed As Integer
        Dim purgeTypeID As Integer
        Dim boxID As Integer
        Dim locationID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT IsDestroyed, PurgeTypeID, BoxID, LocationID FROM Files WHERE FileID = '" & fileID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            isDestroyed = CStr(reader("IsDestroyed"))
            purgeTypeID = CStr(reader("PurgeTypeID"))
            boxID = CStr(reader("BoxID"))
            locationID = CStr(reader("LocationID"))
        End While
        conn.Close()

        Destroyed.DataBind()
        Destroyed.Items.FindByValue(isDestroyed).Selected = True

        If purgeTypeID <> 0 Then
            PurgeType.DataBind()
            PurgeType.Items.FindByValue(purgeTypeID).Selected = True
        Else
            PurgeType.AppendDataBoundItems = True
            PurgeType.Items.Insert(0, New ListItem("Purge Type", ""))
        End If

        If boxID <> 0 Then
            Boxes.DataBind()
            Boxes.Items.FindByValue(boxID).Selected = True
        Else
            Boxes.AppendDataBoundItems = True
            Boxes.Items.Insert(0, New ListItem("Box", ""))
        End If

        If locationID <> 0 Then
            Location.DataBind()
            Location.Items.FindByValue(locationID).Selected = True
        Else
            Location.AppendDataBoundItems = True
            Location.Items.Insert(0, New ListItem("Location", ""))
        End If
    End Sub

    Public Sub SetTextBoxes(ByVal fileID As Integer)
        Dim firstName As String
        Dim lastName As String
        Dim lastFourOfSocial As String
        Dim purgeDate As Date
        Dim note As String

        conn.Open()
        Dim sql As New SqlCommand("SELECT ClientFirstName, ClientLastName, LastFourSSN, PurgeTypeDate, Notes FROM Files WHERE FileID = '" & fileID & "'", conn)
        Dim reader As SqlDataReader = sql.ExecuteReader()
        While reader.Read
            firstName = CStr(reader("ClientFirstName")).Trim
            lastName = CStr(reader("ClientLastName")).Trim
            lastFourOfSocial = CStr(reader("LastFourSSN")).Trim
            purgeDate = CStr(reader("PurgeTypeDate"))
            note = CStr(reader("Notes")).Trim
        End While
        conn.Close()

        clientFirstName.Text = StrConv(firstName, VbStrConv.ProperCase)
        clientLastName.Text = StrConv(lastName, VbStrConv.ProperCase)
        lastFourSSN.Text = lastFourOfSocial
        purgeTypeDate.Text = purgeDate
        notes.Text = note
    End Sub
End Class