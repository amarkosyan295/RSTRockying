<%@ WebHandler Language="C#" Class="UpdatePhoto" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;
using System.Linq;
using System.IO;

public class UpdatePhoto : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    Book book = null;
    Member member = null;
    int bookid;
    string returnurl = "~/mylibrary";
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        if (!context.Request.IsAuthenticated)
            returnurl = "~/books";

        if (!string.IsNullOrEmpty(context.Request.Form["returnurl"]))
            returnurl = context.Request.Form["returnurl"];

        if (!string.IsNullOrEmpty(context.Request.Form["bookid"]))
        {
            if (int.TryParse(context.Request.Form["bookid"], out bookid))
                book = LibaryManager.GetBook(bookid);
        }
        else
            context.Response.Redirect("~/mylibrary");

        if (context.Request.IsAuthenticated)
        {
            member = MemberManager.GetUser(context.User.Identity.Name);
            if (context.Request.Files.Count > 0)
            {
                string ph = string.Empty;
                using (var memoryStream = new MemoryStream())
                {
                    context.Request.Files["photo"].InputStream.CopyTo(memoryStream);
                    byte[] bytes = memoryStream.ToArray();
                    ph = Convert.ToBase64String(bytes);
                }
                LibaryManager.UpdatePhotoMemberBook(book, member, "data:image/png;base64," + ph);
            }

            context.Response.Redirect(returnurl);
        }
        else
            context.Response.Redirect("~/account/login?returnurl=~/book/" + Utility.Slugify(book.Title) + "-" + book.ID);

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}