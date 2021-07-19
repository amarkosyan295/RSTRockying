using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_Default : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            ArticleSource.SelectCommand = "SELECT P.ID, P.Title, P.DateCreated, P.WriterName, P.Viewed, C.Name AS Category, PS.Name AS Status, P.URL FROM Category AS C INNER JOIN Post AS P ON C.ID = P.Category INNER JOIN PostStatus AS PS ON P.Status = PS.ID WHERE P.CreatedBy = " + CurrentUser.ID.ToString();
            
        }
    }
    
    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "TopStory")
        {
            try
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
                {
                    TopStory ts = new TopStory();
                    ts.CreatedBy = CurrentUser.ID;
                    ts.DateCreated = DateTime.UtcNow;
                    ts.PostId = long.Parse(e.CommandArgument.ToString());
                    dc.TopStories.InsertOnSubmit(ts);
                    dc.SubmitChanges();
                    Response.Redirect("topstory.aspx");
                }
            }
            catch (Exception ex)
            {
                message1.Text = string.Format("Unable to set top story. Error - {0}", ex.Message);
                message1.Visible = true;
                message1.Indicate = AlertType.Error;
                Trace.Write("Unable to set top story.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }
        else if (e.CommandName == "DeleteCommand")
        {
            
        }

    }

    protected void DeleteInactiveButton_Click(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            var posts = (from t in dc.Posts where t.Status == (byte)PostStatusType.Inactive && (t.CreatedBy == CurrentUser.ID || CurrentUser.UserType == (byte)MemberTypeType.Admin) select t);
            foreach(Post p in posts)
            {
                if (p != null && p.Status == (byte)PostStatusType.Inactive)
                {
                    try
                    {
                        System.IO.File.Delete(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", p.ID, Utility.CustomPageFolder)));
                        dc.Posts.DeleteOnSubmit(p);
                        dc.SubmitChanges();
                    }
                    catch (Exception iex)
                    {
                        Trace.Write("Unable to delete article file.");
                        Trace.Write(iex.Message);
                        Trace.Write(iex.StackTrace);
                        Trace.Write(iex.Source);
                    }                    
                }
            }
        }
    }

    protected void DeleteDraftButton_Click(object sender, EventArgs e)
    {
        if (CurrentUser.UserType == (byte)MemberTypeType.Admin)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                var posts = (from t in dc.Posts where t.Status == (byte)PostStatusType.Draft && (t.CreatedBy == CurrentUser.ID || CurrentUser.UserType == (byte)MemberTypeType.Admin) select t);
                foreach (Post p in posts)
                {
                    if (p != null && p.Status == (byte)PostStatusType.Draft)
                    {
                        try
                        {
                            System.IO.File.Delete(Server.MapPath(string.Format("{1}/articlexml-{0}.txt", p.ID, Utility.CustomPageFolder)));
                            dc.Posts.DeleteOnSubmit(p);
                            dc.SubmitChanges();
                        }
                        catch (Exception iex)
                        {
                            Trace.Write("Unable to delete article file.");
                            Trace.Write(iex.Message);
                            Trace.Write(iex.StackTrace);
                            Trace.Write(iex.Source);
                        }
                    }
                }
            }
        }
    }
}