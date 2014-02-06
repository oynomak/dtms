
Partial Class reports
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim labels As Language.UserInterfaceLabels = Session("labels")
        Dim lang As String = Session("language")

        lblHeader.Text = labels.GetLabel(lang, "Reports")

        Todays.Text = labels.GetLabel(lang, "Today's Tax Payments")
        ThisMonth.Text = labels.GetLabel(lang, "This Month's Tax Payments")
        ThisYear.Text = labels.GetLabel(lang, "This Year's Tax Payments")
        Period.Text = labels.GetLabel(lang, "Tax payments for a specified period")
        TaxTypeSummary.Text = labels.GetLabel(lang, "Summary of Payments by Tax type")


        If Session("level") = "district" Then
            Todays.NavigateUrl = "Reports/ReportView.aspx?report=paymentsbyperiod&startdate=" & Now.ToShortDateString & "&enddate=" & Now.ToShortDateString
            Todays.Target = "_blank"

            ThisMonth.NavigateUrl = "Reports/ReportView.aspx?report=paymentsbyperiod&startdate=" & MonthStart() & "&enddate=" & MonthEnd()
            ThisMonth.Target = "_blank"

            ThisYear.NavigateUrl = "Reports/ReportView.aspx?report=paymentsbyperiod&startdate=" & YearStart() & "&enddate=" & YearEnd()
            ThisYear.Target = "_blank"

            TaxPayerRegistry.NavigateUrl = "Reports/ReportView.aspx?report=taxpayerregistry"
            TaxPayerRegistry.Target = "_blank"

            TaxpayerProfession.NavigateUrl = "Reports/ReportView.aspx?report=taxpayerprofession"
            TaxpayerProfession.Target = "_blank"

            Period.NavigateUrl = "~/Reports/reportparameters.aspx?report=paymentsbyperiod"
            Period.Target = "_blank"

            TaxTypeSummary.NavigateUrl = "~/Reports/reportparameters.aspx?report=paymentsbytaxtypesummary"
            TaxTypeSummary.Target = "_blank"

            SectorTaxTypeSummary.NavigateUrl = "~/Reports/reportparameters.aspx?report=paymentsbysectortaxtypesummary"
            SectorTaxTypeSummary.Target = "_blank"

            SectorSummary.NavigateUrl = "~/Reports/reportparameters.aspx?report=paymentsbysectorsummary"
            SectorSummary.Target = "_blank"

            SectorPayments.NavigateUrl = "~/Reports/reportparameters.aspx?report=paymentsbysector"
            SectorPayments.Target = "_blank"

            Defaulters.Text = labels.GetLabel(lang, "Defaulters by Sector and Cell")
            Defaulters.NavigateUrl = "~/Reports/ReportView.aspx?report=sectordefaulters"
            Defaulters.Target = "_blank"

        Else

            Todays.NavigateUrl = "Reports/ReportView.aspx?report=Minpaymentsbyperiod&startdate=" & Now.ToShortDateString & "&enddate=" & Now.ToShortDateString
            Todays.Target = "_blank"

            ThisMonth.NavigateUrl = "Reports/ReportView.aspx?report=Minpaymentsbyperiod&startdate=" & MonthStart() & "&enddate=" & MonthEnd()
            ThisMonth.Target = "_blank"

            ThisYear.NavigateUrl = "Reports/ReportView.aspx?report=Minpaymentsbyperiod&startdate=" & YearStart() & "&enddate=" & YearEnd()
            ThisYear.Target = "_blank"

            TaxPayerRegistry.Text = labels.GetLabel(lang, "Taxpayer Registry by District")
            TaxPayerRegistry.NavigateUrl = "Reports/DistrictReportparameter.aspx?report=Mintaxpayerregistry"
            TaxPayerRegistry.Target = "_blank"

            TaxpayerProfession.Text = labels.GetLabel(lang, "Taxpayer Registry By Profession By District")
            TaxpayerProfession.NavigateUrl = "Reports/DistrictReportparameter.aspx?report=Mintaxpayerprofession"
            TaxpayerProfession.Target = "_blank"

            Period.NavigateUrl = "~/Reports/reportparameters.aspx?report=Minpaymentsbyperiod"
            Period.Target = "_blank"

            TaxTypeSummary.NavigateUrl = "~/Reports/reportparameters.aspx?report=Minpaymentsbytaxtypesummary"
            TaxTypeSummary.Target = "_blank"

            SectorTaxTypeSummary.Text = labels.GetLabel(lang, "Summary of Tax Payments by District and Tax type")
            SectorTaxTypeSummary.NavigateUrl = "~/Reports/Reportparameters.aspx?report=MinpaymentsbyDistrictTaxtypesummary"
            SectorTaxTypeSummary.Target = "_blank"

            SectorSummary.Text = labels.GetLabel(lang, "Summary of Tax Payments by District")
            SectorSummary.NavigateUrl = "~/Reports/DistrictPeriodReportparameters.aspx?report=MinpaymentsbyDistrictSummary"
            SectorSummary.Target = "_blank"

            SectorPayments.Text = labels.GetLabel(lang, "Tax Payments By District For a specified period")
            SectorPayments.NavigateUrl = "~/Reports/DistrictPeriodReportparameters.aspx?report=MinpaymentsbyDistrict"
            SectorPayments.Target = "_blank"


            Defaulters.Text = labels.GetLabel(lang, "Defaulters by District")
            Defaulters.NavigateUrl = "Reports/DistrictReportparameter.aspx?report=mindefaulters"
            Defaulters.Target = "_blank"


        End If

    End Sub

    Private Function MonthStart() As String
        Dim dt As Date
        dt = Now.AddDays(-1 * (Now.Day - 1))
        Return dt.ToShortDateString
    End Function

    Private Function MonthEnd() As String
        Dim dt As Date
        dt = Now.AddDays(DateTime.DaysInMonth(Now.Year, Now.Month) - Now.Day)
        Return dt.ToShortDateString
    End Function

    Private Function YearStart() As String
        Dim dt As Date
        dt = DateTime.Parse("1/1/" & Now.Year.ToString)
        Return dt.ToShortDateString
    End Function

    Private Function YearEnd() As String
        Dim dt As Date
        dt = DateTime.Parse("12/31/" & Now.Year.ToString)
        Return dt.ToShortDateString
    End Function

End Class
