using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying.Models;
using Rockying;

public partial class myaccount : MemberPage
{
    Member m;
    protected void Page_Load(object sender, EventArgs e)
    {
        m = CurrentUser;

        if (!Page.IsPostBack && !Page.IsCallback)
        {
            PopulateYear();
            PopulateDays();
            Populate();
        }
    }

    private void Populate()
    {
        EmailTextBox.Text = m.Email;
        NameTextBox.Text = m.MemberName;
        SubscribeCheckBox.Checked = m.Newsletter;
        LastNameTextBox.Text = m.LastName;
        if (m.DOB.HasValue)
        {
            YearDropDown.SelectedValue = m.DOB.Value.Year.ToString();
            MonthDropDown.SelectedValue = m.DOB.Value.Month.ToString();
            PopulateDays();
            DateDropDown.SelectedValue = m.DOB.Value.Date.ToString();
        }
        CountryDropDown.SelectedValue = m.Country;
        
        AltEmailTextBox.Text = m.AlternateEmail;
        //AltEmail2TextBox.Text = m.AlternateEmail2;
        MobileTextBox.Text = m.Mobile;
        //PhoneTextBox.Text = m.Phone;
        AddressTextBox.Text = m.Address;
        if (m.Gender.HasValue)
        {
            GenderDropDown.SelectedValue = m.Gender.Value.ToString();
        }
        WriterDropDown.SelectedValue = m.UserType.ToString();
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

        try
        {
            DateTime dob = DateTime.Parse(string.Format("{0}-{1}-{2}", YearDropDown.SelectedValue, MonthDropDown.SelectedValue,
                DateDropDown.SelectedValue));

            if (MemberManager.Update(Page.User.Identity.Name, NameTextBox.Text.Trim(), SubscribeCheckBox.Checked, dob,
                CountryDropDown.SelectedValue, AltEmailTextBox.Text.Trim(),
                MobileTextBox.Text.Trim(), "", "",
                AddressTextBox.Text.Trim(), LastNameTextBox.Text.Trim(), m.ID,
                GenderDropDown.SelectedValue, (MemberTypeType)Enum.Parse(typeof(MemberTypeType), WriterDropDown.SelectedValue)))
            {
                message1.Text = "Account info updated successfully.";
                message1.Indicate = AlertType.Success;
                message1.Visible = true;
            }
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to update account info.";
            message1.Indicate = AlertType.Error;
            message1.Visible = true;
            Trace.Write("Unable to update account info");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        try
        {
            if (MemberManager.Delete(Page.User.Identity.Name, m.ID))
            {
                message1.Text = string.Format("Account has been disabled. <a href='http://{0}/logout'>Logout Now</a>", Request.Url.Host);
                message1.Indicate = AlertType.Success;
                message1.Visible = true;
            }
        }
        catch (Exception ex)
        {
            message1.Text = Resources.Resource.GenericMessage;
            message1.Indicate = AlertType.Error;
            message1.Visible = true;
            Trace.Write("Unable to disable account");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
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
