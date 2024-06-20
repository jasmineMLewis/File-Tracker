Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Runtime.InteropServices.ComTypes
Imports System.Web.Configuration
Imports System.Windows
Imports Microsoft.VisualStudio.Text.Editor.Commanding.Commands

Public Class BoxInfo
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)
    Dim currentBoxID As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'Retrieve first Box ID to set Box dropdown list 
            currentBoxID = GetFirstBoxID()

            BoxList.DataBind()
            BoxList.Items.FindByValue(currentBoxID).Selected = True

            SetDropdownLists(currentBoxID)
            SetDateTextBoxes(currentBoxID)
            BindGridWithDropDownListBox(currentBoxID)
        End If
    End Sub

    Private Sub BindGridWithDropDownListBox(ByVal boxID As String)
        Dim sql As String = "SELECT Files.FileID, Files.ClientFirstName, Files.ClientLastName, Files.LastFourSSN, " &
                            "      CONVERT (varchar(MAX), CAST(Files.PurgeTypeDate AS date), 101) AS PurgeTypeDate,   " &
                            "      Files.IsDestroyed, Files.Notes, Files.PurgeTypeID, PurgeType.PurgeType, Files.BoxID,  " &
                            "      Boxes.BoxNumber, Boxes.BoxYear, Files.LocationID, Location.Location, " &
                            "      Files.SubmittedByUserID, Users.FirstName + ' ' + Users.LastName AS SubmittedByUser, " &
                            "      CONVERT (varchar(MAX), CAST(Files.DateSubmitted AS date), 101) AS DateSubmitted " &
                            "FROM Files " &
                            "INNER JOIN Boxes ON Files.BoxID = Boxes.BoxID " &
                            "INNER JOIN PurgeType ON Files.PurgeTypeID = PurgeType.PurgeTypeID " &
                            "INNER JOIN Location ON Files.LocationID = Location.LocationID " &
                            "INNER JOIN Users ON Files.SubmittedByUserID = Users.UserID " &
                            "WHERE Files.BoxID = '" & boxID & "'"

        SqlFilesInBox.SelectCommand = sql
        SqlFilesInBox.DataBind()
        GridViewFilesInBox.DataBind()
    End Sub

    Protected Sub BtnFilterBoxes(ByVal sender As Object, ByVal e As EventArgs)
        currentBoxID = BoxList.SelectedValue
        BoxList.DataBind()
        BoxList.Items.FindByValue(currentBoxID).Selected = True

        SetDropdownLists(currentBoxID)
        SetDateTextBoxes(currentBoxID)

        BindGridWithDropDownListBox(currentBoxID)
    End Sub

    Protected Sub BtnUpdateBox(ByVal sender As Object, ByVal e As EventArgs)
        currentBoxID = BoxList.SelectedValue
        BoxList.DataBind()
        BoxList.Items.FindByValue(currentBoxID).Selected = True

        Response.Write("current ID ")
        Response.Write(currentBoxID)

        UpdateBox(currentBoxID)
    End Sub

    Public Function DisplayEditFileLink(ByVal sessionUserID As Integer, ByVal sessionRoleID As Integer, ByVal fileID As Integer) As String
        Return "<a href=../File/EditFile.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & "&FileID=" & fileID & "><i class='fa fa-pencil' aria-hidden='true'></i></a>"
    End Function

    Public Function GetFirstBoxID() As Integer
        Dim firstBoxID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT TOP 1 BoxID 
                                     FROM Boxes", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            firstBoxID = CStr(reader("BoxID")).Trim
        End While
        conn.Close()

        Return firstBoxID
    End Function

    Public Sub SetDateTextBoxes(ByVal boxID As Integer)
        Dim anticaptedDeliveryDate As Date
        Dim deliveryDate As Date
        Dim destructionDate As Date

        conn.Open()
        Dim sql As New SqlCommand("SELECT AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, 
                                          ActualDestructionDate 
                                   FROM Boxes 
                                   WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = sql.ExecuteReader()
        While reader.Read
            If Date.TryParse(reader("AnticipatedDeliveryToWarehouseDate").ToString(), anticaptedDeliveryDate) Then
                anticaptedDeliveryDate = reader("AnticipatedDeliveryToWarehouseDate")
            End If

            If Date.TryParse(reader("DeliveryToWarehouseDate").ToString(), deliveryDate) Then
                deliveryDate = reader("DeliveryToWarehouseDate")
            End If

            If Date.TryParse(reader("ActualDestructionDate").ToString(), destructionDate) Then
                destructionDate = reader("ActualDestructionDate")
            End If
        End While
        conn.Close()

        If anticaptedDeliveryDate = "12:00:00 AM" Then
            AnticipatedDeliveryToWarehouseDate.Text = "yyyy-MM-dd"
        Else
            AnticipatedDeliveryToWarehouseDate.Text = anticaptedDeliveryDate.ToString("yyyy-MM-dd")
        End If

        If deliveryDate = "12:00:00 AM" Then
            DeliveryToWarehouseDate.Text = "yyyy-MM-dd"
        Else
            DeliveryToWarehouseDate.Text = deliveryDate.ToString("yyyy-MM-dd")
        End If

        If destructionDate = "12:00:00 AM" Then
            ActualDestuctionDate.Text = "yyyy-MM-dd"
        Else
            ActualDestuctionDate.Text = destructionDate.ToString("yyyy-MM-dd")
        End If
    End Sub

    Public Sub SetDropdownLists(ByVal boxID As Integer)
        Dim boxNum As Integer
        Dim yearNum As Integer
        Dim locationID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT BoxNumber, BoxYear, LocationID 
                                     FROM Boxes 
                                     WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            boxNum = CStr(reader("BoxNumber")).Trim
            yearNum = CStr(reader("BoxYear")).Trim
            locationID = CStr(reader("LocationID")).Trim
        End While
        conn.Close()

        If boxNum <> 0 Then
            BoxNumberList.DataBind()
            BoxNumberList.Items.FindByValue(boxNum).Selected = True
        End If

        If yearNum <> 0 Then
            YearList.DataBind()
            YearList.Items.FindByValue(yearNum).Selected = True
        End If

        If locationID <> 0 Then
            LocationList.DataBind()
            LocationList.Items.FindByValue(locationID).Selected = True
        End If
    End Sub

    Protected Sub UpdateBox(ByVal boxID As Integer)
        'Const DATE_FORMAT As String = "MM/dd/yyyy"

        Dim boxNum As Integer = BoxNumberList.SelectedValue.Trim
        Dim yearNum As Integer = YearList.SelectedValue.Trim
        Dim locationID As Integer = LocationList.SelectedValue.Trim
        ''Dim anticaptedDeliveryDate As String = AnticipatedDeliveryToWarehouseDate.Text
        ''Dim parsedAnticaptedDeliveryDate As Date = Date.ParseExact(anticaptedDeliveryDate, DATE_FORMAT, CultureInfo.InvariantCulture)

        ''Dim deliveryWarehouseDate As Date = DeliveryToWarehouseDate.Text.Trim
        ''Dim destructionDate As Date = ActualDestuctionDate.Text.Trim

        Dim queryStr As String = String.Empty
        queryStr &= "UPDATE Boxes SET BoxNumber = '" & boxNum & "', BoxYear = '" & yearNum & "', LocationID = '" & locationID & "' "
        'queryStr &= "                 AnticipatedDeliveryToWarehouseDate = '" & anticaptedDeliveryDate & "'"
        'queryStr &= "                 DeliveryToWarehouseDate = '" & deliveryWarehouseDate & "',"
        'queryStr &= "                 ActualDestructionDate = '" & destructionDate & "'"
        queryStr &= " WHERE BoxID = '" & boxID & "'"

        Response.Write(queryStr)

        conn.Open()
        Dim query As New SqlCommand(queryStr, conn)
        query.ExecuteNonQuery()
        conn.Close()

        lblMsg.Text = "NEED TO WORK ON"
    End Sub
End Class