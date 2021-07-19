using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;

namespace Rockying
{
    public class FileStatus
    {
        #region Constructors

        public FileStatus()
        {
        }

        public FileStatus(FileInfo fileInfo, string storageFolder)
        {
            SetValues(fileInfo.Name, fileInfo.Length, storageFolder);
        }

        public FileStatus(string fileName, long fileLength, string storageFolder)
        {
            SetValues(fileName, fileLength, storageFolder);
        }

        #endregion

        #region Properties

        public string group { get; set; }
        public string name { get; set; }
        public string type { get; set; }
        public long size { get; set; }
        public string progress { get; set; }
        public string url { get; set; }
        public string complete_url { get; set; }
        public string error_url { get; set; }
        public string delete_url { get; set; }
        public string delete_type { get; set; }
        public string error { get; set; }
        public string storageFolder { get; set; }

        #endregion

        #region Helpers

        private void SetValues(string fileName, long fileLength, string storage)
        {
            name = fileName;
            type = "image/png";
            size = fileLength;
            progress = "1.0";
            url = "Upload.axd?f=" + fileName + "&storageFolder=" + storage + "&resume=false"; // no resume in case of download
            complete_url = "FileComplete.axd?f=" + fileName;
            error_url = "FileError.axd?f=" + fileName;
            delete_url = "Upload.axd?f=" + fileName + "&storageFolder=" + storage;
            delete_type = "DELETE";
        }

        #endregion
    }
}