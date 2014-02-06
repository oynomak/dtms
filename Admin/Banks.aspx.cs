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

public partial class Banks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Check to see whether we are adding,editing or deleting a bank
        String action = Convert.ToString(Request.QueryString["action"]);
        
        LblAddBank.Text = "Add Bank";

        if (action == null) //Adding here
        {
            LblAddBank.Text = "Add Bank";
            BtnAddBank.Text = "Add Bank";
            HFBankID.Value = Convert.ToString(0);
        }
        else
        {
            TMSDAL.Bank currentBank = new TMSDAL.Bank();
            byte ProvID = Convert.ToByte(Request.QueryString["id"]);
            currentBank.Load(Convert.ToString(Session["connection"]), ProvID);

            if (action == "edit") //editing here
            {
                if (!IsPostBack)
                {
                    LblAddBank.Text = "Change Bank Name";
                    BtnAddBank.Text = "Change Bank Name";
                    txtBankName.Text = currentBank.BankName;
                    HFBankID.Value = Convert.ToString(currentBank.BankID);
                }
            }
            if (action == "remove") //removing here
            {
                currentBank.Delete(Convert.ToString(Session["connection"]));
            }

        }
        
        LblBanks.Text = "Banks";
        //Show the existing banks
        ShowBanks();
    }
    private void ShowBanks()
    {
        TblBanks.Width = new Unit("100%");

        TableRow tr;
       
        //Header
        tr = new TableRow();
        AddCell("Bank", tr);
        AddCell("Branches", tr);
        AddCell("", tr);
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";
        TblBanks.Rows.Add(tr);

        //Data

        TMSDAL.Banks Banks = new TMSDAL.Banks();
        Banks.Load(Session["connection"].ToString());

        foreach (TMSDAL.Bank bk in Banks)
        {
            tr = new TableRow();
            AddCell(bk.BankName, tr);
            AddCell(bk.NumberOfBranches.ToString(), tr);
            AddCell("<A href='Banks.aspx?id=" + bk.BankID  +"&action=edit'>Edit</A>", tr);
            AddCell("<A href='Banks.aspx?id=" + bk.BankID  + "&action=remove'>Remove</A>", tr);
            AddCell("<A href='BankBranches.aspx?id=" + bk.BankID  +"'>View Branches</A>", tr);
            TblBanks.Rows.Add(tr);
        }

    }

    private void AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        TMSDAL.Bank bank = new TMSDAL.Bank();
        bank.BankID = Convert.ToByte (HFBankID.Value);
        bank.BankName = txtBankName.Text;

        bank.Save(Session["connection"].ToString());

        Response.Redirect("Banks.aspx"); 
    }
}
