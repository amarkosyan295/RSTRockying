using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_Books : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsCallback && !Page.IsPostBack)
            BindBooks(0);
    }

    private void BindBooks(int pageindex)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            var query = from t in dc.Books
                        where (KeywordTextBox.Text == "" || (t.Title.Contains(KeywordTextBox.Text.Trim()) || t.Author.Contains(KeywordTextBox.Text.Trim()) || t.ISBN13.Contains(KeywordTextBox.Text.Trim()) || t.ISBN10.Contains(KeywordTextBox.Text.Trim()) || t.Identifiers.Contains(KeywordTextBox.Text.Trim())))
                        select t;
            BooksGridView.DataSource = query;
            BooksGridView.PageIndex = pageindex;
            BooksGridView.DataBind();
        }
    }



    protected void BooksGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        BindBooks(e.NewPageIndex);
    }


    protected void BooksGridView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Remove")
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                long bid = long.Parse(e.CommandArgument.ToString());
                dc.MemberBooks.DeleteAllOnSubmit(dc.MemberBooks.Where(t => t.BookID == bid));
                dc.Books.DeleteOnSubmit(dc.Books.First(t => t.ID == bid));
                dc.SubmitChanges();
            }
            BindBooks(BooksGridView.PageIndex);
        }
    }

    protected void SearchButton_Click(object sender, EventArgs e)
    {
        BindBooks(0);
    }
}