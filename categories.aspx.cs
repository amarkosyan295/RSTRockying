using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;

public partial class categories : BasePage
{

    public List<Category> CategoryList { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        using(RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            var query = from t in dc.Categories
                        where t.Posts.Count() > 0 && t.Status == (byte)GeneralStatusType.Active
                        select t;
            CategoryList = new List<Category>();
            CategoryList.AddRange(query);

        }
    }
}