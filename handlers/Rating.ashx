<%@ WebHandler Language="C#" Class="Rating" %>

using System;
using System.Web;
using System.Linq;
using Rockying;
using Rockying.Models;

public class Rating : IHttpHandler
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
        switch (action)
        {
            case "add":
                AddRating();
                break;
            default:
                break;
        }
    }

    private void AddRating()
    {
        int star = !string.IsNullOrEmpty(_context.Request.Form["star"]) ? int.Parse(_context.Request.Form["star"]) : -1;
        int postid = !string.IsNullOrEmpty(_context.Request.Form["post"]) ? int.Parse(_context.Request.Form["post"]) : -1;
        string comment = _context.Request.Form["comment"];
        string ip = _context.Request.Form["ip"];
        string vid = _context.Request.Form["visitid"];
        Guid visitid = Guid.Empty;
        if (!string.IsNullOrEmpty(vid))
        {
            Guid.TryParse(vid, out visitid);
        }

        if (star > -1 && postid > -1)
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Post p = dc.Posts.FirstOrDefault(t => t.ID == postid);
                if (p != null)
                {
                    StarRating sr = dc.StarRatings.FirstOrDefault(t => t.PostID == p.ID && t.IPAddress == ip && t.VisitID == visitid);
                    if (sr == null)
                    {
                        sr = new StarRating()
                        {
                            VisitID = visitid,
                            Comment = comment,
                            CreateDate = DateTime.UtcNow,
                            IPAddress = ip,
                            PostID = p.ID,
                            Stars = star
                        };
                        if(CurrentUser != null)
                        {
                            sr.MemberID = CurrentUser.ID;
                        }
                        dc.StarRatings.InsertOnSubmit(sr);
                    }
                    else
                    {
                        sr.Stars = star;
                        sr.Comment = comment;
                    }
                    dc.SubmitChanges();
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