using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyBooks : MemberPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsCallback && !Page.IsPostBack)
        {
            BindBooks();
        }
    }

    private void BindBooks()
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            MyBooksRepeater.DataSource = dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID)
                .OrderByDescending(t => t.Book.Title)
                .Select(t => new { t.Book, t.ReadStatus, t.ID });
            MyBooksRepeater.DataBind();
        }

    }

    protected void AddBookButton_Click(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Book b = dc.Books.FirstOrDefault(t => t.ISBN10 == ISBN10Hdn.Value || t.ISBN13 == ISBN13Hdn.Value);
            if (b == null)
            {
                b = new Book()
                {
                    Author = AuthorHdn.Value,
                    CoverPage = CoverPageHdn.Value,
                    CreateDate = DateTime.Now,
                    Description = DescriptionHdn.Value,
                    ISBN10 = ISBN10Hdn.Value,
                    ISBN13 = ISBN13Hdn.Value,
                    Title = BookTitleHdn.Value
                };
                dc.Books.InsertOnSubmit(b);
                dc.SubmitChanges();
            }
            MemberBook mb = dc.MemberBooks.FirstOrDefault(t => t.BookID == b.ID && t.MemberID == CurrentUser.ID);
            if (mb == null)
            {
                mb = new MemberBook()
                {
                    BookID = b.ID,
                    MemberID = CurrentUser.ID,
                    ReadStatus = byte.Parse(ReadStatusHdn.Value),
                    Review = string.Empty
                };
                dc.MemberBooks.InsertOnSubmit(mb);
            }
            else
            {
                mb.ReadStatus = byte.Parse(ReadStatusHdn.Value);
            }
            dc.SubmitChanges();
        }
        Response.Redirect("~/mybooks.aspx");
    }

    protected void MyBooksRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            //Reference the Repeater Item.
            RepeaterItem item = e.Item;

            //Reference the Controls.
            ReadStatusType rs = (ReadStatusType)Enum.Parse(typeof(ReadStatusType), (item.FindControl("ReadStatusLt") as Literal).Text);
            switch (rs)
            {
                case ReadStatusType.Read:
                    (item.FindControl("ReadStatusBadgeLt") as Literal).Text = "<p class='badge bg-primary'>Read</p>";
                    break;
                case ReadStatusType.Reading:
                    (item.FindControl("ReadStatusBadgeLt") as Literal).Text = "<p class='badge bg-success'>Reading</p>";
                    break;
                case ReadStatusType.WanttoRead:
                    (item.FindControl("ReadStatusBadgeLt") as Literal).Text = "<p class='badge bg-secondary'>Want to Read</p>";
                    break;
                default:
                    break;
            }
        }
    }
}