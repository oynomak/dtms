Imports System.Security.Principal

Partial Class mainmaster
    Inherits System.Web.UI.MasterPage

    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        Rwanda.Text = labels.GetLabel(lang, "Kinyarwanda")
        England.Text = labels.GetLabel(lang, "English")
        France.Text = labels.GetLabel(lang, "French")

        LoginStatus1.LoginText = labels.GetLabel(lang, "Sign In")
        LoginStatus1.LogoutText = labels.GetLabel(lang, "Sign Out")
        LblFooter.Text = labels.GetLabel(lang, "Designed by Gravisio - 2007")


        Dim usertext As String = ""

        If Session("user") IsNot Nothing Then
            lblUserInfo.Text = usertext & "<b>" & Session("username") & "</b>"
        Else
            lblUserInfo.Text = usertext & "<b>" & labels.GetLabel(lang, "Guest") & "</b>"
        End If


        lblUserInfo.Visible = True
        lblLocation.Font.Bold = True
        lblLocation.Text = Session("levelname")

        '//Prepare the Top menu
        ASPxMenu1.Items(0).Text = labels.GetLabel(lang, "Home")
        ASPxMenu1.Items(1).Text = labels.GetLabel(lang, "Taxpayers")
        ASPxMenu1.Items(2).Text = labels.GetLabel(lang, "Payments")
        ASPxMenu1.Items(3).Text = labels.GetLabel(lang, "Users")
        ASPxMenu1.Items(4).Text = labels.GetLabel(lang, "Reports")
        ASPxMenu1.Items(5).Text = labels.GetLabel(lang, "Control Panel")

        If Not IsPostBack Then
            If Session("level") = "district" Then '//TODO: Get the current level
                ShowSectors() '//Show sectors for the district
            Else
                ShowProvinces()
            End If
            ShowTaxTypes()

            '//Hide the controlPanel if not an admin
            If Session("username") <> "Admin" Then
                ASPxMenu1.Items(5).Visible = False
                ASPxMenu1.Items(3).Visible = False
            End If
        End If


        NavBar1.AllowExpanding = False
        NavBar1.AutoCollapse = False



    End Sub

    'Private Function IsAdmin(ByVal formsUser As System.Security.Principal.WindowsIdentity) As Boolean

    '    Dim groups As System.Security.Principal.IdentityReferenceCollection = formsUser.Groups.Translate(GetType(NTAccount))
    '    Dim groupname As String
    '    For Each group As System.Security.Principal.NTAccount In groups
    '        groupname = GetAccountName(group.Value)
    '        If groupname = "TMSAdmin" Then
    '            Session("role") = "Admin"
    '            Return True
    '        Else
    '            Session("role") = "user"
    '        End If
    '    Next

    'End Function


    Private Sub ShowProvinces()
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        Dim grp As DevExpress.Web.ASPxNavBar.NavBarGroup
        grp = NavBar1.Groups.Add(labels.GetLabel(lang, "Provinces"))

        Dim provs As TMSDAL.Provinces = New TMSDAL.Provinces
        provs.Load(Session("connection"))

        Dim link As DevExpress.Web.ASPxNavBar.NavBarItem

        For Each prov As TMSDAL.Province In provs
            link = New DevExpress.Web.ASPxNavBar.NavBarItem
            link.Text = labels.GetLabel(lang, prov.ProvinceName)
            link.NavigateUrl = "~/province.aspx?provid=" & prov.ProvinceID
            grp.Items.Add(link)
        Next

    End Sub

    Private Sub ShowSectors()
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        Dim grp As DevExpress.Web.ASPxNavBar.NavBarGroup
        grp = NavBar1.Groups.Add(labels.GetLabel(lang, "Sectors"))

        Dim link As DevExpress.Web.ASPxNavBar.NavBarItem

        Dim dist As TMSDAL.District = GetDistrict()

        If dist IsNot Nothing Then
            Dim sectors As TMSDAL.Sectors = New TMSDAL.Sectors
            sectors.Load(Session("connection"), dist.DistrictID)

            For Each sect As TMSDAL.Sector In sectors
                link = New DevExpress.Web.ASPxNavBar.NavBarItem
                link.Text = sect.SectorName
                link.NavigateUrl = "~/sector.aspx?sectid=" & sect.SectorID
                grp.Items.Add(link)
            Next
        Else
            link = New DevExpress.Web.ASPxNavBar.NavBarItem
            link.Text = labels.GetLabel(lang, "No Sectors in this district")
            grp.Items.Add(link)

        End If

    End Sub

    Private Function GetDistrict() As TMSDAL.District
        Dim dist As TMSDAL.District = Nothing

        If Session("level") = "district" Then
            Dim districtname As String = Session("levelname")
            dist = New TMSDAL.District
            dist.Load(Session("connection"), districtname)
            Session("districtid") = dist.DistrictID
        End If

        Return dist
    End Function

    Private Sub ShowTaxTypes()
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        Dim grp As DevExpress.Web.ASPxNavBar.NavBarGroup
        grp = NavBar1.Groups.Add(labels.GetLabel(lang, "Tax Types"))

        Dim link As DevExpress.Web.ASPxNavBar.NavBarItem

        Dim tts As TMSDAL.TaxTypes = New TMSDAL.TaxTypes
        tts.Load(Session("connection"))

        For Each tt As TMSDAL.TaxType In tts
            link = New DevExpress.Web.ASPxNavBar.NavBarItem
            link.Text = tt.TaxTypeName
            link.NavigateUrl = "~/taxtype.aspx?id=" & tt.TaxTypeID
            grp.Items.Add(link)
        Next
    End Sub

    Protected Sub Rwanda_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Rwanda.Click
        Session("language") = "rw"
        Response.Redirect(Request.Url.AbsoluteUri)
    End Sub

    Protected Sub England_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles England.Click
        Session("language") = "en"
        Response.Redirect(Request.Url.AbsoluteUri)
    End Sub

    Protected Sub France_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles France.Click
        Session("language") = "fr"
        Response.Redirect(Request.Url.AbsoluteUri)
    End Sub


    Protected Sub btnMainSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnMainSearch.Click
        Dim searchphrase As String = txtGeneralSearch.Text.Trim

        Session("Results") = Nothing

        If searchphrase.Length < 3 Then Exit Sub
        If searchphrase.ToLower = "and" Then Exit Sub
        If searchphrase.ToLower = "or" Then Exit Sub

        'Dim Results As SearchResults = New SearchResults(Session("connection"), searchphrase)
        '//SeachResults has [Type,ResultText,link] properties
        'Session("Results") = Results
        Session("searchphrase") = searchphrase

        Response.Redirect("~/search.aspx")

    End Sub
End Class

