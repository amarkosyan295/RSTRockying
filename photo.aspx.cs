using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;
using System.Net.Mail;

public partial class photo : BasePage
{
    public int PhotoID { get; set; }
    public PicturePageModel VPM { get; set; }
    public Member CurrentUser { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.RouteData.Values["id"] != null)
        {
            try
            {
                PhotoID = Convert.ToInt32(Page.RouteData.Values["id"]);
            }
            catch (Exception ex)
            {
                Trace.Write("Invalid id");
                Trace.Write(ex.Message);
                Trace.Write(ex.StackTrace);
            }
        }

        if (Request.IsAuthenticated)
        {
            CurrentUser = MemberManager.GetUser(User.Identity.Name);
        }

        VPM = new PicturePageModel();

        try
        {
            VPM.Next = 0;
            VPM.Prev = 0;
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext())
            {
                try
                {
                    dc.ExecuteCommand(string.Format("UPDATE dbo.Picture SET Viewed = Viewed + 1 WHERE ID = {0}", PhotoID), new object[] { });
                }
                catch (Exception er)
                {
                    Trace.Write("Unable to update view count");
                    Trace.Write(er.Message);
                    Trace.Write(er.StackTrace);
                }

                var items = (from u in dc.Pictures
                             where u.ID == PhotoID &&
                             u.Status == (byte)PostStatusType.Publish
                             select new PictureModel()
                             {
                                 CategoryID = u.CategoryID,
                                 CategoryName = u.Category.Name,
                                 CreateDate = u.CreateDate,
                                 CreatedBy = u.CreatedBy,
                                 CreatedByName = u.Member.MemberName,
                                 Description = u.Description,
                                 ID = u.ID,
                                 ImageURL = u.ImageUrl,
                                 ModifiedBy = u.ModifiedBy,
                                 ModifiedByName = u.Member1.MemberName,
                                 ModifiedDate = u.ModifyDate,
                                 Status = (PostStatusType)u.Status,
                                 Title = u.Title,
                                 Tag = u.Tag
                             }).SingleOrDefault();
                if (items != null)
                {
                    VPM.Current = items;
                }
                else
                {
                    Response.Redirect("../default");
                }
                VPM.Next = (from u in dc.Pictures
                            where u.ID > PhotoID &&
                            (!u.Video.HasValue || !u.Video.Value) &&
                            u.Status == (byte)PostStatusType.Publish
                            orderby u.ID ascending
                            select u.ID).Take(1).SingleOrDefault();
                VPM.Prev = (from u in dc.Pictures
                            where u.ID < PhotoID &&
                            (!u.Video.HasValue || !u.Video.Value) &&
                            u.Status == (byte)PostStatusType.Publish
                            orderby u.ID descending
                            select u.ID).Take(1).SingleOrDefault();

                var items2 = (from t in dc.Pictures
                              where
                                t.Video != true &&
                                   t.Status == (byte)PostStatusType.Publish
                              orderby t.Viewed descending
                              select new PictureModel()
                             {
                                 CategoryID = t.CategoryID,
                                 CategoryName = t.Category.Name,
                                 CreateDate = t.CreateDate,
                                 CreatedBy = t.CreatedBy,
                                 CreatedByName = t.Member.MemberName,
                                 Description = t.Description,
                                 ID = t.ID,
                                 ImageURL = t.ImageUrl,
                                 ModifiedBy = t.ModifiedBy,
                                 ModifiedByName = t.Member1.MemberName,
                                 ModifiedDate = t.ModifyDate,
                                 Status = (PostStatusType)t.Status,
                                 Title = t.Title,
                                 Tag = t.Tag,
                                 Viewed = t.Viewed
                             }).Take(12).ToList<PictureModel>();
                VPM.Related.AddRange(items2);


                var items3 = (from t in dc.TopStories orderby t.DateCreated descending select t);
                foreach (var i in items3)
                {
                    Article a = new Article();
                    a.Category = i.Post.Category;
                    a.CategoryName = i.Post.Category1.Name;
                    a.CreatedBy = i.Post.CreatedBy;
                    a.CreatedByName = i.Post.Member.MemberName;
                    a.DateCreated = i.Post.DateCreated;
                    a.DateModified = i.Post.DateModified;
                    a.Description = i.Post.Description;
                    a.ID = i.Post.ID;
                    a.ModifiedBy = i.Post.ModifiedBy;
                    a.Status = (PostStatusType)i.Post.Status;
                    a.Tag = i.Post.Tag;
                    a.Text = string.Empty;
                    a.Title = i.Post.Title;
                    a.OGImage = i.Post.OGImage;
                    a.OGDescription = i.Post.OGDescription;
                    a.WriterEmail = i.Post.WriterEmail;
                    a.WriterName = i.Post.WriterName;
                    a.Viewed = i.Post.Viewed;
                    VPM.RelatedCategory.Add(a);
                }

            }
        }
        catch (Exception ex)
        {
            Trace.Write(ex.Message);
            Trace.Write(ex.StackTrace);
        }
    }
}