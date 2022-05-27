<%@ WebHandler Language="C#" Class="UpdateReadingProgress" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;
using System.Linq;

public class UpdateReadingProgress : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    Book book = null;
    Member member = null;
    int bookid;
    string returnurl = "~/mylibrary.aspx";
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
            context.Response.Redirect("~/mylibrary.aspx");

        if (context.Request.IsAuthenticated)
        {
            member = MemberManager.GetUser(context.User.Identity.Name);
            LibaryManager.UpdateReadingProgress(book, member, int.Parse(context.Request.Form["pagecount"]));
            context.Response.Redirect(returnurl);
        }
        else
            context.Response.Redirect("~/account/login?returnurl=~/book/" + Utility.Slugify(book.Title, "book") + "-" + book.ID);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}