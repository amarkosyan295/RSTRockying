using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditStory : MemberPage
{
    int ID;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (string.IsNullOrEmpty(Request.QueryString["id"]))
            Response.Redirect("~/mystories.aspx");
        else if (!int.TryParse(Request.QueryString["id"], out ID))
            Response.Redirect("~/mystories.aspx");

        if (!Page.IsCallback && !Page.IsPostBack)
        {
            PopulateForm();
        }
    }

    private void PopulateForm()
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            UrlTextBox.Text = p.URL;
            TitleTextBox.Text = p.Title;
            TagTextBox.Text = p.Tag;
            WriterTextBox.Text = p.WriterName;
            CategoryDropDown.SelectedValue = p.Category.ToString();
            FacebookImageTextBox.Text = p.OGImage.Replace("http://rockying.com/", "//rockying.com/").Replace("http://rudrasofttech.com/rockying/", "//rockying.com/").Replace("http://www.rudrasofttech.com/rockying/", "//rockying.com/").Replace("http://www.rockying.com/", "//rockying.com/");
            FacebookDescTextBox.Text = p.OGDescription;
            StatusDropDown.SelectedValue = ((byte)p.Status).ToString();
            TextTextBox.Text = p.Article;
        }
    }

    protected void TitleTextBox_TextChanged(object sender, EventArgs e)
    {
        TitleReqVal.Validate();
        if (!TitleReqVal.IsValid)
            return;

        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.Title = TitleTextBox.Text.Trim();
            dc.SubmitChanges();
        }
        if (string.IsNullOrEmpty(UrlTextBox.Text))
        {
            UrlTextBox.Text = Utility.Slugify(TitleTextBox.Text.Trim());
            SaveUrl();
        }
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {

    }

    protected void UrlTextBox_TextChanged(object sender, EventArgs e)
    {
        SaveUrl();
    }

    private void SaveUrl()
    {
        UrlTextBox.Text = Utility.Slugify(UrlTextBox.Text.Trim());
        UrlReqVal.Validate();
        if (!UrlReqVal.IsValid)
            return;
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.URL = UrlTextBox.Text.Trim();
            dc.SubmitChanges();
        }
    }

    protected void UrlCustomVal_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            if (dc.Posts.Count(t => t.URL == UrlTextBox.Text.Trim() && t.ID != ID) >= 0)
                args.IsValid = false;
            else
                args.IsValid = true;
        }
    }

    protected void CategoryDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        CategoryReqVal.Validate();
        if (!CategoryReqVal.IsValid)
            return;

        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.Category = int.Parse(CategoryDropDown.SelectedValue);
            dc.SubmitChanges();
        }
    }

    protected void TextTextBox_TextChanged(object sender, EventArgs e)
    {
        TextReqVal.Validate();
        if (!TextReqVal.IsValid)
            return;
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.Article = TextTextBox.Text.Trim();
            dc.SubmitChanges();
        }
    }

    protected void TagTextBox_TextChanged(object sender, EventArgs e)
    {
        TagReqVal.Validate();
        if (!TagReqVal.IsValid)
            return;
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.Tag = TagTextBox.Text.Trim();
            dc.SubmitChanges();
        }
    }

    protected void WriterTextBox_TextChanged(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.WriterName = WriterTextBox.Text.Trim();
            dc.SubmitChanges();
        }
    }

    protected void FacebookImageTextBox_TextChanged(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.OGImage = FacebookImageTextBox.Text.Trim().Replace("http://rockying.com/", "//rockying.com/").Replace("http://rudrasofttech.com/rockying/", "//rockying.com/").Replace("http://www.rudrasofttech.com/rockying/", "//rockying.com/").Replace("http://www.rockying.com/", "//rockying.com/");
            dc.SubmitChanges();
        }
    }

    protected void FacebookDescTextBox_TextChanged(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.OGDescription = FacebookDescTextBox.Text.Trim();
            dc.SubmitChanges();
        }
    }

    protected void StatusDropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
            p.Status = byte.Parse( StatusDropDown.SelectedValue);
            dc.SubmitChanges();
        }
    }
}