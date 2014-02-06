using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        LblReports.Text = labels.GetLabel(lang,"Quick Reports");
        HLTaxpaymentsThisMonth.Text = labels.GetLabel(lang, "Tax Payments this month"); 


        if (Session["levelname"].ToString() == "MINALOC")
        {
            PaymentsHeader.Visible = false;
            PaymentsBox.Visible = false;
            TaxpayersBox.Visible = false;
            TaxpayersHeader.Visible = false;

            LblDistrictData.Text =labels.GetLabel(lang, "District Data");

            //MINALOC Reports
            HLTaxpaymentsThisMonth.NavigateUrl = "~/Reports/Reportview.aspx?report=MinPaymentsByPeriod&startdate=" + MonthStart() + "&enddate=" + MonthEnd();
            HLTaxpaymentsThisMonth.Target = "_blank";

            HLTaxPayersBySector.Text = labels.GetLabel(lang,"Taxpayer Registry By District");
            HLTaxPayersBySector.NavigateUrl = "~/Reports/DistrictReportparameter.aspx?report=Mintaxpayerregistry";
            HLTaxPayersBySector.Target = "_blank";
        }
        else
        {
            DataHeader.Visible = false;
            DataBox.Visible = false;

            HLNewPayment.Text = labels.GetLabel(lang,"Post a New Payment");
            HLNewFeePayment.Text =labels.GetLabel(lang, "Post a New Fee Payment");

            HLNewTaxPayer.Text = labels.GetLabel(lang,"Register a New TaxPayer");
            HLTaxPayerDetails.Text =labels.GetLabel(lang, "View TaxPayer Details"); 

            LblPayments.Text = labels.GetLabel(lang,"Tax Payments");
            LblTaxpayers.Text = labels.GetLabel(lang,"Taxpayers");

            //District Reports
            
            HLTaxpaymentsThisMonth.NavigateUrl = "~/Reports/Reportview.aspx?report=PaymentsByPeriod&startdate=" + MonthStart() + "&enddate=" + MonthEnd();
            HLTaxpaymentsThisMonth.Target = "_blank";

            HLTaxPayersBySector.Text =labels.GetLabel(lang, "Taxpayers By Sector and Cell"); 
            HLTaxPayersBySector.NavigateUrl = "~/Reports/Reportview.aspx?report=taxpayerregistry";
            HLTaxPayersBySector.Target = "_blank";


        }

        HLMore.NavigateUrl = "~/Reports.aspx";
        HLMore.Text = labels.GetLabel(lang, "More") + "...";

    }

    private string MonthStart()
    {
        DateTime dt;

        dt = DateTime.Now.AddDays(-1 * (DateTime.Now.Day - 1));
        return dt.ToShortDateString();
    }

    private string MonthEnd()
    {
        DateTime dt;
        dt = DateTime.Now.AddDays(DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month) - DateTime.Now.Day);
        return dt.ToShortDateString();
    }

}

