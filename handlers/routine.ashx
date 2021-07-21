<%@ WebHandler Language="C#" Class="routine" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;
using System.Threading.Tasks;
using System.IO;

public class routine : IHttpHandler
{

    private void SendMail(HttpContext context)
    {

        for (int i = 0; i < 5; i++)
        {
            try
            {
                EmailMessage em = EmailManager.GetUnsentMessage();
                if (em != null)
                {
                    EmailManager.SendMail(em);
                }
                else
                {
                    break;
                }
            }
            catch (Exception ex)
            {
                context.Trace.Write(ex.Message);
                context.Trace.Write(ex.StackTrace);
            }
        }

    }
    public void ProcessRequest(HttpContext context)
    {

        SendMail(context);

        //context.Response.ContentType = "text/javascript";
        //System.Text.StringBuilder builder = new System.Text.StringBuilder();
        //builder.Append(File.ReadAllText(context.Server.MapPath("~/handlers/utility.js")).Replace("[rooturl]", string.Format("//{0}", context.Request.Url.Host)));
        //builder.Append(File.ReadAllText(context.Server.MapPath("~/handlers/vr.js")).Replace("[rooturl]", string.Format("//{0}", context.Request.Url.Host)));
        //builder.Append(File.ReadAllText(context.Server.MapPath("~/handlers/chat.js")).Replace("[rooturl]", string.Format("//{0}", context.Request.Url.Host)));
        //context.Response.Write(builder.ToString());

        context.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}