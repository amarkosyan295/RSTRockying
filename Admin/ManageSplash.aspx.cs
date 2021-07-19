using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_ManageSplash: AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Mode.Equals("edit"))
        {
            HeadingLit.Text = "Edit Comic";
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Picture p = (from t in dc.Pictures where t.ID == ID && (t.CreatedBy == CurrentUser.ID || CurrentUser.UserType == (byte)MemberTypeType.Admin) select t).SingleOrDefault();
                if (p == null)
                {
                    Response.Redirect("splashlist.aspx");
                }
            }
        }
        else
        {
            HeadingLit.Text = "Add Comic";
        }

        if (!Page.IsCallback && !Page.IsPostBack)
        {
            if (Mode.Equals("edit"))
            {
                PopulateSplashDetail();
            }
        }
    }

    private void PopulateSplashDetail()
    {
        try
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                Picture v = (from u in dc.Pictures where u.ID == ID select u).SingleOrDefault();
                if (v != null)
                {
                    TitleTextBox.Text = v.Title;
                    LinkTextBox.Text = v.ImageUrl;
                    DescriptionTextBox.Text = v.Description;
                    TagTextBox.Text = v.Tag;
                    CategoryDropDown.SelectedValue = v.CategoryID.ToString();
                    StatusDropDown.SelectedValue = v.Status.ToString();
                }
            }
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to load photo details");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("VideoGrp");
        if (!Page.IsValid) return;

        try
        {
            if (Mode == "add" || Mode == string.Empty)
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
                {
                    Picture v = new Picture();
                    v.Title = TitleTextBox.Text.Trim();
                    v.ImageUrl = LinkTextBox.Text.Trim();
                    v.Description = DescriptionTextBox.Text.Trim();
                    v.Tag = TagTextBox.Text.Trim();
                    v.CategoryID = int.Parse(CategoryDropDown.SelectedValue);
                    v.Status = byte.Parse(StatusDropDown.SelectedValue);
                    v.CreateDate = DateTime.Now;
                    v.CreatedBy = CurrentUser.ID;
                    v.Video = false;
                    dc.Pictures.InsertOnSubmit(v);
                    dc.SubmitChanges();
                }

            }
            else if (Mode == "edit")
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
                {
                    Picture v = (from u in dc.Pictures where u.ID == ID select u).SingleOrDefault();
                    if (v != null)
                    {
                        v.Title = TitleTextBox.Text.Trim();
                        v.ImageUrl = LinkTextBox.Text.Trim();
                        v.Description = DescriptionTextBox.Text.Trim();
                        v.Tag = TagTextBox.Text.Trim();
                        v.CategoryID = int.Parse(CategoryDropDown.SelectedValue);
                        v.Status = byte.Parse(StatusDropDown.SelectedValue);
                        v.ModifyDate = DateTime.Now;
                        v.ModifiedBy = CurrentUser.ID;
                        v.Video = false;
                        dc.SubmitChanges();
                    }
                }
            }
            Response.Redirect("SplashList.aspx");
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to save video details");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}