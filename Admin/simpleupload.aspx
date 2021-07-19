<%@ Page Language="C#" AutoEventWireup="true" CodeFile="simpleupload.aspx.cs" Inherits="Admin_simpleupload" %>
<%@ Register TagPrefix="jQuery" TagName="MultipleFileUpload" Src="~/control/MultipleFileUpload.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="bootstrap/css/custom.css" rel="stylesheet" type="text/css" />
    <link href="http://<%: Request.Url.Host %>/bootstrap/css/bootstrap-image-gallery.min.css"
        rel="stylesheet" type="text/css" />
    <link href="http://<%: Request.Url.Host %>/bootstrap/css/jquery.fileupload-ui.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <jQuery:MultipleFileUpload ID="MultipleFileUpload" runat="server" AcceptFileTypes=".*"
        SequentialUploads="false" EnableChunkedUploads="false" MaxChunkSize="15000000"
        Resume="true" AutoRetry="true" RetryTimeout="500" MaxRetries="100" OnFileUploadDone="fileuploaddone"
        LimitConcurrentUploads="2" MaxFileSize="1000000" ForceIframeTransport="false" AutoUpload="false" PreviewAsCanvas="true" />
    <script type="text/javascript">
        function fileuploaddone(e, data) {
            return false;
        }
    </script>
    </form>
</body>
</html>
