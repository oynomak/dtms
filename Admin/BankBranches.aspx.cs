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

public partial class BankBranches : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Get the bank that these Branches belong to
        byte ProvID = Convert.ToByte(Request.QueryString["id"]);
        string action = Convert.ToString(Request.QueryString["action"]);

        HFBankID.Value = ProvID.ToString();

        TMSDAL.Bank bank = new TMSDAL.Bank();
        bank.Load(Convert.ToString(Session["connection"]), ProvID);

        if (action == null) //just show bankBranches
        {
            LblAddBankBranch.Text = "Add a Branch to the '" + bank.BankName + "' bank";
            BtnAddBankBranch.Text = "Add a Branch";
            HFBankBranchID.Value = "0";
        }
        else
        {
            TMSDAL.BankBranch dist = new TMSDAL.BankBranch();
            Byte distID = Convert.ToByte(Request.QueryString["distid"]);
            dist.Load(Session["connection"].ToString(), distID);
            if (action == "edit")
            {
                if (!IsPostBack)
                {
                    LblAddBankBranch.Text = "Rename Branch";
                    BtnAddBankBranch.Text = "Rename Branch";
                    txtBankBranchName.Text = dist.BankBranchName;
                    HFBankBranchID.Value = dist.BankBranchID.ToString();
                }
            }
            if (action == "remove")
            {
                dist.Delete(Session["connection"].ToString());
                Response.Redirect("~/Admin/BankBranches.aspx?id=" + HFBankID.Value);
            }
        }

        LblBankBranches.Text = "Branches in the '" + bank.BankName + "' bank";
        ShowBankBranches(ProvID);

    }
    private void ShowBankBranches(byte ProvID)
    {
        TblBankBranches.Width = new Unit("100%");

        TableRow tr;

        //Header
        tr = new TableRow();
        AddCell("Branch", tr);
        AddCell("", tr);
        AddCell("", tr);
        
        tr.CssClass = "tableheader";
        TblBankBranches.Rows.Add(tr);

        //Data

        TMSDAL.BankBranches bankBranchs = new TMSDAL.BankBranches();
        bankBranchs.Load(Session["connection"].ToString(), ProvID);

        foreach (TMSDAL.BankBranch dist in bankBranchs)
        {
            tr = new TableRow();
            AddCell(dist.BankBranchName, tr);
            AddCell("<A href='BankBranches.aspx?distid=" + dist.BankBranchID + "&action=edit&id=" + HFBankID.Value + "'>Edit</A>", tr);
            AddCell("<A href='BankBranches.aspx?distid=" + dist.BankBranchID + "&action=remove&id=" + HFBankID.Value + "'>Remove</A>", tr);
            TblBankBranches.Rows.Add(tr);
        }

    }

    private void AddCell(String text, TableRow row)
    {
        TableCell tc;
        tc = new TableCell();
        tc.Text = text;
        row.Cells.Add(tc);
    }

    protected void BtnAddBankBranch_Click(object sender, EventArgs e)
    {
        TMSDAL.BankBranch dist = new TMSDAL.BankBranch();
        dist.BankBranchID = Convert.ToInt16(HFBankBranchID.Value);
        dist.BankBranchName = txtBankBranchName.Text;
        dist.BankID = Convert.ToByte(HFBankID.Value);
        dist.Save(Session["connection"].ToString());

        Response.Redirect("~/Admin/BankBranches.aspx?id=" + HFBankID.Value);
    }
}
