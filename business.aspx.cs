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

public partial class business : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        if (!IsPostBack)
        {
            int bussinessid = Convert.ToInt32(Request.QueryString["id"]);

            TMSDAL.Business bus = new TMSDAL.Business();
            bus.Load(Session["connection"].ToString(), bussinessid);

            HFBusinessID.Value = bus.BusinessID.ToString();
            HFTaxPayerID.Value = bus.TaxPayerID.ToString();

            TMSDAL.TaxPayer payer = new TMSDAL.TaxPayer();
            payer.Load(Session["connection"].ToString(), bus.TaxPayerID);

            LblBusiness.Text = payer.Names + " - " + bus.BusinessName ; 

            txtAddress.Text = bus.Address;
            LblAddress.Text =labels.GetLabel(lang, "Address");
            txtAmount.Text = bus.Amount.ToString("N");
            LblAmount.Text = labels.GetLabel(lang,"Trading License Fees");
            txtBusinessName.Text = bus.BusinessName;
            LblBusinessName.Text = labels.GetLabel(lang,"Business Name");
            txtPlotNumber.Text = bus.PlotNumber;
            lblPlotNumber.Text = labels.GetLabel(lang,"Plot No.");
            txtProfession.Text = bus.Profession;
            LblProfession.Text = labels.GetLabel(lang,"Profession");
            StartingDate.SelectedDate  = bus.StartDate;
            LblStartingDate.Text = labels.GetLabel(lang,"Start Date");
            
            BtnSave.Text = " " + labels.GetLabel(lang, "Save") + " ";
            BtnCancel.Text = labels.GetLabel(lang, "Cancel");

        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtAmount.Text.Length > 0)
        {
            if (Statistics.IsNumeric(txtAmount.Text) == true)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter a valid amount";
                return;
            }

            if (txtBusinessName.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the business name";
                return;
            }

            if (txtPlotNumber.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the plot number";
                return;
            }

            if (txtProfession.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the profession";
                return;
            }

            if (StartingDate.SelectedDate.Year == 1)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the starting date of the business";
                return;
            }

            if (txtAddress.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the address of the business";
                return;
            }

            TMSDAL.Business bus = new TMSDAL.Business();

            bus.Address = txtAddress.Text;
            bus.Amount = Convert.ToDecimal(txtAmount.Text);
            bus.BusinessID = Convert.ToInt32(HFBusinessID.Value);
            bus.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);
            bus.BusinessName = txtBusinessName.Text;
            bus.PlotNumber = txtPlotNumber.Text;
            bus.Profession = txtProfession.Text;
            bus.StartDate = StartingDate.SelectedDate ;

            bus.Save(Session["connection"].ToString());

            Response.Redirect("notification.aspx?url=taxpayerdetails.aspx&id=" + HFTaxPayerID.Value + "&saveditem=taxpayer business");
            //Response.Redirect("taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);
        }
        else 
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the trading license fees amount";
       
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("default.aspx");
    }
}
