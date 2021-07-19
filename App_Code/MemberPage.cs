using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Rockying.Models;

namespace Rockying
{
    public class MemberPage : System.Web.UI.Page
    {
        public Member CurrentUser { get; set; }
        public MemberPage()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("~/account/login");
            }
            else
            {
                CurrentUser = MemberManager.GetUser(Page.User.Identity.Name);
            }
        }
    }
}