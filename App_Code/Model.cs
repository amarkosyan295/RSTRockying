using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.Web.Security;

namespace Rockying.Models
{
    public class Article
    {
        public long ID { get; set; }
        public string Title { get; set; }
        public string MetaTitle { get; set; }

        public string OGImage { get; set; }
        public string OGDescription { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateModified { get; set; }
        public long CreatedBy { get; set; }
        public string CreatedByName { get; set; }
        public long? ModifiedBy { get; set; }
        public string ModifiedByName { get; set; }
        public int Category { get; set; }
        public string Tag { get; set; }
        public string CategoryName { get; set; }
        public PostStatusType Status { get; set; }
        public string Description { get; set; }
        public string Text { get; set; }
        public string WriterName { get; set; }
        public string WriterEmail { get; set; }
        public int Viewed { get; set; }
        public string TemplateName { get; set; }
        public string URL { get; set; }

        public Article()
        {
            Status = PostStatusType.Draft;
            WriterEmail = string.Empty;
            WriterName = string.Empty;
            OGImage = string.Empty;
            OGDescription = string.Empty;
            ModifiedByName = string.Empty;
            TemplateName = string.Empty;
            Viewed = 0;
            URL = string.Empty;
            MetaTitle = string.Empty;

        }

        public Article(Post i)
        {
            Category = i.Category;
            CategoryName = i.Category1.Name;
            CreatedBy = i.CreatedBy;
            CreatedByName = i.Member.MemberName;
            DateCreated = i.DateCreated;
            DateModified = i.DateModified;
            Description = i.Description;
            ID = i.ID;
            ModifiedBy = i.ModifiedBy;
            Status = (PostStatusType)i.Status;
            Tag = i.Tag;
            Text = string.Empty;
            Title = i.Title;
            WriterEmail = i.WriterEmail;
            WriterName = i.WriterName;
            OGDescription = i.OGDescription;
            if (string.IsNullOrEmpty(i.OGImage))
            {
                OGImage = string.Format("//rockying.com/art/category/icons/{0}_big.jpg", CategoryName);
            }
            else
            {
                OGImage = Utility.TrimStartHTTP(i.OGImage);
            }

            Viewed = i.Viewed;
            URL = i.URL;

        }
    }
}