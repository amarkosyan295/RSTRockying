using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Register : BasePage
{
    Random oRandom = new Random();


    int iNumber;
    protected void Page_Load(object sender, EventArgs e)
    {
        iNumber = oRandom.Next(100000, 999999);
        if (!Page.IsPostBack && !Page.IsCallback)
        {
            PopulateYear();
            PopulateDays();
            
            Session["captcha"] = iNumber.ToString();

            if (!string.IsNullOrEmpty(Request.QueryString["message"]))
            {
                message1.Text = "Congratulations you are now a registered member of Rockying. You will recieve an email from " + Utility.ContactEmail + " make sure to mark this email address as safe. Please click the account activation link provided in the email.";
                message1.Indicate = AlertType.Success;
                message1.Visible = true;
            }
        }
        else
        {
            message1.Visible = false;
            message1.Text = "";
        }
    }

    public void PopulateYear()
    {
        YearDropDown.Items.Clear();

        int year = DateTime.Now.Year - 13;
        for (int i = year; i >= (year - 80); i--)
        {
            YearDropDown.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }

    public void PopulateDays()
    {
        DateDropDown.Items.Clear();
        for (int i = 1; i <= DateTime.DaysInMonth(int.Parse(YearDropDown.SelectedValue), int.Parse(MonthDropDown.SelectedValue)); i++)
        {
            DateDropDown.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("logingrp");
        if (!Page.IsValid) return;
        if (Captcha.ValidateCaptcha())
        {
            try
            {
                DateTime dob = DateTime.Parse(string.Format("{0}-{1}-{2}", YearDropDown.SelectedValue, MonthDropDown.SelectedValue,
                    DateDropDown.SelectedValue));
                if (MemberManager.CreateUser(EmailTextBox.Text.Trim(), PasswordTextBox.Text.Trim(), newsletterchk.Checked, NameTextBox.Text.Trim(), dob, GenderDropDown.SelectedValue, WriterCheckBox.Checked ? MemberTypeType.Author : MemberTypeType.Member))
                {
                    EmailManager.SendActivationEmail(EmailTextBox.Text.Trim(), NameTextBox.Text.Trim(), PasswordTextBox.Text.Trim());
                    Response.Redirect("~/account/register?message=yes");
                }
            }
            catch (Exception ex)
            {
                message1.Text = Resources.Resource.GenericMessage;
                message1.Indicate = AlertType.Error;
                message1.Visible = true;
                Trace.Write("Register error");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }
        else
        {
            message1.Text = "Captcha Mismatch";
            message1.Indicate = AlertType.Error;
            message1.Visible = true;
        }
    }

    

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (MemberManager.EmailExist(EmailTextBox.Text.Trim()))
        {
            args.IsValid = false;
        }
    }
    protected void YearDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopulateDays();
    }
    protected void MonthDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        PopulateDays();
    }
}