
Partial Class deletetaxpayer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim taxpayerid As Integer = Request.QueryString("id")
        Dim taxpayer As TMSDAL.TaxPayer = New TMSDAL.TaxPayer
        taxpayer.Load(Session("connection"), taxpayerid)

        lblMessage.Width = New Unit("100%")


        Try
            taxpayer.Delete(Session("connection"))
        Catch ex As Exception
            lblMessage.ForeColor = Drawing.Color.Red
            lblMessage.Text = "The taxpayer [<b>" & taxpayer.Names & "</b>] cannot be deleted. Make sure they have no tax payments, tenants, businesses or properties in the system."
            lblMessage.Font.Bold = True
            Exit Sub
        End Try

        lblMessage.Text = "The taxpayer [<b>" & taxpayer.Names & "</b>] has been deleted successfully."

    End Sub
End Class
