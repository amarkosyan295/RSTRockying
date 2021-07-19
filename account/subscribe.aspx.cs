using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class control_subscribe : System.Web.UI.Page
{
    public bool ShowMessage = false;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SubmitBtn_Click(object sender, EventArgs e)
    {
        SubscribeMember();
    }

    private void SubscribeMember()
    {
        try
        {
            string email = string.IsNullOrEmpty(Request.Form["emailtxt"]) ? "" : Request.Form["emailtxt"];
            if (MemberManager.EmailExist(email))
            {
                MemberManager.ToggleSubscriptionUser(MemberManager.GetUser(email).ID, true);
            }
            else
            {
                string password = Guid.NewGuid().ToString().Replace("-","").Substring(0, 10);
                if (MemberManager.CreateUser(email, password, true, nametxt.Value, null, "n", MemberTypeType.Member))
                {
                    EmailManager.SendActivationEmail(email, nametxt.Value, password);
                }
            }
            ShowMessage = true;
        }
        catch (Exception ex)
        {
            Trace.Write("Register error");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
            
        }
    }
}