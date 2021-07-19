<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MultipleFileUpload.ascx.cs" Inherits="control_MultipleFileUpload" %>

    <!-- The file upload form used as target for the file upload widget -->
    <div id="fileupload">
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row-fluid fileupload-buttonbar">
            <div class="span7">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-action fileinput-button"><i class="icon-plus"></i><span>Add files...</span>
                    <!--Enable selecting a complete folder structure, this is currently only supported by Google Chrome-->
                    <input type="file" name="files[]" multiple />
                </span>
                <button type="submit" class="btn btn-action start">
                    <i class="icon-upload"></i><span>Start</span>
                </button>
                <button type="reset" class="btn btn-action cancel">
                    <i class="icon-ban-circle"></i><span>Cancel</span>
                </button>
            </div>
            <!-- The global progress information -->
            <div class="span5 fileupload-progress fade">
                <!-- The global progress bar -->
                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0"
                    aria-valuemax="100">
                    <div class="bar" style="width: 0%;">
                    </div>
                </div>
                <!-- The extended global progress information -->
                <div class="progress-extended">
                    &nbsp;</div>
            </div>
        </div>
        <div class="fileupload-loading">
        </div>
        <div id="dropzone" class="fade well">
            Drop files here</div>
        <br />
        <table role="presentation" class="table table-striped">
            <tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery">
            </tbody>
        </table>
    </div>

<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td class="preview"><span></span></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
            <td class="error" colspan="2"><span class="label label-important">
            {%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
            <td>
                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
            </td>
            <td class="start">{% if (!o.options.autoUpload) { %}
                <button class="btn btn-action">
                    <i class="icon-upload"></i>
                    <span>{%=locale.fileupload.start%}</span>
                </button>
            {% } %}</td>
        {% } else { %}
            <td colspan="2"></td>
        {% } %}
        <td class="cancel">{% if (!i) { %}
            <button class="btn btn-action">
                <i class="icon-ban-circle"></i>
                <span>{%=locale.fileupload.cancel%}</span>
            </button>
        {% } %}</td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
            <td class="name"><span>{%=file.name%}</span></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td class="error" colspan="2"><span class="label label-important">
            {%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else { %}
            <td class="name">
                <span>{%=file.name%}</span>
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td colspan="2"></td>
        {% } %}
        
    </tr>
{% } %}
</script>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/vendor/jquery.ui.widget.js"
    type="text/javascript"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/tmpl.min.js" type="text/javascript"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="http://<%: Request.Url.Host %>/drive/bootstrap/js/load-image.min.js"
    type="text/javascript"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/canvas-to-blob.min.js"
    type="text/javascript"></script>
<!-- Bootstrap JS and Bootstrap Image Gallery are not required, but included for the demo -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/bootstrap-image-gallery.min.js"
    type="text/javascript"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/jquery.iframe-transport.js"
    type="text/javascript"></script>
<!-- The basic File Upload plugin -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/jquery.fileupload.js"
    type="text/javascript"></script>
<!-- The File Upload file processing plugin -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/jquery.fileupload-fp.js"
    type="text/javascript"></script>
<!-- The File Upload user interface plugin -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/jquery.fileupload-ui.js"
    type="text/javascript"></script>
