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

public partial class Sectors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Get the district that these sectors belong to
        short  distID = Convert.ToInt16(Request.QueryString["distid"]);
        string action = Convert.ToString(Request.QueryString["action"]);

        HFDistrictID.Value = distID.ToString();

        TMSDAL.District district = new TMSDAL.District();
        district.Load(Convert.ToString(Session["connection"]), distID);

        if (action == null) //just show sectors
        {
            LblAddSector.Text = "Add a Sector to the '" + district.DistrictName + "' district";
            BtnAddSector.Text = "Add a Sector";
            HFSectorID.Value = 0.ToString();
        }
        else
        {
            TMSDAL.Sector sect = new TMSDAL.Sector ();
            short sectID = Convert.ToInt16(Request.QueryString["sectid"]);
            sect.Load(Session["connection"].ToString(), sectID);
            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddSector.Text = "Rename Sector";
                    BtnAddSector.Text = "Rename Sector";
                    txtSectorName.Text = sect.SectorName ;
                    HFSectorID.Value = sect.SectorID.ToString();
                }
            }
            if (action == "remove")
            {
                sect.Delete(Session["connection"].ToString());
                Response.Redirect("~/Admin/Sectors.aspx?distid=" + HFDistrictID.Value);
            }
        }

        LblSectors.Text = "Sectors in the '" + district.DistrictName + "' district";
        ShowSectors(distID);

    }
    private void ShowSectors(short  distID)
    {
        TblSector.Width = new Unit("100%");

        TableRow tr;

        //Header
        tr = new TableRow();
        AddCell("Sector", tr);
        AddCell("Cells", tr);
        AddCell("", tr);
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";
        TblSector.Rows.Add(tr);

        //Data

        TMSDAL.Sectors sectors = new TMSDAL.Sectors();
        sectors.Load(Session["connection"].ToString(), distID );

        foreach (TMSDAL.Sector sect in sectors)
        {
            tr = new TableRow();
            AddCell(sect.SectorName , tr);
            AddCell(sect.NumberOfCells.ToString(), tr);
            AddCell("<A href='Sectors.aspx?sectid=" + sect.SectorID  + "&action=edit&distid=" + HFDistrictID.Value + "'>Edit</A>", tr);
            AddCell("<A href='Sectors.aspx?sectid=" + sect.SectorID + "&action=remove&distid=" + HFDistrictID.Value + "'>Remove</A>", tr);
            AddCell("<A href='cells.aspx?sectid=" + sect.SectorID + "'>View Cells</A>", tr);
            TblSector.Rows.Add(tr);
        }

    }

    private void AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
    }

    protected void BtnAddSector_Click(object sender, EventArgs e)
    {
        TMSDAL.Sector sect = new TMSDAL.Sector();
        sect.SectorID  = Convert.ToInt16(HFSectorID.Value);
        sect.SectorName = txtSectorName.Text;
        sect.DistrictID = Convert.ToByte(HFDistrictID.Value);
        sect.Save(Session["connection"].ToString());

        Response.Redirect("~/Admin/sectors.aspx?distid=" + HFDistrictID.Value);
    }
}
