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

public partial class taxpayerlanddetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Get the Taxpayers ID
        HFTaxPayerID.Value = Convert.ToString(Request.QueryString["tid"]);

        string action = Convert.ToString(Request.QueryString["action"]);
        short ParcelID = Convert.ToInt16(Request.QueryString["landparcelid"]);
        HFLandParcelID.Value = ParcelID.ToString();

        if (!IsPostBack)
        {
            ShowYears();
            LblError.Text = ""; 
        }


        if (action == null)
        {
            LblAddLandParcel.Text = labels.GetLabel(lang, "Add Land Parcel");
            BtnAddLandParcel.Text = labels.GetLabel(lang, "Add");            
        }
        else
        {
            //Get the Land Parcel in question
            TMSDAL.LandParcel parcel = new TMSDAL.LandParcel();
            parcel.Load(Session["connection"].ToString(), ParcelID);
            
            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddLandParcel.Text = "Change Land Parcel";
                    BtnAddLandParcel.Text = labels.GetLabel(lang, "Change");

                    txtPlotNumber.Text = parcel.PlotNumber;
                    lblPlotNumber.Text = labels.GetLabel(lang, "Plot No.");
                    ddlyears.SelectedValue = parcel.Year.ToString();
                    LblYear.Text = labels.GetLabel(lang, "Year");
                    DDLStandingLevel.SelectedValue  = parcel.StandingLevel;
                    LblStandingLevel.Text = labels.GetLabel(lang, "Standing Level");
                    txtLandTitle.Text = parcel.LandTitle;
                    LblLandTitle.Text = labels.GetLabel(lang, "Land Title");
                    txtTitleNumber.Text = parcel.TitleNumber;
                    LblTitleNumber.Text = labels.GetLabel(lang, "Title Number");
                    txtUsage.Text = parcel.Usage;
                    LblUsage.Text = labels.GetLabel(lang, "Usage");
                    DDLHouses.SelectedValue = parcel.NumberOfHouses.ToString();
                    LblHouses.Text = labels.GetLabel(lang, "Houses");
                    txtContractNumber.Text = parcel.ContractNumber;
                    LblContractNumber.Text = labels.GetLabel(lang, "Contract No.");
                    ContractDate.SelectedDate = parcel.ContractDate;
                    LblContractDate.Text = labels.GetLabel(lang, "Contract Date");
                    LblLandTax.Text = labels.GetLabel(lang, "Land Tax");
                    txtLandTax.Text = parcel.Amount.ToString("N");

                }

            }
            if (action == "remove")
            {
                parcel.Delete(Session["connection"].ToString());
                Response.Redirect("taxpayerlanddetails.aspx?tid=" + Convert.ToString(HFTaxPayerID.Value));
            }
        }
                
        LblLandParcels.Text = labels.GetLabel(lang, "Land Parcels");

        ShowLandParcels();
    }

    private void ShowYears()
    {
        for (int i = DateTime.Now.Year; i >= DateTime.Now.Year - 50; i--)
        {
            ddlyears.Items.Add(i.ToString());
        }

        for (int i = 0; i <= 20; i++)
        {
            DDLHouses.Items.Add(i.ToString());
        }

        DDLStandingLevel.Items.Add("High");
        DDLStandingLevel.Items.Add("Medium");
        DDLStandingLevel.Items.Add("Low");

    }

    private void ShowLandParcels()
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Load the bank parcels for the taxpayer
        int TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);

        TMSDAL.LandParcels parcels = new TMSDAL.LandParcels();
        parcels.Load(Session["connection"].ToString(), TaxPayerID);

        TableRow tr = new TableRow();

        TblLandParcels.Width = new Unit("100%");

        AddCell(labels.GetLabel(lang, "Plot No."), tr);
        AddCell(labels.GetLabel(lang, "Year"), tr);
        AddCell(labels.GetLabel(lang, "Standing Level"), tr);
        AddCell(labels.GetLabel(lang, "Land Title"), tr);
        AddCell(labels.GetLabel(lang, "Title No."), tr);
        AddCell(labels.GetLabel(lang, "Usage"), tr);
        AddCell("#" + labels.GetLabel(lang, "Houses"), tr);
        AddCell(labels.GetLabel(lang, "Contract No."), tr);
        AddCell(labels.GetLabel(lang, "Contract Date"), tr);
        AddCell(labels.GetLabel(lang, "Land Tax"), tr);
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";

        TblLandParcels.Rows.Add(tr);

        foreach (TMSDAL.LandParcel parc in parcels)
        {
            tr = new TableRow();

            AddCell(parc.PlotNumber, tr);
            AddCell(parc.Year.ToString(), tr);
            AddCell(parc.StandingLevel, tr);
            AddCell(parc.LandTitle, tr);
            AddCell(parc.TitleNumber, tr);
            AddCell(parc.Usage, tr);
            AddCell(parc.NumberOfHouses.ToString(), tr);
            AddCell(parc.ContractNumber, tr);
            AddCell(parc.ContractDate.ToShortDateString(), tr);
            AddCell(parc.Amount.ToString("N"), tr);
            AddCell("<A href='taxpayerlanddetails.aspx?tid=" + TaxPayerID + "&landparcelid=" + parc.LandParcelID + "&action=edit'" + ">" + labels.GetLabel(lang, "Edit") + "</A>", tr);
            AddCell("<A href='taxpayerlanddetails.aspx?tid=" + TaxPayerID + "&landparcelid=" + parc.LandParcelID + "&action=remove'" + ">" + labels.GetLabel(lang, "Remove") + "</A>", tr);

            TblLandParcels.Rows.Add(tr);

        }


    }
    protected void BtnAddLandParcel_Click(object sender, EventArgs e)
    {
        if (txtLandTax.Text.Length > 0)
        {
            if (ContractDate.SelectedDate.Year==1 || ContractDate.SelectedDate>DateTime.Now.Date )
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter a valid contract date";
                return;
            }

            
            if (txtPlotNumber.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the plot number";
                return;
            }

            if (txtUsage.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the land usage";
                return;
            }

            if (txtContractNumber.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the contract number";
                return;
            }

            if (txtLandTitle.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the land title";
                return;
            }

            if (txtTitleNumber.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the title number";
                return;
            }

            TMSDAL.LandParcel parcel = new TMSDAL.LandParcel();
            parcel.LandParcelID = Convert.ToInt32(HFLandParcelID.Value);
            parcel.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);
            parcel.PlotNumber = txtPlotNumber.Text;
            parcel.ContractDate = ContractDate.SelectedDate;
            parcel.ContractNumber = txtContractNumber.Text;
            parcel.LandTitle = txtLandTitle.Text;
            parcel.NumberOfHouses = Convert.ToInt16(DDLHouses.SelectedValue);
            parcel.StandingLevel = DDLStandingLevel.SelectedItem.Text;
            parcel.TitleNumber = txtTitleNumber.Text;
            parcel.Usage = txtUsage.Text;
            parcel.Year = Convert.ToInt16(ddlyears.SelectedValue);
            parcel.Amount = Convert.ToDecimal(txtLandTax.Text);

            parcel.Save(Session["connection"].ToString());

            Response.Redirect("~/taxpayerlanddetails.aspx?tid=" + HFTaxPayerID.Value);
        }
        else
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the land tax amount";
        }
    }

    private TableCell AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
        //tc.ID = "cell" + row.Cells.Count.ToString();
        return tc;
    }
    protected void BtnNext_Click(object sender, EventArgs e)
    {
        Response.Redirect("taxpayerbusinesses.aspx?tid=" + HFTaxPayerID.Value);
    }

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("taxpayerbankdetails.aspx?tid=" + HFTaxPayerID.Value);
    }

    protected void BtnFinish_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);
    }
}
