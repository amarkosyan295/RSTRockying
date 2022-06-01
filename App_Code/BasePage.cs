using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using Rockying.Models;

namespace Rockying
{
    public class BasePage : System.Web.UI.Page
    {

        public Member CurrentUser { get; set; }

        public BasePage()
        {
        }

        protected override void OnInit(EventArgs e)
        {
            string name = string.Empty, email = string.Empty;
            long memberid = 0;
            base.OnInit(e);
            if (Request.Cookies[Utility.PreserveCookie] != null)
            {
                CurrentUser = MemberManager.GetUser(Request.Cookies[Utility.PreserveCookie].Value);
                if (CurrentUser != null)
                    FormsAuthentication.SetAuthCookie(CurrentUser.UserName, true);
            }

            if (!Request.IsAuthenticated)
            {
                CurrentUser = null;
            }
            else
            {
                CurrentUser = MemberManager.GetUser(Page.User.Identity.Name);
                name = CurrentUser.MemberName;
                email = CurrentUser.Email;
                memberid = CurrentUser.ID;
            }

            //if there is an email message id attached to url then mark the email as read
            if(Request.QueryString["emailid"] != null)
            {
                Guid emailid;
                if (Guid.TryParse(Request.QueryString["emailid"], out emailid)){
                    EmailManager.MarkAsRead(emailid);
                }
            }

            Guid visitid;
            string referer = string.Empty, searchKeyword = string.Empty;
            //string url = string.Format("http://{0}{1}", Request.Url.Host, Request.RawUrl);
            string url =  Request.Url.PathAndQuery;
            if (Request.UrlReferrer != null)
            {
                referer = Request.UrlReferrer.OriginalString;
                if (Request.UrlReferrer.Host.Trim().ToLower().Contains("google.") || Request.UrlReferrer.Host.Trim().ToLower().Contains("bing."))
                {
                    try
                    {
                        searchKeyword = HttpUtility.ParseQueryString(Request.UrlReferrer.Query).Get("q");
                    }
                    catch { }
                }
            }

            
        }
    }
}