using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        System.Web.Security.FormsAuthentication.SignOut();
        HttpCookie preserveCookie = new HttpCookie(Utility.PreserveCookie);
        preserveCookie.Value = String.Empty;
        preserveCookie.Expires = DateTime.Now.AddMonths(-1);
        Response.SetCookie(preserveCookie);
        Response.Redirect(string.Format("//{0}", Request.Url.Host)); 
    }
}