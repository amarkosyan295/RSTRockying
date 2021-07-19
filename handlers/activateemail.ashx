<%@ WebHandler Language="C#" Class="activateemail" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;

public class activateemail : IHttpHandler {
    public EmailMessage EM = new EmailMessage();
    
    public void ProcessRequest (HttpContext context) {
        try
        {
            if (context.Request.QueryString["mail"] != null)
            {
                if (context.Request.QueryString["mail"].ToString() != string.Empty)
                {
                    Member m = MemberManager.GetUser(context.Request.QueryString["mail"].ToString());
                    MemberManager.Update(m.Email, m.MemberName, true, GeneralStatusType.Active);
                }
            }
        }
        catch (Exception ex)
        {
            context.Trace.Write("Unable to set status of member");
            context.Trace.Write(ex.Message);
            context.Trace.Write(ex.StackTrace);
        }

        try
        {
            if (context.Request.QueryString["eid"] != null)
            {
                try
                {
                    EM.ID = new Guid(context.Request.QueryString["eid"].ToString()); EM = EmailManager.GetMessage(EM.ID);
                    if (EM == null)
                    {
                        EM = new EmailMessage();
                    }
                    else
                    {
                        if (!EM.IsRead)
                        {
                            EM.IsRead = true;
                            EM.ReadDate = DateTime.Now;
                            EmailManager.UpdateMessage(EM);
                        }
                    }
                }
                catch (Exception ex)
                {
                    EM.ID = Guid.Empty;
                    context.Trace.Write("Invalid id");
                    context.Trace.Write(ex.Message);
                    context.Trace.Write(ex.StackTrace);
                }
            }
        }
        catch (Exception ex)
        {
            context.Trace.Write("Unable to set status of member");
            context.Trace.Write(ex.Message);
            context.Trace.Write(ex.StackTrace);
        }

        context.Response.Redirect("~/home");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}