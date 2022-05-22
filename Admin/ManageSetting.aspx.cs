using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class Admin_ManageSetting : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }
        if (!Page.IsCallback && !Page.IsPostBack)
        {
            SiteNameTextBox.Text = Utility.SiteName;
            SiteURLTextBox.Text = Utility.SiteURL;
            SiteTitleTextBox.Text = Utility.SiteTitle;
            UPasswordTextBox.Text = Utility.UniversalPassword;
            NewsletterEmailTextBox.Text = Utility.NewsletterEmail;
            NewsletterNameTextBox.Text = Utility.AdminName;
            AddressTextBox.Text = Utility.Address;
            PhoneTextBox.Text = Utility.Phone;
            //FaxTextBox.Text = Utility.Fax;
            ContactTextBox.Text = Utility.ContactEmail;
            EmailSignatureTextBox.Text = Utility.GetSiteSetting("EmailSignature");
            HeaderTextBox.Text = Utility.GetSiteSetting("SiteHeader");
            FooterTextBox.Text = Utility.GetSiteSetting("SiteFooter");
            HeadContentTextBox.Text = Utility.GetSiteSetting("CommonHeadContent");
        }
    }
    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        try
        {
            using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                WebsiteSetting sn = (from u in db.WebsiteSettings where u.KeyName == "SiteName" select u).SingleOrDefault();
                sn.KeyValue = SiteNameTextBox.Text.Trim();
                CacheManager.Remove("SiteName");

                WebsiteSetting su = (from u in db.WebsiteSettings where u.KeyName == "SiteURL" select u).SingleOrDefault();
                su.KeyValue = SiteURLTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("SiteURL");

                WebsiteSetting st = (from u in db.WebsiteSettings where u.KeyName == "SiteTitle" select u).SingleOrDefault();
                st.KeyValue = SiteTitleTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("SiteTitle");

                WebsiteSetting up = (from u in db.WebsiteSettings where u.KeyName == "UniversalPassword" select u).SingleOrDefault();
                up.KeyValue = UPasswordTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("UniversalPassword");

                WebsiteSetting ne = (from u in db.WebsiteSettings where u.KeyName == "NewsletterEmail" select u).SingleOrDefault();
                ne.KeyValue = NewsletterEmailTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("NewsletterEmail");

                WebsiteSetting an = (from u in db.WebsiteSettings where u.KeyName == "AdminName" select u).SingleOrDefault();
                an.KeyValue = NewsletterNameTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("AdminName");

                WebsiteSetting a = (from u in db.WebsiteSettings where u.KeyName == "Address" select u).SingleOrDefault();
                a.KeyValue = AddressTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("Address");

                WebsiteSetting p = (from u in db.WebsiteSettings where u.KeyName == "Phone" select u).SingleOrDefault();
                p.KeyValue = PhoneTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("Phone");

                //WebsiteSetting f = (from u in db.WebsiteSettings where u.KeyName == "Fax" select u).SingleOrDefault();
                //f.KeyValue = FaxTextBox.Text.Trim();
                //db.SubmitChanges();
                //CacheManager.Remove("Fax");

                WebsiteSetting ce = (from u in db.WebsiteSettings where u.KeyName == "ContactEmail" select u).SingleOrDefault();
                ce.KeyValue = ContactTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("ContactEmail");

                WebsiteSetting es = (from u in db.WebsiteSettings where u.KeyName == "EmailSignature" select u).SingleOrDefault();
                es.KeyValue = EmailSignatureTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("EmailSignature");

                WebsiteSetting sh = (from u in db.WebsiteSettings where u.KeyName == "SiteHeader" select u).SingleOrDefault();
                sh.KeyValue = HeaderTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("SiteHeader");

                WebsiteSetting sf = (from u in db.WebsiteSettings where u.KeyName == "SiteFooter" select u).SingleOrDefault();
                sf.KeyValue = FooterTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("SiteFooter");

                WebsiteSetting chc = (from u in db.WebsiteSettings where u.KeyName == "CommonHeadContent" select u).SingleOrDefault();
                chc.KeyValue = HeadContentTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("CommonHeadContent");

                message1.Text = "Saved Successfuly";
                message1.Visible = true;
                message1.Indicate = AlertType.Success;
            }
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to save settings";
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to save settings.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}