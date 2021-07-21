<%@ WebHandler Language="C#" Class="VisitsInfo" %>

using System;
using System.Web;
using System.Net;
using System.IO;

public class VisitsInfo : IHttpHandler
{

        private string websiteId = "1";
    public void ProcessRequest(HttpContext context)
    {
            string s = "";
        try
        {
            if (context.Request.QueryString["u"] != null)
            {
                WebRequest req;
                req = WebRequest.Create(string.Format("http://vtracker.rudrasofttech.com/report/count/{0}?path={1}",websiteId, context.Request.QueryString["u"]));
                Stream objStream;
                objStream = req.GetResponse().GetResponseStream();
                StreamReader objReader = new StreamReader(objStream);

                s = objReader.ReadToEnd();
            }
        }
        catch (Exception ex)
        {
            context.Trace.Write("Unable to set status of member");
            context.Trace.Write(ex.Message);
            context.Trace.Write(ex.StackTrace);
        }
        context.Response.ContentType = "text/plain";
        context.Response.Write(s);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}