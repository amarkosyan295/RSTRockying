using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;
using System.IO;

public partial class Admin_simpleupload : AdminPage
{
    string folderPath;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["folderpath"] != null)
        {
            folderPath = Request.QueryString["folderpath"];
        }

        if (CurrentUser.UserType == (byte)MemberTypeType.Author)
        {
            folderPath = CurrentUser.ID.ToString() + "/" + folderPath;
        }

        if (!IsPostBack)
        {
            MultipleFileUpload.StorageFolder = folderPath; 
        }

    }
}