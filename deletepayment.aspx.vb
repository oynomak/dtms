
Partial Class deletepayment
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        LblDeletePrompt.Text = "Are you sure you want to delete this payment?"
        lblHeader.Text = "Delete a payment"

        If Not IsPostBack Then
            Dim payid As Integer = Request.QueryString("id")
            HFPaymentID.Value = payid.ToString
        End If

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim payid As Integer = CInt(HFPaymentID.Value)

        Dim pay As TMSDAL.TaxPayment = New TMSDAL.TaxPayment
        pay.Load(Session("connection"), payid)
        pay.Delete(Session("connection"))
        Response.Redirect("~/taxpayments.aspx")
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Redirect("~/taxpayments.aspx")
    End Sub
End Class
