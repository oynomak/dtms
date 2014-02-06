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

public partial class province : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        byte provinceid = Convert.ToByte(Request.QueryString["provid"]);
        TMSDAL.Province prov = new TMSDAL.Province();
        prov.Load(Session["connection"].ToString(), provinceid);

        LblHeader.Text = labels.GetLabel(lang, prov.ProvinceName);

        ShowDistricts(provinceid);

    }

    private void ShowDistricts(byte ProvID)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        TblDistricts.Width = new Unit("100%");

        TableRow tr;

        //Header
        tr = new TableRow();
        AddCell("District", tr);
        AddCell("", tr);
        AddCell("", tr);
        AddCell("", tr);


        tr.CssClass = "tableheader";
        TblDistricts.Rows.Add(tr);

        //Data

        TMSDAL.Districts districts = new TMSDAL.Districts();
        districts.Load(Session["connection"].ToString(), ProvID);

        foreach (TMSDAL.District dist in districts)
        {
            tr = new TableRow();
            AddCell(dist.DistrictName, tr);
            if (dist.NumberOfSectors > 0)
            {
                AddCell("<A href='sectors.aspx?DistrictID=" + dist.DistrictID + "'>Sectors(" + dist.NumberOfSectors.ToString() + ")</A>", tr);
                AddCell("<A href='Reports/ReportView.aspx?report=MinTaxpayerRegistry&DistrictID=" + dist.DistrictID + "' target='_blank'>" + labels.GetLabel(lang,"Taxpayer Registry") + "</A>", tr);
                AddCell("<A href='Reports/reportparameters.aspx?report=MinPaymentsByDistrict&DistrictID=" + dist.DistrictID + "' target='_blank'>" + labels.GetLabel(lang,"Tax Payments") + "</A>", tr);
            }
            else
            {
                AddCell(labels.GetLabel(lang,"No Sectors"), tr);
                AddCell(labels.GetLabel(lang,"No Taxpayers"), tr);
                AddCell(labels.GetLabel(lang,"No Tax payments"), tr);
            }
            TblDistricts.Rows.Add(tr);
        }

    }

    private void AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
    }
}
