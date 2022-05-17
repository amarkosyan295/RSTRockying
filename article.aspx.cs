using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Rockying;
using Rockying.Models;
using System.IO;

public partial class _Article : BasePage
{
    public PostPageModel PPM { get; set; }
    //public int ID { get; set; }
    public Member CurrentUser { get; set; }
    public bool Preview { get; set; }
    public decimal PostRating { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

        PPM = new PostPageModel();
        string pname = "";
        if (Page.RouteData.Values["pagename"] != null)
        {
            pname = Page.RouteData.Values["pagename"].ToString();
        }

        //if (Request.IsAuthenticated)
        //{
        //    CurrentUser = MemberManager.GetUser(User.Identity.Name);
        //}

        if (Request.QueryString["preview"] != null)
        {
            try
            {
                Preview = Convert.ToBoolean(Request.QueryString["preview"]);
            }
            catch (Exception ex)
            {
                Preview = false;
                Trace.Write("Invalid id");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }

        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post item = (from t in dc.Posts
                         where t.URL.ToLower().Trim() == pname.ToLower().Trim()
                             && (t.Status == (byte)PostStatusType.Publish || Preview == true)
                         select t).SingleOrDefault();
            if (item != null)
            {
                PPM.ArticleCreator = item.Member;
                Article a = new Article
                {
                    Category = item.Category,
                    CategoryName = item.Category1.Name,
                    CreatedBy = item.CreatedBy,
                    CreatedByName = item.Member.MemberName,
                    DateCreated = item.DateCreated,
                    DateModified = item.DateModified,
                    Description = item.Description,
                    ID = item.ID,
                    ModifiedBy = item.ModifiedBy,
                    Status = (PostStatusType)item.Status,
                    Tag = string.Format("{0}, {1}", item.Tag, item.Category1.Keywords),
                    Title = item.Title,
                    WriterEmail = item.WriterEmail,
                    WriterName = item.WriterName,
                    Viewed = item.Viewed,
                    URL = item.URL,
                    Text = item.Article
                };
                PPM.Item = a;
                if (File.Exists(Server.MapPath("~/rockyingdata/article/" + a.ID + ".m4a")))
                {
                    PPM.AudioURL = string.Format("{0}/rockyingdata/article/{1}.m4a", Utility.SiteURL, a.ID);
                }
                PPM.ArticleCategory = item.Category1;
                if (PPM.ArticleCreator.UserType != (byte)MemberTypeType.Admin)
                {
                    PPM.Item.Text = HttpUtility.HtmlEncode(PPM.Item.Text);
                    //change article text add HTML tags.
                    PPM.Item.Text = string.Format("<p>{0}</p>", PPM.Item.Text.Replace("\n", "</p><p>"));
                }

                // get the next article by this writer in the same category
                PPM.NextByWriter = (from t in dc.Posts
                                    where t.ID > item.ID && t.CreatedBy == item.CreatedBy && t.Category == item.Category
                                        && (t.Status == (byte)PostStatusType.Publish)
                                    select t).FirstOrDefault();
                if (PPM.NextByWriter != null)
                {
                    PPM.RecommendationList.Add(new Article(PPM.NextByWriter));
                }

                // get the previous article by this writer in the same category
                PPM.PrevByWriter = (from t in dc.Posts
                                    where t.ID < item.ID && t.CreatedBy == item.CreatedBy && t.Category == item.Category
                                        && (t.Status == (byte)PostStatusType.Publish)
                                    select t).FirstOrDefault();
                if (PPM.PrevByWriter != null)
                {
                    PPM.RecommendationList.Add(new Article(PPM.PrevByWriter));
                }
                //- 3 latest stories by other writers in same category
                var Latest3SameCatOtherWrites = (from t in dc.Posts
                                                 where t.CreatedBy != item.CreatedBy && t.Category == item.Category
                                                     && (t.Status == (byte)PostStatusType.Publish)
                                                 select t).OrderByDescending(t => t.DateCreated).Take(3);
                foreach (Post p in Latest3SameCatOtherWrites)
                {
                    if (PPM.NextByWriter != null && p.ID == PPM.NextByWriter.ID)
                        continue;
                    
                    if (PPM.PrevByWriter != null && p.ID == PPM.PrevByWriter.ID)
                        continue;
                    
                    if (PPM.Item != null && p.ID == PPM.Item.ID)
                        continue;
                    

                    PPM.RecommendationList.Add(new Article(p));
                }
                //- 1 latest story by writer in other category
                var LatestStoryByWriterInOtherCat = (from t in dc.Posts
                                                     where t.CreatedBy == item.CreatedBy &&
                                                     t.Category != item.Category &&
                                                     t.Status == (byte)PostStatusType.Publish
                                                     select t).OrderByDescending(t => t.DateCreated).FirstOrDefault();
                if (LatestStoryByWriterInOtherCat != null)
                {
                    PPM.RecommendationList.Add(new Article(LatestStoryByWriterInOtherCat));
                }

                //- 5 latest stories on site in all categories
                var Latest5AllCat = (from t in dc.Posts
                                     where (PPM.Item != null && t.ID != PPM.Item.ID) && t.Status == (byte)PostStatusType.Publish
                                     select t).OrderByDescending(t => t.DateCreated).Take(5);
                foreach (Post p in Latest5AllCat)
                {
                    if (PPM.NextByWriter != null && p.ID == PPM.NextByWriter.ID)
                        continue;
                    
                    if (PPM.PrevByWriter != null && p.ID == PPM.PrevByWriter.ID)
                        continue;
                    
                    PPM.RecommendationList.Add(new Article(p));
                }

                foreach (TopStory ts in dc.TopStories)
                { 
                    if (PPM.NextByWriter != null && ts.PostId == PPM.NextByWriter.ID)
                        continue;

                    if (PPM.PrevByWriter != null && ts.PostId == PPM.PrevByWriter.ID)
                        continue;
                    
                    if (PPM.Item != null && ts.PostId == PPM.Item.ID)
                        continue;
                    
                    PPM.RecommendationList.Add(new Article(ts.Post));
                }
            }
        }
    }
}