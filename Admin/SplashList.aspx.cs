using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_SplashList : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            SplashSource.SelectCommand = "SELECT Picture.ID, Picture.Title, Picture.CreateDate, Picture.ImageUrl, Category.Name AS Category, Picture.Viewed, PostStatus.Name AS Status FROM Picture INNER JOIN Category ON Picture.CategoryID = Category.ID INNER JOIN PostStatus ON Picture.Status = PostStatus.ID WHERE Picture.CreatedBy = " + CurrentUser.ID.ToString() + " AND  (Picture.CategoryID = @Category) AND (Picture.Status = @Status) AND (Picture.Video = 0 OR Picture.Video IS NULL) ORDER BY Picture.CreateDate DESC";
        }
    }
}