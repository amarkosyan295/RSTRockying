<%@ WebHandler Language="C#" Class="RemoveFromLibrary" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;
using System.Linq;
public class RemoveFromLibrary : IHttpHandler, System.Web.SessionState.IRequiresSessionState {
    
        Book book = null;
    Member member = null;
    int bookid;
    string returnurl = "~/mylibrary.aspx";
    public void ProcessRequest (HttpContext context) {
            context.Response.ContentType = "text/plain";
        if (!context.Request.IsAuthenticated)
            returnurl = "~/books";

        if (!string.IsNullOrEmpty(context.Request["returnurl"]))
            returnurl = context.Request["returnurl"];

        if (!string.IsNullOrEmpty(context.Request["bookid"]))
        {
            if (int.TryParse(context.Request["bookid"], out bookid))
                book = LibaryManager.GetBook(bookid);
        }
        else
            context.Response.Redirect("~/mylibrary.aspx");

        if (context.Request.IsAuthenticated)
        {
            member = MemberManager.GetUser(context.User.Identity.Name);
            LibaryManager.RemoveFromLibrary(book, member);
            context.Response.Redirect(returnurl);
        }
        else
            context.Response.Redirect("~/account/login?returnurl=~/book/" + Utility.Slugify(book.Title) + "-" + book.ID);   
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}