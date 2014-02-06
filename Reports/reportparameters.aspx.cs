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

public partial class Reports_reportparameters : System.Web.UI.Page
{
    private DateTime getNewYear()
    {
        return DateTime.Now.AddDays((-1*DateTime.Now.DayOfYear)+1) ;      
    
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DEStartDate.SelectedDate = getNewYear() ;
            DEEndDate.SelectedDate = DateTime.Now.Date;   
        }

        String reportfile = Request.QueryString["report"].ToString();
        string districtid = Convert.ToString(Request.QueryString["districtid"]);
        string sectorid = Convert.ToString(Request.QueryString["sectorid"]);
        string taxtypeid = Convert.ToString(Request.QueryString["taxtypeID"]);

        HFReportName.Value = reportfile;

        HFDistrictID.Value = districtid;
        HFSectorID.Value = sectorid;
        HFTaxTypeID.Value = taxtypeid;

        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        lblHeader.Text = labels.GetLabel(lang, "Report Parameters");
        LblEndDate.Text = labels.GetLabel(lang, "End Date");
        LblStartDate.Text = labels.GetLabel(lang, "Start Date");

        BtnViewReport.Text = labels.GetLabel(lang, "View Report");

    }
    protected void BtnViewReport_Click(object sender, EventArgs e)
    {
        string URL = GetURL();

        Response.Redirect(URL);

    }

    private string GetURL()
    {
        string startdate = DEStartDate.SelectedDate.ToShortDateString();
        string enddate = DEEndDate.SelectedDate.ToShortDateString();
        string URL = "#";

        if (HFTaxTypeID.Value.Length > 0)
        {
            URL = "~/Reports/Reportview.aspx?report=" + HFReportName.Value + "&startdate=" + startdate + "&enddate=" + enddate + "&taxtypeID=" + HFTaxTypeID.Value;
            return URL;
        }

        if (HFDistrictID.Value.Length > 0)
        {
            URL = "~/Reports/Reportview.aspx?report=" + HFReportName.Value + "&startdate=" + startdate + "&enddate=" + enddate + "&districtid=" + HFDistrictID.Value;
            return URL;
        }
        if (HFSectorID.Value.Length > 0)
        {
            URL = "~/Reports/Reportview.aspx?report=" + HFReportName.Value + "&startdate=" + startdate + "&enddate=" + enddate + "&SectorID=" + HFSectorID.Value;
            return URL;
        }

        if (HFDistrictID.Value.Length == 0 && HFSectorID.Value.Length == 0)
        {
            URL = "~/Reports/Reportview.aspx?report=" + HFReportName.Value + "&startdate=" + startdate + "&enddate=" + enddate;
            return URL;
        }

        return URL;
    }
}
