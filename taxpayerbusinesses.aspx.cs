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

public partial class taxpayerbusinesses : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Get the Taxpayers ID
        HFTaxPayerID.Value = Convert.ToString(Request.QueryString["tid"]);

        string action = Convert.ToString(Request.QueryString["action"]);
        short BusID = Convert.ToInt16(Request.QueryString["businessid"]);
        HFBusinessID.Value = BusID.ToString();

        if (action == null)
        {
            LblAddBusiness.Text = labels.GetLabel(lang, "Add Business");
            BtnAddBusiness.Text = labels.GetLabel(lang, "Add");
        }
        else
        {
            //Get the Business in question
            TMSDAL.Business business = new TMSDAL.Business();
            business.Load(Session["connection"].ToString(), BusID);

            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddBusiness.Text = labels.GetLabel(lang, "Change Business");
                    BtnAddBusiness.Text = labels.GetLabel(lang, "Change");

                    txtPlotNumber.Text = business.PlotNumber;
                    txtAddress.Text = business.Address;
                    txtAmount.Text = business.Amount.ToString("N");
                    txtBusinessName.Text = business.BusinessName;
                    txtProfession.Text = business.Profession;
                    StartingDate.SelectedDate = business.StartDate;
                }

            }
            if (action == "remove")
            {
                business.Delete(Session["connection"].ToString());
                Response.Redirect("taxpayerbusinesses.aspx?tid=" + Convert.ToString(HFTaxPayerID.Value));
            }
        }

        BtnAddBusiness.CssClass = "buttons";
        BtnNext.CssClass = "buttons";
        BtnFinish.CssClass = "buttons";
        BtnBack.CssClass = "buttons";

        LblBusinesss.Text = labels.GetLabel(lang, "Businesses");
        lblPlotNumber.Text = labels.GetLabel(lang, "Plot Number");
        LblAmount.Text = labels.GetLabel(lang, "Trading License Fess");
        LblProfession.Text = labels.GetLabel(lang, "Profession");
        LblBusinessName.Text = labels.GetLabel(lang, "Business Name");
        LblStartingDate.Text = labels.GetLabel(lang, "Starting Date"); 

        ShowBusinesses();
    }

    private void ShowBusinesses()
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Load the bank businesss for the taxpayer
        int TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);

        TMSDAL.Businesses businesss = new TMSDAL.Businesses();
        businesss.Load(Session["connection"].ToString(), TaxPayerID);

        TableRow tr = new TableRow();

        TblBusinesss.Width = new Unit("100%");

        AddCell(labels.GetLabel(lang,"Profession"), tr);
        AddCell(labels.GetLabel(lang,"Business Name"), tr);
        AddCell(labels.GetLabel(lang,"Start Date"), tr);
        AddCell(labels.GetLabel(lang,"Trading License"), tr);
        AddCell(labels.GetLabel(lang,"Address"), tr);
        AddCell(labels.GetLabel(lang,"Plot No."), tr);
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";

        TblBusinesss.Rows.Add(tr);


        foreach (TMSDAL.Business parc in businesss)
        {
            tr = new TableRow();

            AddCell(parc.Profession, tr);
            AddCell(parc.BusinessName, tr);
            AddCell(parc.StartDate.ToShortDateString(), tr);
            AddCell(parc.Amount.ToString("N"), tr);
            AddCell(parc.Address, tr);
            AddCell(parc.PlotNumber, tr);
            AddCell("<A href='taxpayerbusinesses.aspx?tid=" + TaxPayerID + "&businessid=" + parc.BusinessID + "&action=edit'" + ">" + "Edit" + "</A>", tr);
            AddCell("<A href='taxpayerbusinesses.aspx?tid=" + TaxPayerID + "&businessid=" + parc.BusinessID + "&action=remove'" + ">" + "Remove" + "</A>", tr);

            TblBusinesss.Rows.Add(tr);

        }


    }
    protected void BtnAddBusiness_Click(object sender, EventArgs e)
    {
        if (txtAmount.Text.Length > 0 )
        {
            if ( Statistics.IsNumeric(txtAmount.Text)==true)
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

            if (StartingDate.SelectedDate.Year  == 1)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the starting date of the business";
                return;
            }

            if (txtAddress.Text.Length == 0)
            {
                LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the address of the business";
                return;
            }

            TMSDAL.Business business = new TMSDAL.Business();
            business.BusinessID = Convert.ToInt32(HFBusinessID.Value);
            business.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);
            business.PlotNumber = txtPlotNumber.Text;
            business.Address = txtAddress.Text;
            business.Amount = Convert.ToDecimal(txtAmount.Text);
            business.BusinessName = txtBusinessName.Text;
            business.Profession = txtProfession.Text;
            business.StartDate = StartingDate.SelectedDate;

            business.Save(Session["connection"].ToString());
            Response.Redirect("~/taxpayerbusinesses.aspx?tid=" + HFTaxPayerID.Value);
        }
        else
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must enter the trading license fees amount";
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
        Response.Redirect("taxpayertenants.aspx?tid=" + HFTaxPayerID.Value);
    }

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("taxpayerlanddetails.aspx?tid=" + HFTaxPayerID.Value);
    }

    protected void BtnFinish_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);
    }
}
