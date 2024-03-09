Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Web.Configuration

Public Class CreateFile
    Inherits System.Web.UI.Page
    Dim conn As SqlConnection = New SqlConnection(WebConfigurationManager.ConnectionStrings("FileTrackerConnectionString").ConnectionString)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Boxes.AppendDataBoundItems = True
            Boxes.Items.Insert(0, New ListItem("Box", ""))

            PurgeType.AppendDataBoundItems = True
            PurgeType.Items.Insert(0, New ListItem("Purge Type*", ""))

            Location.AppendDataBoundItems = True
            Location.Items.Insert(0, New ListItem("Location", ""))
        End If
    End Sub

    Protected Sub BtnCreateFile(ByVal sender As Object, ByVal e As EventArgs)
        CreateFile()
        ClearForm()
    End Sub

    Public Sub ClearForm()
        clientFirstName.Text = ""
        clientLastName.Text = ""
        lastFourSSN.Text = ""
        PurgeType.SelectedValue = ""
        Boxes.SelectedValue = ""
        Location.SelectedValue = ""
        notes.Text = ""
        purgeTypeDate.Text = ""
    End Sub

    Protected Sub CreateFile()
        Const IS_DESTROYED As Boolean = 0
        'Const DATE_FORMAT As String = "MM/dd/yyyy"

        Dim sessionUserID As Integer = GetSessionUserID()
        Dim firstName As String = clientFirstName.Text.Trim
        Dim lastName As String = clientLastName.Text.Trim
        Dim lastFourOfSocial As String = lastFourSSN.Text.Trim
        Dim purgeTypeID As Integer = PurgeType.SelectedValue
        Dim boxID As Integer = Boxes.SelectedValue
        Dim locationID As Integer = Location.SelectedValue
        Dim note As String = notes.Text.Trim
        'Dim parsePurgeTypeDate As String = purgeTypeDate.Text
        'Dim parsePurgeTypeDate As Date = Date.ParseExact(purgeTypeDate.Text, DATE_FORMAT, CultureInfo.InvariantCulture)

        Dim query As String = String.Empty
        query &= "INSERT INTO Files (ClientFirstName, ClientLastName, LastFourSSN, PurgeTypeDate, Notes, IsDestroyed, DateSubmitted, PurgeTypeID, BoxID, LocationID, SubmittedByUserID)"
        query &= "VALUES (@ClientFirstName, @ClientLastName, @LastFourSSN, @PurgeTypeDate, @Notes, @IsDestroyed, @DateSubmitted, @PurgeTypeID, @BoxID, @LocationID, @SubmittedByUserID)"

        Using comm As New SqlCommand()
            With comm
                .Connection = conn
                .CommandType = CommandType.Text
                .CommandText = query
                .Parameters.AddWithValue("@ClientFirstName", StrConv(firstName, VbStrConv.ProperCase))
                .Parameters.AddWithValue("@ClientLastName", StrConv(lastName, VbStrConv.ProperCase))
                .Parameters.AddWithValue("@LastFourSSN", lastFourOfSocial)
                '.Parameters.AddWithValue("@PurgeTypeDate", parsePurgeTypeDate)
                .Parameters.AddWithValue("@PurgeTypeDate", Date.Now)
                .Parameters.AddWithValue("@Notes", note)
                .Parameters.AddWithValue("@IsDestroyed", IS_DESTROYED)
                .Parameters.AddWithValue("@DateSubmitted", Date.Now)
                .Parameters.AddWithValue("@PurgeTypeID", purgeTypeID)
                .Parameters.AddWithValue("@BoxID", boxID)
                .Parameters.AddWithValue("@LocationID", locationID)
                .Parameters.AddWithValue("@SubmittedByUserID", sessionUserID)
            End With
            conn.Open()
            comm.ExecuteNonQuery()
            conn.Close()
            lblMsg.Text = "Successful File Submission"
        End Using
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
End Class