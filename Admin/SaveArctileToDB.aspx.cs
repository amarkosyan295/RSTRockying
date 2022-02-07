using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_SaveArctileToDB : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Article a;
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            var posts = from t in dc.Posts select t;
            foreach (Post p in posts)
            {
                try
                {
                    a = Utility.Deserialize<Article>(System.IO.File.ReadAllText(Server.MapPath(string.Format("~/rockyingdata/article/articlexml-{0}.txt", p.ID))));
                    p.Article = a.Text;
                    dc.SubmitChanges();
                }
                catch (Exception ex)
                {
                    Trace.Write("Unable to read xml file of article.");
                    Trace.Write(ex.Message);
                    Trace.Write(ex.StackTrace);
                }
            }
        }
    }
}