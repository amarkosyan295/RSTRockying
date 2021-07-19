using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class rss : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Text.StringBuilder builder = new System.Text.StringBuilder();
        builder.Append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        builder.Append("<rss version=\"0.91\">");
        builder.Append("<channel>");
        builder.Append(string.Format("<title>{0}</title>", Utility.SiteName));
        builder.Append(string.Format("<link>{0}</link>", Utility.SiteURL));
        builder.Append("<description></description><language>en-us</language>");
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            var items = (from t in dc.Posts
                         where t.Status == (byte)PostStatusType.Publish
                         orderby t.DateCreated descending
                         select t).Take(20);
            foreach (var i in items)
            {
                try
                {
                    builder.Append("<item>");
                    builder.Append(string.Format("<title>{0}</title>", i.Title.ToString()));
                    builder.Append(string.Format("<link>{1}/a/{0}</link>", i.ID.ToString(), Utility.SiteURL));
                    builder.Append(string.Format("<description><![CDATA[{0}]]></description>", i.Description));
                    builder.Append(string.Format("<lastBuildDate>{0}</lastBuildDate>", i.DateModified.ToString()));
                    builder.Append(string.Format("<category>{0}</category>", i.Category1.Name));
                    builder.Append("</item>");
                }
                catch
                {
                }
            }
        }
        builder.Append("</channel>");
        builder.Append("</rss>");
        Response.Write(builder.ToString());
        Response.End();
    }
}