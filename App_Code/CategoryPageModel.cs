using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Rockying.Models
{
    public class CategoryPageModel
    {
        public List<Article> ArticleList { get; set; }
        public List<Category> ChildList { get; set; }
        public Category Current { get; set; }

        public CategoryPageModel()
        {
            ArticleList = new List<Article>();
            ChildList = new List<Category>();
        }
    }
}