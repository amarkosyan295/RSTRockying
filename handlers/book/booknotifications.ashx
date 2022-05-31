<%@ WebHandler Language="C#" Class="BookNotificationsHandler" %>

using System;
using System.Web;
using System.Linq;
using Rockying;
using Rockying.Models;

public class BookNotificationsHandler : IHttpHandler
{
    private NotificationType ntype;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (!string.IsNullOrEmpty(context.Request.QueryString["type"]))
        {
            Enum.TryParse(context.Request.QueryString["type"], out ntype);
        }
        if (ntype == NotificationType.NoReadingUpdate)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                var query = dc.MemberBooks.Where(t => t.ReadStatus == (byte)ReadStatusType.Reading);
                foreach (var mb in query)
                {
                    if (mb.ReadingUpdateDate.HasValue && mb.ReadingUpdateDate.Value > DateTime.Now.AddDays(-2)) { continue; }
                    string message = System.IO.File.ReadAllText(context.Server.MapPath("~/emailtemplates/ReadingUpdate.htm"));
                    message = message.Replace("[coverphoto]", mb.Photo);
                    message = message.Replace("[title]", mb.Book.Title);
                    message = message.Replace("[bookurl]", "https://www.rockying.com/book/" + Utility.Slugify(mb.Book.Title, "book") + "-" + mb.BookID + "#" + Utility.UpdateReadingProgressHash);

                    EmailManager.SendMail(Utility.NewsletterEmail, mb.Member.Email, Utility.AdminName, mb.Member.MemberName, message, "Update your reading progress", EmailMessageType.Notification, "NoReadingUpdate");
                }
            }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}