<%@ WebHandler Language="C#" Class="RecordVisit" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;

public class RecordVisit : IHttpHandler
{

    string action = "";
    HttpContext _context;
    public Member CurrentUser { get; set; }
    public void ProcessRequest(HttpContext context)
    {
        _context = context;
        if (_context.Request.IsAuthenticated)
        {
            CurrentUser = MemberManager.GetUser(_context.User.Identity.Name);
        }
        if (!string.IsNullOrEmpty(context.Request.Form["action"]))
        {
            action = context.Request.Form["action"].ToString();
        }

        //switch (action)
        //{
        //    case "add":
        //        Record();
        //        break;
        //    case "hb":
        //        RecordHeartbeat();
        //        break;
        //    default:
        //        break;
        //}
    }

    //private void Record()
    //{
    //    string url = _context.Request.Form["url"];
    //    string useragent = _context.Request.Form["ua"];
    //    string ip = _context.Request.Form["ip"];
    //    string referer = _context.Request.Form["referer"];
    //    string vid = _context.Request.Form["visitid"];
    //    Guid visitid = Guid.Empty;
    //    if (!string.IsNullOrEmpty(vid))
    //    {
    //        Guid.TryParse(vid, out visitid);
    //    }
    //    PageVisit pg = VisitManager.RecordVisit(url, useragent, ip, referer, CurrentUser != null ? CurrentUser.ID : -1, visitid);
    //    _context.Response.ContentType = "text/plain";
    //    _context.Response.Write(pg.ID.ToString());
    //}

    //private void RecordHeartbeat()
    //{
    //    long pageid = !string.IsNullOrEmpty(_context.Request.Form["pageid"]) ? long.Parse(_context.Request.Form["pageid"]) : 0;
    //    if (pageid > 0)
    //    {
    //        string url = _context.Request.Form["url"];
    //        string vid = _context.Request.Form["visitid"];
    //        Guid visitid = Guid.Empty;
    //        if (!string.IsNullOrEmpty(vid))
    //        {
    //            Guid.TryParse(vid, out visitid);
    //        }
    //        VisitManager.RecordPulse(visitid, pageid);
    //        _context.Response.ContentType = "text/plain";
    //        _context.Response.Write("");
    //    }
    //}

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}