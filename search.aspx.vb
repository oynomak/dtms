
Partial Class search
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        Dim phrase As String = Session("searchphrase")

        LblHeader.Text = labels.GetLabel(lang, "Search results for") & ": <i>" & phrase & "</i>"


        '//Show results
        '//For each tab page show the header and the results
        Dim tp, bs, lp, tn As DevExpress.Web.ASPxTabControl.TabPage
        
        tp = PageControl.TabPages(0)
        bs = PageControl.TabPages(1)
        lp = PageControl.TabPages(2)
        tn = PageControl.TabPages(3)

        Dim tr As TableRow
        Dim tblTaxPayer As Table = New Table
        tp.Controls.Add(tblTaxPayer)

        '//Show taxpayer results
        Dim taxpayers As TMSDAL.TaxPayers = New TMSDAL.TaxPayers
        taxpayers.Load(Session("connection"), phrase)
        tp.Text = labels.GetLabel(lang, "Taxpayers") & "(" & taxpayers.Count & ")"

        Dim i As Integer
        For Each txp As TMSDAL.TaxPayer In taxpayers
            i += 1
            tr = New TableRow
            AddCell(i & ".<A href='taxpayerdetails.aspx?id=" & txp.TaxPayerID & "'>" & txp.Names & "</A>", tr)
            tblTaxPayer.Rows.Add(tr)
            tblTaxPayer.Rows.Add(tr)
        Next


        Dim tblBusinesses As Table = New Table
        bs.Controls.Add(tblBusinesses)

        '//Show business results
        Dim buses As TMSDAL.Businesses = New TMSDAL.Businesses
        buses.Load(Session("connection"), phrase)
        bs.Text = labels.GetLabel(lang, "Businesses") & "(" & buses.Count & ")"

        i = 0
        For Each bus As TMSDAL.Business In buses
            i += 1
            tr = New TableRow
            AddCell(i & ".<A href='business.aspx?id=" & bus.BusinessID & "'>" & bus.BusinessName & "</A>", tr)
            tblBusinesses.Rows.Add(tr)
        Next

        '//Show land results
        Dim tblLand As Table = New Table
        lp.Controls.Add(tblLand)

        Dim landps As TMSDAL.LandParcels = New TMSDAL.LandParcels
        landps.Load(Session("connection"), phrase)
        lp.Text = labels.GetLabel(lang, "Land Parcels") & "(" & landps.Count & ")"

        i = 0
        For Each landp As TMSDAL.LandParcel In landps
            tr = New TableRow
            i += 1
            AddCell(i & ".<A href='landparcel.aspx?id=" & landp.LandParcelID & "'>" & landp.PlotNumber & "</A>", tr)
            tblLand.Rows.Add(tr)
        Next

        '//Show Tenant results
        Dim tblTenants As Table = New Table
        tn.Controls.Add(tblTenants)

        Dim tenants As TMSDAL.HouseTenants = New TMSDAL.HouseTenants
        tenants.Load(Session("connection"), phrase)
        tn.Text = labels.GetLabel(lang, "Tenants") & "(" & tenants.Count & ")"

        i = 0
        For Each tenant As TMSDAL.HouseTenant In tenants
            tr = New TableRow
            i += 1
            AddCell(i & ".<A href='tenant.aspx?id=" & tenant.HouseID & "'>" & tenant.FullName & "</A>", tr)
            tblTenants.Rows.Add(tr)
        Next

    End Sub

    Private Sub AddCell(ByVal text As String, ByVal row As TableRow)
        Dim tc As TableCell
        tc = New TableCell
        tc.Text = text
        row.Cells.Add(tc)
    End Sub

End Class
