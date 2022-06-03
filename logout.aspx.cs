using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Rockying.Models;

public partial class logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        HttpCookie preserveCookie = new HttpCookie(Utility.PreserveCookie);
        preserveCookie.Value = String.Empty;
        preserveCookie.Expires = DateTime.Now.AddMonths(-1);
        Response.SetCookie(preserveCookie);
        Response.Redirect("~");
    }
}