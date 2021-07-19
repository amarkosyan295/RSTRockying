using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_SendMail : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }

        if (!Page.IsPostBack && !Page.IsCallback)
        {

            Member m = MemberManager.GetUser(ID);
            if (m != null)
            {
                ToNameTextBox.Text = m.MemberName;
                ToEmailTextBox.Text = m.Email;
            }
            else
            {
                Response.Redirect("MemberList.aspx");
            }
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        try
        {
            EmailManager.SendMail(Utility.ContactEmail, ToEmailTextBox.Text.Trim(), Utility.AdminName, ToNameTextBox.Text.Trim(), MessageTextBox.Text,SubjectTextBox.Text.Trim(), (EmailMessageType)Enum.Parse(typeof(EmailMessageType),ETypeList.SelectedValue), EGroupTextBox.Text.Trim());
            message1.Text = "Mail Sent Successfuly";
            message1.Visible = true;
            message1.Indicate = AlertType.Success;
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to send email.";
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to send email.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}