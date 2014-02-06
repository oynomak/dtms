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

public partial class Provinces : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Check to see whether we are adding,editing or deleting a province
        String action=Convert.ToString(Request.QueryString["action"]);
        if (action == null) //Adding here
        {
            LblAddProvince.Text = "Add a Province";
            BtnAddProvince.Text = "Add a Province";
            HFProvinceID.Value = Convert.ToString(0);                     
        }
        else
        {
            TMSDAL.Province currentProvince = new TMSDAL.Province();
            byte ProvID =Convert.ToByte (Request.QueryString["id"]);
            currentProvince.Load(Convert.ToString(Session["connection"]),ProvID);

            if (action=="edit") //editing here
            {
                if (!IsPostBack)
                {
                    LblAddProvince.Text = "Change Province Name";
                    BtnAddProvince.Text = "Change Province Name";
                    txtProvinceName.Text = currentProvince.ProvinceName;
                    HFProvinceID.Value = Convert.ToString(currentProvince.ProvinceID);
                }
            }
            if (action == "remove") //removing here
            {
                currentProvince.Delete(Convert.ToString(Session["connection"]) );
            }
            
        }
                
        LblProvinces.Text = "Provinces";
        //Show the existing provinces
        ShowProvinces();
        
    }

    private void ShowProvinces()
    {
        //Load the provinces from the database
        TMSDAL.Provinces provinces = new TMSDAL.Provinces();
        provinces.Load(Convert.ToString (Session["connection"]));

        TblProvinces.Width = new Unit("100%");

        TableRow tr;
       
        //Header
        tr = new TableRow();
        AddCell("Province", tr);
        AddCell("Districts", tr);
        AddCell("", tr);
        AddCell("", tr);
        AddCell("", tr);
        
        tr.CssClass = "tableheader";
        TblProvinces.Rows.Add(tr);  

        //Data
              
        foreach(TMSDAL.Province prov in provinces) 
        {   
            tr = new TableRow();
            AddCell(prov.ProvinceName , tr);
            AddCell(Convert.ToString(prov.NumberOfDistricts), tr);
            AddCell("<A href='provinces.aspx?id=" +  prov.ProvinceID  +"&action=edit'>Edit</A>", tr);
            AddCell("<A href='provinces.aspx?id=" + prov.ProvinceID + "&action=remove'>Remove</A>", tr);
            AddCell("<A href='districts.aspx?id=" + prov.ProvinceID + "'>View Districts</A>", tr);
            TblProvinces.Rows.Add(tr);
        }

    }

    private void AddCell(String text,TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        TMSDAL.Province province = new TMSDAL.Province();
        province.ProvinceName = txtProvinceName.Text;
        province.ProvinceID = Convert.ToByte(HFProvinceID.Value);
        province.Save(Convert.ToString(Session["connection"]));

        Response.Redirect("~/Admin/Provinces.aspx");

    }
}