<!-- The localization script -->
<script src="http://<%: Request.Url.Host %>/bootstrap/js/locale.js" type="text/javascript"></script>
<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->
<!--[if gte IE 8]><script src="http://<%: Request.Url.Host %>/bootstrap/js/cors/jquery.xdr-transport.js"></script><![endif]-->
<script type="text/javascript">

    // -------------------------------------------------
    //                 Main script
    // -------------------------------------------------

    /*jslint nomen: true, unparam: true, regexp: true */
    /*global $, window, document */
    $(function () {
        //
        // Options: https://github.com/blueimp/jQuery-File-Upload/wiki/Options
        // Browser support: https://github.com/blueimp/jQuery-File-Upload/wiki/Browser-support
        //
        'use strict';

        //
        // Options
        //
        var maxChunkSize = parseInt('<%= MaxChunkSize %>'),
        enableChunkedUploads = '<%= EnableChunkedUploads %>'.toLowerCase() === 'true' && navigator.userAgent.indexOf('Opera') == -1,
        resume = enableChunkedUploads && '<%= Resume %>'.toLowerCase() === 'true',
        handler = 'http://<%: Request.Url.Host %>/handlers/Upload.ashx?storageFolder=' + '<%= Server.UrlEncode(StorageFolder)  %>' + '&maxChunkSize=' + maxChunkSize + '&resume=' + resume,
        acceptFileTypes = new RegExp('(\.|\/)(' + '<%= AcceptFileTypes %>' + ')', 'i'),
        sequentialUploads = '<%= SequentialUploads %>'.toLowerCase() === 'true',
        autoRetry = '<%= AutoRetry %>'.toLowerCase() === 'true',
        maxRetries = parseInt('<%= MaxRetries %>'),
        retryTimeout = parseInt('<%= RetryTimeout %>'), // in Milliseconds!
        limitConcurrentUploads = parseInt('<%= LimitConcurrentUploads %>'),
        forceIframeTransport = '<%= ForceIframeTransport %>'.toLowerCase() === 'true',
        autoUpload = '<%= AutoUpload %>'.toLowerCase() === 'true',
        maxNumberOfFiles = parseInt('<%= MaxNumberOfFiles %>'),
        maxFileSize = parseInt('<%= MaxFileSize %>'),
        minFileSize = parseInt('<%= MinFileSize %>'),
        previewAsCanvas = '<%= PreviewAsCanvas %>'.toLowerCase() === 'true',

        //
        // Events
        //
        fileuploadadd = '<%= OnFileUploadAdd %>',
        fileuploadsubmit = '<%= OnFileUploadSubmit %>',
        fileuploadsend = '<%= OnFileUploadSend %>',
        fileuploaddone = '<%= OnFileUploadDone %>',
        fileuploadfail = '<%= OnFileUploadFail %>',
        fileuploadalways = '<%= OnFileUploadAlways %>',
        fileuploadprogress = '<%= OnFileUploadProgress %>',
        fileuploadprogressall = '<%= OnFileUploadProgressAll %>',
        fileuploadstart = '<%= OnFileUploadStart %>',
        fileuploadstop = '<%= OnFileUploadStop %>',
        fileuploadchange = '<%= OnFileUploadChange %>',
        fileuploadpaste = '<%= OnFileUploadPaste %>',
        fileuploaddrop = '<%= OnFileUploadDrop %>',
        fileuploaddragover = '<%= OnFileUploadDragOver %>',
        fileuploaddestroy = '<%= OnFileUploadDestroy %>',
        fileuploaddestroyed = '<%= OnFileUploadDestroyed %>',
        fileuploadadded = '<%= OnFileUploadAdded %>',
        fileuploadsent = '<%= OnFileUploadSent %>',
        fileuploadcompleted = '<%= OnFileUploadCompleted %>',
        fileuploadfailed = '<%= OnFileUploadFailed %>',
        fileuploadstarted = '<%= OnFileUploadStarted %>',
        fileuploadstopped = '<%= OnFileUploadStopped %>';

        //
        // Initialize the jQuery File Upload widget
        //
        $('#fileupload').fileupload({
            url: handler,
            dropZone: $('#dropzone'),
            sequentialUploads: sequentialUploads,
            acceptFileTypes: acceptFileTypes,
            limitConcurrentUploads: limitConcurrentUploads == -1 ? undefined : limitConcurrentUploads,
            forceIframeTransport: forceIframeTransport,
            autoUpload: autoUpload,
            maxNumberOfFiles: maxNumberOfFiles == -1 ? undefined : maxNumberOfFiles,
            maxFileSize: maxFileSize == -1 ? undefined : maxFileSize,
            minFileSize: minFileSize == -1 ? undefined : minFileSize,
            previewAsCanvas: previewAsCanvas
        });

        //
        // Chunked uploads works under Chrome and FireFox 4+.
        // Chunked uploads through jQuery File Upload are not supported by Opera yet.
        // Automatic fallback is done for IE and Safari.
        // 
        if (enableChunkedUploads) {
            $('#fileupload').fileupload({
                // In order for chunked uploads to work in Mozilla Firefox, 
                // the multipart option has to be set to false. This is due to 
                // the Gecko 2.0 browser engine - used by Firefox 4+ - adding blobs 
                // with an empty filename when building a multipart upload request 
                // using the FormData interface
                multipart: false,
                maxChunkSize: maxChunkSize, // Defaults to 10 MB 
                beforeSend: function (jqXHR, settings) {
                    if (settings.chunksNumber) {
                        jqXHR.setRequestHeader('X-Chunk-Index', settings.chunkIndex);
                        jqXHR.setRequestHeader('X-Chunks-Number', settings.chunksNumber);
                    }
                }
            });

            if (resume) {
                $('#fileupload').fileupload({
                    add: function (e, data) {
                        var that = this;
                        $.getJSON(handler, { f: data.files[0].name }, function (file) {
                            data.uploadedBytes = file && file.size;
                            $.blueimpUI.fileupload.prototype.options.add.call(that, e, data);
                        });
                    }
                });

                if (autoRetry) {
                    $('#fileupload').fileupload({
                        maxRetries: maxRetries,
                        retryTimeout: retryTimeout, // Milliseconds!
                        fail: function (e, data) {
                            var fu = $(this).data('fileupload'),
                        retries = data.context.data('retries') || 0,
                        retry = function () {
                            $.getJSON(handler, { f: data.files[0].name })
                                .done(function (file) {
                                    data.uploadedBytes = file && file.size;
                                    // clear the previous data
                                    data.data = null;
                                    data.submit();
                                })
                                .fail(function () {
                                    fu._trigger('fail', e, data);
                                });
                        };
                            if (data.errorThrown !== 'abort' &&
                            data.errorThrown !== 'uploadedBytes' &&
                            retries < fu.options.maxRetries) {
                                //alert(retries);
                                retries++;
                                data.context.data('retries', retries);
                                window.setTimeout(retry, retries * fu.options.retryTimeout);
                                return;
                            }
                            data.context.removeData('retries');
                            $.blueimpUI.fileupload.prototype.options.fail.call(this, e, data);
                        }
                    });
                }
            }
            else {
                // Delete the chunks written on the server when canceling the upload
                $('#fileupload').bind('fileuploadfail', function (e, data) {
                    if (data.errorThrown === 'abort') {
                        $.ajax({
                            url: handler
                                + '&'
                                + $.param({ f: data.files[0].name }),
                            type: 'DELETE'
                        });
                    }
                });
            }
        }

        //
        // Enable iframe cross-domain access via redirect option
        //
        $('#fileupload').fileupload(
                    'option',
                    'redirect',
                    window.location.href.replace(/\/[^\/]*$/, '/cors/result.html?%s')
            );

        //
        // Load existing files
        //
        $('#fileupload').each(function () {
            var that = this;
            $.getJSON(handler, function (result) {
                if (result && result.length) {
                    $(that).fileupload('option', 'done')
                .call(that, null, { result: result });
                }
            });
        });

        //
        // Events bindings 
        // (use data.files[0].name, data.files[0].size and data.files[0].type to access the file on the client)
        //
        $('#fileupload')
            .bind('fileuploadadd', function (e, data) {
                typeof window[fileuploadadd] == 'function' && window[fileuploadadd](e, data);
            })
            .bind('fileuploadsubmit', function (e, data) {
                typeof window[fileuploadsubmit] == 'function' && window[fileuploadsubmit](e, data);
            })
            .bind('fileuploadsend', function (e, data) {
                typeof window[fileuploadsend] == 'function' && window[fileuploadsend](e, data);
            })
            .bind('fileuploaddone', function (e, data) {
                typeof window[fileuploaddone] == 'function' && window[fileuploaddone](e, data);
            })
            .bind('fileuploadfail', function (e, data) {
                typeof window[fileuploadfail] == 'function' && window[fileuploadfail](e, data);
            })
            .bind('fileuploadalways', function (e, data) {
                typeof window[fileuploadalways] == 'function' && window[fileuploadalways](e, data);
            })
            .bind('fileuploadprogress', function (e, data) {
                typeof window[fileuploadprogress] == 'function' && window[fileuploadprogress](e, data);
            })
            .bind('fileuploadprogressall', function (e, data) {
                typeof window[fileuploadprogressall] == 'function' && window[fileuploadprogressall](e, data);
            })
            .bind('fileuploadstart', function (e) {
                typeof window[fileuploadstart] == 'function' && window[fileuploadstart](e, data);
            })
            .bind('fileuploadstop', function (e) {
                typeof window[fileuploadstop] == 'function' && window[fileuploadstop](e, data);
            })
            .bind('fileuploadchange', function (e, data) {
                typeof window[fileuploadchange] == 'function' && window[fileuploadchange](e, data);
            })
            .bind('fileuploadpaste', function (e, data) {
                typeof window[fileuploadpaste] == 'function' && window[fileuploadpaste](e, data);
            })
            .bind('fileuploaddrop', function (e, data) {
                typeof window[fileuploaddrop] == 'function' && window[fileuploaddrop](e, data);
            })
            .bind('fileuploaddragover', function (e) {
                typeof window[fileuploaddragover] == 'function' && window[fileuploaddragover](e, data);
            })
            .bind('fileuploaddestroy', function (e, data) {
                typeof window[fileuploaddestroy] == 'function' && window[fileuploaddestroy](e, data);
            })
            .bind('fileuploaddestroyed', function (e, data) {
                typeof window[fileuploaddestroyed] == 'function' && window[fileuploaddestroyed](e, data);
            })
            .bind('fileuploadadded', function (e, data) {
                typeof window[fileuploadadded] == 'function' && window[fileuploadadded](e, data);
            })
            .bind('fileuploadsent', function (e, data) {
                typeof window[fileuploadsent] == 'function' && window[fileuploadsent](e, data);
            })
            .bind('fileuploadcompleted', function (e, data) {
                typeof window[fileuploadcompleted] == 'function' && window[fileuploadcompleted](e, data);
            })
            .bind('fileuploadfailed', function (e, data) {
                typeof window[fileuploadfailed] == 'function' && window[fileuploadfailed](e, data);
            })
            .bind('fileuploadstarted', function (e) {
                typeof window[fileuploadstarted] == 'function' && window[fileuploadstarted](e, data);
            })
            .bind('fileuploadstopped', function (e) {
                typeof window[fileuploadstopped] == 'function' && window[fileuploadstopped](e, data);
            });
    });

    //
    //  dragover event
    //
    $(document).bind('dragover', function (e) {
        var dropZone = $('#dropzone'), timeout = window.dropZoneTimeout;
        if (!timeout) {
            dropZone.addClass('in');
        } else {
            clearTimeout(timeout);
        }
        if (e.target === dropZone[0]) {
            dropZone.addClass('thumbnail hover');
        } else {
            dropZone.removeClass('hover');
        }
        window.dropZoneTimeout = setTimeout(function () {
            window.dropZoneTimeout = null;
            dropZone.removeClass('in hover');
        }, 100);
    });
</script>
