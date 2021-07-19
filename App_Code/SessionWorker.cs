using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{

    public class ApplicationWorker
    {
        public static List<Guid> Visits
        {
            get
            {
                if (HttpContext.Current.Application["visitlist"] == null)
                {
                    return null;
                }
                else
                {
                    return (List<Guid>)HttpContext.Current.Application["visitlist"];
                }
            }
            set
            {
                HttpContext.Current.Application["visitlist"] = value;
            }
        }
    }

    public class SessionWorker
    {
        public static VisitInfo Visit
        {
            get
            {

                if (HttpContext.Current.Session["visit"] != null)
                {
                    return (VisitInfo)HttpContext.Current.Session["visit"];
                }
                else
                {
                    return null;
                }


            }
            set
            {
                HttpContext.Current.Session["visit"] = value;
            }
        }

        public static Guid VisitID
        {
            get
            {

                if (HttpContext.Current.Session["visitid"] != null)
                {
                    return (Guid)HttpContext.Current.Session["visitid"];
                }
                else
                {
                    return Guid.Empty;
                }


            }
            set
            {
                HttpContext.Current.Session["visitid"] = value;
            }
        }

    }

    public class CookieWorker
    {
        public static void SetCookie(string cname, string key, string value, DateTime expiry)
        {
            HttpCookie cookie = new HttpCookie(cname);
            cookie[key] = value;
            cookie.Expires = expiry;
            HttpContext.Current.Response.Cookies.Add(cookie);
        }

        public static void RemoveCookie(string cname)
        {
            HttpContext.Current.Response.Cookies[cname].Expires = DateTime.Now.AddDays(-1);
        }

        public static string GetCookie(string cname, string key)
        {
            string result = string.Empty;
            if (HttpContext.Current.Request.Cookies[cname] != null)
            {
                if (HttpContext.Current.Request.Cookies[cname][key] != null)
                {
                    result = HttpContext.Current.Request.Cookies[cname][key];
                }
            }

            return result;
        }
    }
}