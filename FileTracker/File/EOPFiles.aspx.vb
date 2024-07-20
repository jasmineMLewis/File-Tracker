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
        Dim sql As String = "SELECT [File].FileID, [File].ClientFirstName, [File].ClientLastName, [File].ClientLastFourSSN, " &
                            "      CONVERT (varchar(MAX), CAST([File].PurgeTypeDate AS date), 101) AS PurgeTypeDate,   " &
                            "      [File].IsDestroyed, [File].Notes, [File].PurgeTypeID, PurgeType.PurgeType, [File].BoxID,  " &
                            "      (Box.BoxNumber + ' | ' + Box.BoxYear) AS Box, [File].LocationID, Location.Location, " &
                            "      [File].SubmittedByUserID, [User].FirstName + ' ' + [User].LastName AS SubmittedByUser, " &
                            "      CONVERT (varchar(MAX), CAST([File].DateSubmitted AS date), 101) AS DateSubmitted " &
                            "FROM [File] " &
                            "INNER JOIN Box ON [File].BoxID = Box.BoxID " &
                            "INNER JOIN PurgeType ON [File].PurgeTypeID = PurgeType.PurgeTypeID " &
                            "INNER JOIN Location ON [File].LocationID = Location.LocationID " &
                            "INNER JOIN [User] ON [File].SubmittedByUserID = [User].UserID " &
                            "WHERE [File].PurgeTypeID = '1' "

        Dim boxID As Integer = Boxes.SelectedValue
        Dim locationID As Integer = Location.SelectedValue
        Dim firstName As String = clientFirstName.Text.Trim
        Dim lastName As String = clientLastName.Text.Trim

        If (boxID > 0) Then
            sql += " AND [File].BoxID = " + boxID.ToString()
        End If

        If (locationID > 0) Then
            sql += " AND [File].LocationID = " + locationID.ToString()
        End If

        If Not String.IsNullOrEmpty(firstName) Then
            sql += " AND [File].ClientFirstName LIKE '" + firstName.ToString() + "%'"
        End If

        If Not String.IsNullOrEmpty(lastName) Then
            sql += " AND [File].ClientLastName LIKE '" + lastName.ToString() + "%'"
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