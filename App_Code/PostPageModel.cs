using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{

    public class PostPageModel
    {
        public Article Item { get; set; }
        public Category ArticleCategory { get; set; }
        public Member ArticleCreator { get; set; }
        public Post NextByWriter { get; set; }
        public Post PrevByWriter { get; set; }
        public List<Article> RecommendationList { get; set; }
        public List<Article> RelatedCategory { get; set; }

        public PostPageModel()
        {
            Item = new Article();
            NextByWriter = null;
            PrevByWriter = null;
            RecommendationList = new List<Article>();
            RelatedCategory = new List<Article>();
            ArticleCreator = new Member();
        }
    }
}