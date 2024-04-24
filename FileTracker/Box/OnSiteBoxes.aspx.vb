Imports System.Data.SqlClient
Imports System.Numerics
Imports System.Web.Configuration

Public Class OnSiteBoxes
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

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
        End If

        SqlOnSiteBoxes.SelectCommand = sql
        SqlOnSiteBoxes.DataBind()
        GridViewOnSiteBoxes.DataBind()
    End Sub

    Protected Sub BtnFilterBoxes(ByVal sender As Object, ByVal e As EventArgs)
        BindGridWithFilters()
    End Sub

    Public Function DisplayActualDestructionDate(ByVal boxID As Integer) As String
        Dim actualDestructionDate As Date

        conn.Open()
        Dim query As New SqlCommand("SELECT ActualDestructionDate FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            actualDestructionDate = CStr(reader("ActualDestructionDate"))
        End While
        conn.Close()

        If actualDestructionDate = "1900-01-01" Then
            Return ""
        ElseIf actualDestructionDate = String.Empty Then
            Return ""
        Else
            Return actualDestructionDate
        End If
    End Function

    Public Function DisplayAnticipatedDeliveryToWarehouseDate(ByVal boxID As Integer) As String
        Dim anticipatedDeliveryToWarehouseDate As Date

        conn.Open()
        Dim query As New SqlCommand("SELECT AnticipatedDeliveryToWarehouseDate FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            anticipatedDeliveryToWarehouseDate = CStr(reader("AnticipatedDeliveryToWarehouseDate"))
        End While
        conn.Close()

        If anticipatedDeliveryToWarehouseDate = "1900-01-01" Then
            Return ""
        ElseIf anticipatedDeliveryToWarehouseDate = String.Empty Then
            Return ""
        Else
            Return anticipatedDeliveryToWarehouseDate
        End If
    End Function

    Public Function DisplayBoxNumber(ByVal sessionUserID As Integer, ByVal sessionRoleID As Integer, ByVal boxID As Integer, ByVal boxNumber As String) As String
        Return "<a href=BoxInfo.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & "&BoxID=" & boxID & ">" & boxNumber & "</a>"
    End Function

    Public Function DisplayDeliveryToWarehouseDate(ByVal boxID As Integer) As String
        Dim deliveryToWarehouseDate As Date

        conn.Open()
        Dim query As New SqlCommand("SELECT DeliveryToWarehouseDate FROM Boxes WHERE BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            deliveryToWarehouseDate = CStr(reader("DeliveryToWarehouseDate"))
        End While
        conn.Close()

        If deliveryToWarehouseDate = "1900-01-01" Then
            Return ""
        ElseIf deliveryToWarehouseDate = String.Empty Then
            Return ""
        Else
            Return deliveryToWarehouseDate
        End If
    End Function
End Class