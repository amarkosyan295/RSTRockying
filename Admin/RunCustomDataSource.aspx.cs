using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_RunCustomDataSource : AdminPage
{
    string dsname = string.Empty;
    public string Result { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }

        if (Request.QueryString["dsname"] != null) {
            dsname = Request.QueryString["dsname"].ToString();
        }

        HeadingLit.Text = dsname;

        DataSourceManager dsm = new DataSourceManager();
        Result =  dsm.LoadContent(dsname);
    }
}