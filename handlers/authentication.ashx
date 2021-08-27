<%@ WebHandler Language="C#" Class="authentication" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using Rockying;
using Rockying.Models;

public class authentication : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    public void ProcessRequest(HttpContext context)
    {
        JavaScriptSerializer s = new JavaScriptSerializer();
        context.Response.ContentType = "text/json";
        if (context.Request.IsAuthenticated)
        {
            Member m = MemberManager.GetUser(HttpContext.Current.User.Identity.Name.ToString());
            context.Response.Write(s.Serialize(new
            {
                authenticated = true,
                Name = m.MemberName,
                Email = m.Email,
                Newsletter = m.Newsletter,
                UserType = m.UserType,
                DOB = m.DOB,
                Country = m.Country,
                AlternateEmail = m.AlternateEmail,
                AlternateEmail2 = m.AlternateEmail2,
                Mobile = m.Mobile,
                Phone = m.Phone,
                Address = m.Address,
                LastName = m.LastName,
                Gender = m.Gender,
                MemberImage = m.MemberImage,
                UserName = m.UserName
            }));
            
        }
        else
        {
            context.Response.Write(s.Serialize(new { authenticated = false }));
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}