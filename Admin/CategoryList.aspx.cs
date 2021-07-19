using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_CategoryList : AdminPage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }
        if (!Page.IsCallback && !Page.IsPostBack)
        {
            PopulateParent();
            PopulateCategory();
        }
    }

    private void PopulateParent()
    {
        ParentDropDown.Items.Clear();
        ParentDropDown.Items.Add(new ListItem("--select--", ""));
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            var items = from u in dc.Categories where u.Status != (byte)GeneralStatusType.Deleted select u;
            foreach (Category c in items)
            {
                ParentDropDown.Items.Add(new ListItem(c.Name, c.ID.ToString()));
            }
        }
    }

    private void PopulateCategory()
    {
        if (Mode == "edit")
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Category c = (from u in dc.Categories where u.ID == ID select u).SingleOrDefault();
                if (c != null)
                {
                    NameTextBox.Text = c.Name;
                    if (c.Parent.HasValue)
                    {
                        ParentDropDown.SelectedValue = c.Parent.Value.ToString();
                    }
                    StatusDropDown.SelectedValue = c.Status.ToString();
                    UrlNameTextBox.Text = c.UrlName;
                    KeywordTextBox.Text = c.Keywords;
                    dc.SubmitChanges();
                }
            }
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        if (Mode == "add" || Mode == string.Empty)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Category c = new Category();
                c.Name = NameTextBox.Text.Trim();
                if (ParentDropDown.SelectedValue != string.Empty)
                {
                    c.Parent = int.Parse(ParentDropDown.SelectedValue);
                }
                c.Status = byte.Parse(StatusDropDown.SelectedValue);
                c.UrlName = UrlNameTextBox.Text.Trim();
                dc.Categories.InsertOnSubmit(c);
                dc.SubmitChanges();
            }
        }
        else if (Mode == "edit")
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Category c = (from u in dc.Categories where u.ID == ID select u).SingleOrDefault();
                if (c != null)
                {
                    c.Name = NameTextBox.Text.Trim();
                    if (ParentDropDown.SelectedValue != string.Empty)
                    {
                        c.Parent = int.Parse(ParentDropDown.SelectedValue);
                    }
                    c.Status = byte.Parse(StatusDropDown.SelectedValue);
                    c.UrlName = UrlNameTextBox.Text.Trim();
                    c.Keywords = KeywordTextBox.Text.Trim();
                    dc.SubmitChanges();
                }
            }
        }
        Response.Redirect("categorylist.aspx");
    }
}