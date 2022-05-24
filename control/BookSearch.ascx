<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BookSearch.ascx.cs" Inherits="control_BookSearch" %>
<%@ Import Namespace="Rockying.Models" %>
<div style="position: relative;">
    <div class="input-group mb-1">
        <button type="button" class="input-group-text" data-bs-toggle="modal" data-bs-target="#livestream_scanner"><i class="bi bi-camera-fill"></i>&nbsp;Scan</button>
        <asp:TextBox ID="SearchKeywordTextBox" CssClass="form-control" placeholder="Search Book by Title or ISBN" MaxLength="300" runat="server"></asp:TextBox>
        <asp:Button ID="SearchButton" CssClass="input-group-text" ValidationGroup="searchbookgrp" runat="server" OnClick="SearchButton_Click" Text="Search" />
    </div>
    <div class="modal fade" id="livestream_scanner" tabindex="-1" aria-labelledby="scanISBNModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="scanISBNModalLabel">ISBN Barcode Scanner</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="interactive" class="viewport"></div>
                    <div class="error"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="searchbookgrp" CssClass="text-danger" Display="Dynamic" ControlToValidate="SearchKeywordTextBox" runat="server" ErrorMessage="Missing Keywords" SetFocusOnError="True"></asp:RequiredFieldValidator>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="10" runat="server">
        <ProgressTemplate>
            <div class="progress m-1" style="height: 5px;">
                <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 75%"></div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true" RenderMode="Block">
        <ContentTemplate>
            <asp:Repeater ID="SearchResultRepeater" runat="server" EnableViewState="false" OnItemDataBound="SearchResultRepeater_ItemDataBound">
                <HeaderTemplate>
                    <div style="position: absolute; top: 40px; z-index: 10; width: 100%" class="bg-light p-2 border">
                        <div class="row mt-2">
                            <div class="col-6">
                                <h5>Search Results</h5>
                            </div>
                            <div class="col-6 text-end">
                                <asp:Button ID="ClearSearchButton" runat="server" Text="Clear" CssClass="btn btn-link btn-sm" OnClick="ClearSearchButton_Click" />
                            </div>
                        </div>
                        <div class="p-1" style="max-height: 500px; overflow-y: auto;">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="card special m-1 border-bottom">
                        <div class="row g-0">
                            <div class="col-mb-2 col-3">
                                <a runat="server" href='<%# "~/book/" + Utility.Slugify(Eval("Title").ToString(), "book")  + "-" + Eval("ID") %>'>
                                    <img src="<%# Eval("CoverPage") %>" class="card-img-top" alt="" /></a>
                            </div>
                            <div class="col-mb-10 col-9">
                                <div class="card-body">
                                    <h5 class="card-title "><a runat="server" class="text-dark text-decoration-none" href='<%# "~/book/" + Utility.Slugify(Eval("Title").ToString(), "book") + "-" + Eval("ID") %>'><%# Eval("Title") %></a></h5>
                                    <p class="card-text">
                                        <asp:Literal ID="AuthorLt" Mode="PassThrough" runat="server" Text='<%# Eval("Author") %>'></asp:Literal>
                                    </p>
                                    <p class="card-text">
                                        Publisher: <%# Eval("Publisher") %>
                                    </p>
                                    <p class="card-text">
                                        <%# Eval("PageCount") %> Pages
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                        </div>
                </FooterTemplate>
            </asp:Repeater>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</div>
<script type="text/javascript">
    $(function () {
        // Create the QuaggaJS config object for the live stream
        var liveStreamConfig = {
            inputStream: {
                type: "LiveStream",
                constraints: {
                    width: { min: 640 },
                    height: { min: 480 },
                    aspectRatio: { min: 1, max: 2 },
                    facingMode: "environment" // or "user" for the front camera
                }
            },
            locator: {
                patchSize: "medium",
                halfSample: true
            },
            numOfWorkers: (navigator.hardwareConcurrency ? navigator.hardwareConcurrency : 4),
            decoder: {
                "readers": [
                    { "format": "ean_reader", "config": {} }
                ]
            },
            locate: true
        };
        // The fallback to the file API requires a different inputStream option. 
        // The rest is the same 
        var fileConfig = $.extend(
            {},
            liveStreamConfig,
            {
                inputStream: {
                    size: 800
                }
            }
        );

        var livestream_scanner = document.getElementById('livestream_scanner');
        // Start the live stream scanner when the modal opens
        livestream_scanner.addEventListener('shown.bs.modal', function (e) {
            Quagga.init(
                liveStreamConfig,
                function (err) {
                    if (err) {
                        $('#livestream_scanner .modal-body .error').html('<div class="alert alert-danger"><strong><i class="fa fa-exclamation-triangle"></i> ' + err.name + '</strong>: ' + err.message + '</div>');
                        Quagga.stop();
                        return;
                    }
                    Quagga.start();
                }
            );
        });

        // Make sure, QuaggaJS draws frames an lines around possible 
        // barcodes on the live stream
        Quagga.onProcessed(function (result) {
            var drawingCtx = Quagga.canvas.ctx.overlay,
                drawingCanvas = Quagga.canvas.dom.overlay;

            if (result) {
                if (result.boxes) {
                    drawingCtx.clearRect(0, 0, parseInt(drawingCanvas.getAttribute("width")), parseInt(drawingCanvas.getAttribute("height")));
                    result.boxes.filter(function (box) {
                        return box !== result.box;
                    }).forEach(function (box) {
                        Quagga.ImageDebug.drawPath(box, { x: 0, y: 1 }, drawingCtx, { color: "green", lineWidth: 2 });
                    });
                }

                if (result.box) {
                    Quagga.ImageDebug.drawPath(result.box, { x: 0, y: 1 }, drawingCtx, { color: "#00F", lineWidth: 2 });
                }

                if (result.codeResult && result.codeResult.code) {
                    Quagga.ImageDebug.drawPath(result.line, { x: 'x', y: 'y' }, drawingCtx, { color: 'red', lineWidth: 3 });
                }
            }
        });

        // Once a barcode had been read successfully, stop quagga and 
        // close the modal after a second to let the user notice where 
        // the barcode had actually been found.
        Quagga.onDetected(function (result) {
            if (result.codeResult.code) {
                $('#<%: SearchKeywordTextBox.ClientID%>').val("isbn:" + result.codeResult.code);
                    $('#<%: SearchButton.ClientID %>').click();
                    Quagga.stop();
                    setTimeout(function () { $('#livestream_scanner').modal('hide'); }, 400);
                }
            });

            // Stop quagga in any case, when the modal is closed
            $('#livestream_scanner').on('hide.bs.modal', function () {
                if (Quagga) {
                    Quagga.stop();
                }
            });

            // Call Quagga.decodeSingle() for every file selected in the 
            // file input
            $("#livestream_scanner input:file").on("change", function (e) {
                if (e.target.files && e.target.files.length) {
                    Quagga.decodeSingle($.extend({}, fileConfig, { src: URL.createObjectURL(e.target.files[0]) }), function (result) { alert(result.codeResult.code); });
                }
            });
        });
</script>
