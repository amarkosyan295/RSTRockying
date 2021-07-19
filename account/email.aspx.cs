using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class email : System.Web.UI.Page
{
    public EmailMessage EM = new EmailMessage();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.RouteData.Values["id"] != null)
        {
            try
            {
                EM.ID = new Guid(Page.RouteData.Values["id"].ToString());
            }
            catch (Exception ex)
            {
                EM.ID = Guid.Empty;
                Trace.Write("Invalid id");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }

        EM = EmailManager.GetMessage(EM.ID);
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

        if (Page.RouteData.Values["trans"] != null)
        {
            // 1.
            // Get path of byte file.
            string path = Server.MapPath("~/trans.png");

            // 2.
            // Get byte array of file.
            byte[] byteArray = File.ReadAllBytes(path);

            // 3A.
            // Write byte array with BinaryWrite.
            Response.BinaryWrite(byteArray);

            // 3B.
            // Write with OutputStream.Write [commented out]
            // Response.OutputStream.Write(byteArray, 0, byteArray.Length);

            // 4.
            // Set content type.
            Response.ContentType = "image/png";
            Response.End();
        }
    }
}