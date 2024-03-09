Public Class PortOut
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
        Dim sql As String = "SELECT Files.pk_FileID, Files.ClientFirstName, Files.ClientLastName, Files.LastFourSSN, " & _
                            "      CONVERT (varchar(MAX), CAST(Files.PurgeTypeDate AS date), 101) AS PurgeTypeDate,   " & _
                            "      Files.IsDestroyed, Files.Notes, Files.fk_PurgeTypeID, PurgeType.PurgeType, Files.fk_BoxID,  " & _
                            "      (Boxes.BoxNumber + ' | ' + Boxes.Year) AS Box, Files.fk_LocationID, Location.Location, " & _
                            "      Files.fk_SubmittedByUserID, Users.FirstName + ' ' + Users.LastName AS SubmittedByUser, " & _
                            "      CONVERT (varchar(MAX), CAST(Files.DateSubmitted AS date), 101) AS DateSubmitted " & _
                            "FROM Files " & _
                            "INNER JOIN Boxes ON Files.fk_BoxID = Boxes.pk_BoxID " & _
                            "INNER JOIN PurgeType ON Files.fk_PurgeTypeID = PurgeType.pk_PurgeTypeID " & _
                            "INNER JOIN Location ON Files.fk_LocationID = Location.pk_LocationID " & _
                            "INNER JOIN Users ON Files.fk_SubmittedByUserID = Users.pk_UserID " & _
                            "WHERE Files.fk_PurgeTypeID = '3' "

        Dim boxID As Integer = Boxes.SelectedValue
        Dim locataionID As Integer = Location.SelectedValue
        Dim firstName As String = clientFirstName.Text
        Dim lastName As String = clientLastName.Text

        If (boxID > 0) Then
            sql += " AND Files.fk_BoxID = " + boxID.ToString()
        End If

        If (locataionID > 0) Then
            sql += " AND Files.fk_LocationID = " + locataionID.ToString()
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
        Me.BindGridWithFilters()
    End Sub

    Public Function DisplayDeleteIcon(ByVal isDestroyed As Integer) As String
        If isDestroyed = 1 Then
            Return "<i class='fa fa-check' aria-hidden='true' style='color:green;'></i>"
        Else
            Return "<i class='fa fa-close' aria-hidden='true' style='color:red;'></i>"
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