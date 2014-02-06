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

public partial class FeePayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        lblHeader.Text = labels.GetLabel(lang, "Fee Payment");

        //Get the ID of this payment if editing
        int payID = Convert.ToInt32(Request.QueryString["id"]);
        HFFeePaymentID.Value = payID.ToString();

        //Load and show the taxpayers registered for this district
        TMSDAL.TaxPayers payers = new TMSDAL.TaxPayers();
        payers.Load(Session["connection"].ToString());

        ListItem li;
        li = new ListItem(labels.GetLabel(lang, "Select a Taxpayer"), "0");
        cboTaxPayerID.Items.Add(li);

        foreach (TMSDAL.TaxPayer payer in payers)
        {
            li = new ListItem(payer.Names, payer.TaxPayerID.ToString());
            cboTaxPayerID.Items.Add(li);
        }

        lblAmount.Text = labels.GetLabel(lang,"Amount");
        lblDesignation.Text = labels.GetLabel(lang, "Description");
        lblPaymentDate.Text = labels.GetLabel(lang, "Payment Date");
        lblTaxPayerID.Text = labels.GetLabel(lang, "Taxpayer"); 
    }

    protected void BtnSave_Click(object sender, EventArgs e)
    {
        TMSDAL.FeePayment payment = new TMSDAL.FeePayment();

        if (txtAmount.Text.Length * txtDesignation.Text.Length * Convert.ToInt32 ( cboTaxPayerID.SelectedItem.Value)==0)
        {
            LblError.Text = "<br/><img src='images/stop.gif' align='middle'>&nbsp; Not all data for required fields has been provided.<hr/>"; 
            return;
        }

        if (DEPaymentDate.SelectedDate.Year== 1)
        {
            LblError.Text = "<br/><img src='images/stop.gif' align='middle'>&nbsp; You must provide the transaction date.<hr/>";
            return;
        }
        if (DEPaymentDate.SelectedDate > DateTime.Now.Date)
        {
            LblError.Text = "<br/><img src='images/stop.gif' align='middle'>&nbsp;The payment date cannot be later than today.<hr/>";
            return;
        }

        payment.Amount = Convert.ToDecimal(txtAmount.Text);
        payment.Designation = txtDesignation.Text;
        payment.PaymentDate = DEPaymentDate.SelectedDate;
        payment.PaymentID = Convert.ToInt64(HFFeePaymentID.Value);
        payment.TaxPayerID = Convert.ToInt32(cboTaxPayerID.SelectedItem.Value);

        payment.Save(Session["connection"].ToString());

        Response.Redirect("notification.aspx?url=FeePayment.aspx&saveditem=fee payment");
        //Response.Redirect("~/FeePayment.aspx");
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx");
    }
}
