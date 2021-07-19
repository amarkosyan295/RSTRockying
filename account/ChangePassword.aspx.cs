using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class account_ChangePassword : MemberPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("logingrp");
        if (!Page.IsValid) return;

        try
        {
            if (MemberManager.ValidateUser(Page.User.Identity.Name, OldPasswordTextBox.Text.Trim()))
            {
                Member m = MemberManager.GetUser(Page.User.Identity.Name);
                MemberManager.ChangePassword(m.ID, NewPasswordTextBox.Text.Trim());
                
                EmailMessage em = EmailManager.AddMessage(Guid.NewGuid(), m.Email, Utility.NewsletterEmail, "Rockying Account Password Change Notification", "",
                    EmailMessageType.ChangePassword, EmailMessageType.ChangePassword.ToString(), string.Empty, m.MemberName, Utility.SiteName);
                EmailManager.SendMail(em);

                message1.Text =string.Format("You have successfuly changed your account password. We have sent an email to your registered email address. If you don't find email in you inbox, please check the SPAM folder and mark {0} as Safe sender.", Utility.NewsletterEmail);
                message1.Indicate = AlertType.Error;
                message1.Visible = true;
            }
            else
            {
                message1.Text = "Please provide correct current password.";
                message1.Indicate = AlertType.Error;
                message1.Visible = true;
            }
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to change password.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}