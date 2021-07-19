using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_GenerateSitemap : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btGenerateSitemap_Click(object sender, EventArgs e)
    {

        try
        {

            System.Text.StringBuilder builder = new System.Text.StringBuilder();
            builder.Append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            builder.Append("<urlset xmlns=\"http://www.google.com/schemas/sitemap/0.9\">");

            //Add Home Page and other static pages
            builder.Append("<url>");
            builder.Append(string.Format("<loc>{0}/</loc>", Utility.SiteURL));
            builder.Append("</url>");

            builder.Append("<url>");
            builder.Append(string.Format("<loc>{0}/blog</loc>", Utility.SiteURL));
            builder.Append("</url>");

            foreach (Category c in Utility.CategoryList())
            {
                if (c.Status == (byte)GeneralStatusType.Active)
                {
                    builder.Append("<url>");
                    builder.Append(string.Format("<loc>{1}/{0}/index</loc>", c.UrlName, Utility.SiteURL));
                    builder.Append("</url>");
                }
            }

            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                var cp = from u in dc.CustomPages where u.Status == (byte)PostStatusType.Publish select u;
                foreach (var i in cp)
                {
                    builder.Append("<url>");
                    builder.Append(string.Format("<loc>{1}/{0}</loc>", i.Name, Utility.SiteURL));
                    builder.Append("</url>");
                }

                var items = from t in dc.Posts
                            where t.Status == (byte)PostStatusType.Publish
                            orderby t.DateCreated descending
                            select t;
                foreach (var i in items)
                {
                    builder.Append("<url>");
                    if (i.URL.ToLower() ==  i.ID.ToString()) {
                        builder.Append(string.Format("<loc>{1}/a/{0}?title={2}</loc>", i.ID.ToString(), Utility.SiteURL, Utility.Slugify( i.Title)));
                    }
                    else {
                        builder.Append(string.Format("<loc>{1}/a/{0}</loc>", i.URL, Utility.SiteURL));
                    }
                    
                    builder.Append("</url>");
                }

                var items2 = from t in dc.Pictures
                             where t.Status == (byte)PostStatusType.Publish &&
                             (!t.Video.HasValue || !t.Video.Value)
                             orderby t.CreateDate descending
                             select t;
                foreach (var i in items2)
                {
                    builder.Append("<url>");
                    builder.Append(string.Format("<loc>{1}/p/{0}?title={2}</loc>", i.ID.ToString(), Utility.SiteURL, Utility.Slugify(i.Title)));
                    builder.Append("</url>");
                }
            }

            builder.Append("</urlset>");

            System.IO.File.WriteAllText(Server.MapPath("~/sitemap.xml"), builder.ToString());
            lnkSitemap.Visible = true;
        }
        catch (Exception ex)
        {
            lbMessage.Text = ex.Message;
            lbMessage.Visible = true;
            lbMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
}