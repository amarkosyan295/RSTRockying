using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Rockying;
using Rockying.Models;
using System.IO;

public partial class Admin_ManageDrive : AdminPage
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

    protected void CreateFolderButton_Click(object sender, EventArgs e)
    {
        Page.Validate("foldergrp");
        if (!Page.IsValid) return;
        try
        {
            string newfolder = FolderPath;
            if (newfolder == string.Empty)
            {
                newfolder = FolderTextBox.Text.Trim();
            }
            else
            {
                newfolder = string.Format("{0}/{1}", newfolder, FolderTextBox.Text.Trim());
            }
            DM.CreateDriveFolder(newfolder, DriveItemType.Folder);
            Response.Redirect(string.Format("managedrive.aspx?folderpath={0}", FolderPath));
        }
        catch (Exception ex)
        {
            message1.Text = string.Format("Unable to create folder. Please avoid \\ / : ? * \" &gt; &lt; |<br/>Error: {0}", ex.Message);
            message1.Indicate = AlertType.Error;
            message1.Visible = true;
        }
    }

    protected void RenameFolderButton_Click(object sender, EventArgs e)
    {
        RenameFolderPanel.Visible = true;
        Page.Validate("FolderNameGrp");
        if (!Page.IsValid) return;
        try
        {
            if (DM.RenameFolder(Path.Combine(FolderPath, RenameFolderSourceHdn.Value.Trim()), RenameFolderNameTextBox.Text.Trim()))
            {
                Response.Redirect(string.Format("managedrive.aspx?folderpath={0}", FolderPath));
            }
        }
        catch (DirectoryNotFoundException)
        {
            message2.Text = "Invalid Folder Selected.";
            message2.Indicate = AlertType.Error;
            message2.Visible = true;
        }
        catch (ArgumentException)
        {
            message2.Text = "Please avoid \\ / : ? * \" &gt; &lt; |";
            message2.Indicate = AlertType.Error;
            message2.Visible = true;
        }
        catch (IOException)
        {
            message2.Text = "Folder exists or You do not have permission to perform this action.";
            message2.Indicate = AlertType.Error;
            message2.Visible = true;
        }
    }

    protected void RenameFileButton_Click(object sender, EventArgs e)
    {
        RenameFilePanel.Visible = true;
        Page.Validate("FileNameGrp");
        if (!Page.IsValid) return;
        try
        {
            if (DM.RenameFile(Path.Combine(FolderPath, RenameFileSourceHdn.Value.Trim()), RenameFileNameTextBox.Text.Trim()))
            {
                Response.Redirect(string.Format("managedrive.aspx?folderpath={0}", FolderPath));
            }
        }
        catch (DirectoryNotFoundException)
        {
            message3.Text = "Invalid File Selected.";
            message3.Indicate = AlertType.Error;
            message3.Visible = true;

        }
        catch (ArgumentException)
        {
            message3.Text = "Please avoid \\ / : ? * \" &gt; &lt; |";
            message3.Indicate = AlertType.Error;
            message3.Visible = true;
        }
        catch (IOException)
        {
            message3.Text = "File exists or You do not have permission to perform this action.";
            message3.Indicate = AlertType.Error;
            message3.Visible = true;
        }
        catch (UnauthorizedAccessException)
        {
            message3.Text = "You do not have permission to perform this action. Please avoid \\ / : ? * \" &gt; &lt; | in file name.";
            message3.Indicate = AlertType.Error;
            message3.Visible = true;
        }
    }

    protected void FolderTableRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString().ToLower() == "rename")
        {

            RenameFolderPanel.Visible = true;
            RenameFolderSourceHdn.Value = e.CommandArgument.ToString();
            RenameFolderNameTextBox.Text = e.CommandArgument.ToString();
        }
        else if (e.CommandName.ToString().ToLower() == "delete")
        {

            DM.DeleteFolder(Path.Combine(FolderPath, e.CommandArgument.ToString()));
            Response.Redirect(string.Format("managedrive.aspx?folderpath={0}", FolderPath));
        }
    }

    protected void RenameFolderCancelButton_Click(object sender, EventArgs e)
    {
        RenameFolderPanel.Visible = false;
        RenameFolderSourceHdn.Value = string.Empty;
        RenameFolderNameTextBox.Text = string.Empty;
    }

    protected void RenameFileCancelButton_Click(object sender, EventArgs e)
    {
        RenameFilePanel.Visible = false;
        RenameFileSourceHdn.Value = string.Empty;
        RenameFileNameTextBox.Text = string.Empty;
    }

    protected void FileItemRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName.ToString().ToLower() == "rename")
        {
            RenameFilePanel.Visible = true;
            RenameFileSourceHdn.Value = e.CommandArgument.ToString();
            RenameFileNameTextBox.Text = e.CommandArgument.ToString();
        }
        else if (e.CommandName.ToString().ToLower() == "delete")
        {

            DM.DeleteFile(Path.Combine(FolderPath, e.CommandArgument.ToString()));
            Response.Redirect(string.Format("managedrive.aspx?folderpath={0}", FolderPath));
        }
    }
}