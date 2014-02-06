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

public partial class User : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Language.UserInterfaceLabels labels = (Language.UserInterfaceLabels)Session["labels"];
        string lang = Session["language"].ToString();

        LblHeader.Text =labels.GetLabel(lang, "User Details"); 

        
        //Get any user passed in if editing
        if (!IsPostBack)
        {
            
            short userid = Convert.ToInt16(Request.QueryString["id"]);
            HFUserID.Value = userid.ToString();

            if (userid > 0)
            {
                TMSDAL.User user = new TMSDAL.User();
                user.Load(Session["connection"].ToString(), userid);

                txtUserName.Text = user.UserName;
                lblUserName.Text = labels.GetLabel(lang,"Username");
                lblFullName.Text = labels.GetLabel(lang,"Full Name"); 
                TxtFullname.Text = user.FullName;
                lblPassword.Text = labels.GetLabel(lang,"Password");
                txtPassword.Text = user.Password;

                HFPassword.Value = user.Password;
                HFStatus.Value = user.Status.ToString(); 
            }
            else
            {
                HFPassword.Value = "";
                HFStatus.Value = "0";
            }
        }
 
    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        TMSDAL.User user = new TMSDAL.User();
        user.FullName = TxtFullname.Text;
        user.UserName = txtUserName.Text;
        if (txtPassword.Text.Length > 0)
        {
            user.Password = txtPassword.Text;
        }
        else
        {
            user.Password = HFPassword.Value;
        }

        user.DistrictID = Convert.ToInt16(Session["districtid"]);
        user.UserID = Convert.ToInt16(HFUserID.Value);
        user.Status = Convert.ToInt32(HFStatus.Value);
        user.Save(Session["connection"].ToString());

        Response.Redirect("users.aspx"); 
    }
    protected void BtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("users.aspx"); 
    }
}
