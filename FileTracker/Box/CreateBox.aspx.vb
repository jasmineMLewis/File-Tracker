Imports System.Globalization
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class CreateBox
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BoxNumber.AppendDataBoundItems = True
            BoxNumber.Items.Insert(0, New ListItem("Box Number", ""))
            PopulateBoxNumberList()

            BoxYear.AppendDataBoundItems = True
            BoxYear.Items.Insert(0, New ListItem("Year", ""))
            PopulateBoxYearList()

            BoxLocation.AppendDataBoundItems = True
            BoxLocation.Items.Insert(0, New ListItem("Location", ""))
        End If
    End Sub

    Protected Sub BtnCreateBox(ByVal sender As Object, ByVal e As EventArgs)
        CreateBox()
        ClearForm()
    End Sub

    Public Sub ClearForm()
        BoxNumber.SelectedValue = ""
        BoxYear.SelectedValue = ""
        AnticipatedDeliveryToWarehouseDate.Text = ""
        BoxLocation.SelectedValue = ""
    End Sub

    Public Function IsBoxExists(ByVal boxYear As Integer, ByVal boxNumber As Integer) As Boolean
        Dim isExists As Boolean
        conn.Open()
        Dim query As New SqlCommand("SELECT BoxID FROM Boxes WHERE BoxYear = '" & boxYear & "' AND BoxNumber = '" & boxNumber & "'", conn)
        Dim reader As SqlDataReader = query.ExecuteReader()

        If reader.HasRows Then
            isExists = True
        Else
            isExists = False
        End If
        conn.Close()

        Return isExists
    End Function

    Public Sub CreateBox()
        Dim year As Integer = BoxYear.SelectedValue
        Dim number As Integer = BoxNumber.SelectedValue

        'Check if box exists
        If IsBoxExists(year, number) Then
            lblMsg.Text = "Failed Box Creation because it already EXISTS"
        Else
            Dim sessionUserID As Integer = GetSessionUserID()
            Dim locationID As Integer = BoxLocation.SelectedValue

            'The format that the date control uses
            'Const DATE_FORMAT As String = "MM/dd/yyyy"
            'Dim parsedAnticipatedDeliveryDate As DateTime  = DateTime.ParseExact(AnticipatedDeliveryToWarehouseDate.Text, DATE_FORMAT, CultureInfo.InvariantCulture)

            Dim query As String = String.Empty
            query &= "INSERT INTO Boxes (BoxYear, BoxNumber, AnticipatedDeliveryToWarehouseDate, DeliveryToWarehouseDate, ActualDestructionDate, DateSubmitted, LocationID, SubmittedByUserID)"
            query &= "VALUES (@BoxYear, @BoxNumber, @AnticipatedDeliveryToWarehouseDate, @DeliveryToWarehouseDate, @ActualDestructionDate, @DateSubmitted, @LocationID, @SubmittedByUserID)"

            Using comm As New SqlCommand()
                With comm
                    .Connection = conn
                    .CommandType = CommandType.Text
                    .CommandText = query
                    .Parameters.AddWithValue("@BoxYear", year)
                    .Parameters.AddWithValue("@BoxNumber", number)
                    .Parameters.AddWithValue("@AnticipatedDeliveryToWarehouseDate", DBNull.Value)
                    .Parameters.AddWithValue("@DeliveryToWarehouseDate", DBNull.Value)
                    .Parameters.AddWithValue("@ActualDestructionDate", DBNull.Value)
                    .Parameters.AddWithValue("@DateSubmitted", Date.Now)
                    .Parameters.AddWithValue("@LocationID", locationID)
                    .Parameters.AddWithValue("@SubmittedByUserID", sessionUserID)
                End With
                conn.Open()
                comm.ExecuteNonQuery()
                conn.Close()
                lblMsg.Text = "Successful Box Creation"
            End Using
        End If
    End Sub

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

    Public Sub PopulateBoxNumberList()
        Const MAX_BOX As Integer = 25
        Dim i As Integer = 1
        Do While (i <= MAX_BOX)
            BoxNumber.Items.Add(New ListItem((i), i.ToString))
            i = (i + 1)
        Loop
        BoxNumber.DataBind()
    End Sub

    Public Sub PopulateBoxYearList()
        Const MAX_YEAR As Integer = 2030
        Dim i As Integer = 2006
        Do While (i <= MAX_YEAR)
            BoxYear.Items.Add(New ListItem((i), i.ToString))
            i = (i + 1)
        Loop
        BoxYear.DataBind()
    End Sub
End Class