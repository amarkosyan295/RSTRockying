using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
using System.Text.RegularExpressions;

namespace Rockying.Models
{
    public class Utility
    {

        public static string PreserveCookie = "rockyingpreserve";
        public static string UpdateReadingProgressHash = "updateprogress";
        public static string ContactEmail
        {
            get
            {
                return GetSiteSetting("ContactEmail");
            }
        }

        public static string Fax
        {
            get
            {
                return GetSiteSetting("Fax");
            }
        }

        public static string Phone
        {
            get
            {
                return GetSiteSetting("Phone");
            }
        }

        public static string Address
        {
            get
            {
                return GetSiteSetting("Address");
            }
        }

        public static string SiteName
        {
            get
            {
                return GetSiteSetting("SiteName");
            }
        }

        public static string SiteURL
        {
            get
            {
                return GetSiteSetting("SiteURL");
            }
        }

        public static string CommentBannedIP
        {
            get
            {
                return GetSiteSetting("CommentBannedIP");
            }
        }

        public static string UniversalPassword
        {
            get
            {
                return GetSiteSetting("UniversalPassword");
            }
        }

        public static string NewsletterEmail
        {
            get
            {
                return GetSiteSetting("NewsletterEmail");
            }
        }

        public static string AdminName
        {
            get
            {
                return GetSiteSetting("AdminName");
            }
        }

        public static string SiteTitle
        {
            get
            {
                return GetSiteSetting("SiteTitle");
            }
        }

        public static string ArticleFolder
        {
            get
            {
                return "~/rockyingdata/Article";
            }
        }

        public static string CustomPageFolder
        {
            get
            {
                return "~/rockyingdata/CustomPage";
            }
        }

        public static string SiteDriveFolderPath
        {
            get
            {
                return string.Format("~/{0}", SiteDriveFolderName);
            }
        }

        public static string SiteDriveFolderName
        {
            get
            {
                return "art";
            }
        }

        public static string TrimStartHTTP(string url)
        {
            return url.TrimStart("http:".ToCharArray());
        }

