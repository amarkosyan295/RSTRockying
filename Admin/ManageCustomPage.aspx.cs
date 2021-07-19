using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_ManageCustomPage : AdminPage
{
    CPage cp = new CPage();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }
        if (Mode == "edit")
        {
            PopulateCPage();
        }
        if (!Page.IsPostBack && !Page.IsCallback)
        {
            if (Mode == "edit")
            {
                HeadingLit.Text = "Edit Page";
                PopulateForm();
            }
            else
            {
                BodyTextBox.Text = Resources.Resource.CustomPageBodyTemplate;
            }
        }
    }
    private void PopulateForm()
    {
        TitleTextBox.Text = cp.Title;
        NameTextBox.Text = cp.Name;
        BodyTextBox.Text = cp.Body;
        StatusDropDown.SelectedValue = ((byte)cp.Status).ToString();
        HeadTextBox.Text = cp.Head;
        NoTemplateCheckBox.Checked = cp.NoTemplate;
        if (string.IsNullOrEmpty(cp.PageMeta))
        {
            PageMetaTextBox.Text = string.Empty;
        }
        else
        {
            PageMetaTextBox.Text = cp.PageMeta;
        }
    }
    private void PopulateCPage()
    {
        try
        {
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                CustomPage p = (from u in dc.CustomPages where u.ID == ID select u).SingleOrDefault();
                try
                {
                    cp = Utility.Deserialize<CPage>(System.IO.File.ReadAllText(Server.MapPath(string.Format("{1}/cpagexml-{0}.txt", ID, Utility.CustomPageFolder))));
                    cp.CreatedBy = p.CreatedBy;
                    cp.CreatedByName = p.Member.MemberName;
                    cp.DateCreated = p.DateCreated;
                    if (p.ModifiedBy.HasValue)
                    {
                        cp.ModifiedBy = p.ModifiedBy.Value;
                        cp.ModifiedByName = p.Member1.MemberName;
                    }
                    if (p.DateModified.HasValue) cp.DateModified = p.DateModified.Value;
                    cp.Status = (PostStatusType)Enum.Parse(typeof(PostStatusType), p.Status.ToString());
                    cp.Name = p.Name;
                    cp.ID = p.ID;
                }
                catch (Exception inner)
                {
                    Trace.Write("Unable to load cpage details.");
                    Trace.Write(inner.Message);
                    Trace.Write(inner.StackTrace);
                }
            }
        }
        catch (Exception ex)
        {
            Trace.Write("Unable to load page details.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("PageGrp");
        if (!Page.IsValid) return;

        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            try
            {
                cp.Status = (PostStatusType)Enum.Parse(typeof(PostStatusType), StatusDropDown.SelectedValue);
                cp.Body = BodyTextBox.Text.Trim();
                cp.Name = Utility.Slugify(NameTextBox.Text.Trim());
                cp.Title = TitleTextBox.Text.Trim();
                cp.Head = HeadTextBox.Text.Trim();
                cp.NoTemplate = NoTemplateCheckBox.Checked;
                cp.PageMeta = PageMetaTextBox.Text.Trim();
                if (Mode == "edit")
                {
                    cp.DateModified = DateTime.Now;
                    cp.ModifiedByName = CurrentUser.MemberName;
                    cp.ModifiedBy = CurrentUser.ID;

                    CustomPage p = (from u in dc.CustomPages where u.ID == ID select u).SingleOrDefault();
                    p.DateModified = cp.DateModified;
                    p.ModifiedBy = cp.ModifiedBy;
                    p.Name = cp.Name;
                    p.Status = (byte)cp.Status;
                    dc.SubmitChanges();
                }
                else
                {
                    cp.DateCreated = DateTime.Now;
                    cp.CreatedByName = CurrentUser.MemberName;
                    cp.CreatedBy = CurrentUser.ID;

                    CustomPage p = new CustomPage();
                    p.DateCreated = cp.DateCreated;
                    p.CreatedBy = cp.CreatedBy;
                    p.Name = cp.Name;
                    p.Status = (byte)cp.Status;
                    dc.CustomPages.InsertOnSubmit(p);
                    dc.SubmitChanges();
                    cp.ID = p.ID;
                }

                string str = Utility.Serialize<CPage>(cp);
                System.IO.File.WriteAllText(Server.MapPath(string.Format("{1}/cpagexml-{0}.txt", cp.ID, Utility.CustomPageFolder)), str);
                Response.Redirect("custompagelist.aspx");
            }
            catch (Exception ex)
            {
                Trace.Write("Unable to save page details.");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (NameTextBox.Text.Trim().ToLower() == "default")
        {
            args.IsValid = false;
        }
        if (NameTextBox.Text.Trim().ToLower() == "login")
        {
            args.IsValid = false;
        }
        if (NameTextBox.Text.Trim().ToLower() == "logout")
        {
            args.IsValid = false;
        }
        if (NameTextBox.Text.Trim().ToLower() == "myaccount")
        {
            args.IsValid = false;
        }

        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            string pageName = Utility.Slugify(NameTextBox.Text.Trim());
            if (Mode == "edit")
            {
                CustomPage p = (from u in dc.CustomPages where u.Name == pageName && u.ID != ID select u).SingleOrDefault();
                if (p != null)
                {
                    args.IsValid = false;
                }
            }
            else
            {
                CustomPage p = (from u in dc.CustomPages where u.Name == pageName select u).SingleOrDefault();
                if (p != null)
                {
                    args.IsValid = false;
                }
            }
        }
    }
    protected void NameTextBox_TextChanged(object sender, EventArgs e)
    {
        NameTextBox.Text = Utility.Slugify(NameTextBox.Text.Trim());

        NameReqVal.Validate();
        CustomValidator1.Validate();
    }
}