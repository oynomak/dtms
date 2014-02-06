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

public partial class taxpayerproperties : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();


        //Get the Taxpayers ID
        HFTaxPayerID.Value = Convert.ToString(Request.QueryString["tid"]);

        string action = Convert.ToString(Request.QueryString["action"]);
        int PropID = Convert.ToInt32(Request.QueryString["propertyid"]);
        HFPropertyID.Value = PropID.ToString();

        if (action == null)
        {
            LblAddProperty.Text = labels.GetLabel(lang, "Add Property");
            BtnAddProperty.Text = labels.GetLabel(lang, "Add");
        }
        else
        {
            //Get the Property in question
            TMSDAL.Property property = new TMSDAL.Property();
            property.Load(Session["connection"].ToString(), PropID);

            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddProperty.Text = labels.GetLabel(lang, "Change Property");
                    BtnAddProperty.Text = labels.GetLabel(lang, "Change");

                    txtPropertyTax.Text = property.Amount.ToString("N");
                    txtPlotNumber.Text = property.PlotNumber;
                    LblPlotNumber.Text = labels.GetLabel(lang, "Plot No.");
                    DateOfAcquisition.SelectedDate = property.DateOfAcquisition;
                    LblDateOfAcquisition.Text = labels.GetLabel(lang, "Date of Acquisition");
                    txtDistrictPropertyValue.Text = property.DistrictValuation.ToString("N");
                    lblDistrictPropertyValue.Text = labels.GetLabel(lang, "Property Value - District");
                    txtOwnerName.Text = property.OwnersName;
                    LblOwnerName.Text = labels.GetLabel(lang, "Owner's Name");
                    txtOwnerPropertyValue.Text = property.OwnerValuation.ToString("N");
                    LblOwnerPropertyValue.Text = labels.GetLabel(lang, "Property Value - Owner");
                    txtUse.Text = property.Usage;
                    LblUse.Text = labels.GetLabel(lang, "Use");
                }

            }
            if (action == "remove")
            {
                property.Delete(Session["connection"].ToString());
                Response.Redirect("taxpayerproperties.aspx?tid=" + Convert.ToString(HFTaxPayerID.Value));
            }
        }

        LblProperties.Text = "Properties";

        ShowProperties();
    }

    private void ShowProperties()
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Load the bank propertys for the taxpayer
        int TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);

        TMSDAL.Properties properties = new TMSDAL.Properties();
        properties.Load(Session["connection"].ToString(), TaxPayerID);

        TableRow tr = new TableRow();

        TblProperties.Width = new Unit("100%");

        AddCell(labels.GetLabel(lang, "Use"), tr);
        AddCell(labels.GetLabel(lang, "Owner's Name"), tr);
        AddCell(labels.GetLabel(lang, "Date of Acquisition"), tr);
        AddCell(labels.GetLabel(lang, "Property Value - Owner"), tr);
        AddCell(labels.GetLabel(lang, "Property Value - District"), tr);
        AddCell(labels.GetLabel(lang, "Plot No."), tr);
        AddCell(labels.GetLabel(lang, "Tax"), tr);
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";

        TblProperties.Rows.Add(tr);


        foreach (TMSDAL.Property prop in properties)
        {
            tr = new TableRow();

            AddCell(prop.Usage, tr);
            AddCell(prop.OwnersName, tr);
            AddCell(prop.DateOfAcquisition.ToShortDateString(), tr);
            AddCell(prop.OwnerValuation.ToString("N"), tr);
            AddCell(prop.DistrictValuation.ToString("N"), tr);
            AddCell(prop.PlotNumber, tr);
            AddCell(prop.Amount.ToString("N"), tr);
            AddCell("<A href='taxpayerproperties.aspx?tid=" + TaxPayerID + "&propertyid=" + prop.PropertyID + "&action=edit'" + ">" + labels.GetLabel(lang, "Edit") + "</A>", tr);
            AddCell("<A href='taxpayerproperties.aspx?tid=" + TaxPayerID + "&propertyid=" + prop.PropertyID + "&action=remove'" + ">" + labels.GetLabel(lang, "Remove") + "</A>", tr);

            TblProperties.Rows.Add(tr);

        }


    }
    protected void BtnAddProperty_Click(object sender, EventArgs e)
    {
        if (txtPropertyTax.Text.Length * txtOwnerPropertyValue.Text.Length * txtDistrictPropertyValue.Text.Length > 0)
        {
            if (txtOwnerName.Text.Length * txtUse.Text.Length * txtPlotNumber.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must provide the owner's name, property usage and plot number";
                return;
            }

            if (DateOfAcquisition.SelectedDate.Year == 1)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must provide the date of acquisition of the property";
                return;
            }
            if (DateOfAcquisition.SelectedDate > DateTime.Now.Date)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;The date of acquisition of the property cannot be later than today";
                return;
            }

            TMSDAL.Property property = new TMSDAL.Property();
            property.PropertyID = Convert.ToInt32(HFPropertyID.Value);
            property.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);
            property.PlotNumber = txtPlotNumber.Text;
            property.Usage = txtUse.Text;
            property.OwnersName = txtOwnerName.Text;
            property.DateOfAcquisition = DateOfAcquisition.SelectedDate;
            property.OwnerValuation = Convert.ToDecimal(txtOwnerPropertyValue.Text);
            property.DistrictValuation = Convert.ToDecimal(txtDistrictPropertyValue.Text);
            property.Amount = Convert.ToDecimal(txtPropertyTax.Text);

            property.Save(Session["connection"].ToString());

            Response.Redirect("~/taxpayerproperties.aspx?tid=" + HFTaxPayerID.Value);
        }
        else
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the tax amount and property value";

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
        Response.Redirect("~/taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);
    }

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("taxpayertenants.aspx?tid=" + HFTaxPayerID.Value);
    }


}
