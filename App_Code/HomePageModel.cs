using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{
    public class HomePageModel
    {
        public List<Article> HeroList { get; set; }
        public List<Article> LatestList { get; set; }
        public List<PictureModel> PM { get; set; }

        public HomePageModel()
        {
            HeroList = new List<Article>();
            LatestList = new List<Article>();
            PM = new List<PictureModel>();
        }
    }
}