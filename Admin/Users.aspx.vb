
Partial Class Users
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        lblHeader.Text = labels.GetLabel(lang, "Users")
        HLAddUser.Text = labels.GetLabel(lang, "Add User")

        Dim action As String = Request.QueryString("action")
        Dim userid As Short = Val(Request.QueryString("id"))

        If action IsNot Nothing Then
            Dim user As TMSDAL.User = New TMSDAL.User
            user.Load(Session("connection"), userid)

            If action = "delete" Then
                '//delete the user
                user.Delete(Session("connection"))
            ElseIf action = "activate" Then
                '//Activate the user
                user.Status = 1
                user.Save(Session("connection"))
            ElseIf action = "deactivate" Then
                '//Activate the user
                user.Status = 0
                user.Save(Session("connection"))
            End If

            Response.Redirect("users.aspx")
        End If


        '//Show the users
        Dim tr As TableRow
        tr = New TableRow

        AddCell("", tr)
        AddCell(labels.GetLabel(lang, "Name"), tr)
        AddCell(labels.GetLabel(lang, "Status"), tr)
        AddCell("", tr)
        AddCell("", tr)

        tr.CssClass = "tableheader"
        TblUsers.Rows.Add(tr)

        Dim status(1) As String
        status(0) = labels.GetLabel(lang, "Inactive")
        status(1) = labels.GetLabel(lang, "Active")

        Dim users As TMSDAL.Users = New TMSDAL.Users
        users.Load(Session("connection"))
        Dim i As Integer

        For Each user As TMSDAL.User In users
            i += 1
            tr = New TableRow
            AddCell(i & ".", tr)
            AddCell("<A href='user.aspx?id=" & user.UserID & "'>" & user.FullName & "</A>", tr)
            AddCell(status(Math.Abs(user.Status)), tr)
            AddCell("<A href='users.aspx?id=" & user.UserID & "&action=delete'>" & labels.GetLabel(lang, "Delete") & "</A>", tr)
            If user.Status = 0 Then
                AddCell("<A href='users.aspx?id=" & user.UserID & "&action=activate'>" & labels.GetLabel(lang, "Activate") & "</A>", tr)
            Else
                AddCell("<A href='users.aspx?id=" & user.UserID & "&action=deactivate'>" & labels.GetLabel(lang, "Deactivate") & "</A>", tr)
            End If

            TblUsers.Rows.Add(tr)
        Next


    End Sub

    Private Sub AddCell(ByVal text As String, ByVal row As TableRow)
        Dim tc As TableCell
        tc = New TableCell
        tc.Text = text
        row.Cells.Add(tc)
    End Sub
End Class
