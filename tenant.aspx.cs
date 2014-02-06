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

public partial class tenant : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        LblTenantInformation.Text = labels.GetLabel(lang, "Tenant Details");
        //Load the tenant's details

        int tenantID = Convert.ToInt32(Request.QueryString["id"]);

        if (!IsPostBack)
        {
            TMSDAL.HouseTenant tenant = new TMSDAL.HouseTenant();
            tenant.Load(Session["connection"].ToString(), tenantID);

            HFTaxPayerID.Value = tenant.TaxPayerID.ToString();
            HFTenantID.Value = tenant.HouseID.ToString();

            txtAddress.Text = tenant.Address;
            LblAddress.Text = labels.GetLabel(lang, "Address");
            txtAmount.Text = tenant.Amount.ToString("#,###,###");
            LblAmount.Text = labels.GetLabel(lang, "Amount");
            txtPlotNumber.Text = tenant.PlotNumber;
            lblPlotNumber.Text = labels.GetLabel(lang, "Plot No.");
            txtTelephone.Text = tenant.Telephone;
            LblTelephone.Text = labels.GetLabel(lang, "Telephone");
            txtTenantName.Text = tenant.FullName;
            LblTenantName.Text = labels.GetLabel(lang, "Full Name");

            BtnSave.Text = labels.GetLabel(lang, "Save");
            BtnCancel.Text = labels.GetLabel(lang, "Cancel");

            HFBack.Value = Request.UrlReferrer.PathAndQuery;

        }


    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {

        if (txtAmount.Text.Length * txtTenantName.Text.Length * txtPlotNumber.Text.Length * txtAddress.Text.Length > 0)
        {

            if (Statistics.IsNumeric(txtAmount.Text) == false || Convert.ToInt32(txtAmount.Text) <= 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter a valid rent amount";
                return;
            }


            TMSDAL.HouseTenant tenant = new TMSDAL.HouseTenant();

            tenant.HouseID = Convert.ToInt32(HFTenantID.Value);
            tenant.Address = txtAddress.Text;
            tenant.Amount = Convert.ToDecimal(txtAmount.Text);
            tenant.FullName = txtTenantName.Text;
            tenant.PlotNumber = txtPlotNumber.Text;
            tenant.Telephone = txtTelephone.Text;
            tenant.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);

            tenant.Save(Session["connection"].ToString());
            
            Response.Redirect("notification.aspx?url=taxpayerdetails.aspx&id=" + HFTaxPayerID.Value + "&saveditem=tenant");
            //Response.Redirect("taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);
        }

        else
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the rent amount,tenant's name,plot number and address";

        }
    }

    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }
}
