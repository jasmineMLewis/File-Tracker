Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Web.Configuration
Imports System.Windows
Imports Microsoft.VisualStudio.Text.Editor.Commanding.Commands

Public Class BoxInfo
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim boxID As Integer

        If (Request.QueryString("BoxID") Is Nothing) Then
            If Not IsPostBack Then
                BoxList.AppendDataBoundItems = True
                BoxList.Items.Insert(0, New ListItem("Box", 0))
            End If
        End If

        If Not (Request.QueryString("BoxID") Is Nothing) Then
            boxID = Request.QueryString("BoxID").Trim
            BoxList.DataBind()
            BoxList.Items.FindByValue(boxID).Selected = True

            BindGridWithQueryString(boxID)

            If Not IsPostBack Then
                SetDropdownLists(boxID)
            End If
        End If

        SetTextBoxes(boxID)
    End Sub

    Private Sub BindGridWithDropDownListBox()
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
                            "INNER JOIN Users ON Files.SubmittedByUserID = Users.UserID "

        Dim boxID As Integer = BoxList.SelectedValue
        If (boxID > 0) Then
            sql += " WHERE Files.BoxID = " + boxID.ToString()
        End If

        SqlFilesInBox.SelectCommand = sql
        SqlFilesInBox.DataBind()
        GridViewFilesInBox.DataBind()
    End Sub

    Private Sub BindGridWithQueryString(ByVal boxID As String)
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
        BindGridWithDropDownListBox()
    End Sub

    Protected Sub BtnUpdateBox(ByVal sender As Object, ByVal e As EventArgs)
        Dim boxID As Integer
        If BoxList.SelectedValue <> 0 Then
            boxID = BoxList.SelectedValue.Trim
        Else
            boxID = Request.QueryString("BoxID").Trim
        End If

        UpdateBox(boxID)
    End Sub

    Public Function DisplayEditFileLink(ByVal sessionUserID As Integer, ByVal sessionRoleID As Integer, ByVal fileID As Integer) As String
        Return "<a href=../File/EditFile.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & "&FileID=" & fileID & "><i class='fa fa-pencil' aria-hidden='true'></i></a>"
    End Function

    Public Sub SetDropdownLists(ByVal boxID As Integer)
        Dim boxNum As Integer
        Dim yearNum As Integer
        Dim locationID As Integer

        conn.Open()
        Dim query As New SqlCommand("SELECT BoxNumber, BoxYear, LocationID FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
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

    Public Sub SetTextBoxes(ByVal boxID As Integer)
        Dim anticaptedDeliveryDate As String
        Dim deliveryDate As String
        Dim destructionDate As String

        conn.Open()
        Dim sql As New SqlCommand("SELECT AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = sql.ExecuteReader()
        While reader.Read
            anticaptedDeliveryDate = CStr(reader("DeliveryToWarehouseDate"))
            deliveryDate = CStr(reader("AnticipatedDeliveryToWarehouseDate"))
            destructionDate = CStr(reader("ActualDestructionDate"))
        End While
        conn.Close()

        AnticipatedDeliveryToWarehouseDate.Text = "NEED WORK"
        DeliveryToWarehouseDate.Text = "NEED WORK"
        ActualDestuctionDate.Text = "NEED WORK"
    End Sub

    Protected Sub UpdateBox(ByVal boxID As Integer)
        'Const DATE_FORMAT As String = "MM/dd/yyyy"

        Dim boxNum As Integer = BoxNumberList.SelectedValue.Trim
        Dim yearNum As Integer = YearList.SelectedValue.Trim
        Dim locationID As Integer = LocationList.SelectedValue.Trim
        Dim anticaptedDeliveryDate As String = AnticipatedDeliveryToWarehouseDate.Text
        'Dim parsedAnticaptedDeliveryDate As Date = Date.ParseExact(anticaptedDeliveryDate, DATE_FORMAT, CultureInfo.InvariantCulture)

        'Dim deliveryWarehouseDate As Date = DeliveryToWarehouseDate.Text.Trim
        'Dim destructionDate As Date = ActualDestuctionDate.Text.Trim

        Dim queryStr As String = String.Empty
        queryStr &= "UPDATE Boxes SET BoxNumber = '" & boxNum & "', BoxYear = '" & yearNum & "', LocationID = '" & locationID & "' "
        'queryStr &= "                 AnticipatedDeliveryToWarehouseDate = '" & anticaptedDeliveryDate & "'"
        'queryStr &= "                 DeliveryToWarehouseDate = '" & deliveryWarehouseDate & "',"
        'queryStr &= "                 ActualDestructionDate = '" & destructionDate & "'"
        queryStr &= " WHERE BoxID = '" & boxID & "'"

        'Response.Write(queryStr)

        conn.Open()
        Dim query As New SqlCommand(queryStr, conn)
        query.ExecuteNonQuery()
        conn.Close()

        lblMsg.Text = "Successful Box Update"
    End Sub
End Class