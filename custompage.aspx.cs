using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;
using System.Text;
using System.IO;

public partial class custompage : BasePage
{
    public CPage CP { get; set; }
    public HomePageModel HPM
    {
        get;
        set;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            HPM = null;
            string pname = "home";
            if (Page.RouteData.Values["pagename"] != null)
            {
                pname = Page.RouteData.Values["pagename"].ToString();
            }
            if (pname != "home")
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
                {
                    int pid = (from u in dc.CustomPages where u.Name == pname && u.Status == (byte)PostStatusType.Publish select u.ID).SingleOrDefault();
                    CP = Utility.Deserialize<CPage>(System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/cpagexml-{0}.txt", pid, Utility.CustomPageFolder))));

                    Master.NoTemplate = CP.NoTemplate;

                    #region Replace Custom Data Source
                    DataSourceManager dsm = new DataSourceManager();
                    CP.Body = dsm.ParseAndPopulate(CP.Body);
                    #endregion
                }
            }
            else
            {
                HPM = new HomePageModel();
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
                {
                    var items = (from t in dc.Posts
                                 where t.Status == (byte)PostStatusType.Publish
                                 orderby t.DateCreated descending
                                 select t).Take(9);
                    foreach (var i in items)
                    {
                        Article a = new Article();
                        a.Category = i.Category;
                        a.CategoryName = i.Category1.Name;
                        a.CreatedBy = i.CreatedBy;
                        a.CreatedByName = i.Member.MemberName;
                        a.DateCreated = i.DateCreated;
                        a.DateModified = i.DateModified;
                        a.Description = i.Description;
                        a.ID = i.ID;
                        a.ModifiedBy = i.ModifiedBy;
                        a.Status = (PostStatusType)i.Status;
                        a.Tag = i.Tag;
                        a.Text = string.Empty;
                        a.Title = i.Title;
                        a.OGImage = Utility.TrimStartHTTP(i.OGImage);
                        a.OGDescription = i.OGDescription;
                        a.WriterEmail = i.WriterEmail;
                        a.WriterName = i.WriterName;
                        a.Viewed = i.Viewed;
                        a.URL = i.URL;
                        HPM.LatestList.Add(a);
                    }
                    var top = from t in dc.TopStories orderby t.DateCreated descending select t;
                    foreach (var i in top)
                    {
                        Article a = new Article();
                        a.Category = i.Post.Category;
                        a.CategoryName = i.Post.Category1.Name;
                        a.CreatedBy = i.Post.CreatedBy;
                        a.CreatedByName = i.Post.Member.MemberName;
                        a.DateCreated = i.Post.DateCreated;
                        a.DateModified = i.Post.DateModified;
                        a.Description = i.Post.Description;
                        a.ID = i.Post.ID;
                        a.ModifiedBy = i.Post.ModifiedBy;
                        a.Status = (PostStatusType)i.Post.Status;
                        a.Tag = i.Post.Tag;
                        a.Text = string.Empty;
                        a.Title = i.Post.Title;
                        a.OGImage = Utility.TrimStartHTTP(i.Post.OGImage);
                        a.OGDescription = i.Post.OGDescription;
                        a.WriterEmail = i.Post.WriterEmail;
                        a.WriterName = i.Post.WriterName;
                        a.URL = i.Post.URL;
                        HPM.HeroList.Add(a);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CP = new CPage();
            CP.Body = Resources.Resource._404;
            Trace.Write("Invalid pagename");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}