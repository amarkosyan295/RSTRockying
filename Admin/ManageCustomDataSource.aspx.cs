using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_ManageCustomDataSource : AdminPage
{
    DataSourceManager dsm = new DataSourceManager();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }

        if (!Page.IsPostBack && !Page.IsCallback)
        {
            if (Mode == "edit")
            {
                var item = dsm.GetById(ID);
                if (item != null)
                {
                    NameTextBox.Text = item.Name;
                    QueryTextBox.Text = item.Query;
                    TemplateTextBox.Text = item.HtmlTemplate;
                }
            }
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {

        if (Mode == "add")
        {
            if (dsm.GetByName(NameTextBox.Text.Trim()) != null)
            {
                args.IsValid = false;
            }
        }
        else if (Mode == "edit")
        {
            var item = dsm.GetByName(NameTextBox.Text.Trim());
            if (item != null)
            {
                if (item.ID != ID)
                {
                    args.IsValid = false;
                }
            }
        }
    }
    protected void NameTextBox_TextChanged(object sender, EventArgs e)
    {
        CustomValidator1.Validate();
        NameTextBox.Text = NameTextBox.Text.Replace(" ", "");
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("validategrp");
        if (!Page.IsValid) return;

        try
        {
            if (Mode == "add")
            {
                if (dsm.Add(NameTextBox.Text.Trim(), QueryTextBox.Text.Trim(), TemplateTextBox.Text.Trim(), CurrentUser.ID))
                {
                    Response.Redirect("CustomDataSourceList.aspx");
                }
            }
            else if (Mode == "edit")
            {
                if (dsm.Update(ID, NameTextBox.Text.Trim(), QueryTextBox.Text.Trim(), TemplateTextBox.Text.Trim(), CurrentUser.ID))
                {
                    Response.Redirect("CustomDataSourceList.aspx");
                }
            }
        }
        catch(Exception ex) {
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            message1.Text = ex.Message;
        }
    }
    protected void QueryTextBox_TextChanged(object sender, EventArgs e)
    {
        CustomValidator2.Validate();
    }
    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string temp = QueryTextBox.Text.Trim().ToLower();
        if (temp.Contains("delete") || temp.Contains("insert") || temp.Contains("update") || temp.Contains("drop") || temp.Contains("alter"))
        {
            args.IsValid = false;
        }
    }
    
}