<%@ WebHandler Language="C#" Class="FileComplete" %>

using System;
using System.Web;

public class FileComplete : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "image/png";
        context.Response.WriteFile(context.Server.MapPath("~/bootstrap/img/file-complete-icon.png"));
    }

    public bool IsReusable { get { return false; } }
}