
Partial Class taxpayers
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        lblHeader.Text = labels.GetLabel(lang, "Taxpayers")

        If Session("level") = "district" Then
            HLAddTaxpayer.Text = labels.GetLabel(lang, "Add Taxpayer")
            ASPxGrid1.Columns(6).HeaderText = labels.GetLabel(lang, "Edit")
            ASPxGrid1.Columns(7).HeaderText = labels.GetLabel(lang, "Delete")
        Else
            HLAddTaxpayer.Visible = False
            ASPxGrid1.Columns(7).Visible = False
            ASPxGrid1.Columns(6).HeaderText = labels.GetLabel(lang, "View")
        End If

        ASPxGrid1.Columns(0).HeaderText = labels.GetLabel(lang, "District")
        ASPxGrid1.Columns(1).HeaderText = labels.GetLabel(lang, "Sector")
        ASPxGrid1.Columns(2).HeaderText = labels.GetLabel(lang, "Cell")
        ASPxGrid1.Columns(3).HeaderText = labels.GetLabel(lang, "Name")
        ASPxGrid1.Columns(4).HeaderText = labels.GetLabel(lang, "Profession")
        ASPxGrid1.Columns(5).HeaderText = labels.GetLabel(lang, "Telephone")


        ASPxGrid1.PageSize = 30
        ASPxGrid1.BehaviorOptions.HideGroupedColumns = True

    End Sub

    Private Sub AddCell(ByVal text As String, ByVal row As TableRow)
        Dim tc As TableCell
        tc = New TableCell
        tc.Text = text
        row.Cells.Add(tc)
    End Sub


End Class
