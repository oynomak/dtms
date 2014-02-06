
Partial Class TaxPayments
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        lblHeader.Text = labels.GetLabel(lang, "Tax Payments")

        If Session("level") = "district" Then
            HLAddPayment.Text = labels.GetLabel(lang, "Add New Payment")
        Else
            HLAddPayment.Visible = False
            ASPxGrid1.Columns(6).Visible = False
            ASPxGrid1.Columns(7).Visible = False
        End If

        ASPxGrid1.Columns(0).HeaderText = labels.GetLabel(lang, "Date")
        ASPxGrid1.Columns(1).HeaderText = labels.GetLabel(lang, "Taxpayer")
        ASPxGrid1.Columns(2).HeaderText = labels.GetLabel(lang, "Amount")
        ASPxGrid1.Columns(3).HeaderText = labels.GetLabel(lang, "Description")
        ASPxGrid1.Columns(4).HeaderText = labels.GetLabel(lang, "Tax Type")
        ASPxGrid1.Columns(5).HeaderText = labels.GetLabel(lang, "User")

    End Sub

    Private Sub AddCell(ByVal text As String, ByVal row As TableRow)
        Dim tc As TableCell
        tc = New TableCell
        tc.Text = text
        If IsNumeric(text) = True Then
            tc.HorizontalAlign = HorizontalAlign.Right
        End If
        row.Cells.Add(tc)
    End Sub

End Class
