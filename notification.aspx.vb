
Partial Class notification
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            Dim urlback As String = Request.QueryString("url")
            Dim taxpayerID As Integer = Request.QueryString("id")

            If taxpayerID > 0 Then
                HFUrlBack.Value = urlback & "?id=" & taxpayerID
            Else
                HFUrlBack.Value = urlback
            End If


            Dim saveditem As String = Request.QueryString("saveditem")
            lblHeader.Text = saveditem & " Saved Successfully"

            lblNotification.Text = "The " & saveditem & " has been saved successfully."
        End If

    End Sub

    Protected Sub BtnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnBack.Click
        If HFUrlBack.Value IsNot Nothing Then
            If HFUrlBack.Value.Length > 0 Then
                Response.Redirect(HFUrlBack.Value)
            End If
        End If
    End Sub
End Class
