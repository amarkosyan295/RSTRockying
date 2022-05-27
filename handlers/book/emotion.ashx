<%@ WebHandler Language="C#" Class="SetEmotion" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;
using System.Linq;

public class SetEmotion : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    Book book = null;
    Member member = null;
    int bookid;
    string returnurl = "~/mylibrary";
    BookReviewEmotionType emotion;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        if (!context.Request.IsAuthenticated)
            returnurl = "~/books";

        if (!string.IsNullOrEmpty(context.Request.QueryString["emotion"]))
        {
                Enum.TryParse<BookReviewEmotionType>(context.Request.QueryString["emotion"], out emotion);
        }
        if (!string.IsNullOrEmpty(context.Request.QueryString["bookid"]))
        {
            if (int.TryParse(context.Request.QueryString["bookid"], out bookid))
            {
                book = LibaryManager.GetBook(bookid);
                returnurl = string.Format("~/book/{0}-{1}", Utility.Slugify(book.Title, "book"), book.ID);
            }
        }
        else
            context.Response.Redirect("~/mylibrary.aspx");

        if (context.Request.IsAuthenticated)
        {
            member = MemberManager.GetUser(context.User.Identity.Name);
            LibaryManager.SetEmotion(book, member, emotion);
            context.Response.Redirect(returnurl);
        }
        else
            context.Response.Redirect("~/account/login?returnurl=" + context.Server.UrlEncode("~/handlers/book/emotion.ashx?emotion=" + (byte)emotion + "&bookid=" + book.ID));
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}