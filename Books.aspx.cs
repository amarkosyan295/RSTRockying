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
    public Dictionary<long, MemberBook> MemberBooks = new Dictionary<long, MemberBook>();

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        PopularList = new List<PopularBook>();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
        {
            if(CurrentUser != null)
            {
                var list = dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID).ToList();
                foreach(var l in list)
                    MemberBooks.Add(l.BookID, l);
            }
            PopularList.AddRange(dc.PopularBooks.OrderByDescending(t => t.ShelfCount).Take(30).ToList());
        }
    }
}