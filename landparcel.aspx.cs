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

public partial class landparcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        LblAddLandParcel.Text = labels.GetLabel(lang, "Land Parcel Details");

        if (!IsPostBack)
        {
            ShowYears();
            LblError.Text = "";

            DDLStandingLevel.Items.Add("High");
            DDLStandingLevel.Items.Add("Medium");
            DDLStandingLevel.Items.Add("Low");

            int parcelID = Convert.ToInt32(Request.QueryString["id"]);

            TMSDAL.LandParcel parcel = new TMSDAL.LandParcel();
            parcel.Load(Session["connection"].ToString(), parcelID);

            HFLandParcelID.Value = parcelID.ToString();
            HFTaxPayerID.Value = parcel.TaxPayerID.ToString();

            ContractDate.SelectedDate = parcel.ContractDate;
            LblContractDate.Text = labels.GetLabel(lang, "Contract Date");
            txtContractNumber.Text = parcel.ContractNumber;
            LblContractNumber.Text = labels.GetLabel(lang, "Contract No.");
            DDLHouses.SelectedValue  = parcel.NumberOfHouses.ToString();
            LblHouses.Text = labels.GetLabel(lang, "Houses");
            txtLandTax.Text = parcel.Amount.ToString("N");
            LblLandTax.Text = labels.GetLabel(lang, "Land Tax Amount");
            txtLandTitle.Text = parcel.LandTitle;
            LblLandTitle.Text = labels.GetLabel(lang, "Land Title");
            txtPlotNumber.Text = parcel.PlotNumber;
            lblPlotNumber.Text = labels.GetLabel(lang, "Plot No.");
            DDLStandingLevel.SelectedValue = parcel.StandingLevel;
            LblStandingLevel.Text = labels.GetLabel(lang, "Standing Level");
            txtTitleNumber.Text = parcel.TitleNumber;
            LblTitleNumber.Text = labels.GetLabel(lang, "Title No.");
            txtUsage.Text = parcel.Usage;
            LblUsage.Text = labels.GetLabel(lang, "Usage");
            ddlyears.SelectedValue = parcel.Year.ToString();
            LblYear.Text = labels.GetLabel(lang, "Year");

            BtnSave.Text = " " + labels.GetLabel(lang, "Save") + " ";
            BtnCancel.Text = labels.GetLabel(lang, "Cancel");

            BtnSave.CssClass = "buttons";
            BtnCancel.CssClass = "buttons";

        }

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

    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {

        if (txtLandTax.Text.Length == 0)
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the land tax amount";
            return;
        }

        if (ContractDate.SelectedDate.Year == 1 || ContractDate.SelectedDate > DateTime.Now.Date)
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

        parcel.ContractDate = ContractDate.SelectedDate;
        parcel.ContractNumber = txtContractNumber.Text;
        parcel.NumberOfHouses = Convert.ToInt16(DDLHouses.SelectedValue );
        parcel.Amount = Convert.ToDecimal(txtLandTax.Text);
        parcel.LandTitle = txtLandTitle.Text;
        parcel.PlotNumber = txtPlotNumber.Text;
        parcel.StandingLevel = DDLStandingLevel.SelectedValue;
        parcel.TitleNumber = txtTitleNumber.Text;
        parcel.Usage = txtUsage.Text;
        parcel.Year = Convert.ToInt16(ddlyears.SelectedValue);

        parcel.Save(Session["connection"].ToString());
        Response.Redirect("taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);

    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }
}
