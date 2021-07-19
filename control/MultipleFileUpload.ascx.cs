using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class control_MultipleFileUpload : System.Web.UI.UserControl
{
    #region [ options ]

    /// <summary>
    /// Storage folder path (ex. C:\Storage).
    /// </summary>
    public string StorageFolder { get { return (string)(ViewState["StorageFolder"] ?? string.Empty); } set { ViewState["StorageFolder"] = value; } }

    /// <summary>
    /// Allowed file types (ex. jpg|gif|png).
    /// </summary>
    public string AcceptFileTypes { get { return (string)(ViewState["AcceptFileTypes"] ?? ".*"); } set { ViewState["AcceptFileTypes"] = value; } }

    /// <summary>
    /// Enable Chunked Uploads for browsers supporting the Blob API. Defaults to false.
    /// </summary>
    public bool EnableChunkedUploads { get { return (bool)(ViewState["EnableChunkedUploads"] ?? false); } set { ViewState["EnableChunkedUploads"] = value; } }

    /// <summary>
    /// Preferred maximum chunk size in Bytes. Defaults to 10MB.
    /// </summary>
    public int MaxChunkSize { get { return (int)(ViewState["MaxChunkSize"] ?? 10000000); } set { ViewState["MaxChunkSize"] = value; } }

    /// <summary>
    /// Sequential uploads. Defaults to simultaneous uploads.
    /// </summary>
    public bool SequentialUploads { get { return (bool)(ViewState["SequentialUploads"] ?? false); } set { ViewState["SequentialUploads"] = value; } }

    /// <summary>
    /// Enable resuming Uploads for browsers supporting the Blob API. Defaults to false.
    /// EnableChunkedUploads needs to be True to enable resuming.
    /// </summary>
    public bool Resume { get { return (bool)(ViewState["Resume"] ?? false); } set { ViewState["Resume"] = value; } }

    /// <summary>
    /// Enable automatic resuming Uploads for browsers supporting the Blob API in case of upload failures. Defaults to false.
    /// Resume needs to be True to enable this option.
    /// </summary>
    public bool AutoRetry { get { return (bool)(ViewState["AutoRetry"] ?? false); } set { ViewState["AutoRetry"] = value; } }

    /// <summary>
    /// Maximum retries. Defaults to 100 retries.
    /// </summary>
    public int MaxRetries { get { return (int)(ViewState["MaxRetries"] ?? 100); } set { ViewState["MaxRetries"] = value; } }

    /// <summary>
    /// Retry time out in milliseconds, before the file upload is resumed. Defaults to 500 milliseconds.
    /// </summary>
    public int RetryTimeout { get { return (int)(ViewState["RetryTimeout"] ?? 500); } set { ViewState["RetryTimeout"] = value; } }

    /// <summary>
    /// To limit the number of concurrent uploads, set this option to an integer value greater than 0.
    /// Defaults to undefined.
    /// </summary>
    public int LimitConcurrentUploads { get { return (int)(ViewState["LimitConcurrentUploads"] ?? -1); } set { ViewState["LimitConcurrentUploads"] = value; } }

    /// <summary>
    /// Set this option to true to force iframe transport uploads, even if the browser is capable of XmlHttpRequest file uploads.
    /// This can be useful for cross-site file uploads, if the Access-Control-Allow-Origin header cannot be set for the server-side upload handler which is required for cross-site XHR file uploads.
    /// Defaults to false.
    /// </summary>
    public bool ForceIframeTransport { get { return (bool)(ViewState["ForceIframeTransport"] ?? false); } set { ViewState["ForceIframeTransport"] = value; } }

    /// <summary>
    /// By default, files added to the UI are uploaded as soon as the user clicks on the start buttons. To enable automatic uploads, set this option to true.
    /// Defauls to false.
    /// </summary>
    public bool AutoUpload { get { return (bool)(ViewState["AutoUpload"] ?? false); } set { ViewState["AutoUpload"] = value; } }

    /// <summary>
    /// This option limits the number of files that are allowed to be uploaded.
    /// By default, unlimited file uploads are allowed.
    /// </summary>
    public int MaxNumberOfFiles { get { return (int)(ViewState["MaxNumberOfFiles"] ?? -1); } set { ViewState["MaxNumberOfFiles"] = value; } }

    /// <summary>
    /// The maximum allowed file size in bytes, by default unlimited.
    /// </summary>
    public int MaxFileSize { get { return (int)(ViewState["MaxFileSize"] ?? -1); } set { ViewState["MaxFileSize"] = value; } }

    /// <summary>
    /// The minimum allowed file size, by default 1 byte.
    /// </summary>
    public int MinFileSize { get { return (int)(ViewState["MinFileSize"] ?? -1); } set { ViewState["MinFileSize"] = value; } }

    /// <summary>
    /// By default, preview images are displayed as canvas elements if supported by the browser.
    /// Set this option to false to always display preview images as img elements.
    /// Defaults to true.
    /// </summary>
    public bool PreviewAsCanvas { get { return (bool)(ViewState["PreviewAsCanvas"] ?? true); } set { ViewState["PreviewAsCanvas"] = value; } }

    #endregion

    #region [ client side events ]

    /// <summary>
    /// This event fires when the file is added to the upload queue. 
    /// </summary>
    public string OnFileUploadAdd { get { return (string)(ViewState["OnFileUploadAdd"] ?? string.Empty); } set { ViewState["OnFileUploadAdd"] = value; } }

    /// <summary>
    /// This event fires when the file is submitted. If this event returns False, the file upload request is not started.
    /// </summary>
    public string OnFileUploadSubmit { get { return (string)(ViewState["OnFileUploadSubmit"] ?? string.Empty); } set { ViewState["OnFileUploadSubmit"] = value; } }

    /// <summary>
    /// This event fires at the start of file upload request. If this event returns False, the file upload request is aborted. 
    /// </summary>
    public string OnFileUploadSend { get { return (string)(ViewState["OnFileUploadSend"] ?? string.Empty); } set { ViewState["OnFileUploadSend"] = value; } }

    /// <summary>
    /// This event fires when the file upload is completed successfuly. 
    /// </summary>
    public string OnFileUploadDone { get { return (string)(ViewState["OnFileUploadDone"] ?? string.Empty); } set { ViewState["OnFileUploadDone"] = value; } }

    /// <summary>
    /// This event fires in case of failed (abort or error) uploads. 
    /// </summary>
    public string OnFileUploadFail { get { return (string)(ViewState["OnFileUploadFail"] ?? string.Empty); } set { ViewState["OnFileUploadFail"] = value; } }

    /// <summary>
    /// This event fires in case of completed (success, abort or error) uploads. 
    /// </summary>
    public string OnFileUploadAlways { get { return (string)(ViewState["OnFileUploadAlways"] ?? string.Empty); } set { ViewState["OnFileUploadAlways"] = value; } }

    /// <summary>
    ///  This event fires for upload progress of a file. 
    /// </summary>
    public string OnFileUploadProgress { get { return (string)(ViewState["OnFileUploadProgress"] ?? string.Empty); } set { ViewState["OnFileUploadProgress"] = value; } }

    /// <summary>
    /// This event fires for global upload progress. 
    /// </summary>
    public string OnFileUploadProgressAll { get { return (string)(ViewState["OnFileUploadProgressAll"] ?? string.Empty); } set { ViewState["OnFileUploadProgressAll"] = value; } }

    /// <summary>
    /// This event fires when upload starts.
    /// </summary>
    public string OnFileUploadStart { get { return (string)(ViewState["OnFileUploadStart"] ?? string.Empty); } set { ViewState["OnFileUploadStart"] = value; } }

    /// <summary>
    ///  This event fires when upload stops. 
    /// </summary>
    public string OnFileUploadStop { get { return (string)(ViewState["OnFileUploadStop"] ?? string.Empty); } set { ViewState["OnFileUploadStop"] = value; } }

    /// <summary>
    /// This event fires when the file input collection changes. 
    /// </summary>
    public string OnFileUploadChange { get { return (string)(ViewState["OnFileUploadChange"] ?? string.Empty); } set { ViewState["OnFileUploadChange"] = value; } }

    /// <summary>
    /// This event fires for paste events to the dropZone collection.  
    /// </summary>
    public string OnFileUploadPaste { get { return (string)(ViewState["OnFileUploadPaste"] ?? string.Empty); } set { ViewState["OnFileUploadPaste"] = value; } }

    /// <summary>
    /// This event fires for drop events of the dropZone collection. 
    /// </summary>
    public string OnFileUploadDrop { get { return (string)(ViewState["OnFileUploadDrop"] ?? string.Empty); } set { ViewState["OnFileUploadDrop"] = value; } }

    /// <summary>
    /// This event fires for dragover events of the dropZone collection.
    /// </summary>
    public string OnFileUploadDragOver { get { return (string)(ViewState["OnFileUploadDragOver"] ?? string.Empty); } set { ViewState["OnFileUploadDragOver"] = value; } }

    /// <summary>
    /// This event fires before the file is deleted.
    /// </summary>
    public string OnFileUploadDestroy { get { return (string)(ViewState["OnFileUploadDestroy"] ?? string.Empty); } set { ViewState["OnFileUploadDestroy"] = value; } }

    /// <summary>
    /// This event fires after the file is deleted, the transition effects have completed and the download template has been removed.
    /// </summary>
    public string OnFileUploadDestroyed { get { return (string)(ViewState["OnFileUploadDestroyed"] ?? string.Empty); } set { ViewState["OnFileUploadDestroyed"] = value; } }

    /// <summary>
    /// This event fires after the file has been added to the list, the upload template has been rendered and the transition effects have completed.
    /// </summary>
    public string OnFileUploadAdded { get { return (string)(ViewState["OnFileUploadAdded"] ?? string.Empty); } set { ViewState["OnFileUploadAdded"] = value; } }

    /// <summary>
    /// This event fires after the send event and the file is about to be sent.
    /// </summary>
    public string OnFileUploadSent { get { return (string)(ViewState["OnFileUploadSent"] ?? string.Empty); } set { ViewState["OnFileUploadSent"] = value; } }

    /// <summary>
    /// This event fires after successful uploads after the download template has been rendered and the transition effects have completed.
    /// </summary>
    public string OnFileUploadCompleted { get { return (string)(ViewState["OnFileUploadCompleted"] ?? string.Empty); } set { ViewState["OnFileUploadCompleted"] = value; } }

    /// <summary>
    /// This event fires after failed uploads after the download template has been rendered and the transition effects have completed.
    /// </summary>
    public string OnFileUploadFailed { get { return (string)(ViewState["OnFileUploadFailed"] ?? string.Empty); } set { ViewState["OnFileUploadFailed"] = value; } }

    /// <summary>
    /// This event fires after the start event has run and the transition effects called in the start event have completed.
    /// </summary>
    public string OnFileUploadStarted { get { return (string)(ViewState["OnFileUploadStarted"] ?? string.Empty); } set { ViewState["OnFileUploadStarted"] = value; } }

    /// <summary>
    /// This event fires after the stop event has run and the transition effects called in the stop event have completed.
    /// </summary>
    public string OnFileUploadStopped { get { return (string)(ViewState["OnFileUploadStopped"] ?? string.Empty); } set { ViewState["OnFileUploadStopped"] = value; } }

    #endregion
}