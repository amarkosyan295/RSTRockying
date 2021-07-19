<%@ WebHandler Language="C#" Class="subscribe" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using Rockying;
using Rockying.Models;

public class subscribe : IHttpHandler
{
    JavaScriptSerializer serializer = new JavaScriptSerializer();
    HttpContext currentContext;
    string email = string.Empty;
    string name = string.Empty;
    bool newsletter = true;
    string json = "";

    public void ProcessRequest(HttpContext context)
    {
        currentContext = context;
        context.Response.Clear();
        context.Response.ContentType = "application/json; charset=utf-8";

        if (context.Request["name"] != null)
        {
            name = context.Request["name"].Trim();
        }
        if (context.Request["email"] == null)
        {
            json = serializer.Serialize(new { status = "error", message = "No Email Provided." });
            context.Response.Write(json);
        }
        else
        {
            if (Utility.ValidateEmail(context.Request["email"].Trim()))
            {
                email = context.Request["email"].Trim();
                SubscribeMember();
            }
            else
            {
                json = serializer.Serialize(new { status = "error", message = "Not a valid email." });
                context.Response.Write(json);
            }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    private void SendEmail(string email, string name)
    {
        string emessage = Resources.Resource.ActivationEmail;
        string subject = Resources.Resource.ActivationEmailSubject;
        emessage = emessage.Replace("[name]", name);
        emessage = emessage.Replace("[activateurl]", string.Format("http://{0}/handlers/activateemail.ashx?mail={1}", currentContext.Request.Url.Host, email));
        emessage = emessage.Replace(System.Environment.NewLine, "<br/>");

        EmailManager.SendMail(Utility.NewsletterEmail, email, Utility.SiteName, name, emessage, subject, EmailMessageType.Activation, EmailMessageType.Activation.ToString());
    }

    private void SubscribeMember()
    {
        try
        {
            if (MemberManager.EmailExist(email))
            {
                MemberManager.ToggleSubscriptionUser(MemberManager.GetUser(email).ID, true);
                json = serializer.Serialize(new { status = "success", message = "" });
                currentContext.Response.Write(json);
            }
            else
            {
                string password = string.Format("{0} {1}{2}", Utility.UniversalPassword, DateTime.Now.Minute.ToString(), DateTime.Now.Second.ToString());
                if (MemberManager.CreateUser(email, password, newsletter, name, null, string.Empty, MemberTypeType.Member))
                {
                    SendEmail(email, name);
                    json = serializer.Serialize(new { status = "success", message = "" });
                    currentContext.Response.Write(json);

                }
            }


            //add name, email and member id in current visit
            Member m = MemberManager.GetUser(email);
            Guid visitid;
            if (Guid.TryParse(CookieWorker.GetCookie("visit", "visitid"), out visitid))
            {
                if (CacheManager.Get<VisitInfo>(visitid.ToString()) != null)
                {
                    VisitManager vm = new VisitManager(CacheManager.Get<VisitInfo>(visitid.ToString()));
                    VisitInfo vi = vm.UpdateVisitorInfo(m.ID, m.MemberName, m.Email, m.MemberImage);
                    CacheManager.AddSliding(vi.ID.ToString(), vi, 2);
                }
            }
        }
        catch (Exception ex)
        {
            currentContext.Trace.Write("Register error");
            currentContext.Trace.Write(ex.Message);
            currentContext.Trace.Write(ex.StackTrace);
            json = serializer.Serialize(new { status = "error", message = ex.Message });
            currentContext.Response.Write(json);
        }
    }

}