<%@ WebHandler Language="C#" Class="contact" %>

using System;
using System.Web;
using Rockying;
using Rockying.Models;


public class contact : IHttpHandler
{
    HttpContext currentContext;
    private string email;
    private string name;
    private string phone;
    private string website;
    private string purpose;
    private string message;
    private string json = "";

    public void ProcessRequest(HttpContext context)
    {
        currentContext = context;
        context.Response.Clear();
        context.Response.ContentType = "application/json; charset=utf-8";

        if (!ValidateInput()) {
             return; }

        SendMessage();
    }

    public bool IsReusable
    {
        get        {
            return false;
        }
    }

    private void SendMessage() {
        try
        {
            EmailMessage em = new EmailMessage();
            em.CCAdress = string.Empty;
            em.CreateDate = DateTime.Now;
            em.EmailGroup = "ContactForm";
            em.EmailType = (byte)EmailMessageType.Communication;
            em.FromAddress = email;
            em.FromName = name;
            em.ID = Guid.NewGuid();
            em.Message = string.Format("Phone: {0} <br/>Email: {1} <br/> Website: {2} <br/> Message:<br/> {3}",
                phone, email, website, message);
            em.Subject = string.Format("Message From {0}", name);
            em.ToAddress = Utility.NewsletterEmail;
            em.ToName = Utility.AdminName;

            if (EmailManager.SendMail(em))
            {
                json = "{ \"status\" : \"success\", \"message\" : \"We have received your message, shall contact you shortly.\"}";
                currentContext.Response.Write(json);
            }
            else
            {
                json = "{ \"status\" : \"error\", \"message\" : \"Unable to send your message.\"}";
                currentContext.Response.Write(json);
            }
        }
        catch (Exception ex)
        {
            json = "{ \"status\" : \"error\", \"message\" : \"Unable to send your message. Due to some technical reason.\"}";
            currentContext.Response.Write(json);
            currentContext.Trace.Write(ex.Message);
            currentContext.Trace.Write(ex.StackTrace);
        }
    }
    
    private bool ValidateInput()
    {
        if (currentContext.Request["name"] != null)
        {
            if (!Utility.ValidateRequired(currentContext.Request["name"].Trim()))
            {
                json = "{ \"status\" : \"error\", \"message\" : \"No Name Provided.\"}";
                currentContext.Response.Write(json);
                return false;
            }
            else
            {
                name = currentContext.Request["name"].Trim();
            }
        }
        else
        {
            json = "{ \"status\" : \"error\", \"message\" : \"No Name Provided.\"}";
            currentContext.Response.Write(json);
            return false;
        }

        if (currentContext.Request["email"] != null)
        {
            if (!Utility.ValidateEmail(currentContext.Request["email"].Trim()))
            {
                json = "{ \"status\" : \"error\", \"message\" : \"No Email Provided.\"}";
                currentContext.Response.Write(json);
                return false;
            }
            else
            {
                email = currentContext.Request["email"].Trim();
            }
        }
        else
        {
            json = "{ \"status\" : \"error\", \"message\" : \"No Email Provided.\"}";
            currentContext.Response.Write(json);
            return false;
        }

        if (currentContext.Request["message"] != null)
        {
            if (!Utility.ValidateRequired(currentContext.Request["message"].Trim()))
            {
                json = "{ \"status\" : \"error\", \"message\" : \"No Message Provided.\"}";
                currentContext.Response.Write(json);
                return false;
            }
            else
            {
                message = currentContext.Request["message"].Trim();
            }
        }
        else
        {
            json = "{ \"status\" : \"error\", \"message\" : \"No Message Provided.\"}";
            currentContext.Response.Write(json);
            return false;
        }

        if (currentContext.Request["phone"] != null)
        {
            phone = currentContext.Request["phone"].Trim();
        }

        if (currentContext.Request["website"] != null)
        {
            website = currentContext.Request["website"].Trim();
        }

        if (currentContext.Request["purpose"] != null)
        {
            website = currentContext.Request["purpose"].Trim();
        }

        return true;
    }

}