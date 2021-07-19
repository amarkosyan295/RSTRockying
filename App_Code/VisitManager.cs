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
    public class IPLocation
    {
        public string statusCode { get; set; }
        public string statusMessage { get; set; }
        public string ipAddress { get; set; }
        public string countryCode { get; set; }
        public string countryName { get; set; }
        public string regionName { get; set; }
        public string cityName { get; set; }
        public string zipCode { get; set; }
        public string latitude { get; set; }
        public string longitude { get; set; }
        public string timeZone { get; set; }

        public IPLocation()
        {
            statusCode = string.Empty;
            statusMessage = string.Empty;
            ipAddress = string.Empty;
            countryCode = string.Empty;
            countryName = string.Empty;
            regionName = string.Empty;
            cityName = string.Empty;
            zipCode = string.Empty;
            latitude = string.Empty;
            longitude = string.Empty;
            timeZone = string.Empty;
        }
    }

    [Serializable]
    public class VisitInfo
    {
        public Guid ID { get; set; }
        public DateTime VisitDate { get; set; }
        public string Name { get; set; }
        public string URLReferer { get; set; }
        public string Country { get; set; }
        public string State { get; set; }
        public string City { get; set; }
        public string Area { get; set; }
        public string UserAgent { get; set; }
        public long MemberID { get; set; }
        public string MemberEmail { get; set; }
        public bool ReturnVisit { get; set; }
        public Guid PreviousID { get; set; }
        public List<ViewInfo> Views { get; set; }
        public string RequestType { get; set; }
        public DateTime LastHeartBeat { get; set; }
        public string MemberImage { get; set; }
        public string IP { get; set; }
        public long AdminId { get; set; }
        public string AdminName { get; set; }
        public string SearchKeyword { get; set; }
        public VisitChatBoard VisitBoard { get; set; }

        public int TimeSpent
        {
            get
            {
                int result = 0;
                foreach (ViewInfo vi in Views)
                {
                    result += Convert.ToInt32(vi.TimeSpent);
                }
                return result;
            }
            set { }
        }

        public int TotalViews
        {
            get { return Views.Count; }
            set { }
        }

        public string CurrentView
        {
            get
            {
                if (Views.Count > 0)
                {
                    return Views.Last().PageUrlRaw;
                }
                else
                {
                    return string.Empty;
                }
            }
            set { }
        }

        public List<Actionable> Actionables { get; set; }

        public string LastVisitorMessage
        {
            get
            {
                string result = string.Empty;
                if (VisitBoard.MessageList.Count > 0)
                {
                    if (VisitBoard.MessageList[VisitBoard.MessageList.Count - 1].SenderID == MemberID)
                    {
                        result = VisitBoard.MessageList[VisitBoard.MessageList.Count - 1].Message;
                    }
                }
                return result;
            }
        }

        public VisitInfo()
        {
            Actionables = new List<Actionable>();
            ID = Guid.NewGuid();
            IP = string.Empty;
            Name = string.Empty;
            RequestType = string.Empty;
            VisitDate = DateTime.Now;
            Country = string.Empty;
            State = string.Empty;
            City = string.Empty;
            Area = string.Empty;
            UserAgent = string.Empty;
            MemberID = 0;
            ReturnVisit = false;
            PreviousID = Guid.Empty;
            URLReferer = string.Empty;
            MemberImage = string.Empty;
            Views = new List<ViewInfo>();
            VisitBoard = new VisitChatBoard();
            SearchKeyword = string.Empty;
        }
    }

    [Serializable]
    public class ViewInfo
    {
        public string PageUrlRaw { get; set; }
        public string PageUrlPath { get; set; }
        public string PageUrlData { get; set; }
        public DateTime Arrival { get; set; }
        /// <summary>
        /// Record Time Spent of View in seconds
        /// </summary>
        public double TimeSpent { get; set; }
        public List<ViewAction> Actions { get; set; }


        public ViewInfo()
        {
            PageUrlRaw = string.Empty;
            PageUrlPath = string.Empty;
            PageUrlData = string.Empty;
            Arrival = DateTime.Now;
            TimeSpent = 0;
            Actions = new List<ViewAction>();

        }
    }

    [Serializable]
    public class ViewAction
    {
        public string Action { get; set; }
        public string Name { get; set; }
        public string ID { get; set; }
        public string Other { get; set; }
        public DateTime Created { get; set; }

        public ViewAction()
        {
            Action = string.Empty;
            Name = string.Empty;
            ID = string.Empty;
            Other = string.Empty;
            Created = DateTime.Now;

        }
    }

    [Serializable]
    public class Actionable
    {
        public Guid ID { get; set; }
        public string Name { get; set; }
        public DateTime Created { get; set; }
        public bool Status { get; set; }

        public Actionable()
        {
            ID = Guid.Empty;
            Name = string.Empty;
            Created = DateTime.Now;
            Status = false;
        }
    }

    public class VisitManager
    {
        public VisitInfo CurrentVisit = null;

        public VisitManager(VisitInfo cv)
        {
            CurrentVisit = cv;
        }

        public static void DiscardVisit(Guid id)
        {
            List<Guid> list = ApplicationWorker.Visits;

            if (list != null)
            {
                if (list.Contains(id))
                {
                    list.Remove(id);
                }
            }
            ApplicationWorker.Visits = list;
        }

        /// <summary>
        /// Call this function to start recording a visit.
        /// </summary>
        public static VisitInfo StartRecording(string pageurl, string useragent, string IP, DateTime visitDate, long memberid, string name, string email, bool returnvisit, Guid previousVisitID, string referer, string requestType)
        {

            //Get location information from visitors IP address
            IPLocation ipl = null;
            try
            {
                WebRequest request = WebRequest.Create("http://www.rudrasofttech.com/handlers/tools/IpLocator.ashx?ip=" + IP);
                request.Credentials = CredentialCache.DefaultCredentials;
                WebResponse response = request.GetResponse();
                Stream dataStream = response.GetResponseStream();
                StreamReader reader = new StreamReader(dataStream);
                ipl = new JavaScriptSerializer().Deserialize<IPLocation>(reader.ReadToEnd());
            }
            catch (Exception ex)
            {
                ipl = new IPLocation();
                HttpContext.Current.Trace.Write(ex.Message);
                HttpContext.Current.Trace.Write(ex.StackTrace);
            }

            //New Create new visit.
            VisitInfo vinfo = new VisitInfo()
            {
                IP = IP,
                RequestType = requestType,
                MemberID = memberid,
                Name = name,
                MemberEmail = email,
                ReturnVisit = returnvisit,
                UserAgent = useragent,
                PreviousID = previousVisitID,
                VisitDate = visitDate,
                URLReferer = referer,
                Country = ipl.countryName,
                City = ipl.cityName,
                State = ipl.regionName,
                Area = ipl.zipCode
            };

            //Add first view to visit
            ViewInfo vi = new ViewInfo();
            vi.PageUrlRaw = pageurl;
            vi.PageUrlPath = string.Empty;
            vi.PageUrlData = string.Empty;
            vinfo.Views.Insert(0, vi);
            return vinfo;
        }

        /// <summary>
        /// Record action done to current view.
        /// </summary>
        /// <param name="xml"></param>
        /// <returns></returns>
        public VisitInfo RecordAction(string xml)
        {
            XmlDocument doc = new XmlDocument();
            try
            {
                doc.LoadXml(xml);
                ViewInfo currentView = CurrentVisit.Views.First<ViewInfo>();
                currentView.TimeSpent = (DateTime.Now - currentView.Arrival).TotalSeconds;

                if (doc.GetElementsByTagName("a").Count > 0)
                {
                    //update last heartbeat 
                    if (doc.GetElementsByTagName("a")[0].InnerText.ToLower() == "heartbeat")
                    {
                        CurrentVisit.LastHeartBeat = DateTime.Now;
                    }

                    if (doc.GetElementsByTagName("v").Count > 0)
                    {
                        Uri u = new Uri(doc.GetElementsByTagName("v")[0].InnerText.ToLower());
                        if (currentView.PageUrlRaw.ToLower() != u.PathAndQuery.ToLower())
                        {
                            ViewInfo vi = new ViewInfo();
                            
                            vi.PageUrlRaw = u.PathAndQuery; //doc.GetElementsByTagName("v")[0].InnerText.ToLower();
                            vi.PageUrlPath = string.Empty;
                            vi.PageUrlData = string.Empty;
                            ViewAction va = new ViewAction();
                            va.Created = DateTime.Now;
                            va.Action = doc.GetElementsByTagName("a")[0].InnerText;
                            va.ID = doc.GetElementsByTagName("i")[0].InnerText;
                            va.Name = doc.GetElementsByTagName("n")[0].InnerText;
                            va.Other = doc.GetElementsByTagName("o")[0].InnerText;
                            vi.Actions.Insert(0, va);
                            CurrentVisit.Views.Insert(0, vi);
                        }
                        else
                        {
                            ViewAction va = new ViewAction();
                            va.Created = DateTime.Now;
                            va.Action = doc.GetElementsByTagName("a")[0].InnerText;
                            va.ID = doc.GetElementsByTagName("i")[0].InnerText;
                            va.Name = doc.GetElementsByTagName("n")[0].InnerText;
                            va.Other = doc.GetElementsByTagName("o")[0].InnerText;
                            currentView.Actions.Insert(0, va);
                        }
                    }
                }

            }
            catch { throw; }
            return CurrentVisit;
        }

        public VisitInfo RecordAction(Uri pageurl)
        {
            ViewInfo currentView = CurrentVisit.Views.First<ViewInfo>();
            currentView.TimeSpent = (DateTime.Now - currentView.Arrival).TotalSeconds;

            if (currentView.PageUrlRaw.ToLower() != pageurl.OriginalString.ToLower())
            {
                ViewInfo vi = new ViewInfo();
                Uri u = pageurl;
                vi.PageUrlRaw = u.OriginalString;
                vi.PageUrlPath = u.AbsolutePath;
                vi.PageUrlData = u.Query;
                CurrentVisit.Views.Insert(0, vi);
            }

            return CurrentVisit;
        }

        public VisitInfo UpdateVisitorInfo(long memberid, string name, string email, string image)
        {
            CurrentVisit.MemberID = memberid;
            CurrentVisit.MemberEmail = email;
            CurrentVisit.Name = name;
            CurrentVisit.MemberImage = image;

            return CurrentVisit;
        }

        public VisitInfo SetAdmin(long memberid, string name)
        {

            CurrentVisit.AdminId = memberid;
            CurrentVisit.AdminName = name;

            return CurrentVisit;
        }

        public VisitInfo RemoveAdmin()
        {
            CurrentVisit.AdminId = 0;
            CurrentVisit.AdminName = string.Empty;

            return CurrentVisit;
        }
    }
}