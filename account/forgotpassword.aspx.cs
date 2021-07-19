using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;
using System.Text;

public partial class account_forgotpassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.Action = string.Format("forgotpassword{0}", Request.Url.Query);
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        try
        {
            Page.Validate("logingrp");
            if (!Page.IsValid) return;
            Member m = MemberManager.GetUser(EmailTextBox.Text);
            if (m != null)
            {
                StringBuilder builder = new StringBuilder();
                builder.Append(string.Format("Hello {0},<br/>", m.MemberName));
                builder.Append("<br/><br/>");
                builder.Append("Please check your password provided below.<br/>");
                builder.Append(string.Format("Email - {0},<br/>", m.Email));
                builder.Append(string.Format("Password - {0},<br/>", m.Password));
                builder.Append("<br/><br/>");

                if (EmailManager.SendMail(Utility.NewsletterEmail, m.Email, Utility.SiteName, m.MemberName, builder.ToString(), "Account Password Notification", EmailMessageType.Notification, "Password Notification"))
                {
                    message1.Text = string.Format("We have sent your password to {0} email account. If you do not find any email in your inbox also check SPAM folder. Sender email - {1}", m.Email, Utility.NewsletterEmail);
                    message1.Visible = true;
                    message1.Indicate = AlertType.Success;
                }
            }
            else
            {
                message1.Text = "We could not find any information related to email address provided.";
                message1.Visible = true;
                message1.Indicate = AlertType.Error;
            }
        }
        catch (Exception ex)
        {
            message1.Text = Resources.Resource.GenericMessage;
            message1.Visible = true;
            message1.Heading = Resources.Resource.WarningHeading;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to retreive password.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}