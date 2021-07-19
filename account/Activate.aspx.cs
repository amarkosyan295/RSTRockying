using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class account_Activate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!String.IsNullOrEmpty(Request.QueryString["mail"]))
        {
            MemberManager.ActivateUser(Request.QueryString["mail"]);
            Response.Redirect("~/account/myaccount");
        }
        else
        {
            Response.Redirect("~");
        }
    }
}