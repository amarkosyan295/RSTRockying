<%@ WebHandler Language="C#" Class="DownloadCoverPhoto" %>

using System;
using System.Web;
using Rockying;
using System.Linq;
using System.Net;
using System.IO;
using System.Text;
using Rockying.Models;

public class DownloadCoverPhoto : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        StringBuilder builder = new StringBuilder();
        context.Response.ContentType = "text/plain";
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            foreach (var b in dc.Books.Where(t => t.CoverPage.StartsWith("http://books.google.com")).Take(1))
            {
                builder.Append("book id: ");
                builder.Append(b.ID);
                builder.Append(", title: ");
                builder.Append(b.Title);

                string img = SaveImage(b.CoverPage);
                if (!string.IsNullOrEmpty(img))
                    b.CoverPage = "data:image/png;base64," + img;
            }
            dc.SubmitChanges();
        }
        context.Response.Write(builder.ToString());
    }

    private string SaveImage(string imageUrl)
    {
        string ph = string.Empty;
        try
        {
            using (WebClient client = new WebClient())
            {
                using (Stream stream = client.OpenRead(imageUrl))
                {
                    using (var memoryStream = new MemoryStream())
                    {
                        stream.CopyTo(memoryStream);
                        byte[] bytes = memoryStream.ToArray();
                        ph = Convert.ToBase64String(bytes);
                    }

                    stream.Flush();
                    stream.Close();
                    client.Dispose();
                }
            }
        }
        catch (Exception ex)
        {

        }
        return ph;

    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}