        public static string GetSiteSetting(string keyname)
        {
            if (CacheManager.Get<string>(keyname) == null)
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    var item = (from t in dc.WebsiteSettings where t.KeyName == keyname select t.KeyValue).SingleOrDefault();
                    if (item != null)
                    {
                        CacheManager.Add(keyname, item, DateTime.Now.AddDays(2));
                    }
                    else
                    {
                        CacheManager.Add(keyname, string.Empty, DateTime.Now.AddSeconds(2));
                    }
                    
                }
            }
            return CacheManager.Get<string>(keyname);
        }
        
        public static T Deserialize<T>(string obj)
        {
            // Create a new file stream for reading the XML file
            XmlSerializer SerializerObj = new XmlSerializer(typeof(T));
            // Load the object saved above by using the Deserialize function
            T LoadedObj = (T)SerializerObj.Deserialize(new StringReader(obj));

            return LoadedObj;
        }

        public static string Serialize<T>(T obj)
        {
            // Create a new XmlSerializer instance with the type of the test class
            XmlSerializer SerializerObj = new XmlSerializer(typeof(T));

            // Create a new file stream to write the serialized object to a file
            TextWriter WriteFileStream = new StringWriter();
            SerializerObj.Serialize(WriteFileStream, obj);

            // Cleanup
            return WriteFileStream.ToString();
        }

        public static List<Category> CategoryList()
        {

            if (CacheManager.Category.Count == 0)
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    CacheManager.Category = (from t in dc.Categories select t).ToList<Category>();
                }
            }
            return CacheManager.Category;
        }

        public static int GetAllCommentCount()
        {
            if (CacheManager.Get<int?>("AllCommentCount") == null)
            {

                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    CacheManager.Add("AllCommentCount", (from t in dc.PageComments where t.Status != (byte)PostStatusType.Inactive select t).Count(), DateTime.Now.AddMinutes(5));
                }
            }
            return CacheManager.Get<int?>("AllCommentCount").Value;
        }

        public static int GetCustomPageCount()
        {
            if (CacheManager.Get<int?>("CustomPageCount") == null)
            {

                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    CacheManager.Add("CustomPageCount", (from t in dc.CustomPages where t.Status != (byte)PostStatusType.Inactive select t).Count(), DateTime.Now.AddMinutes(10));
                }
            }
            return CacheManager.Get<int?>("CustomPageCount").Value;
        }

        public static int GetMemberCount()
        {
            if (CacheManager.Get<int?>("MemberCount") == null)
            {

                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    CacheManager.Add("MemberCount", (from t in dc.Members where t.Status == (byte)GeneralStatusType.Active select t).Count(), DateTime.Now.AddMinutes(50));
                }
            }
            return CacheManager.Get<int?>("MemberCount").Value;
        }

        public static int GetDraftCommentCount()
        {
            if (CacheManager.Get<int?>("DraftCommentCount") == null)
            {

                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    CacheManager.Add("DraftCommentCount", (from t in dc.PageComments where t.Status == (byte)PostStatusType.Draft select t).Count(), DateTime.Now.AddMinutes(1));
                }
            }
            return CacheManager.Get<int?>("DraftCommentCount").Value;
        }

        public static int GetArticleCount()
        {
            if (CacheManager.Get<int?>("ArticleCount") == null)
            {

                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    CacheManager.Add("ArticleCount", (from t in dc.Posts where t.Status != (byte)PostStatusType.Inactive select t).Count(), DateTime.Now.AddMinutes(5));
                }
            }
            return CacheManager.Get<int?>("ArticleCount").Value;
        }

        
        public static string ActivationEmail()
        {
            return GetSiteSetting("ActivationEmail");
        }
        
        public static string ImageFormat()
        {
            return ".bmp,.dds,.dng,.gif,.jpg,.png,.psd,.psd,.pspimage,.tga,.thm,.tif,.yuv,.ai,.eps,.ps,.svg";
        }

        public static string VideoFormat()
        {
            return ".3g2,.3gp,.asf,.asx,.flv,.mov,.mp4,.mpg,.rm,.srt,.swf,.vob,.wmv";
        }

        public static string TextFormat()
        {
            return ".doc,.docx,.log,.msg,.odt,.pages,.rtf,.tex,.txt,.wpd,.wps";
        }

        public static string CompresssedFormat()
        {
            return ".7z,.cbr,.deb,.gz,.pkg,.rar,.rpm,.sit,.sitx,.tar.gz,.zip,.zipx";
        }

        public static string NewsletterDesign()
        {
            return GetSiteSetting("NewsletterDesign");
        }

        public static string UrlFriendlyTitle(string title)
        {
            return HttpContext.Current.Server.UrlEncode(title.Trim().Replace(" ", "-").Replace(":", "-"));
        }

        public static string RemoveAccent(string txt)
        {
            byte[] bytes = System.Text.Encoding.GetEncoding("Cyrillic").GetBytes(txt);
            return System.Text.Encoding.ASCII.GetString(bytes);
        }

        public static string Slugify(string phrase, string emptyreplace = "" )
        {
            string str = RemoveAccent(phrase).ToLower();
            str = System.Text.RegularExpressions.Regex.Replace(str, @"[^a-z0-9/\s-]", ""); // Remove all non valid chars          
            str = System.Text.RegularExpressions.Regex.Replace(str, @"\s+", " ").Trim(); // convert multiple spaces into one space  
            str = System.Text.RegularExpressions.Regex.Replace(str, @"\s", "-"); // //Replace spaces by dashes
            if (string.IsNullOrEmpty(str))
                str = emptyreplace;
            
            return str;
        }

        public static string ConnectionString
        {
            get
            {
                return System.Configuration.ConfigurationManager.ConnectionStrings["RockyingConnectionString"].ConnectionString;
            }
        }

        #region Validation Functions
        public static bool ValidateEmail(string email)
        {
            string pattern = @"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*";
            Regex regex = new Regex(pattern, RegexOptions.IgnoreCase);
            return regex.IsMatch(email);
        }

        public static bool ValidateRequired(string input)
        {
            if (input.Trim() == string.Empty)
            {
                return false;
            }
            else { return true; }
        }
        #endregion
    }
}