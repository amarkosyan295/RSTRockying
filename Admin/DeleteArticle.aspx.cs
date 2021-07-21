using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_DeleteArticle : AdminPage
{
    public Article a { get; set; }
    public String script { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        a = new Article();
        script = "";
        //redirect if user is not admin or dont own the article
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            Post p = (from t in dc.Posts where t.ID == ID && (t.CreatedBy == CurrentUser.ID || CurrentUser.UserType == (byte)MemberTypeType.Admin) select t).SingleOrDefault();
            if (p == null)
            {
                Response.Redirect("default.aspx");
            }
        }

        if (!Page.IsCallback && !Page.IsPostBack)
        {
            PopulateArticle();
        }
    }

    private void PopulateArticle()
    {

        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {

            try
            {
                a = Utility.Deserialize<Article>(System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", ID, Utility.ArticleFolder))));
                if (string.IsNullOrEmpty(a.MetaTitle))
                {
                    a.MetaTitle = a.Title;
                }
                Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
                if (p != null)
                {
                    a.URL = p.URL;
                }
            }
            catch (Exception ex)
            {
                a = new Article();
                Trace.Write("Unable to read xml file of article.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
                Post p = (from t in dc.Posts where t.ID == ID select t).SingleOrDefault();
                if (p != null)
                {
                    a.Category = p.Category;
                    a.CreatedBy = p.CreatedBy;
                    a.DateCreated = p.DateCreated;
                    a.DateModified = p.DateModified;
                    a.Description = p.Description;
                    a.ID = p.ID;
                    a.ModifiedBy = p.ModifiedBy;
                    a.Status = (PostStatusType)Enum.Parse(typeof(PostStatusType), p.Status.ToString());
                    a.Tag = p.Tag;
                    a.Title = p.Title;
                    a.WriterEmail = p.WriterEmail;
                    a.WriterName = p.WriterName;
                    a.Viewed = p.Viewed;
                    a.URL = p.URL;
                    try
                    {
                        a.Text = System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/article-{0}.txt", p.ID, Utility.ArticleFolder)));

                    }
                    catch (Exception ex2)
                    {
                        Trace.Write(ex2.Message);
                        Trace.Write(ex2.StackTrace);
                    }
                }
                else
                {
                    Response.Redirect("default.aspx");
                }
            }
        }
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        try
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                var item = (from u in dc.Posts where u.ID == ID select u).SingleOrDefault();
                if (item != null)
                {
                    try
                    {
                        System.IO.File.Delete(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", item.ID, Utility.CustomPageFolder)));
                    }
                    catch (Exception iex)
                    {
                        Trace.Write("Unable to delete article file.");
                        Trace.Write(iex.Message);
                        Trace.Write(iex.StackTrace);
                        Trace.Write(iex.Source);
                    }
                    dc.Posts.DeleteOnSubmit(item);
                    //item.Status = (byte)PostStatusType.Inactive;
                    dc.SubmitChanges();
                }
            }
            script = "window.close();";
        }
        catch (Exception ex)
        {
            message1.Text = string.Format("Unable to delete article. Error - {0}", ex.Message);
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to delete article.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
            Trace.Write(ex.Source);
        }
    }
}