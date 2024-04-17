Public Class EOPFiles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Boxes.AppendDataBoundItems = True
            Boxes.Items.Insert(0, New ListItem("Box", "0"))

            Location.AppendDataBoundItems = True
            Location.Items.Insert(0, New ListItem("Location", "0"))
        End If
    End Sub

    Private Sub BindGridWithFilters()
        Dim sql As String = "SELECT Files.FileID, Files.ClientFirstName, Files.ClientLastName, Files.LastFourSSN, " &
                            "      CONVERT (varchar(MAX), CAST(Files.PurgeTypeDate AS date), 101) AS PurgeTypeDate,   " &
                            "      Files.IsDestroyed, Files.Notes, Files.PurgeTypeID, PurgeType.PurgeType, Files.BoxID,  " &
                            "      (Boxes.BoxNumber + ' | ' + Boxes.Year) AS Box, Files.LocationID, Location.Location, " &
                            "      Files.SubmittedByUserID, Users.FirstName + ' ' + Users.LastName AS SubmittedByUser, " &
                            "      CONVERT (varchar(MAX), CAST(Files.DateSubmitted AS date), 101) AS DateSubmitted " &
                            "FROM Files " &
                            "INNER JOIN Boxes ON Files.BoxID = Boxes.BoxID " &
                            "INNER JOIN PurgeType ON Files.PurgeTypeID = PurgeType.PurgeTypeID " &
                            "INNER JOIN Location ON Files.LocationID = Location.LocationID " &
                            "INNER JOIN Users ON Files.SubmittedByUserID = Users.UserID " &
                            "WHERE Files.PurgeTypeID = '1' "

        Dim boxID As Integer = Boxes.SelectedValue
        Dim locationID As Integer = Location.SelectedValue
        Dim firstName As String = clientFirstName.Text
        Dim lastName As String = clientLastName.Text

        If (boxID > 0) Then
            sql += " AND Files.BoxID = " + boxID.ToString()
        End If

        If (locationID > 0) Then
            sql += " AND Files.LocationID = " + locationID.ToString()
        End If

        If Not String.IsNullOrEmpty(firstName) Then
            sql += " AND Files.ClientFirstName LIKE '" + firstName.ToString() + "%'"
        End If

        If Not String.IsNullOrEmpty(lastName) Then
            sql += " AND Files.ClientLastName LIKE '" + lastName.ToString() + "%'"
        End If

        SqlFiles.SelectCommand = sql
        SqlFiles.DataBind()
        GridViewFiles.DataBind()
    End Sub

    Protected Sub BtnFilterFiles(ByVal sender As Object, ByVal e As EventArgs)
        BindGridWithFilters()
    End Sub

    Public Function DisplayDeleteIcon(ByVal isDestroyed As Integer) As String
        If isDestroyed = 1 Then
            Return "<i class='fa fa-check' aria-hidden='true' style='color:green;'></i>"
        ElseIf isDestroyed = 0 Then
            Return "<i class='fa fa-close' aria-hidden='true' style='color:red;'></i>"
        Else
            Return "Unsure"
        End If
    End Function

    Public Function DisplayEditFileLink(ByVal sessionUserID As Integer, ByVal sessionRoleID As Integer, ByVal fileID As Integer) As String
        Return "<a href=EditFile.aspx?SessionUserID=" & sessionUserID & "&SessionRoleID=" & sessionRoleID & "&FileID=" & fileID & "><i class='fa fa-pencil' aria-hidden='true'></i></a>"
    End Function

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        ' Confirms that an HtmlForm control is rendered for the specified ASP.NET
        '     server control at run time. 
    End Sub
End Class