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
    public Dictionary<string, PopularBook> PopularList { get; set; }
    public Dictionary<long, MemberBook> MemberBooks = new Dictionary<long, MemberBook>();

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        PopularList = new Dictionary<string, PopularBook>();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            if (CurrentUser != null)
            {
                var list = dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID).ToList();
                foreach (var l in list)
                    MemberBooks.Add(l.BookID, l);
            }
            var list2 = dc.PopularBooks.OrderByDescending(t => t.ShelfCount).Take(100).ToList();
            foreach (var item in list2)
                if (!PopularList.ContainsKey(item.Title.Trim().ToLower()) && PopularList.Count < 51)
                    PopularList.Add(item.Title.Trim().ToLower(), item);
        }
    }
}