using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Net;
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
    public int percentread;
    public int LikeCount;
    public int DislikeCount;
    public BookReviewEmotionType Emotion;
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
                    LikeCount = dc.MemberBooks.Count(t => t.BookID == bookid && t.Emotion == (byte)BookReviewEmotionType.Like);
                    DislikeCount = dc.MemberBooks.Count(t => t.BookID == bookid && t.Emotion == (byte)BookReviewEmotionType.Dislike);
                    if (CurrentBook.CoverPage.ToLower().StartsWith("http://books.google.com"))
                    {
                        string ph = SaveImage(CurrentBook.CoverPage);
                        if (!string.IsNullOrEmpty(ph))
                        {
                            CurrentBook.CoverPage = "data:image/png;base64," + ph;
                            dc.SubmitChanges();
                        }
                    }
                    Page.Title = CurrentBook.Title;
                    if (CurrentUser != null)
                    {
                        MemberBook = dc.MemberBooks.FirstOrDefault(t => t.BookID == bookid && t.MemberID == CurrentUser.ID);
                        if (MemberBook != null)
                        {
                            Enum.TryParse<BookReviewEmotionType>(MemberBook.Emotion.ToString(), out Emotion);

                            if (MemberBook.ReadStatus == (byte)ReadStatusType.Reading)
                            {
                                MemberBook.CurrentPage = MemberBook.CurrentPage == null ? 0 : MemberBook.CurrentPage;
                                percentread = (int)(0.5f + ((100f * MemberBook.CurrentPage) / CurrentBook.PageCount));
                            }
                        }
                    }
                }
            }
        }

        if (CurrentBook != null)
            if (!Page.IsPostBack && !Page.IsCallback)
                BindReviews(0);
    }

    private string SaveImage(string imageUrl)
    {
        string ph = string.Empty;
        try
        {
            using (WebClient client = new WebClient())
            {
                using (Stream stream = client.OpenRead(imageUrl))
                {
                    using (var memoryStream = new MemoryStream())
                    {
                        stream.CopyTo(memoryStream);
                        byte[] bytes = memoryStream.ToArray();
                        ph = Convert.ToBase64String(bytes);
                    }

                    stream.Flush();
                    stream.Close();
                    client.Dispose();
                }
            }
        }
        catch (Exception ex)
        {

        }
        return ph;

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
                    Review = ReviewTextBox.Text.Trim().Length > 3000 ? ReviewTextBox.Text.Trim().Substring(0, 2999) : ReviewTextBox.Text.Trim(),
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