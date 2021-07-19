using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{
    public class CacheManager
    {

        public static void Remove(string key)
        {
            HttpContext.Current.Cache.Remove(key);
        }

        public static T Get<T>(string key)
        {
            try
            {
                return (T)HttpContext.Current.Cache.Get(key);
            }
            catch
            {
                return default(T);
            }
        }

        public static void Add(string key, object value, DateTime expiry)
        {
            HttpContext.Current.Cache.Insert(key, value, null, expiry, System.Web.Caching.Cache.NoSlidingExpiration, System.Web.Caching.CacheItemPriority.Normal, null);
        }

        public static void AddSliding(string key, object value, int waitInMinutes)
        {
            HttpContext.Current.Cache.Insert(key, value, null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(waitInMinutes));

        }

        public static List<Category> Category
        {
            get
            {
                if (HttpContext.Current.Cache["Category"] == null)
                {
                    return new List<Category>();
                }
                else
                {
                    return (List<Category>)HttpContext.Current.Cache["Category"];
                }
            }
            set
            {
                HttpContext.Current.Cache["Category"] = value;
            }
        }
    }
}