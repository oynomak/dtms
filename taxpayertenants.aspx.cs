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

public partial class taxpayertenants : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Get the Taxpayers ID
        HFTaxPayerID.Value = Convert.ToString(Request.QueryString["tid"]);

        string action = Convert.ToString(Request.QueryString["action"]);
        int TenantID = Convert.ToInt32(Request.QueryString["tenantid"]);
        HFTenantID.Value = TenantID.ToString();

        if (action == null)
        {
            LblAddTenant.Text = labels.GetLabel(lang, "Add Tenant");
            BtnAddTenant.Text = labels.GetLabel(lang, "Add");
        }
        else
        {
            //Get the Tenant in question
            TMSDAL.HouseTenant tenant = new TMSDAL.HouseTenant();
            tenant.Load(Session["connection"].ToString(), TenantID);

            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddTenant.Text = labels.GetLabel(lang, "Change Tenant");
                    BtnAddTenant.Text = labels.GetLabel(lang, "Change");

                    txtPlotNumber.Text = tenant.PlotNumber;
                    lblPlotNumber.Text = labels.GetLabel(lang, "Plot No.");
                    txtAddress.Text = tenant.Address;
                    LblAddress.Text = labels.GetLabel(lang, "Address");
                    txtAmount.Text = tenant.Amount.ToString("N");
                    LblAmount.Text = labels.GetLabel(lang, "Monthly Rent");
                    txtTenantName.Text = tenant.FullName;
                    LblTenantName.Text = labels.GetLabel(lang, "Full Name");
                    txtTelephone.Text = tenant.Telephone;
                    LblTelephone.Text = labels.GetLabel(lang, "Telephone");
                }

            }
            if (action == "remove")
            {
                tenant.Delete(Session["connection"].ToString());
                Response.Redirect("taxpayertenants.aspx?tid=" + Convert.ToString(HFTaxPayerID.Value));
            }
        }

        LblTenants.Text = labels.GetLabel(lang, "Tenants");

        ShowTenants();
    }

    private void ShowTenants()
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Load the bank tenants for the taxpayer
        int TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);

        TMSDAL.HouseTenants tenants = new TMSDAL.HouseTenants();
        tenants.Load(Session["connection"].ToString(), TaxPayerID);

        TableRow tr = new TableRow();

        TblTenants.Width = new Unit("100%");

        AddCell(labels.GetLabel(lang, "Plot No."), tr);
        AddCell(labels.GetLabel(lang, "Tenant's Full Name"), tr);
        AddCell(labels.GetLabel(lang, "Telephone"), tr);
        AddCell(labels.GetLabel(lang, "Address"), tr);
        AddCell(labels.GetLabel(lang, "Monthly Rent"), tr);
        
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";

        TblTenants.Rows.Add(tr);

        TableCell tc;

        foreach (TMSDAL.HouseTenant ten in tenants)
        {
            tr = new TableRow();
            AddCell(ten.PlotNumber, tr);
            AddCell(ten.FullName, tr);
            AddCell(ten.Telephone, tr);
            AddCell(ten.Address, tr);
            tc=AddCell(ten.Amount.ToString("N"), tr);
            tc.HorizontalAlign = HorizontalAlign.Right;  
            AddCell("<A href='taxpayertenants.aspx?tid=" + TaxPayerID + "&tenantid=" + ten.HouseID + "&action=edit'" + ">" + labels.GetLabel(lang, "Edit") + "</A>", tr);
            AddCell("<A href='taxpayertenants.aspx?tid=" + TaxPayerID + "&tenantid=" + ten.HouseID + "&action=remove'" + ">" + labels.GetLabel(lang, "Remove") + "</A>", tr);

            TblTenants.Rows.Add(tr);             

        }

        tr = new TableRow();
        
        tc = AddCell("Annual Rental Tax", tr);
        tc.ColumnSpan = 4;
        tc.HorizontalAlign = HorizontalAlign.Right;
        tc = AddCell(tenants.GetRentalTax(Session["connection"].ToString(), TaxPayerID).ToString("N") , tr);
        tc.HorizontalAlign = HorizontalAlign.Right;
        TblTenants.Rows.Add(tr);
        tr.CssClass = "tablefooter";
        
    }
    protected void BtnAddTenant_Click(object sender, EventArgs e)
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
            tenant.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);
            tenant.PlotNumber = txtPlotNumber.Text;
            tenant.Address = txtAddress.Text;
            tenant.Amount = Convert.ToDecimal(txtAmount.Text);
            //TODO: calculate the rental tax
            tenant.FullName = txtTenantName.Text;
            tenant.Telephone = txtTelephone.Text;

            tenant.Save(Session["connection"].ToString());
          
            Response.Redirect("~/taxpayertenants.aspx?tid=" + HFTaxPayerID.Value);
        }
        else
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the rent amount,tenant's name,plot number and address";

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
        Response.Redirect("taxpayerproperties.aspx?tid=" + HFTaxPayerID.Value);
    }

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("taxpayerbusinesses.aspx?tid=" + HFTaxPayerID.Value);
    }


    protected void BtnFinish_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);
    }
}
