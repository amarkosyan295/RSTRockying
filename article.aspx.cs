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

        if (Request.IsAuthenticated)
        {
            CurrentUser = MemberManager.GetUser(User.Identity.Name);
        }

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
                Article a = new Article();
                try
                {
                    if (!string.IsNullOrWhiteSpace(item.Article))
                    {
                        a = Utility.Deserialize<Article>(item.Article);
                    }
                    //else
                    //{
                    //    a = Utility.Deserialize<Article>(System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", item.ID, Utility.ArticleFolder))));
                    //}
                }
                catch (Exception ex)
                {
                    Trace.Write("Unable to read xml file of article.");
                    Trace.Write(ex.Message);
                    Trace.Write(ex.StackTrace);
                    try
                    {
                        a.Text = System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/article-{0}.txt", item.ID, Utility.ArticleFolder)));
                    }
                    catch (Exception ex1)
                    {
                        a.Text = string.Empty;
                        Trace.Write(ex1.Message);
                        Trace.Write(ex1.StackTrace);
                    }
                }
                a.Category = item.Category;
                a.CategoryName = item.Category1.Name;
                a.CreatedBy = item.CreatedBy;
                a.CreatedByName = item.Member.MemberName;
                a.DateCreated = item.DateCreated;
                a.DateModified = item.DateModified;
                a.Description = item.Description;
                a.ID = item.ID;
                a.ModifiedBy = item.ModifiedBy;
                a.Status = (PostStatusType)item.Status;
                a.Tag = string.Format("{0}, {1}", item.Tag, item.Category1.Keywords);
                a.Title = item.Title;
                a.WriterEmail = item.WriterEmail;
                a.WriterName = item.WriterName;
                a.Viewed = item.Viewed;
                a.URL = item.URL;

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
                GetRating();
                //#region Replace Custom Data Source
                //DataSourceManager dsm = new DataSourceManager();
                //if (PPM.Item.TemplateName == string.Empty)
                //{
                //    PPM.Item.TemplateName = "LeftColumnBlogTemplate";
                //}
                //if (PPM.Item.TemplateName != string.Empty)
                //{
                //    HtmlAgilityPack.HtmlDocument doc = new HtmlAgilityPack.HtmlDocument();
                //    string templateHTML = dsm.LoadContent(PPM.Item.TemplateName);
                //    doc.LoadHtml(templateHTML);

                //    if (doc.DocumentNode.SelectNodes("//datasource") != null)
                //    {
                //        foreach (HtmlAgilityPack.HtmlNode ds in doc.DocumentNode.SelectNodes("//datasource"))
                //        {
                //            try
                //            {
                //                HtmlAgilityPack.HtmlAttribute att = ds.Attributes["name"];

                //                if (att != null)
                //                {
                //                    var temp = doc.CreateElement("temp");
                //                    var current = ds;
                //                    if (att.Value == "articletext")
                //                    {
                //                        temp.InnerHtml = PPM.Item.Text;
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articleimg")
                //                    {
                //                        if (PPM.Item.OGImage != string.Empty)
                //                            temp.InnerHtml = string.Format("<img src='{0}' alt='' />", PPM.Item.OGImage);
                //                        else
                //                            temp.InnerHtml = "";

                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articletitle")
                //                    {
                //                        temp.InnerHtml = PPM.Item.Title;
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articledate")
                //                    {
                //                        temp.InnerHtml = PPM.Item.DateCreated.ToShortDateString();
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articleviewcount")
                //                    {
                //                        temp.InnerHtml = PPM.Item.Viewed.ToString();
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articletag")
                //                    {
                //                        temp.InnerHtml = PPM.Item.Tag;
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articlewritername")
                //                    {
                //                        temp.InnerHtml = PPM.Item.WriterName;
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articlewriteremail")
                //                    {
                //                        temp.InnerHtml = PPM.Item.WriterEmail;
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articlecategory")
                //                    {
                //                        temp.InnerHtml = PPM.Item.CategoryName;
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                    else if (att.Value == "articledescription")
                //                    {
                //                        temp.InnerHtml = PPM.Item.OGDescription;
                //                        foreach (var child in temp.ChildNodes)
                //                        {
                //                            ds.ParentNode.InsertAfter(child, current);
                //                            current = child;
                //                        }
                //                        ds.Remove();
                //                    }
                //                }
                //            }
                //            catch (Exception ex) {
                //                Trace.Write(ex.Message);
                //                Trace.Write(ex.Source);
                //                Trace.Write(ex.StackTrace);
                //            }
                //        }
                //    }

                //    PPM.Item.Text = doc.DocumentNode.OuterHtml;
                //}
                //PPM.Item.Text = dsm.ParseAndPopulate(PPM.Item.Text);
                //#endregion

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
                    {
                        continue;
                    }
                    if (PPM.PrevByWriter != null && p.ID == PPM.PrevByWriter.ID)
                    {
                        continue;
                    }
                    if (PPM.Item != null && p.ID == PPM.Item.ID)
                    {
                        continue;
                    }

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
                    {
                        continue;
                    }
                    if (PPM.PrevByWriter != null && p.ID == PPM.PrevByWriter.ID)
                    {
                        continue;
                    }
                    PPM.RecommendationList.Add(new Article(p));
                }

                foreach (TopStory ts in dc.TopStories)
                {

                    if (PPM.NextByWriter != null && ts.PostId == PPM.NextByWriter.ID)
                    {
                        continue;
                    }
                    if (PPM.PrevByWriter != null && ts.PostId == PPM.PrevByWriter.ID)
                    {
                        continue;
                    }
                    if (PPM.Item != null && ts.PostId == PPM.Item.ID)
                    {
                        continue;
                    }

                    PPM.RecommendationList.Add(new Article(ts.Post));
                }
            }

        }

    }

    private void GetRating()
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            Post p = dc.Posts.FirstOrDefault(t => t.ID == PPM.Item.ID);
            if (p != null)
            {
                var ratingcount = dc.StarRatings.Count(t => t.PostID == p.ID);
                if (ratingcount > 0)
                {
                    var totalrating = dc.StarRatings.Where(t => t.PostID == p.ID).Sum(t => t.Stars);
                    PostRating = totalrating / ratingcount;
                }
            }
        }

    }
}