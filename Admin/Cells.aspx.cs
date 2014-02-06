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

public partial class Cells : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Get the sector that these cells belong to
        short sectID = Convert.ToInt16(Request.QueryString["sectid"]);
        string action = Convert.ToString(Request.QueryString["action"]);

        HFSectorID.Value = sectID.ToString();

        TMSDAL.Sector sector = new TMSDAL.Sector();
        sector.Load(Convert.ToString(Session["connection"]), sectID);

        if (action == null) //just show cells
        {
            LblAddCell.Text = "Add a Cell to the '" + sector.SectorName + "' sector";
            BtnAddCell.Text = "Add a Cell";
            HFCellID.Value = 0.ToString();
        }
        else
        {
            TMSDAL.Cell cell = new TMSDAL.Cell();
            short cellID = Convert.ToInt16(Request.QueryString["cellid"]);
            cell.Load(Session["connection"].ToString(), cellID);
            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddCell.Text = "Rename Cell";
                    BtnAddCell.Text = "Rename Cell";
                    txtCellName.Text = cell.CellName;
                    HFCellID.Value = cell.CellID.ToString();
                }
            }
            if (action == "remove")
            {
                cell.Delete(Session["connection"].ToString());
                Response.Redirect("~/Admin/cells.aspx?sectid=" + HFSectorID.Value);
            }
        }

        LblCells.Text = "Cells in the '" + sector.SectorName + "' sector";
        ShowCells(sectID);

    }
    private void ShowCells(short sectID)
    {
        TblCells.Width = new Unit("100%");

        TableRow tr;

        //Header
        tr = new TableRow();
        AddCell("Cell", tr);
        AddCell("", tr);
        AddCell("", tr);
        
        tr.CssClass = "tableheader";
        TblCells.Rows.Add(tr);

        //Data

        TMSDAL.Cells cells = new TMSDAL.Cells();
        cells.Load(Session["connection"].ToString(), sectID);

        foreach (TMSDAL.Cell cell in cells)
        {
            tr = new TableRow();
            AddCell(cell.CellName, tr);
            AddCell("<A href='Cells.aspx?cellid=" + cell.CellID + "&action=edit&sectid=" + HFSectorID.Value + "'>Edit</A>", tr);
            AddCell("<A href='Cells.aspx?cellid=" + cell.CellID + "&action=remove&sectid=" + HFSectorID.Value + "'>Remove</A>", tr);
            TblCells.Rows.Add(tr);
        }

    }

    private void AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
    }

    protected void BtnAddCell_Click(object sender, EventArgs e)
    {
        TMSDAL.Cell cell = new TMSDAL.Cell();
        cell.CellID = Convert.ToInt16(HFCellID.Value);
        cell.CellName = txtCellName.Text;
        cell.SectorID = Convert.ToByte(HFSectorID.Value);
        cell.Save(Session["connection"].ToString());

        Response.Redirect("~/Admin/cells.aspx?sectid=" + HFSectorID.Value);
    }
}
