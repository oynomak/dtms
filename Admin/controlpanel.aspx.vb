
Partial Class controlpanel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        lblHeader.Text = labels.GetLabel(lang, "Control Panel")

        PageControl.TabPages(0).Text = labels.GetLabel(lang, "Regions")
        PageControl.TabPages(1).Text = labels.GetLabel(lang, "Security")
        PageControl.TabPages(2).Text = labels.GetLabel(lang, "Payment Institutions")

        If Session("level") = "district" Then
            RegionsMenu.Items(0).Visible = False '//Provinces
            RegionsMenu.Items(1).Visible = False '//Districts
            RegionsMenu.Items(2).NavigateUrl = "sectors.aspx?distid=" & Session("districtid")
            RegionsMenu.Items(2).Text = labels.GetLabel(lang, "Manage the Sectors List")
            RegionsMenu.Items(3).Visible = False '//cells
        Else
            RegionsMenu.Items(0).Visible = True '//Provinces
            RegionsMenu.Items(0).Text = labels.GetLabel(lang, "Manage the Provinces List")

            RegionsMenu.Items(1).Visible = False '//Districts
            RegionsMenu.Items(2).Visible = False '//Sectors
            RegionsMenu.Items(3).Visible = False '//cells

            PageControl.TabPages(2).Visible = False '//Payments and Banks
        End If


        SecurityMenu.Items(0).Text = labels.GetLabel(lang, "Manage Users who can access this application")
        SecurityMenu.Items(1).Text = labels.GetLabel(lang, "Manage User Permissions")



    End Sub
End Class
