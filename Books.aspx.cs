using Rockying;
using Rockying.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Books : BasePage
{
    public List<PopularBook> PopularList { get; set; }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        PopularList = new List<PopularBook>();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            PopularList.AddRange(dc.PopularBooks.OrderByDescending(t => t.ShelfCount).Take(30).ToList());
        }
    }
}