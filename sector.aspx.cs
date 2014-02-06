using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class sector : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        taxpayments.InnerText = labels.GetLabel(lang,"Tax Payments");
        feepayments.InnerText = labels.GetLabel(lang,"Fee Payments");

        short sectorid = Convert.ToInt16(Request.QueryString["sectid"]);
        TMSDAL.Sector sector = new TMSDAL.Sector();
        sector.Load(Session["connection"].ToString(), sectorid);

        string sectorname = sector.SectorName;

        LblHeader.Text = labels.GetLabel(lang,"Sector") + ": " + sectorname.ToUpper();

        Registry.Text = labels.GetLabel(lang,"Tax Payer Registry");
        Registry.NavigateUrl = "Reports/ReportView.aspx?report=sectortaxpayerregistry&sectid=" + sectorid;
        Registry.Target = "_blank";

        TaxToday.Text = labels.GetLabel(lang,"Today");
        TaxToday.NavigateUrl = "Reports/ReportView.aspx?report=sectorpayments&sectid=" + sectorid + "&startdate=" + DateTime.Now.ToShortDateString() + "&enddate=" + DateTime.Now.ToShortDateString();
        TaxToday.Target = "_blank";

        Statistics dates = new Statistics();

        TaxThisWeek.Text = labels.GetLabel(lang,"This Week");
        TaxThisWeek.NavigateUrl = "Reports/ReportView.aspx?report=sectorpayments&sectid=" + sectorid + "&startdate=" + dates.WeekStart() + "&enddate=" + dates.WeekEnd();
        TaxThisWeek.Target = "_blank";

        TaxThisMonth.Text = labels.GetLabel(lang,"This Month"); 
        TaxThisMonth.NavigateUrl = "Reports/ReportView.aspx?report=sectorpayments&sectid=" + sectorid + "&startdate=" + dates.MonthStart() + "&enddate=" + dates.MonthEnd();
        TaxThisMonth.Target = "_blank";

        TaxThisYear.Text = labels.GetLabel(lang,"This Year");
        TaxThisYear.NavigateUrl = "Reports/ReportView.aspx?report=sectorpayments&sectid=" + sectorid + "&startdate=" + dates.YearStart() + "&enddate=" + dates.YearEnd();
        TaxThisYear.Target = "_blank";

        //Fees
        FeesToday.Text = labels.GetLabel(lang,"Today");
        FeesToday.NavigateUrl = "Reports/ReportView.aspx?report=feepaymentsbyPeriod&sectid=" + sectorid + "&startdate=" + DateTime.Now.ToShortDateString() + "&enddate=" + DateTime.Now.ToShortDateString();
        FeesToday.Target = "_blank";

        FeesThisWeek.Text=labels.GetLabel(lang,"This Week") ;
        FeesThisWeek.NavigateUrl = "Reports/ReportView.aspx?report=feepaymentsbyPeriod&sectid=" + sectorid + "&startdate=" + dates.WeekStart() + "&enddate=" + dates.WeekEnd();
        FeesThisWeek.Target = "_blank";

        FeesThisMonth.Text =labels.GetLabel(lang, "This Month");
        FeesThisMonth.NavigateUrl = "Reports/ReportView.aspx?report=feepaymentsbyPeriod&sectid=" + sectorid + "&startdate=" + dates.MonthStart() + "&enddate=" + dates.MonthEnd();
        FeesThisMonth.Target = "_blank";

        FeesThisYear.Text = labels.GetLabel(lang,"This Year"); 
        FeesThisYear.NavigateUrl = "Reports/ReportView.aspx?report=feepaymentsbyPeriod&sectid=" + sectorid + "&startdate=" + dates.YearStart() + "&enddate=" + dates.YearEnd();
        FeesThisYear.Target = "_blank";


    }
}
