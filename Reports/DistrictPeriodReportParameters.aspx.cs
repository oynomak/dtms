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

public partial class Reports_DistrictPeriodReportParameters : System.Web.UI.Page
{

    private DateTime getNewYear()
    {
        return DateTime.Now.AddDays((-1 * DateTime.Now.DayOfYear) + 1);

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DEStartDate.SelectedDate = getNewYear();
            DEEndDate.SelectedDate = DateTime.Now.Date;        
        }

        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        String reportfile = Request.QueryString["report"].ToString();

        HFReportName.Value = reportfile;

        lblHeader.Text =labels.GetLabel(lang, "Report Parameters");
        LblEndDate.Text =labels.GetLabel(lang, "End Date");
        LblStartDate.Text = labels.GetLabel(lang,"Start Date");

        //Load districts

        TMSDAL.Districts districts = new TMSDAL.Districts();
        districts.Load(Session["connection"].ToString(), 0);

        ListItem li = new ListItem(labels.GetLabel(lang,"Select District"), "0");
        DDLDistricts.Items.Add(li);

        foreach (TMSDAL.District dist in districts)
        {
            li = new ListItem(dist.DistrictName, dist.DistrictID.ToString());
            DDLDistricts.Items.Add(li);
        }


        BtnViewReport.Text = labels.GetLabel(lang,"View Report");
    }

    protected void BtnViewReport_Click(object sender, EventArgs e)
    {

        string startdate = DEStartDate.SelectedDate.ToShortDateString();
        string enddate = DEEndDate.SelectedDate.ToShortDateString();
        int DistrictID = Convert.ToInt32(DDLDistricts.SelectedItem.Value);

        string URL = "~/Reports/Reportview.aspx?report=" + HFReportName.Value + "&startdate=" + startdate + "&enddate=" + enddate + "&DistrictID=" + DistrictID;

        Response.Redirect(URL);

    }
}
