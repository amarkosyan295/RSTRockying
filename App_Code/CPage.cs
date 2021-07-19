using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{
    [Serializable]
    public class CPage
    {
        public int ID { get; set; }
        public string Name { get; set; }
        public string Title { get; set; }
        public DateTime DateCreated { get; set; }
        public string CreatedByName { get; set; }
        public long CreatedBy { get; set; }
        public PostStatusType Status { get; set; }
        public string ModifiedByName { get; set; }
        public long ModifiedBy { get; set; }
        public string Body { get; set; }
        public DateTime DateModified { get; set; }
        public string Head { get; set; }
        public bool Sitemap { get; set; }
        public bool NoTemplate { get; set; }
        public string PageMeta { get; set; }

        public CPage()
        {
            Name = string.Empty;
            Title = string.Empty;
            Status = PostStatusType.Inactive;
            CreatedByName = string.Empty;
            ModifiedByName = string.Empty;
            Body = string.Empty;
            Head = string.Empty;
            NoTemplate = false;
            PageMeta = string.Empty;
        }
    }
}