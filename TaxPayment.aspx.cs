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

public partial class TaxPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] == null)
        {
            FormsAuthentication.RedirectToLoginPage("ReturnUrl=taxpayment.aspx");  
        }
        
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Get the ID of this payment if editing
        byte payID = Convert.ToByte(Request.QueryString["id"]);
        HFTaxPaymentID.Value = payID.ToString();

        BtnSave.CssClass = "buttons";
        BtnCancel.CssClass = "buttons";

        string action = Convert.ToString(Request.QueryString["action"]);

        TMSDAL.TaxPayment payment = new TMSDAL.TaxPayment();
        payment.Load(Session["connection"].ToString(), payID);

        if (action == "delete")
        {
            Response.Redirect("~/deletepayment.aspx?id=" + payID.ToString());

        }


        Lblheader.Text = labels.GetLabel(lang, "Tax Payment");

        if (!IsPostBack)
        {
            //Load and show the taxpayers registered for this district
            TMSDAL.TaxPayers payers = new TMSDAL.TaxPayers();
            payers.Load(Session["connection"].ToString());

            ListItem li;
            li = new ListItem(labels.GetLabel(lang, "Select a Taxpayer"), "0");
            cboTaxPayerID.Items.Add(li);

            foreach (TMSDAL.TaxPayer payer in payers)
            {
                li = new ListItem(payer.Names + " - " + payer.IDNumber, payer.TaxPayerID.ToString());
                cboTaxPayerID.Items.Add(li);
            }

            //Load and show the tax types

            TMSDAL.TaxTypes taxtypes = new TMSDAL.TaxTypes();
            taxtypes.Load(Session["connection"].ToString());

            li = new ListItem(labels.GetLabel(lang, "Select a Tax Type"), "0");
            DDLTaxType.Items.Add(li);

            foreach (TMSDAL.TaxType tt in taxtypes)
            {
                li = new ListItem(tt.TaxTypeName, tt.TaxTypeID.ToString());
                DDLTaxType.Items.Add(li);
            }

            lblAmount.Text = labels.GetLabel(lang, "Amount");
            lblDescription.Text = labels.GetLabel(lang, "Description");
            lblPaymentDate.Text = labels.GetLabel(lang, "Payment Date");
            lblTaxPayerID.Text = labels.GetLabel(lang, "Taxpayer");
            LblTaxType.Text = labels.GetLabel(lang, "Tax Type");

            if (payID > 0)
            {
                cboTaxPayerID.SelectedValue = payment.TaxPayerID.ToString();
                DDLTaxType.SelectedValue = payment.TaxTypeID.ToString();
                txtAmount.Text = payment.Amount.ToString();
                txtDescription.Text = payment.Description;
                DEPaymentDate.SelectedDate = payment.PaymentDate;
            }

        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        TMSDAL.TaxPayment payment = new TMSDAL.TaxPayment();

        if (txtAmount.Text.Length * Convert.ToInt32(DDLTaxType.SelectedItem.Value) * Convert.ToInt32(cboTaxPayerID.SelectedItem.Value) == 0)
        {
            LblError.Text = "<br/><img src='images/stop.gif' align='middle'>&nbsp;Not all data for required fields has been provided.<hr/>";
            return;
        }

        if (DEPaymentDate.SelectedDate.Year==1)
        {
            LblError.Text = "<br/><img src='images/stop.gif' align='middle'>&nbsp;You must provide a date for this payment.<hr/>";
            return;
        }

        if (DEPaymentDate.SelectedDate>DateTime.Now.Date)
        {
            LblError.Text = "<br/><img src='images/stop.gif' align='middle'>&nbsp;The payment date cannot be later than today.<hr/>";
            return;
        }
          
        payment.Amount = Convert.ToDecimal(txtAmount.Text);
        payment.Description = txtDescription.Text;
        payment.PaymentDate = DEPaymentDate.SelectedDate;
        payment.PaymentID = Convert.ToInt32(HFTaxPaymentID.Value);
        payment.TaxPayerID = Convert.ToInt32(cboTaxPayerID.SelectedItem.Value);
        payment.TaxTypeID = Convert.ToByte(DDLTaxType.SelectedItem.Value);
        payment.Cashier = Session["username"].ToString();
        payment.Save(Session["connection"].ToString());


        if (payment.PaymentID > 0)
        {

            Response.Redirect("notification.aspx?url=taxpayments.aspx&saveditem=tax payment");
            //Response.Redirect("~/taxpayments.aspx");
        }
        else
        {
            Response.Redirect("notification.aspx?url=taxpayment.aspx&saveditem=tax payment");
            //Response.Redirect("~/taxpayment.aspx");
        }
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/default.aspx");
    }
}
