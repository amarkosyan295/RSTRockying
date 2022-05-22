using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageBook : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsCallback && !Page.IsPostBack)
        {
            BindData();
        }
    }

    private void BindData()
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString)) {
            Book b = dc.Books.FirstOrDefault(t => t.ID == ID);
            if(b != null)
            {
                TitleTextBox.Text = b.Title;
                DescTextBox.Text = b.Description;
                AuthorTextBox.Text = b.Author;
                ISBN13TextBox.Text = b.ISBN13;
                ISBN10TextBox.Text = b.ISBN10;
                //coverpageimg.Src = b.CoverPage;
                CoverPageHdn.Value = b.CoverPage;
                PageCountTextBox.Text = b.PageCount.ToString();
                PublishDateTextBox.Text = b.PublishDate;
                PublisherTextBox.Text = b.Publisher;
                CategoriesTextBox.Text = b.Categories;
                IdentifiersTextBox.Text = b.Identifiers;
            }
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Book b = dc.Books.FirstOrDefault(t => t.ID == ID);
            if (b == null)
                b = new Book()
                {
                    GoogleData = string.Empty,
                    CreateDate = DateTime.Now
                };
            b.CoverPage = CoverPageHdn.Value;
            b.Title = TitleTextBox.Text.Trim();
            b.Description = DescTextBox.Text.Trim();
            b.Author = AuthorTextBox.Text.Trim();
            b.ISBN13 = ISBN13TextBox.Text.Trim();
            b.ISBN10 = ISBN10TextBox.Text.Trim();
            b.PageCount = int.Parse(PageCountTextBox.Text.Trim());
            b.PublishDate = PublishDateTextBox.Text.Trim();
            b.Publisher = PublisherTextBox.Text.Trim();
            b.Categories = CategoriesTextBox.Text.Trim();
            b.Identifiers = IdentifiersTextBox.Text.Trim();
            if(b.ID == 0)
            {
                dc.Books.InsertOnSubmit(b);
            }
            dc.SubmitChanges();
        }
    }
}