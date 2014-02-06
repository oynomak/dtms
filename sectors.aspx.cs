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

public partial class sectors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        byte districtid = Convert.ToByte(Request.QueryString["districtid"]);
        TMSDAL.District dist = new TMSDAL.District();
        dist.Load(Session["connection"].ToString(), districtid);

        LblHeader.Text = dist.DistrictName;

        ShowSectors(districtid);

    }

    private void ShowSectors(byte DistID)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        TblSectors.Width = new Unit("100%");

        TableRow tr;

        //Header
        tr = new TableRow();
        AddCell(labels.GetLabel(lang,"Sector"), tr);
        AddCell("", tr);
        AddCell("", tr);


        tr.CssClass = "tableheader";
        TblSectors.Rows.Add(tr);

        //Data

        TMSDAL.Sectors Sectors = new TMSDAL.Sectors();
        Sectors.Load(Session["connection"].ToString(), DistID);

        foreach (TMSDAL.Sector sect in Sectors)
        {
            tr = new TableRow();
            AddCell(sect.SectorName, tr);
            if (sect.NumberOfCells > 0)
            {
                AddCell("<A href='Reports/ReportView.aspx?report=MinSectorTaxpayerRegistry&SectorID=" + sect.SectorID + "' target='_blank'>" + labels.GetLabel(lang,"Taxpayer Registry") + "</A>", tr);
                AddCell("<A href='Reports/reportparameters.aspx?report=MinPaymentsBySector&SectorID=" + sect.SectorID + "' target='_blank'>" + labels.GetLabel(lang,"Tax Payments") + "</A>", tr);
            }
            else
            {
                AddCell(labels.GetLabel(lang,"No Cells"), tr);
                AddCell(labels.GetLabel(lang,"No Taxpayers"), tr);
                AddCell(labels.GetLabel(lang,"No Tax payments"), tr);
            }
            TblSectors.Rows.Add(tr);
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
