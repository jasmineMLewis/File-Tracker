Imports System.Data.SqlClient

Public Class OnSiteBoxes
    Inherits System.Web.UI.Page
    Dim conn As New SqlConnection("Server=HANOAPPS1;Database=File_Tracker;User Id=filetuser;Password=P@55w0rd17")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BoxList.AppendDataBoundItems = True
            BoxList.Items.Insert(0, New ListItem("Box", "0"))
        End If
    End Sub

    Private Sub BindGridWithFilters()
        Dim sql As String = "SELECT Boxes.pk_BoxID, Boxes.BoxNumber, Boxes.Year, Boxes.BoxNumber + ' | ' + Boxes.Year AS Box, " & _
                            "       Boxes.fk_LocationID, Location.Location, " & _
                            "       CAST(MONTH(AnticipatedDeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(AnticipatedDeliveryToWarehouseDate) AS varchar) AS AnticipatedDeliveryToWarehouseDate, " & _
                            "       CAST(MONTH(Boxes.DeliveryToWarehouseDate) AS varchar) + '-' + CAST(YEAR(Boxes.DeliveryToWarehouseDate) AS varchar) AS DeliveryToWarehouseDate, " & _
                            "       CAST(MONTH(Boxes.ActualDestructionDate) AS varchar) + '-' + CAST(YEAR(Boxes.ActualDestructionDate) AS varchar) AS ActualDestructionDate, " & _
                            "       (SELECT COUNT(pk_FileID) AS Expr1 FROM Files WHERE (fk_BoxID = Boxes.pk_BoxID)) AS FileCountPerBox " & _
                            "FROM Boxes " & _
                            "INNER JOIN Location ON Boxes.fk_LocationID = Location.pk_LocationID "

        Dim boxID As Integer = BoxList.SelectedValue
        If (boxID > 0) Then
            sql += " WHERE Boxes.pk_BoxID = " + boxID.ToString()
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
        Dim query As New SqlCommand("SELECT ActualDestructionDate FROM Boxes WHERE pk_BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            actualDestructionDate = CStr(reader("ActualDestructionDate"))
        End While
        conn.Close()

        If actualDestructionDate = "1900-01-01" Then
            Return ""
        Else
            Return actualDestructionDate
        End If
    End Function

    Public Function DisplayAnticipatedDeliveryToWarehouseDate(ByVal boxID As Integer) As String
        Dim anticipatedDeliveryToWarehouseDate As Date

        conn.Open()
        Dim query As New SqlCommand("SELECT AnticipatedDeliveryToWarehouseDate FROM Boxes WHERE pk_BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            anticipatedDeliveryToWarehouseDate = CStr(reader("AnticipatedDeliveryToWarehouseDate"))
        End While
        conn.Close()

        If anticipatedDeliveryToWarehouseDate = "1900-01-01" Then
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
        Dim query As New SqlCommand("SELECT DeliveryToWarehouseDate FROM Boxes WHERE pk_BoxID = '" & boxID & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()
        While reader.Read
            deliveryToWarehouseDate = CStr(reader("DeliveryToWarehouseDate"))
        End While
        conn.Close()

        If deliveryToWarehouseDate = "1900-01-01" Then
            Return ""
        Else
            Return deliveryToWarehouseDate
        End If
    End Function
End Class