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


public partial class TaxPayer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        if (Request.QueryString["id"] == null)
        {
            HFTaxPayerID.Value = "0";
        }
        else
        {
            HFTaxPayerID.Value = Convert.ToString(Request.QueryString["id"]);
        }


        if (Session["level"].ToString() == "ministry")
        {
            Response.Redirect("~/taxpayerdetails.aspx?id=" + Convert.ToString(HFTaxPayerID.Value));
        }

        lblAddress.Text = labels.GetLabel(lang, "Address");
        lblCellID.Text = labels.GetLabel(lang,"Cell");
        lblDOB.Text = labels.GetLabel(lang,"Date of Birth");
        lblEmail.Text = labels.GetLabel(lang,"E-mail");
        lblFileNumber.Text = labels.GetLabel(lang,"File Number");
        lblIDNumber.Text = labels.GetLabel(lang,"ID No.");
        lblIDType.Text = labels.GetLabel(lang,"Identification Type");
        lblMobile.Text = labels.GetLabel(lang,"Mobile");
        LblNames.Text = labels.GetLabel(lang,"Name");
        lblProffession.Text = labels.GetLabel(lang,"Profession");
        LblSector.Text = labels.GetLabel(lang,"Sector");
        lblTelephone.Text = labels.GetLabel(lang,"Telephone");
        lblTin.Text = labels.GetLabel(lang,"TIN");
        BtnSave.Text = " " + labels.GetLabel(lang, "Save") + " ";
        BtnCancel.Text = labels.GetLabel(lang, "Cancel");

        lblHeader.Text = labels.GetLabel(lang,"Taxpayer Details");

        if (IsPostBack == false)
        {
            //Load Sectors for the current district
            TMSDAL.Sectors sects = new TMSDAL.Sectors();
            sects.Load(Session["connection"].ToString(), Convert.ToInt16(Session["districtid"]));

            ListItem li;

            li = new ListItem("Select a Sector", "0");
            DDLSector.Items.Add(li);

            foreach (TMSDAL.Sector sect in sects)
            {
                if (sect.NumberOfCells > 0)
                {
                    li = new ListItem(sect.SectorName, sect.SectorID.ToString());
                    DDLSector.Items.Add(li);
                }
            }

            li = new ListItem("Unknown", "Unknown");
            DDLIDType.Items.Add(li);

            li = new ListItem("Identity Card", "Identity Card");
            DDLIDType.Items.Add(li);
            li = new ListItem("Passport", "Passport");
            DDLIDType.Items.Add(li);
            li = new ListItem("Driving Licence", "Driving Licence");
            DDLIDType.Items.Add(li);

            if (HFTaxPayerID.Value.Length == 0)
            {
                HFTaxPayerID.Value = "0";
            }
            else
            {
                //We are editing this taxpayer
                ShowTaxpayer(Convert.ToInt32(HFTaxPayerID.Value));
            }
            
        }

    }

    private void ShowTaxpayer(int TaxPayerID)
    {
        //Load taxpayer
        TMSDAL.TaxPayer payer = new TMSDAL.TaxPayer();
        payer.Load(Session["connection"].ToString(), TaxPayerID);

        txtAddress.Text = payer.Address;
        DEDOB.SelectedDate = payer.DateOfBirth;
        txtEmail.Text = payer.Email;
        txtFileNumber.Text = payer.FileNumber;
        txtIDNumber.Text = payer.IDNumber;
        txtMobile.Text = payer.Mobile;
        txtProffession.Text = payer.Profession;
        txtTaxPayerName.Text = payer.Names;
        txtTelephone.Text = payer.Telephone;
        txtTin.Text = payer.TIN;
        DDLIDType.SelectedValue = payer.IDType;

        //TODO: Select the correct sector and cell
        short sectorid = GetSectorIDfromCellID(payer.CellID);
        DDLSector.SelectedValue = sectorid.ToString();

        //Get the cells for this sector
        ShowCells(sectorid);

        cboCellID.SelectedValue = payer.CellID.ToString();
    }

    private short GetSectorIDfromCellID(short cellID)
    {
        TMSDAL.Cell cell = new TMSDAL.Cell();
        cell.Load(Session["connection"].ToString(), cellID);

        return cell.SectorID;

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
              
        TMSDAL.TaxPayer taxpayer = new TMSDAL.TaxPayer();

        //Basic Taxpayer Information

        if (txtTaxPayerName.Text.Length * txtAddress.Text.Length  *txtIDNumber.Text.Length  *txtProffession.Text.Length  *DDLIDType.SelectedItem.Text.Length==0) 
        {
            LblError.Text = "<br/><img src='images/stop.gif' align='middle'>&nbsp;Not all data for required fields has been provided.<hr/>"; 
            return ;
        }
        
        taxpayer.Names = txtTaxPayerName.Text;

        taxpayer.Address = txtAddress.Text;
        if (cboCellID.SelectedItem.Value =="0")
        {
            return;
        }
        else
        {
            taxpayer.CellID = Convert.ToInt16(cboCellID.SelectedItem.Value);
        }

        taxpayer.DateOfBirth = DEDOB.SelectedDate;
        taxpayer.Email = txtEmail.Text;
        taxpayer.FileNumber = txtFileNumber.Text;
        taxpayer.IDNumber = txtIDNumber.Text;
        taxpayer.Mobile = txtMobile.Text;
        taxpayer.Profession = txtProffession.Text;
        taxpayer.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);
        taxpayer.Telephone = txtTelephone.Text;
        taxpayer.TIN = txtTin.Text;
        taxpayer.IDType = DDLIDType.SelectedItem.Text;


        taxpayer.Save(Convert.ToString(Session["connection"]));

        Response.Redirect("~/taxpayerbankdetails.aspx?tid=" + taxpayer.TaxPayerID.ToString());

    }

    protected void DDLSector_SelectedIndexChanged(object sender, EventArgs e)
    {
        short sectorid = Convert.ToInt16(DDLSector.SelectedItem.Value);
        ShowCells(sectorid); 
    }

    private void ShowCells(short sectorid)
    {
        TMSDAL.Cells cells = new TMSDAL.Cells();
        cells.Load(Session["connection"].ToString(), sectorid);
        ListItem li;

        cboCellID.Items.Clear();


        li = new ListItem("Select a Cell", "0");
        cboCellID.Items.Add(li);

        foreach (TMSDAL.Cell cell in cells)
        {
            li = new ListItem(cell.CellName, cell.CellID.ToString());
            cboCellID.Items.Add(li);
        }
    
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/taxpayerdetails.aspx?id=" + HFTaxPayerID.Value  );
    }
}
