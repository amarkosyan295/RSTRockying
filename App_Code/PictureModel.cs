using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace Rockying.Models
{
    public class PictureModel
    {
        public long ID { get; set; }
        public string Title { get; set; }
        public string ImageURL { get; set; }
        public string Description { get; set; }
        public PostStatusType Status { get; set; }
        public DateTime CreateDate { get; set; }
        public long CreatedBy { get; set; }
        public string CreatedByName { get; set; }
        public long? ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedByName { get; set; }
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public string Tag { get; set; }
        public int Viewed { get; set; }

        public PictureModel()
        {
            Title = string.Empty;
            ImageURL = string.Empty;
            Description = string.Empty;
            Viewed = 0;
        }
    }
}