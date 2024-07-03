Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class UnknownBoxes
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Private Const UNKNOWN_LOCATION_DB_ID As Integer = 3

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BoxList.AppendDataBoundItems = True
            BoxList.Items.Insert(0, New ListItem("Box", "0"))
        End If
    End Sub

    Private Sub BindGridWithFilters()
        Dim sql As String = "SELECT Boxes.BoxID, Boxes.BoxNumber, Boxes.BoxYear, Boxes.BoxNumber + ' | ' + Boxes.BoxYear AS Box, " &
                            "       Boxes.LocationID, Location.Location, " &
                            "       CAST(MONTH(AnticipatedDeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(AnticipatedDeliveryToWarehouseDate) AS varchar) AS AnticipatedDeliveryToWarehouseDate, " &
                            "       CAST(MONTH(Boxes.DeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(Boxes.DeliveryToWarehouseDate) AS varchar) AS DeliveryToWarehouseDate, " &
                            "       CAST(MONTH(Boxes.ActualDestructionDate) AS varchar) + '-' + CAST(YEAR(Boxes.ActualDestructionDate) AS varchar) AS ActualDestructionDate, " &
                            "       (SELECT COUNT(FileID) AS FileID FROM Files WHERE (BoxID = Boxes.BoxID)) AS FileCountPerBox " &
                            "FROM Boxes " &
                            "INNER JOIN Location ON Boxes.LocationID = Location.LocationID "

        Dim boxID As Integer = BoxList.SelectedValue
        If (boxID > 0) Then
            sql += " WHERE Boxes.BoxID = " + boxID.ToString()
        ElseIf (boxID = 0) Then
            sql += " WHERE Boxes.LocationID = " + UNKNOWN_LOCATION_DB_ID.ToString()
        End If

        SqlUnknownBoxes.SelectCommand = sql
        SqlUnknownBoxes.DataBind()
        GridViewUnknownBoxes.DataBind()
    End Sub

    Protected Sub BtnFilterBoxes(ByVal sender As Object, ByVal e As EventArgs)
        BindGridWithFilters()
    End Sub

    Public Function DisplayActualDestructionDate(ByVal boxID As Integer) As String
        Dim actualDestructionDate As String

        conn.Open()
        Dim query As New SqlCommand("SELECT 
                                        CASE
                                             WHEN ActualDestructionDate IS NULL THEN ''
                                             WHEN ActualDestructionDate IS NOT NULL THEN CONVERT(VARCHAR(25), ActualDestructionDate, 101)
                                             ELSE ActualDestructionDate
                                        END AS ActualDestructionDate
                                    FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.Read() Then
            actualDestructionDate = reader("ActualDestructionDate")
        End If
        conn.Close()

        If actualDestructionDate = "12:00:00 AM" Then
            actualDestructionDate = ""
        ElseIf actualDestructionDate = "1/1/1900" Then
            actualDestructionDate = ""
        Else
            actualDestructionDate = actualDestructionDate.ToString()
        End If

        Return actualDestructionDate
    End Function

    Public Function DisplayAnticipatedDeliveryToWarehouseDate(ByVal boxID As Integer) As String
        Dim anticipatedDeliveryToWarehouseDate As String

        conn.Open()
        Dim query As New SqlCommand("SELECT 
                                        CASE
                                             WHEN AnticipatedDeliveryToWarehouseDate IS NULL THEN ''
                                             WHEN AnticipatedDeliveryToWarehouseDate IS NOT NULL THEN CONVERT(VARCHAR(25), AnticipatedDeliveryToWarehouseDate, 101)
                                             ELSE AnticipatedDeliveryToWarehouseDate
                                        END AS AnticipatedDeliveryToWarehouseDate
                                    FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.Read() Then
            anticipatedDeliveryToWarehouseDate = reader("AnticipatedDeliveryToWarehouseDate")
        End If
        conn.Close()

        If anticipatedDeliveryToWarehouseDate = "12:00:00 AM" Then
            anticipatedDeliveryToWarehouseDate = ""
        ElseIf anticipatedDeliveryToWarehouseDate = "1/1/1900" Then
            anticipatedDeliveryToWarehouseDate = ""
        Else
            anticipatedDeliveryToWarehouseDate = anticipatedDeliveryToWarehouseDate.ToString()
        End If

        Return anticipatedDeliveryToWarehouseDate
    End Function

    Public Function DisplayBoxNumber(ByVal sessionUserID As Integer, ByVal sessionRoleID As Integer, ByVal boxID As Integer, ByVal boxNumber As String) As String
        Return "<a href=BoxInfo.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & "&BoxID=" & boxID & ">" & boxNumber & "</a>"
    End Function

    Public Function DisplayDeliveryToWarehouseDate(ByVal boxID As Integer) As String
        Dim deliveryToWarehouseDate As String

        conn.Open()
        Dim query As New SqlCommand("SELECT 
                                        CASE
                                             WHEN DeliveryToWarehouseDate IS NULL THEN ''
                                             WHEN DeliveryToWarehouseDate IS NOT NULL THEN CONVERT(VARCHAR(25), DeliveryToWarehouseDate, 101)
                                             ELSE DeliveryToWarehouseDate
                                        END AS DeliveryToWarehouseDate
                                    FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        If reader.Read() Then
            deliveryToWarehouseDate = reader("DeliveryToWarehouseDate")
        End If
        conn.Close()

        If deliveryToWarehouseDate = "12:00:00 AM" Then
            deliveryToWarehouseDate = ""
        ElseIf deliveryToWarehouseDate = "1/1/1900" Then
            deliveryToWarehouseDate = ""
        Else
            deliveryToWarehouseDate = deliveryToWarehouseDate.ToString()
        End If

        Return deliveryToWarehouseDate
    End Function
End Class