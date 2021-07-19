using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class account_unsubscribe : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["mail"] != null)
            {
                EmailTextBox.Text = Request.QueryString["mail"].Trim();
            }
        }
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        try
        {
           Member m =  MemberManager.GetUser(EmailTextBox.Text.Trim());
           if (m != null)
           {
               MemberManager.Update(m.Email, m.MemberName, false, (GeneralStatusType)m.Status);
               message1.Text = "We have removed your email address from our subscribers list.";
               message1.Indicate = AlertType.Success;
               message1.Visible = true;
           }
           else
           {
               message1.Text = "We cannot find provided email address in our subscribers list. Please make check for spelling errors.";
               message1.Indicate = AlertType.Error;
               message1.Visible = true;
           }
        }
        catch(Exception ex)
        {
            message1.Text = Resources.Resource.GenericMessage;
            message1.Indicate = AlertType.Error;
            message1.Visible = true;
            Trace.Write("Unable to save information");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
            return;
        }

        string body = string.Format("Email: {0}<br/>Reason: {1}<br/>Comments: <br/>{2}<br/>", EmailTextBox.Text.Trim(), ReasonDropDown.SelectedValue, CommentTextBox.Text.Trim());
        EmailManager.SendMail(Utility.NewsletterEmail, "rajkiran.singh@rudrasofttech.com", "Rockying", "Raj Kiran Singh", body, "Unsubscribe Request", "preeti.singh@rudrasofttech.com", EmailMessageType.Unsubscribe, EmailMessageType.Unsubscribe.ToString());
    }
}