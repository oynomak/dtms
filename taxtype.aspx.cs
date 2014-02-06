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

public partial class taxtype : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();


        byte taxtypeID = Convert.ToByte(Request.QueryString["id"]);

        TMSDAL.TaxType taxtype = new TMSDAL.TaxType();
        taxtype.Load(Session["connection"].ToString(), taxtypeID);

        LblHeader.Text = labels.GetLabel(lang,"Tax Type") + ": " + taxtype.TaxTypeName;

        if (Session["level"].ToString() == "district")
        {
            TodayPayments.NavigateUrl = "Reports/ReportView.aspx?report=paymentsbytype&taxtype=" + taxtypeID.ToString() + "&startdate=" + DateTime.Now.ToShortDateString() + "&enddate=" + DateTime.Now.ToShortDateString();
            TodayPayments.Text = labels.GetLabel(lang,"Today");
            TodayPayments.Target = "_blank";

            Statistics stats = new Statistics();

            HLThisWeekPayments.NavigateUrl = "Reports/ReportView.aspx?report=paymentsbytype&taxtype=" + taxtypeID.ToString() + "&startdate=" + stats.WeekStart() + "&enddate=" + stats.WeekEnd();
            HLThisWeekPayments.Text =labels.GetLabel(lang, "This Week");
            HLThisWeekPayments.Target = "_blank";

            HLThisMonthPayments.NavigateUrl = "Reports/ReportView.aspx?report=paymentsbytype&taxtype=" + taxtypeID.ToString() + "&startdate=" + stats.MonthStart() + "&enddate=" + stats.MonthEnd();
            HLThisMonthPayments.Text =labels.GetLabel(lang, "This Month");
            HLThisMonthPayments.Target = "_blank";


            HLThisYearPayments.NavigateUrl = "Reports/ReportView.aspx?report=paymentsbytype&taxtype=" + taxtypeID.ToString() + "&startdate=" + stats.YearStart() + "&enddate=" + stats.YearEnd();
            HLThisYearPayments.Text =labels.GetLabel(lang, "This Year");
            HLThisYearPayments.Target = "_blank";

            HLSpecifyPeriod.NavigateUrl = "Reports/Reportparameters.aspx?report=paymentsbytype&taxtype=" + taxtypeID.ToString();
            HLSpecifyPeriod.Text = labels.GetLabel(lang,"Specify Period") + "....";
            HLSpecifyPeriod.Target = "_blank";
        }
        else
        {
            TodayPayments.NavigateUrl = "Reports/ReportView.aspx?report=Minpaymentsbytype&taxtypeID=" + taxtypeID.ToString() + "&startdate=" + DateTime.Now.ToShortDateString() + "&enddate=" + DateTime.Now.ToShortDateString();
            TodayPayments.Text =labels.GetLabel(lang, "Today");
            TodayPayments.Target = "_blank";

            Statistics stats = new Statistics();

            HLThisWeekPayments.NavigateUrl = "Reports/ReportView.aspx?report=Minpaymentsbytype&taxtypeID=" + taxtypeID.ToString() + "&startdate=" + stats.WeekStart() + "&enddate=" + stats.WeekEnd();
            HLThisWeekPayments.Text = labels.GetLabel(lang,"This Week");
            HLThisWeekPayments.Target = "_blank";

            HLThisMonthPayments.NavigateUrl = "Reports/ReportView.aspx?report=Minpaymentsbytype&taxtypeID=" + taxtypeID.ToString() + "&startdate=" + stats.MonthStart() + "&enddate=" + stats.MonthEnd();
            HLThisMonthPayments.Text = labels.GetLabel(lang,"This Month");
            HLThisMonthPayments.Target = "_blank";


            HLThisYearPayments.NavigateUrl = "Reports/ReportView.aspx?report=Minpaymentsbytype&taxtypeID=" + taxtypeID.ToString() + "&startdate=" + stats.YearStart() + "&enddate=" + stats.YearEnd();
            HLThisYearPayments.Text =labels.GetLabel(lang, "This Year");
            HLThisYearPayments.Target = "_blank";

            HLSpecifyPeriod.NavigateUrl = "Reports/Reportparameters.aspx?report=Minpaymentsbytype&taxtypeID=" + taxtypeID.ToString();
            HLSpecifyPeriod.Text = labels.GetLabel(lang,"Specify Period") + "....";
            HLSpecifyPeriod.Target = "_blank";
        }
    }
}
