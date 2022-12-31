using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyLibrary : MemberPage
{
    public List<MemberBook> MemberBooks = new List<MemberBook>();
    public decimal PagesReadThisYear { get; set; }
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        BookSearch2.CurrentUser = CurrentUser;

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        BindBooks();
    }

    private void BindBooks()
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            MemberBooks.AddRange(dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID)
                .OrderByDescending(t => t.ID));

            var pages = dc.MemberBooks.Where(t => t.ReadingStartDate.HasValue && t.ReadingStartDate.Value.Year == DateTime.Now.Year && t.MemberID == CurrentUser.ID).Sum(t => t.CurrentPage);
            if (pages.HasValue)
                PagesReadThisYear = pages.Value / 365;

        }
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
                    (item.FindControl("ReadStatusBadgeLt") as Literal).Text = "<p class='text-success fw-bold text-capitalize'>Read</p>";
                    break;
                case ReadStatusType.Reading:
                    (item.FindControl("ReadStatusBadgeLt") as Literal).Text = "<p class='text-primary fw-bold text-capitalize'>Reading Now</p>";
                    break;
                case ReadStatusType.WanttoRead:
                    (item.FindControl("ReadStatusBadgeLt") as Literal).Text = "<p class='text-secondary fw-bold text-capitalize'>Want to Read</p>";
                    break;
                default:
                    break;
            }
        }
    }

    protected void MyBooksRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "remove")
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                MemberBook mb = (from t in dc.MemberBooks where t.ID == int.Parse(e.CommandArgument.ToString()) && t.MemberID == CurrentUser.ID select t).SingleOrDefault();
                dc.MemberBooks.DeleteOnSubmit(mb);
                dc.SubmitChanges();
            }
            BindBooks();
        }
    }
}