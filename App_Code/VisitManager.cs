using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;
using System.Xml;

namespace Rockying.Models
{
    //public class IPLocation
    //{
    //    public string statusCode { get; set; }
    //    public string statusMessage { get; set; }
    //    public string ipAddress { get; set; }
    //    public string countryCode { get; set; }
    //    public string countryName { get; set; }
    //    public string regionName { get; set; }
    //    public string cityName { get; set; }
    //    public string zipCode { get; set; }
    //    public string latitude { get; set; }
    //    public string longitude { get; set; }
    //    public string timeZone { get; set; }

    //    public IPLocation()
    //    {
    //        statusCode = string.Empty;
    //        statusMessage = string.Empty;
    //        ipAddress = string.Empty;
    //        countryCode = string.Empty;
    //        countryName = string.Empty;
    //        regionName = string.Empty;
    //        cityName = string.Empty;
    //        zipCode = string.Empty;
    //        latitude = string.Empty;
    //        longitude = string.Empty;
    //        timeZone = string.Empty;
    //    }
    //}

    //[Serializable]
    //public class VisitInfo
    //{
    //    public Guid ID { get; set; }
    //    public DateTime VisitDate { get; set; }
    //    public string Name { get; set; }
    //    public string URLReferer { get; set; }
    //    public string Country { get; set; }
    //    public string State { get; set; }
    //    public string City { get; set; }
    //    public string Area { get; set; }
    //    public string UserAgent { get; set; }
    //    public long MemberID { get; set; }
    //    public string MemberEmail { get; set; }
    //    public bool ReturnVisit { get; set; }
    //    public Guid PreviousID { get; set; }
    //    public List<ViewInfo> Views { get; set; }
    //    public string RequestType { get; set; }
    //    public DateTime LastHeartBeat { get; set; }
    //    public string MemberImage { get; set; }
    //    public string IP { get; set; }
    //    public long AdminId { get; set; }
    //    public string AdminName { get; set; }
    //    public string SearchKeyword { get; set; }
    //    public VisitChatBoard VisitBoard { get; set; }

    //    public int TimeSpent
    //    {
    //        get
    //        {
    //            int result = 0;
    //            foreach (ViewInfo vi in Views)
    //            {
    //                result += Convert.ToInt32(vi.TimeSpent);
    //            }
    //            return result;
    //        }
    //        set { }
    //    }

    //    public int TotalViews
    //    {
    //        get { return Views.Count; }
    //        set { }
    //    }

    //    public string CurrentView
    //    {
    //        get
    //        {
    //            if (Views.Count > 0)
    //            {
    //                return Views.Last().PageUrlRaw;
    //            }
    //            else
    //            {
    //                return string.Empty;
    //            }
    //        }
    //        set { }
    //    }

    //    public List<Actionable> Actionables { get; set; }

    //    public string LastVisitorMessage
    //    {
    //        get
    //        {
    //            string result = string.Empty;
    //            if (VisitBoard.MessageList.Count > 0)
    //            {
    //                if (VisitBoard.MessageList[VisitBoard.MessageList.Count - 1].SenderID == MemberID)
    //                {
    //                    result = VisitBoard.MessageList[VisitBoard.MessageList.Count - 1].Message;
    //                }
    //            }
    //            return result;
    //        }
    //    }

    //    public VisitInfo()
    //    {
    //        Actionables = new List<Actionable>();
    //        ID = Guid.NewGuid();
    //        IP = string.Empty;
    //        Name = string.Empty;
    //        RequestType = string.Empty;
    //        VisitDate = DateTime.Now;
    //        Country = string.Empty;
    //        State = string.Empty;
    //        City = string.Empty;
    //        Area = string.Empty;
    //        UserAgent = string.Empty;
    //        MemberID = 0;
    //        ReturnVisit = false;
    //        PreviousID = Guid.Empty;
    //        URLReferer = string.Empty;
    //        MemberImage = string.Empty;
    //        Views = new List<ViewInfo>();
    //        VisitBoard = new VisitChatBoard();
    //        SearchKeyword = string.Empty;
    //    }
    //}

