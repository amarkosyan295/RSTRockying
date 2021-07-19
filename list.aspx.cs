using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying.Models;
using Rockying;

public partial class list : BasePage
{
    public CategoryPageModel CPM { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        CPM = new CategoryPageModel();

        if (Page.RouteData.Values["category"] != null)
        {
            try
            {
                string name = Page.RouteData.Values["category"].ToString();
               
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
                {
                    var item = (from t in dc.Categories
                                where t.UrlName == name
                                    && t.Status == (byte)GeneralStatusType.Active
                                select t).SingleOrDefault();
                    if (item != null)
                    {
                        CPM.Current = item;
                        CPM.ChildList.AddRange(item.Categories.ToList());
                        var items = from t in dc.Posts
                                    where t.Status == (byte)PostStatusType.Publish && t.Category == item.ID
                                    orderby t.DateCreated descending
                                    select t;
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
                            a.WriterEmail = i.WriterEmail;
                            a.WriterName = i.WriterName;
                            a.OGDescription = i.OGDescription;
                            if (string.IsNullOrEmpty(i.OGImage))
                            {
                                a.OGImage = string.Format("//rockying.com/art/category/icons/{0}_big.jpg", a.CategoryName);
                            }
                            else
                            {
                                a.OGImage = Utility.TrimStartHTTP(i.OGImage);
                            }
                            
                            a.Viewed = i.Viewed;
                            a.URL = i.URL;
                            CPM.ArticleList.Add(a);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Trace.Write("Invalid Category");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }
    }
}