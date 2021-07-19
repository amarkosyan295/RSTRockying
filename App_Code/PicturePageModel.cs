using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{
    public class PicturePageModel
    {
        public long Prev { get; set; }
        public PictureModel Current { get; set; }
        public long Next { get; set; }
        public List<PictureModel> Related { get; set; }
        public List<Article> RelatedCategory { get; set; }

        public PicturePageModel()
        {
            Related = new List<PictureModel>();
            RelatedCategory = new List<Article>();
        }
    }
}