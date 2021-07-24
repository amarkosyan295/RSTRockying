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
    public string email = "";
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
            email = string.IsNullOrEmpty(Request.Form["emailtxt"]) ? "" : Request.Form["emailtxt"];
            string otp = string.IsNullOrEmpty(Request.Form["otptxt"]) ? "" : Request.Form["otptxt"];
            if (ViewState["OTP"].ToString() == otp)
            {
                if (MemberManager.EmailExist(email))
                {
                    MemberManager.ToggleSubscriptionUser(MemberManager.GetUser(email).ID, true);
                }
                else
                {
                    string password = Guid.NewGuid().ToString().Replace("-", "").Substring(0, 10);
                    if (MemberManager.CreateUser(email, password, true, nametxt.Value, null, "n", MemberTypeType.Member))
                    {
                        //EmailManager.SendActivationEmail(email, nametxt.Value, password);
                        MemberManager.ActivateUser(email);
                    }
                }
                //Response.Redirect("~/account/subscribe");
                ViewState["OTP"] = "";
                GenerateOTPBtn.CssClass = "btn btn-primary";
                SubmitBtn.Visible = false;
                OTPPlaceHolder.Visible = false;
                ShowMessage = true;
                OTPMistmatchPlaceHolder.Visible = false;
            }
            else
            {
                OTPMistmatchPlaceHolder.Visible = true;
            }
        }
        catch (Exception ex)
        {
            Trace.Write("Register error");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);

        }
    }

    protected void GenerateOTPBtn_Click(object sender, EventArgs e)
    {
        email = string.IsNullOrEmpty(Request.Form["emailtxt"]) ? "" : Request.Form["emailtxt"];
        if (!string.IsNullOrEmpty(email))
        {
            Random r = new Random();
            string otp = r.Next(100000, 999999).ToString();
            ViewState["OTP"] = otp;
            EmailManager.SendMail(Utility.NewsletterEmail, email, Utility.AdminName, "", String.Format("Your OTP : {0}", otp), "Rockying OTP", EmailMessageType.Notification, "OTP");
            OTPMessagePlaceHolder.Visible = true;
            OTPPlaceHolder.Visible = true;
            SubmitBtn.Visible = true;
            GenerateOTPBtn.CssClass = "btn btn-secondary";
        }
    }
}