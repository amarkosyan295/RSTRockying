using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_EmailList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }
        if (!Page.IsPostBack && !Page.IsCallback)
        {
            Bind(0);
        }
    }

    private void Bind(int pageIndex)
    {
        try
        {
            using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                string query = "SELECT [ID], [ToAddress], [LastAttempt], [ToName], [ReadDate], [EmailGroup], [EmailType], [IsSent], [IsRead], [CreateDate], [SentDate], [Subject] FROM [EmailMessage] WHERE 1=1 ";

                if (TypeDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND([EmailType] = {1})", query, TypeDropDown.SelectedValue);
                }
                
                if (GroupDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND(EmailGroup = '{1}')", query, GroupDropDown.SelectedValue);
                }

                if (SentDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND([IsSent] = {1})", query, SentDropDown.SelectedValue);
                }

                if (ReadDropDown.SelectedValue != "")
                {
                    query = string.Format("{0} AND([IsRead] = {1})", query, ReadDropDown.SelectedValue);
                }

                query = string.Format("{0} ORDER BY CreateDate desc ", query);

                EmailGrid.DataSource = db.ExecuteQuery<EmailMessage>(query, new object[] { }).ToList<EmailMessage>();
                EmailGrid.PageIndex = pageIndex;
                EmailGrid.DataBind();
            }
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to fetch email records.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Bind(0);
    }
    protected void EmailGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Bind(e.NewPageIndex);
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            
            string query = "Delete FROM [EmailMessage] WHERE 1=1 ";

            if (TypeDropDown.SelectedValue != "")
            {
                query = string.Format("{0} AND([EmailType] = {1})", query, TypeDropDown.SelectedValue);
                
            }

            if (GroupDropDown.SelectedValue != "")
            {
                query = string.Format("{0} AND(EmailGroup = '{1}')", query, GroupDropDown.SelectedValue);
            }

            if (SentDropDown.SelectedValue != "")
            {
                query = string.Format("{0} AND([IsSent] = {1})", query, SentDropDown.SelectedValue);
            }

            if (ReadDropDown.SelectedValue != "")
            {
                query = string.Format("{0} AND([IsRead] = {1})", query, ReadDropDown.SelectedValue);
            }

            //query = string.Format("{0} ORDER BY CreateDate desc ", query);

            db.ExecuteCommand(query, new object[] { });
            Bind(0);
        }
    }
}