using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MyStories : MemberPage
{
    public List<Post> Stories { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        Stories = new List<Post>();
        if (!Page.IsCallback && !Page.IsPostBack)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                Stories.AddRange(dc.Posts.Where(t => t.CreatedBy == CurrentUser.ID)
                    .OrderByDescending(t => t.DateCreated));
                StoryRepeater.DataSource = Stories;
                StoryRepeater.DataBind();
            }
        }
    }

    protected void StoryRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "delete")
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                Post p = (from t in dc.Posts where t.ID == int.Parse(e.CommandArgument.ToString()) select t).SingleOrDefault();
                dc.Posts.DeleteOnSubmit(p);
                dc.SubmitChanges();

                StoryRepeater.DataSource = dc.Posts.Where(t => t.CreatedBy == CurrentUser.ID).OrderByDescending(t => t.DateCreated);
                StoryRepeater.DataBind();
            }
        }
    }

    protected void CreatePostBtn_Click(object sender, EventArgs e)
    {
        Post p = new Post()
        {
            Article = string.Empty,
            CreatedBy = CurrentUser.ID,
            Description = string.Empty,
            OGDescription = string.Empty,
            OGImage = string.Empty,
            Status = 1,
            Tag = string.Empty,
            Title = string.Empty,
            URL = string.Empty,
            WriterEmail = CurrentUser.Email,
            WriterName = CurrentUser.MemberName,
            DateCreated = DateTime.Now
        };
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            p.Category1 = dc.Categories.FirstOrDefault(t => t.Name == "Fiction");
            dc.Posts.InsertOnSubmit(p);
            dc.SubmitChanges();
        }
        Response.Redirect("~/editstory.aspx?id=" + p.ID);

    }
}