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

public partial class taxpayerbankdetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Get the Taxpayers ID
        HFTaxPayerID.Value = Convert.ToString(Request.QueryString["tid"]);

        string action = Convert.ToString(Request.QueryString["action"]);
        short accID = Convert.ToInt16(Request.QueryString["accountid"]);
        HFBankAccountID.Value = accID.ToString();

        if (!IsPostBack)
        {
            //Load the Bank Branches

            TMSDAL.Banks banks = new TMSDAL.Banks();
            banks.Load(Session["connection"].ToString());

            ListItem li;

            DDLBankBranches.Items.Clear();

            li = new ListItem(labels.GetLabel(lang, "Select a Bank Branch"), "0");
            DDLBankBranches.Items.Add(li);

            foreach (TMSDAL.Bank bank in banks)
            {
                foreach (TMSDAL.BankBranch branch in bank.Branches)
                {
                    li = new ListItem(bank.BankName + "-" + branch.BankBranchName, branch.BankBranchID.ToString());
                    DDLBankBranches.Items.Add(li);
                }
            }
        }

        if (action == null)
        {
            LblAddBankAccount.Text = labels.GetLabel(lang, "Add Bank Account");
            BtnAddBankAccount.Text = labels.GetLabel(lang, "Add");
        }
        else
        {
            //Get the Bank Account in question
            TMSDAL.BankAccount account = new TMSDAL.BankAccount();
            account.Load(Session["connection"].ToString(), accID);

            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddBankAccount.Text = labels.GetLabel(lang, "Change Bank Account");
                    BtnAddBankAccount.Text = labels.GetLabel(lang, "Change");

                    txtAccountNumber.Text = account.AccountNumber;
                    DDLBankBranches.SelectedValue = Convert.ToString(account.BankBranchID);
                }

            }
            if (action == "remove")
            {
                account.Delete(Session["connection"].ToString());
                Response.Redirect("taxpayerbankdetails.aspx?tid=" + Convert.ToString(HFTaxPayerID.Value));
            }
        }

        LblBankAccounts.Text = labels.GetLabel(lang, "Bank Accounts");

        BtnBack.CssClass = "buttons";
        BtnNext.CssClass = "buttons";
        BtnFinish.CssClass = "buttons";
        BtnAddBankAccount.CssClass = "buttons";

        ShowBankAccounts();
    }

    private void ShowBankAccounts()
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        //Load the bank accounts for the taxpayer
        int TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);

        TMSDAL.BankAccounts accounts = new TMSDAL.BankAccounts();
        accounts.Load(Session["connection"].ToString(), TaxPayerID);

        TableRow tr = new TableRow();

        TblAccounts.Width = new Unit("100%");

        AddCell(labels.GetLabel(lang, "Bank"), tr);
        AddCell(labels.GetLabel(lang, "Branch"), tr);
        AddCell(labels.GetLabel(lang, "Account No."), tr);
        AddCell("", tr);
        AddCell("", tr);

        tr.CssClass = "tableheader";

        TblAccounts.Rows.Add(tr);

        string bankname;
        string branchname;

        foreach (TMSDAL.BankAccount acc in accounts)
        {
            tr = new TableRow();
            bankname = acc.BranchName.Split("-".ToCharArray()).GetValue(0).ToString();
            branchname = acc.BranchName.Split("-".ToCharArray()).GetValue(1).ToString();

            AddCell(bankname, tr);
            AddCell(branchname, tr);
            AddCell(acc.AccountNumber, tr);
            AddCell("<A href='taxpayerbankdetails.aspx?tid=" + TaxPayerID + "&accountid=" + acc.BankAccountID + "&action=edit'" + ">" + labels.GetLabel(lang, "Edit") + "</A>", tr);
            AddCell("<A href='taxpayerbankdetails.aspx?tid=" + TaxPayerID + "&accountid=" + acc.BankAccountID + "&action=remove'" + ">" + labels.GetLabel(lang, "Remove") + "</A>", tr);

            TblAccounts.Rows.Add(tr);

        }


    }
    protected void BtnAddBankAccount_Click(object sender, EventArgs e)
    {
        if (txtAccountNumber.Text.Length * Convert.ToInt32(DDLBankBranches.SelectedValue) == 0)
        {
            LblError.Text = "<img src='images/stop.gif' align='middle'>&nbsp;You must select a bank branch and enter an account number";
            return;
        }

        TMSDAL.BankAccount account = new TMSDAL.BankAccount();
        account.BankAccountID = Convert.ToInt32(HFBankAccountID.Value);
        account.BankBranchID = Convert.ToInt16(DDLBankBranches.SelectedItem.Value);
        account.TaxPayerID = Convert.ToInt32(HFTaxPayerID.Value);
        account.AccountNumber = txtAccountNumber.Text;

        account.Save(Session["connection"].ToString());

        Response.Redirect("~/taxpayerbankdetails.aspx?tid=" + HFTaxPayerID.Value);
    }

    private TableCell AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
        tc.ID = "cell" + row.Cells.Count.ToString();
        return tc;
    }

    protected void BtnNext_Click(object sender, EventArgs e)
    {
        Response.Redirect("taxpayerlanddetails.aspx?tid=" + HFTaxPayerID.Value);
    }

    protected void BtnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("taxpayer.aspx?id=" + HFTaxPayerID.Value);
    }


    protected void BtnFinish_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/taxpayerdetails.aspx?id=" + HFTaxPayerID.Value);
    }
}
