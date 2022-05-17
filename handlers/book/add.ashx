<%@ WebHandler Language="C#" Class="AddHandler" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;
using System.Linq;

public class AddHandler : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    Book book;
    Member member;
    ReadStatusType rstatus;
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        //context.Response.Write("Hello World");
        if (!string.IsNullOrEmpty(context.Request.QueryString["bookid"]))
        {
            int bookid;
            if (int.TryParse(context.Request.QueryString["bookid"], out bookid))
                book = LibaryManager.GetBook(bookid);
        }
        else
            context.Response.Redirect("~/books");

        if (!string.IsNullOrEmpty(context.Request.QueryString["rs"]))
            rstatus = (ReadStatusType)Enum.Parse(typeof(ReadStatusType), context.Request.QueryString["rs"]);

        if (context.Request.IsAuthenticated)
        {
            member = MemberManager.GetUser(context.User.Identity.Name);
            LibaryManager.AddBookToLibrary(book, member, rstatus);
            context.Response.Redirect("~/book/" + Utility.Slugify(book.Title) + "-" + book.ID);
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