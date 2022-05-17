using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class RockyingBook : BasePage
{
    public Book CurrentBook { get; set; }
    public List<MemberBook> Reviews { get; set; }
    private int bookid;
    public MemberBook MemberBook { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        Reviews = new List<MemberBook>();
        if (Page.RouteData.Values["id"] != null && int.TryParse(Page.RouteData.Values["id"].ToString(), out bookid))
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                CurrentBook = dc.Books.FirstOrDefault(t => t.ID == bookid);
                if (CurrentBook != null)
                {
                    Page.Title = CurrentBook.Title;

                    if (CurrentUser != null)
                    {
                        MemberBook = dc.MemberBooks.FirstOrDefault(t => t.BookID == bookid && t.MemberID == CurrentUser.ID);
                        ReviewFormPlaceHolder.Visible = true;
                    }
                    else
                        ReviewFormPlaceHolder.Visible = false;

                }
            }
        }

        if (CurrentBook != null)
            if (!Page.IsPostBack && !Page.IsCallback)
                BindReviews(0);
    }

    private void BindReviews(int pageIndex)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            ReviewGridView.DataSource = dc.MemberBooks.Where(t => t.BookID == bookid && t.Review != "").OrderByDescending(t => t.ID).Take(1000).ToList();
            ReviewGridView.PageIndex = pageIndex;
            ReviewGridView.DataBind();
        }
    }

    private void SaveBookToLibrary(ReadStatusType readStatus)
    {
        if (CurrentUser != null)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                MemberBook = dc.MemberBooks.FirstOrDefault(t => t.BookID == bookid && t.MemberID == CurrentUser.ID);
                if (MemberBook == null)
                {
                    MemberBook = new MemberBook()
                    {
                        BookID = bookid,
                        MemberID = CurrentUser.ID,
                        ReadStatus = (byte)readStatus,
                        Review = string.Empty,
                        Emotion = 0
                    };
                    dc.MemberBooks.InsertOnSubmit(MemberBook);
                }
                else
                {
                    MemberBook.ReadStatus = (byte)readStatus;
                }
                dc.SubmitChanges();
            }
        }
    }

    protected void ReadStatusBtn_Click(object sender, EventArgs e)
    {
        SaveBookToLibrary(ReadStatusType.Read);
        Response.Redirect("~/book/" + Utility.Slugify(CurrentBook.Title) + "-" + CurrentBook.ID);
    }

    protected void ReadingStatusBtn_Click(object sender, EventArgs e)
    {
        SaveBookToLibrary(ReadStatusType.Reading);
        Response.Redirect("~/book/" + Utility.Slugify(CurrentBook.Title) + "-" + CurrentBook.ID);
    }

    protected void WantReadBtn_Click(object sender, EventArgs e)
    {
        SaveBookToLibrary(ReadStatusType.WanttoRead);
        Response.Redirect("~/book/" + Utility.Slugify(CurrentBook.Title) + "-" + CurrentBook.ID);
    }

    protected void SaveReviewButton_Click(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            MemberBook = dc.MemberBooks.FirstOrDefault(t => t.BookID == bookid && t.MemberID == CurrentUser.ID);
            if (MemberBook == null)
            {
                MemberBook = new MemberBook()
                {
                    BookID = bookid,
                    MemberID = CurrentUser.ID,
                    ReadStatus = (byte)ReadStatusType.Read,
                    Review = ReviewTextBox.Text.Trim(),
                    Emotion = 0
                };
                dc.MemberBooks.InsertOnSubmit(MemberBook);
            }
            else
            {
                MemberBook.Review = ReviewTextBox.Text.Trim();
            }
            dc.SubmitChanges();
        }
        Response.Redirect("~/book/" + Utility.Slugify(CurrentBook.Title) + "-" + CurrentBook.ID);
    }


    protected void ReviewGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        BindReviews(e.NewPageIndex);
    }
}