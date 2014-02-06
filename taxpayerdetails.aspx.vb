
Partial Class taxpayerdetails
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")
        '//Load and display taxpayer data
        Dim taxpayerID As Integer

        If Request.QueryString("id") IsNot Nothing And Request.QueryString("id").Length > 0 Then

            taxpayerID = Request.QueryString("id")
            Dim payer As TMSDAL.TaxPayer = New TMSDAL.TaxPayer

            payer.Load(Session("connection"), taxpayerID)

            ShowTaxPayer(payer)
            ShowBanks(taxpayerID)
            ShowLandParcels(taxpayerID)
            ShowBusinesses(taxpayerID)
            ShowTenants(taxpayerID)
            ShowProperties(taxpayerID)
        End If

        If Session("level") = "district" Then
            HLEditTaxpayer.NavigateUrl = "~/taxpayer.aspx?id=" & taxpayerID
            HLDeleteTaxPayer.NavigateUrl = "~/deletetaxpayer.aspx?id=" & taxpayerID
            HLDeleteTaxPayer.Text = "[" & labels.GetLabel(lang, "Delete Taxpayer") & "]"
            HLEditTaxpayer.Text = "[" & labels.GetLabel(lang, "Edit Taxpayer details") & "]"
            HLEditBanks.NavigateUrl = "~/taxpayerbankdetails.aspx?tid=" & taxpayerID
            HLEditBanks.Text = labels.GetLabel(lang, "Edit Bank details")
            HLEditBusinesses.NavigateUrl = "~/taxpayerbusinesses.aspx?tid=" & taxpayerID
            HLEditBusinesses.Text = labels.GetLabel(lang, "Edit Businesses")
            HLEditLandParcels.NavigateUrl = "~/taxpayerlanddetails.aspx?tid=" & taxpayerID
            HLEditLandParcels.Text = labels.GetLabel(lang, "Edit Land Parcels")
            HLEditProperties.NavigateUrl = "~/taxpayerproperties.aspx?tid=" & taxpayerID
            HLEditProperties.Text = labels.GetLabel(lang, "Edit Properties")
            HLEditTenants.NavigateUrl = "~/taxpayertenants.aspx?tid=" & taxpayerID
            HLEditTenants.Text = labels.GetLabel(lang, "Edit Tenants")
        Else
            HLEditTaxpayer.Visible = False
            HLDeleteTaxPayer.Visible = False
            HLEditBanks.Visible = False
            HLEditBusinesses.Visible = False
            HLEditLandParcels.Visible = False
            HLEditProperties.Visible = False
            HLEditTenants.Visible = False
        End If
    End Sub

    Private Sub ShowProperties(ByVal taxpayerID As Integer)
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        LblProperties.Text = labels.GetLabel(lang, "Properties")

        '//Load the bank propertys for the taxpayer

        Dim properties As TMSDAL.Properties = New TMSDAL.Properties()
        properties.Load(Session("connection").ToString(), taxpayerID)

        If properties.Count > 0 Then
            Dim tr As TableRow = New TableRow()

            TblProperties.Width = New Unit("100%")

            AddCell(labels.GetLabel(lang, "Use"), tr)
            AddCell(labels.GetLabel(lang, "Owner's Name"), tr)
            AddCell(labels.GetLabel(lang, "Date of Acquisition"), tr)
            AddCell(labels.GetLabel(lang, "Property Value - Owner"), tr)
            AddCell(labels.GetLabel(lang, "Property Value - District"), tr)
            AddCell(labels.GetLabel(lang, "Plot No."), tr)

            tr.CssClass = "tableheader"

            TblProperties.Rows.Add(tr)


            For Each prop As TMSDAL.Property In properties

                tr = New TableRow()

                AddCell(prop.Usage, tr)
                AddCell(prop.OwnersName, tr)
                AddCell(prop.DateOfAcquisition.ToShortDateString(), tr)
                AddCell(prop.OwnerValuation.ToString("####,###"), tr)
                AddCell(prop.DistrictValuation.ToString("####,###"), tr)
                AddCell(prop.PlotNumber, tr)

                TblProperties.Rows.Add(tr)

            Next
        Else
            TaxPayerProperties.Visible = False
        End If
    End Sub

    Private Sub ShowTenants(ByVal taxpayerID As Integer)
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        LblTenants.Text = labels.GetLabel(lang, "Tenants")
        '//Load the bank tenants for the taxpayer

        Dim tenants As TMSDAL.HouseTenants = New TMSDAL.HouseTenants()
        tenants.Load(Session("connection").ToString(), taxpayerID)

        If tenants.Count > 0 Then
            Dim tr As TableRow = New TableRow()
            Dim tc As TableCell
            TblTenants.Width = New Unit("100%")
            AddCell(labels.GetLabel(lang, "Plot No."), tr)
            AddCell(labels.GetLabel(lang, "Tenant's Full Name"), tr)
            AddCell(labels.GetLabel(lang, "Telephone"), tr)
            AddCell(labels.GetLabel(lang, "Address"), tr)
            tc = AddCell(labels.GetLabel(lang, "Amount"), tr)
            tc.HorizontalAlign = HorizontalAlign.Right

            tr.CssClass = "tableheader"

            TblTenants.Rows.Add(tr)


            For Each ten As TMSDAL.HouseTenant In tenants

                tr = New TableRow()
                AddCell(ten.PlotNumber, tr)
                AddCell(ten.FullName, tr)
                AddCell(ten.Telephone, tr)
                AddCell(ten.Address, tr)
                tc = AddCell(ten.Amount.ToString("####,###"), tr)
                tc.HorizontalAlign = HorizontalAlign.Right
                TblTenants.Rows.Add(tr)
            Next

            tr = New TableRow()

            tc = AddCell("Annual Rental Tax", tr)
            tc.ColumnSpan = 4
            tc.HorizontalAlign = HorizontalAlign.Right
            Dim rtax As String
            If Session("level") = "district" Then
                rtax = tenants.GetRentalTax(Session("connection").ToString(), taxpayerID).ToString()
                rtax = FormatNumber(rtax, 0, TriState.UseDefault, TriState.UseDefault, TriState.True)
                tc = AddCell(rtax, tr)
            ElseIf Session("level") = "ministry" Then
                Dim p As TMSDAL.TaxPayer = New TMSDAL.TaxPayer
                p.Load(Session("connection"), taxpayerID)
                rtax = tenants.GetRentalTax(Session("connection"), taxpayerID, p.CellID).ToString()
                rtax = FormatNumber(rtax, 0, TriState.UseDefault, TriState.UseDefault, TriState.True)
                tc = AddCell(rtax, tr)
            End If
            tc.HorizontalAlign = HorizontalAlign.Right
            TblTenants.Rows.Add(tr)
            tr.CssClass = "tablefooter"

        Else
            HouseTenants.Visible = False
        End If

    End Sub

    Private Sub ShowBusinesses(ByVal taxpayerID As Integer)
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        LblBusinesses.Text = labels.GetLabel(lang, "Businesses")

        '//Load the bank businesss for the taxpayer

        Dim businesss As TMSDAL.Businesses = New TMSDAL.Businesses()
        businesss.Load(Session("connection").ToString(), taxpayerID)

        If businesss.Count > 0 Then
            Dim tr As TableRow = New TableRow()

            TblBusinesses.Width = New Unit("100%")

            AddCell(labels.GetLabel(lang, "Profession"), tr)
            AddCell(labels.GetLabel(lang, "Business Name"), tr)
            AddCell(labels.GetLabel(lang, "Start Date"), tr)
            AddCell(labels.GetLabel(lang, "Amount"), tr)
            AddCell(labels.GetLabel(lang, "Address"), tr)
            AddCell(labels.GetLabel(lang, "Plot No."), tr)

            tr.CssClass = "tableheader"

            TblBusinesses.Rows.Add(tr)


            For Each parc As TMSDAL.Business In businesss

                tr = New TableRow()

                AddCell(parc.Profession, tr)
                AddCell(parc.BusinessName, tr)
                AddCell(parc.StartDate.ToShortDateString(), tr)
                AddCell(parc.Amount.ToString("####,###"), tr)
                AddCell(parc.Address, tr)
                AddCell(parc.PlotNumber, tr)

                TblBusinesses.Rows.Add(tr)

            Next
        Else
            Businesses.Visible = False
        End If

    End Sub

    Private Sub ShowTaxPayer(ByVal payer As TMSDAL.TaxPayer)
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        LblTaxPayerDetails.Text = labels.GetLabel(lang, "Taxpayer Details")

        LblAddressData.Text = payer.Address
        lblAddress.Text = labels.GetLabel(lang, "Address")

        LblCellData.Text = payer.Cell
        lblCellID.Text = labels.GetLabel(lang, "Cell")
        lblDOBData.Text = payer.DateOfBirth.ToLongDateString
        lblDOB.Text = labels.GetLabel(lang, "Date of Birth")
        lblEmailData.Text = payer.Email
        lblEmail.Text = labels.GetLabel(lang, "E-mail")
        LblFileNumberData.Text = payer.FileNumber
        lblFileNumber.Text = labels.GetLabel(lang, "File Number")
        lblIDNumberData.Text = payer.IDNumber
        lblIDNumber.Text = labels.GetLabel(lang, "ID No.")
        lblIDTypeData.Text = payer.IDType
        lblIDType.Text = labels.GetLabel(lang, "Identification Type")
        lblMobileData.Text = payer.Mobile
        lblMobile.Text = labels.GetLabel(lang, "Mobile")
        LblNamesData.Text = payer.Names
        LblNames.Text = labels.GetLabel(lang, "Name")
        lblProffessionData.Text = payer.Profession
        lblProffession.Text = labels.GetLabel(lang, "Profession")
        LblSectorData.Text = payer.Sector
        LblSector.Text = labels.GetLabel(lang, "Sector")
        lblTelephoneData.Text = payer.Telephone
        lblTelephone.Text = labels.GetLabel(lang, "Telephone")
        lblTinData.Text = payer.TIN
        lblTin.Text = labels.GetLabel(lang, "TIN")

    End Sub

    Private Sub ShowBanks(ByVal taxpayerID As Integer)
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        LblBanks.Text = labels.GetLabel(lang, "Bank Accounts")
        '//Load the bank accounts for the taxpayer

        Dim accounts As TMSDAL.BankAccounts = New TMSDAL.BankAccounts
        accounts.Load(Session("connection").ToString(), taxpayerID)

        If accounts.Count > 0 Then
            Dim tr As TableRow = New TableRow()

            TblBanks.Width = New Unit("100%")

            AddCell(labels.GetLabel(lang, "Bank"), tr)
            AddCell(labels.GetLabel(lang, "Branch"), tr)
            AddCell(labels.GetLabel(lang, "Account No."), tr)

            tr.CssClass = "tableheader"

            TblBanks.Rows.Add(tr)

            Dim bankname As String
            Dim branchname As String

            For Each acc As TMSDAL.BankAccount In accounts

                tr = New TableRow()
                bankname = acc.BranchName.Split("-".ToCharArray()).GetValue(0).ToString()
                branchname = acc.BranchName.Split("-".ToCharArray()).GetValue(1).ToString()

                AddCell(bankname, tr)
                AddCell(branchname, tr)
                AddCell(acc.AccountNumber, tr)

                TblBanks.Rows.Add(tr)

            Next
        Else
            BankAccounts.Visible = False
        End If


    End Sub

    Private Sub ShowLandParcels(ByVal taxpayerID As Integer)
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        lblLandParcels.Text = labels.GetLabel(lang, "Land Parcels")
        '//Load the bank parcels for the taxpayer

        Dim parcels As TMSDAL.LandParcels = New TMSDAL.LandParcels
        parcels.Load(Session("connection").ToString(), taxpayerID)

        If parcels.Count > 0 Then
            Dim tr As TableRow = New TableRow()

            TblLandParcels.Width = New Unit("100%")

            AddCell(labels.GetLabel(lang, "Plot No."), tr)
            AddCell(labels.GetLabel(lang, "Year"), tr)
            AddCell(labels.GetLabel(lang, "Standing Level"), tr)
            AddCell(labels.GetLabel(lang, "Land Title"), tr)
            AddCell(labels.GetLabel(lang, "Title No."), tr)
            AddCell(labels.GetLabel(lang, "Usage"), tr)
            AddCell("#" & labels.GetLabel(lang, "Houses"), tr)
            AddCell(labels.GetLabel(lang, "Contract No."), tr)
            AddCell(labels.GetLabel(lang, "Contract Date"), tr)

            tr.CssClass = "tableheader"

            TblLandParcels.Rows.Add(tr)


            For Each parc As TMSDAL.LandParcel In parcels

                tr = New TableRow()

                AddCell(parc.PlotNumber, tr)
                AddCell(parc.Year.ToString(), tr)
                AddCell(parc.StandingLevel, tr)
                AddCell(parc.LandTitle, tr)
                AddCell(parc.TitleNumber, tr)
                AddCell(parc.Usage, tr)
                AddCell(parc.NumberOfHouses.ToString(), tr)
                AddCell(parc.ContractNumber, tr)
                AddCell(parc.ContractDate.ToShortDateString(), tr)

                TblLandParcels.Rows.Add(tr)
            Next
        Else
            LandParcels.Visible = False
        End If
    End Sub

    Private Function AddCell(ByVal text As String, ByVal row As TableRow) As TableCell
        Dim tc As TableCell
        tc = New TableCell
        tc.Text = text
        row.Cells.Add(tc)
        Return tc
    End Function
End Class
