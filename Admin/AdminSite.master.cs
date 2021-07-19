using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_AdminSite : System.Web.UI.MasterPage
{
    public Member CurrentUser { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        CurrentUser = MemberManager.GetUser(Page.User.Identity.Name);
    }
}
