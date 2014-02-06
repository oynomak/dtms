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

public partial class Districts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Get the province that these districts belong to
        byte ProvID=Convert.ToByte (Request.QueryString["id"]);
        string action = Convert.ToString(Request.QueryString["action"]);
 
        HFProvinceID.Value = ProvID.ToString(); 

        TMSDAL.Province province = new TMSDAL.Province();
        province.Load (Convert.ToString (Session["connection"]),ProvID );

        if (action == null) //just show districts
        {
            LblAddDistrict.Text = "Add a district to the '" + province.ProvinceName + "' province";
            BtnAddDistrict.Text = "Add a District";
            HFDistrictID.Value = "0";
        }
        else 
        {
            TMSDAL.District dist=new TMSDAL.District(); 
            short distID=Convert.ToInt16 (Request.QueryString["distid"]);  
            dist.Load (Session["connection"].ToString() ,distID);
            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddDistrict.Text = "Rename District";
                    BtnAddDistrict.Text = "Rename District";
                    txtDistrictName.Text =dist.DistrictName ;
                    HFDistrictID.Value =dist.DistrictID.ToString()   ; 
                }
            }
            if (action == "remove")
            {
                dist.Delete(Session["connection"].ToString());
                Response.Redirect("~/Admin/Districts.aspx?id=" + HFProvinceID.Value);
            }
        }

        LblDisticts.Text = "Districts in the '" + province.ProvinceName + "' province";
        ShowDistricts(ProvID);

    }
    private void ShowDistricts(byte ProvID)
    {
        TblProvinces.Width = new Unit("100%");

        TableRow tr;
     
        //Header
        tr = new TableRow();
        AddCell("District", tr);
        AddCell("Sectors", tr);
        AddCell("", tr);
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";
        TblProvinces.Rows.Add(tr);

        //Data

        TMSDAL.Districts  districts = new TMSDAL.Districts ();
        districts.Load(Session["connection"].ToString(),ProvID);  

        foreach (TMSDAL.District  dist in districts )
        {
            tr = new TableRow();
            AddCell(dist.DistrictName, tr);
            AddCell(dist.NumberOfSectors.ToString(), tr);
            AddCell("<A href='Districts.aspx?distid=" + dist.DistrictID  + "&action=edit&id=" + HFProvinceID.Value + "'>Edit</A>", tr);
            AddCell("<A href='Districts.aspx?distid=" + dist.DistrictID + "&action=remove&id=" + HFProvinceID.Value + "'>Remove</A>", tr);
            AddCell("<A href='sectors.aspx?distid=" + dist.DistrictID + "'>View Sectors</A>", tr);
            TblProvinces.Rows.Add(tr);
        }

    }

    private void AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
    }

    protected void BtnAddDistrict_Click(object sender, EventArgs e)
    {
        TMSDAL.District dist = new TMSDAL.District();
        dist.DistrictID = Convert.ToInt16 (HFDistrictID.Value);
        dist.DistrictName = txtDistrictName.Text;
        dist.ProvinceID = Convert.ToByte (HFProvinceID.Value);
        dist.Save(Session["connection"].ToString());

        Response.Redirect("~/Admin/Districts.aspx?id=" + HFProvinceID.Value); 
    }
}
