using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    public Member CurrentUser { get; set; }
    //private bool _noTemplate = false;
    //public bool NoTemplate { get { return _noTemplate; } set { _noTemplate = value; } }
    


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies[Utility.PreserveCookie] != null)
            CurrentUser = MemberManager.GetUser(Request.Cookies[Utility.PreserveCookie].Value);

        if (Request.IsAuthenticated && CurrentUser == null)
            CurrentUser = MemberManager.GetUser(Page.User.Identity.Name);

    }
}
