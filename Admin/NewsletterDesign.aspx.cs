using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;
using System.Text;

public partial class Admin_NewsletterDesign : AdminPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (CurrentUser.UserType != (byte)MemberTypeType.Admin)
        {
            Response.Redirect("default.aspx");
        }
        message1.Text = string.Empty;
        if (!Page.IsPostBack && !Page.IsCallback)
        {
            EGroupTextBox.Text = "Rockying Newsletter";
            SubjectTextBox.Text = "Rockying Newsletter";
            Bind();
        }
    }

    private void Bind()
    {
        KeyValueTextBox.Text = Utility.NewsletterDesign();
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        try
        {
            using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                WebsiteSetting rs = (from u in db.WebsiteSettings where u.KeyName == "NewsletterDesign" select u).SingleOrDefault();
                rs.KeyValue = KeyValueTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("NewsletterDesign");
                message1.Text = "Saved Successfuly";
                message1.Visible = true;
                message1.Indicate = AlertType.Success;
            }
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to save NewsletterDesign";
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to save NewsletterDesign.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }

    protected void PreviewButton_Click(object sender, EventArgs e)
    {
        string emessage = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/emailtemplates/EmailWrapper.htm"));

        emessage = emessage.Replace("[root]", Utility.SiteURL);
        emessage = emessage.Replace("[newsletteremail]", Utility.NewsletterEmail);
        emessage = emessage.Replace("[message]", KeyValueTextBox.Text.Trim());
        emessage = emessage.Replace("[id]", Guid.Empty.ToString());
        emessage = emessage.Replace("[toaddress]", "sample@email.com");
        emessage = emessage.Replace("[sitename]", Utility.SiteName);
        emessage = emessage.Replace("[emailsignature]", Utility.GetSiteSetting("emailsignature"));
        emessage = emessage.Replace("[adminname]", Utility.AdminName);
        emessage = emessage.Replace("[address]", Utility.Address);
        
        Literal1.Text = emessage;
    }

    protected void ArticleButton_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder builder = new StringBuilder();

            using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                builder.Append("<ul style='list-style:none;'>\r\n");
                foreach (ListItem item in ArticleList.Items)
                {
                    if (item.Selected)
                    {
                        Post p = (from u in db.Posts where u.ID == int.Parse(item.Value) select u).SingleOrDefault();
                        if (p != null)
                        {
                            builder.Append("<li style='text-align:center;border-bottom:1px solid Gainsboro;margin-bottom:5px;'>");
                            builder.Append(Environment.NewLine);
                            builder.Append(string.Format("<a href='{0}/a/{1}?ref=newsletter'>", Utility.SiteURL, p.URL));
                            if (p.OGImage.StartsWith("//"))
                            {
                                p.OGImage = "https:" + p.OGImage;
                            }
                            builder.Append(string.Format("<img src='{0}' style='max-width:600px;max-height:250px;width:auto;border:0px;' alt=''/>", p.OGImage));
                            builder.Append("</a>");
                            builder.Append(Environment.NewLine);
                            builder.Append(string.Format("<a href='{1}/a/{2}?ref=newsletter' style='color:#000;'><h3>{0}</h3></a>\r\n", p.Title, Utility.SiteURL, p.URL, p.Title));
                            builder.Append(Environment.NewLine);
                            builder.Append(string.Format("<p>{0}</p>", p.OGDescription));
                            builder.Append("</li>");
                            //builder.Append("\t<li><hr/></li>\r\n");
                        }
                    }
                }
                builder.Append("</ul>\r\n");
            }
            KeyValueTextBox.Text = builder.ToString();
        }
        catch (Exception ex)
        {
            message1.Text = "Unable to select article";
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to select article");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
    protected void SendButton_Click(object sender, EventArgs e)
    {
        Page.Validate("CategoryGrp");
        if (!Page.IsValid) return;

        try
        {
            using (RockyingDataClassesDataContext db = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                WebsiteSetting rs = (from u in db.WebsiteSettings where u.KeyName == "NewsletterDesign" select u).SingleOrDefault();
                rs.KeyValue = KeyValueTextBox.Text.Trim();
                db.SubmitChanges();
                CacheManager.Remove("NewsletterDesign");

                List<Member> list = MemberManager.GetMemberList();
                foreach (Member m in list)
                {
                    if (m.Newsletter)
                    {
                        EmailMessage em = new EmailMessage();
                        em.CCAdress = string.Empty;
                        em.CreateDate = DateTime.Now;
                        em.SentDate = DateTime.Now;
                        em.EmailGroup = EGroupTextBox.Text.Trim();
                        em.EmailType = (byte)EmailMessageType.Newsletter;
                        em.FromAddress = Utility.NewsletterEmail;
                        em.FromName = Utility.SiteName;
                        em.LastAttempt = DateTime.Now;
                        em.ID = Guid.NewGuid();
                        em.Subject = SubjectTextBox.Text.Trim();
                        em.ToAddress = m.Email;
                        em.ToName = m.MemberName;
                        em.Message = Utility.NewsletterDesign();

                        string emessage = System.IO.File.ReadAllText(HttpContext.Current.Server.MapPath("~/emailtemplates/EmailWrapper.htm"));
                        emessage = emessage.Replace("[root]", Utility.SiteURL);
                        emessage = emessage.Replace("[newsletteremail]", Utility.NewsletterEmail);
                        emessage = emessage.Replace("[message]", em.Message);
                        emessage = emessage.Replace("[id]", em.ID.ToString());
                        emessage = emessage.Replace("[toaddress]", em.ToAddress);
                        emessage = emessage.Replace("[sitename]", Utility.SiteName);
                        emessage = emessage.Replace("[adminname]", Utility.AdminName);
                        emessage = emessage.Replace("[address]", Utility.Address);
                        emessage = emessage.Replace("[emailid]", em.ToAddress);
                        emessage = emessage.Replace("[emailsignature]", Utility.GetSiteSetting("emailsignature"));
                        em.Message = emessage;

                        db.EmailMessages.InsertOnSubmit(em);
                    }
                }

                db.SubmitChanges();
                message1.Text = "Sent Successfuly";
                message1.Visible = true;
                message1.Indicate = AlertType.Success;
            }
        }
        catch (Exception ex)
        {
            message1.Text = string.Format("Unable to save & send NewsletterDesign. Message {0}", ex.Message);
            message1.Visible = true;
            message1.Indicate = AlertType.Error;
            Trace.Write("Unable to save NewsletterDesign.");
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}