    //[Serializable]
    //public class ViewInfo
    //{
    //    public string PageUrlRaw { get; set; }
    //    public string PageUrlPath { get; set; }
    //    public string PageUrlData { get; set; }
    //    public DateTime Arrival { get; set; }
    //    /// <summary>
    //    /// Record Time Spent of View in seconds
    //    /// </summary>
    //    public double TimeSpent { get; set; }
    //    public List<ViewAction> Actions { get; set; }


    //    public ViewInfo()
    //    {
    //        PageUrlRaw = string.Empty;
    //        PageUrlPath = string.Empty;
    //        PageUrlData = string.Empty;
    //        Arrival = DateTime.Now;
    //        TimeSpent = 0;
    //        Actions = new List<ViewAction>();

    //    }
    //}

    //[Serializable]
    //public class ViewAction
    //{
    //    public string Action { get; set; }
    //    public string Name { get; set; }
    //    public string ID { get; set; }
    //    public string Other { get; set; }
    //    public DateTime Created { get; set; }

    //    public ViewAction()
    //    {
    //        Action = string.Empty;
    //        Name = string.Empty;
    //        ID = string.Empty;
    //        Other = string.Empty;
    //        Created = DateTime.Now;

    //    }
    //}

    //[Serializable]
    //public class Actionable
    //{
    //    public Guid ID { get; set; }
    //    public string Name { get; set; }
    //    public DateTime Created { get; set; }
    //    public bool Status { get; set; }

    //    public Actionable()
    //    {
    //        ID = Guid.Empty;
    //        Name = string.Empty;
    //        Created = DateTime.Now;
    //        Status = false;
    //    }
    //}

    public class VisitManager
    {
        //public VisitManager()
        //{
        //}
       
        ///// <summary>
        ///// Call this function to start recording a visit.
        ///// </summary>
        //public static PageVisit RecordVisit(string pageurl, string useragent, string IP, string referer, long memberid, Guid vid)
        //{

        //    //Get location information from visitors IP address
        //    IPLocation ipl = null;
        //    try
        //    {
        //        WebRequest request = WebRequest.Create("https://www.rudrasofttech.com/handlers/tools/IpLocator.ashx?ip=" + IP);
        //        request.Credentials = CredentialCache.DefaultCredentials;
        //        WebResponse response = request.GetResponse();
        //        Stream dataStream = response.GetResponseStream();
        //        StreamReader reader = new StreamReader(dataStream);
        //        ipl = new JavaScriptSerializer().Deserialize<IPLocation>(reader.ReadToEnd());
        //    }
        //    catch (Exception ex)
        //    {
        //        ipl = new IPLocation();
        //        HttpContext.Current.Trace.Write(ex.Message);
        //        HttpContext.Current.Trace.Write(ex.StackTrace);
        //    }

        //    //New Create new visit.
        //    PageVisit vinfo = new PageVisit()
        //    {
        //        CreateDate = DateTime.UtcNow,
        //        LastHeartBeat = DateTime.UtcNow,
        //        VisitID = vid == Guid.Empty ?  Guid.NewGuid() : vid,
        //        PageURL = pageurl,
        //        MemberID = memberid,
        //        UserAgent = useragent,
        //        URLReferer = referer,
        //        Country = ipl.countryCode,
        //        IPAddress = IP
        //    };

        //    using(RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        //    {
        //        dc.PageVisits.InsertOnSubmit(vinfo);
        //        dc.SubmitChanges();
        //    }

        //    return vinfo;
        //}

        //public static void RecordPulse(  Guid vid, long pageid)
        //{
        //    using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        //    {
        //        dc.ExecuteCommand("UPDATE dbo.PageVisit Set LastHeartBeat = GETUTCDATE() WHERE ID = " + pageid );
        //    }
        //}
    }
}