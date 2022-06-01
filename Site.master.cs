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
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        if (Request.IsAuthenticated)
            CurrentUser = MemberManager.GetUser(Page.User.Identity.Name);
        
    }
    
}
