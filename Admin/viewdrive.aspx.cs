using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;
using System.IO;
using System.Data;

public partial class account_viewdrive : MemberPage
{
    public List<String> FolderList = new List<string>();

    public RDirectoryItem CurrentFolder = new RDirectoryItem();
    public string FolderPath { get; set; }
    DriveManager DM;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            
            if (CurrentUser.UserType == (byte)MemberTypeType.Admin)
            {
                DM = new DriveManager(CurrentUser, Server.MapPath(Utility.SiteDriveFolderPath),
                    string.Format("{0}/{1}", Utility.SiteURL, Utility.SiteDriveFolderName));
                DM.ItemDeletable = true;
            }
            else if (CurrentUser.UserType == (byte)MemberTypeType.Author)
            {
                DM = new DriveManager(CurrentUser, Server.MapPath(Utility.SiteDriveFolderPath + "/" + CurrentUser.ID.ToString()),
                    string.Format("{0}/{1}/{2}", Utility.SiteURL, Utility.SiteDriveFolderName, CurrentUser.ID.ToString()));
                DM.ItemDeletable = true;
                //check if author drive folder exists if not create one.
                DM.VerifyDrive();
            }

            if (Request.QueryString["folderpath"] != null)
            {
                FolderPath = Request.QueryString["folderpath"].ToString().Trim();
            }
            else
            {
                FolderPath = string.Empty;
            }

            FolderList = FolderPath.Split('/').ToList<string>();
            CurrentFolder = DM.GetFolderName(FolderPath);


            FolderTableRepeater.DataSource = DM.GetDirectoryItemList(FolderPath);
            FolderTableRepeater.DataBind();
            FileItemRepeater.DataSource = DM.GetFileItemList(FolderPath);
            FileItemRepeater.DataBind();
        }
        catch (Exception ex)
        {
            message4.Text = string.Format("Unable to process request. Error - {0}", ex.Message);
            message4.Visible = true;
            message4.Indicate = AlertType.Error;
        }
    }
}