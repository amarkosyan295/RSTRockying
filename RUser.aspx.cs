using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RUser : BasePage
{
    public Member Member;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = string.Empty;
        if (Page.RouteData.Values["username"] != null)
        {
            username = Page.RouteData.Values["username"].ToString();
            using(RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                Member = dc.Members.FirstOrDefault(t => t.UserName == username);
            }
        }
    }
}