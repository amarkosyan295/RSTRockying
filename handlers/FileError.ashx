<%@ WebHandler Language="C#" Class="FileError" %>

using System;
using System.Web;

public class FileError : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "image/png";
        context.Response.WriteFile(context.Server.MapPath("~/bootstrap/img/file-error-icon.png"));
    }

    public bool IsReusable { get { return false; } }

}