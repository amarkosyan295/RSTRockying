<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Book.aspx.cs" Inherits="RockyingBook" %>

<%@ Import Namespace="Rockying.Models" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <%if (CurrentBook != null)
        {%>
    <div class="row">
        <div class="col-md-3 text-center">
            <%if (MemberBook != null && !string.IsNullOrEmpty(MemberBook.Photo))
                { %>
            <img src="<%: MemberBook.Photo %>" id="coverpageimg" class="img-fluid" alt="<%: CurrentBook.Title %>" />
            <%}
                else
                { %>
            <img id="coverpageimg" src="<%: CurrentBook.CoverPage %>" class="img-fluid" alt="<%: CurrentBook.Title %>" />
            <%} %>
            <%if (CurrentUser != null)
                {%>
            <%if (MemberBook != null)
                {%>
            <div class="my-2">
                <button type="button" class="btn btn-sm btn-dark" data-bs-toggle="modal" data-bs-target="#photoUpdateModal">Update Photo</button>
                <div class="modal fade" id="photoUpdateModal" tabindex="-1" aria-labelledby="photoUpdateModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="photoUpdateModalLabel">Update Book Photo</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form enctype="multipart/form-data" action="../handlers/book/updatephoto.ashx" id="updatephotofrm-<%: CurrentBook.ID %>" method="post">
                                    <input type="hidden" name="bookid" value="<%:CurrentBook.ID %>" />
                                    <input type="hidden" name="returnurl" value="~/book/<%: Utility.Slugify(CurrentBook.Title) + "-" + CurrentBook.ID %>" />
                                    <div class="mb-3">
                                        <label for="formFile" class="form-label">Photo of Book</label>
                                        <input class="form-control" type="file" id="formFile" name="photo" />
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick='$("#updatephotofrm-<%: CurrentBook.ID %>").submit();'>Update</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%} %>
            <%if (MemberBook != null && MemberBook.ReadStatus == (byte)ReadStatusType.Read)
                { %>
            <div class="dropdown my-2">
                <button class="btn btn-success btn-sm dropdown-toggle" type="button" id="readStatusBtn" data-bs-toggle="dropdown" aria-expanded="false">Already Read</button>
                <ul class="dropdown-menu" aria-labelledby="readStatusBtn">
                    <li><a class="dropdown-item" href="../handlers/book/add.ashx?rs=2&bookid=<%: CurrentBook.ID %>">Reading Now</a></li>
                    <li><a class="dropdown-item" href="../handlers/book/add.ashx?rs=3&bookid=<%: CurrentBook.ID %>">Want to Read</a></li>
                    <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%:CurrentBook.ID%>&returnurl=~/book/<%:Utility.Slugify(CurrentBook.Title)%>-<%:CurrentBook.ID %>">Remove from Library</a></li>
                </ul>
            </div>
            <%}
                else if (MemberBook != null && MemberBook.ReadStatus == (byte)ReadStatusType.Reading)
                {%>
            <div class="p-1 bg-light border my-2">
                <div class="row my-1">
                    <div class="col">
                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#readingUpdateModal">Update Progress</button>
                    </div>
                    <div class="col">
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="modal" data-bs-target="#shareUpdateModal" >Share Update</button>
                    </div>
                </div>
                <div class="progress mt-2">
                    <div class="progress-bar" role="progressbar" style='<%: "width:" + percentread + "%;" %>' aria-valuenow="<%:percentread %>" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <div class="text-center"><%: MemberBook.CurrentPage %> read of <%: CurrentBook.PageCount %> pages</div>
                <div class="text-center my-2"><a class="btn btn-link" href="../handlers/book/removefromlibrary.ashx?bookid=<%: CurrentBook.ID%>&returnurl=~/book/<%:Utility.Slugify(CurrentBook.Title)%>-<%:CurrentBook.ID %>">Remove from Library</a></div>
                <div class="modal fade" id="readingUpdateModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Reading Update</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="../handlers/book/updateprogress.ashx" id="readingupdatefrm-<%: CurrentBook.ID %>" method="post">
                                    <input type="hidden" name="bookid" value="<%:CurrentBook.ID %>" />
                                    <input type="hidden" name="returnurl" value="~/book/<%: Utility.Slugify(CurrentBook.Title) + "-" + CurrentBook.ID %>" />
                                    <div class="input-group mb-3">
                                        <span class="input-group-text">I have read</span>
                                        <input value="<%: MemberBook.CurrentPage == null ? "0" : MemberBook.CurrentPage.ToString() %>" type="number" class="form-control" name="pagecount" min="0" aria-describedby="basic-addon2" max="10000" />
                                        <span class="input-group-text" id="basic-addon2">Pages</span>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick='$("#readingupdatefrm-<%: CurrentBook.ID %>").submit();'>Update</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal fade" id="shareUpdateModal" tabindex="-1" aria-labelledby="shareModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="shareModalLabel">Share Reading Progress</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body text-center">
                                <div id="bookcont" class="my-2 d-none">
                                    <input type="hidden" id="currentpagetxt" value="<%: MemberBook.CurrentPage %>" />
                                    <input type="hidden" id="startdatetxt" value="<%: MemberBook.ReadingStartDate.Value.ToString("yyyy-MM-dd") %>" />
                                    <input type="hidden" id="pagecounttxt" value="<%:CurrentBook.PageCount %>" />
                                    <canvas id="canvas" width="400" height="400"></canvas>
                                </div>
                                <img id="readingstatsimg" src="" alt="" class="img-fluid" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick="downloadImage()">Download</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%}
                else if (MemberBook != null && MemberBook.ReadStatus == (byte)ReadStatusType.WanttoRead)
                {%>
            <div class="dropdown my-2">
                <button class="btn btn-success btn-sm dropdown-toggle" type="button" id="wantoreadBtn" data-bs-toggle="dropdown" aria-expanded="false">Want to Read</button>
                <ul class="dropdown-menu" aria-labelledby="wantoreadBtn">
                    <li><a class="dropdown-item" href="../handlers/book/add.ashx?rs=1&bookid=<%: CurrentBook.ID %>">Already Read</a></li>
                    <li><a class="dropdown-item" href="../handlers/book/add.ashx?rs=2&bookid=<%: CurrentBook.ID %>">Reading Now</a></li>
                    <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%: CurrentBook.ID %>&returnurl=~/book/<%: Utility.Slugify(CurrentBook.Title)%>-<%: CurrentBook.ID %>">Remove from Library</a></li>
                </ul>
            </div>
            <%}
                else
                {%>
            <div class="dropdown my-2">
                <button class="btn btn-success dropdown-toggle" type="button" id="addtolibBtn" data-bs-toggle="dropdown" aria-expanded="false">Add to Library</button>
                <ul class="dropdown-menu" aria-labelledby="addtolibBtn">
                    <li><a class="dropdown-item" href="../handlers/book/add.ashx?rs=1&bookid=<%:CurrentBook.ID %>">Already Read</a></li>
                    <li><a class="dropdown-item" href="../handlers/book/add.ashx?rs=2&bookid=<%:CurrentBook.ID %>">Reading Now</a></li>
                    <li><a class="dropdown-item" href="../handlers/book/add.ashx?rs=3&bookid=<%: CurrentBook.ID %>">Want to Read</a></li>
                </ul>
            </div>
            <%}
                }
                else
                { %>
            <div class="text-center p-2">
                <a class="btn btn-primary" href="../account/login?returnurl=~/book/<%= Utility.Slugify(CurrentBook.Title) %>-<%= CurrentBook.ID %>">Add to Library</a>
            </div>
            <%} %>
        </div>
        <div class="col-md-7">
            <h1><%: CurrentBook.Title %></h1>
            <p>Author: <%: CurrentBook.Author %></p>
            <%if (!string.IsNullOrEmpty(CurrentBook.ISBN13) || !string.IsNullOrEmpty(CurrentBook.ISBN10))
                {  %>
            <p>ISBN 13: <%: CurrentBook.ISBN13 %>, ISBN 10: <%: CurrentBook.ISBN10 %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.Identifiers))
                {%>
            <p><%: CurrentBook.Identifiers %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.Publisher))
                {%>
            <p>Publisher: <%: CurrentBook.Publisher %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.PublishDate))
                {%>
            <p>Publish Date: <%: CurrentBook.PublishDate %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.Categories))
                {%>
            <p>Categories: <%: CurrentBook.Categories %></p>
            <%} %>
            <%if (CurrentBook.PageCount > 0)
                {%>
            <p><%: CurrentBook.PageCount %> Pages</p>
            <%} %>
        </div>
    </div>
    <p class="my-2"><%: CurrentBook.Description %></p>
    <h5 class="mt-3">Reviews</h5>
    <form runat="server">
        <asp:PlaceHolder ID="ReviewFormPlaceHolder" runat="server">
            <div class="mb-1">
                <asp:TextBox ID="ReviewTextBox" TextMode="MultiLine" MaxLength="3000" Rows="5" CssClass="form-control" placeholder="Write a review of the book..." runat="server"></asp:TextBox>
                <div class="text-end pt-2">
                    <asp:Button ID="SaveReviewButton" runat="server" Text="Post Review" CssClass="btn btn-secondary" CausesValidation="false" OnClick="SaveReviewButton_Click" />
                </div>
            </div>
        </asp:PlaceHolder>
        <asp:GridView ID="ReviewGridView" ShowHeader="false" BorderWidth="0" runat="server"
            AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" EmptyDataText="No Reviews posted on this book."
            PageSize="100" Width="100%" OnPageIndexChanging="ReviewGridView_PageIndexChanging">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="mb-2 p-2 border-bottom">
                            <div><strong><%# Eval("MemberName") %> <%# Eval("LastName") %></strong></div>
                            <p class="bg-light">
                                <asp:Literal ID="reviewlt" runat="server" Text='<%# Bind("Review") %>'></asp:Literal>
                            </p>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
    <%}
        else
        { %>
    <p class="py-3 text-center">We could not find any book.</p>
    <%} %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
    <script>
        const canvas = document.getElementById('canvas');
        const context = canvas.getContext('2d');
        var reader = new FileReader();
        var bkimage = document.getElementById("coverpageimg");
        var newHeight = 0, newWidth = 0;
        //var imgWidth = 0, imgHeight = 0;
        //var imageLoader = document.getElementById('bookpicfile');
        //imageLoader.addEventListener('change', handleImage, false);
        var currentlyreading = { image: '', totalpages: 1, currentpage: 1, readingstartdate: null, yeargoal: '' };

        //function handleImage(e) {
        //    reader = new FileReader();
        //    reader.onload = function (event) {
        //        bkimage = new Image();
        //        bkimage.src = event.target.result;
        //    }
        //    reader.readAsDataURL(e.target.files[0]);
        //}

        function generateWithT1() {
            $("#canvas").attr("width", "500").attr("height", "500");
            $("#canvas").width(500);
            $("#canvas").height(500);
            var textstart = canvas.width / 2;
            //var image = new Image();
            //image.onload = function () {
            //    var wrh = image.width / image.height;

            //    newWidth = canvas.width / 2; //image.width >  canvas.width ? canvas.width : image.width;
            //    newHeight = newWidth / wrh;
            //    if (newHeight > canvas.height) {
            //        newHeight = canvas.height;
            //        newWidth = newHeight * wrh;
            //    }
            //    var xOffset = 0; // newWidth < canvas.width ? ((canvas.width - newWidth) / 2) : 0;
            //    var yOffset = 0; //newHeight < canvas.height ? ((canvas.height - newHeight) / 2) : 0;

            //    context.drawImage(image, 0, 0, newWidth, newHeight);
            //}
            //image.src = reader.result;

            var wrh = bkimage.width / bkimage.height;
            newWidth = canvas.width / 2; //bkimage.width >  canvas.width ? canvas.width : bkimage.width;
            newHeight = newWidth / wrh;
            if (newHeight > canvas.height) {
                newHeight = canvas.height;
                newWidth = newHeight * wrh;
            }
            context.drawImage(bkimage, 0, 0, newWidth, newHeight);
            context.clearRect(canvas.width / 2, 0, canvas.width, canvas.height);
            context.fillStyle = '#ffffff';
            context.fillRect(canvas.width / 2, 0, canvas.width, newHeight);
            context.font = '18px Arial';
            context.fillStyle = '#212529';
            context.textAlign = 'left';
            //context.textBaseline = 'middle';
            context.fillText("Reading Now", textstart + 5, 20);

            var x = textstart + 5;
            var y = 50;
            context.font = '14px Arial';
            context.fillStyle = "#6c757d";
            context.fillText($("#currentpagetxt").val() + " of " + $("#pagecounttxt").val() + " Pages Read", x, y);

            var percentage = (parseInt($("#currentpagetxt").val(), 10) / parseInt($("#pagecounttxt").val(), 10)) * 100;
            var progress = (percentage * (canvas.width / 2) - 20) / 100;

            context.fillStyle = '#007bff';
            context.fillRect(textstart + 5, 60, progress, 15);
            context.fillStyle = '#e9ecef';
            context.fillRect(textstart + 5 + progress, 60, ((canvas.width / 2) - 20) - progress, 15);

            var readstartdate = new Date($("#startdatetxt").val());

            var today = new Date();
            //calculate time difference
            var time_difference = today.getTime() - readstartdate.getTime();

            //calculate days difference by dividing total milliseconds in a day
            var days_difference = time_difference / (1000 * 60 * 60 * 24);

            var avgspeed = parseInt(parseInt($("#currentpagetxt").val(), 10) / days_difference, 10);
            context.fillStyle = '#212529';
            context.font = 'bold 14px Arial';
            context.fillText("Speed", textstart + 5, 100);
            context.fillStyle = "#6c757d";
            context.font = '14px Arial';
            context.fillText(avgspeed + " pages read per day", textstart + 5, 120);

            var pagesleft = parseInt($("#pagecounttxt").val(), 10) - parseInt($("#currentpagetxt").val(), 10);
            var tentativecmp = new Date(Date.now());
            tentativecmp.setDate(tentativecmp.getDate() + (pagesleft / avgspeed))
            context.fillStyle = '#17a2b8';
            context.fillText(tentativecmp.toDateString(), textstart + 5, 150);
            context.fillText(" तक आप इसे पढ़ लेंगे।", textstart + 5, 170);

            context.fillStyle = "#6c757d";
            context.font = 'bold 14px Arial';
            context.fillText("<%: DateTime.Now.Year + " Goal"%>", textstart + 5, 200);
            context.font = '14px Arial';
            context.fillText($("#yeargoaltxt").val(), textstart + 5, 220);


        }

        function generateWithT2() {
            $("#canvas").attr("width", "360").attr("height", "640");
            $("#canvas").width(360);
            $("#canvas").height(640);

            var wrh = bkimage.width / bkimage.height;
            newWidth = bkimage.width > canvas.width ? canvas.width : bkimage.width;
            newHeight = newWidth / wrh;
            if (newHeight > canvas.height) {
                newHeight = canvas.height;
                newWidth = newHeight * wrh;
            }
            var xOffset = newWidth < canvas.width ? ((canvas.width - newWidth) / 2) : 0;
            var yOffset = newHeight < canvas.height ? ((canvas.height - newHeight) / 2) : 0;
            context.drawImage(bkimage, xOffset, yOffset, newWidth, newHeight);

            var txtHeight = canvas.height - 130;
            context.globalAlpha = 0.5;
            context.fillStyle = "#000000";
            context.fillRect(0, canvas.height - 130, canvas.width, 130);
            context.globalAlpha = 1.0;

            context.font = '25px Verdana';
            context.fillStyle = '#ffffff';
            context.textAlign = 'center';
            context.textBaseline = 'middle';
            context.fillText("Reading Now", canvas.width / 2, txtHeight + 25);

            var x = canvas.width / 2;
            var y = txtHeight + 65;
            context.font = '18px Arial';
            context.fillText($("#currentpagetxt").val() + " of " + $("#pagecounttxt").val() + " Pages Read", x, y);

            var percentage = (parseInt($("#currentpagetxt").val(), 10) / parseInt($("#pagecounttxt").val(), 10)) * 100;
            var progress = (percentage * (canvas.width) - 20) / 100;

            context.fillStyle = '#007bff';
            context.fillRect(10, txtHeight + 80, progress, 10);
            context.fillStyle = '#495057';
            context.fillRect(10 + progress, txtHeight + 80, (canvas.width - 20) - progress, 10);

            //var readstartdate = new Date($("#startdatetxt").val());

            //var today = new Date();
            //calculate time difference
            //var time_difference = today.getTime() - readstartdate.getTime();
            //calculate days difference by dividing total milliseconds in a day
            var days_difference = parseInt("<%: (MemberBook != null && MemberBook.ReadingStartDate.HasValue) ? DateTime.Now.Subtract(MemberBook.ReadingStartDate.Value).TotalDays : 0 %>", 10) //time_difference / (1000 * 60 * 60 * 24);

            var avgspeed = parseInt(parseInt($("#currentpagetxt").val(), 10) / days_difference, 10);
            context.fillStyle = '#ffffff';
            context.font = '18px Arial';
            context.fillText("I read " + avgspeed + " pages per day :)", canvas.width / 2, txtHeight + 110);
        }

        function createImage() {
            //if ($("#templaterd1").is(":checked")) {
            //    generateWithT1();
            //}
            //else if ($("#templaterd2").is(":checked")) {
                generateWithT2();
            //}

            currentlyreading.currentpage = parseInt($("#currentpagetxt").val(), 10);
            currentlyreading.readingstartdate = $("#startdatetxt").val();
            currentlyreading.totalpages = parseInt($("#pagecounttxt").val(), 10);
            currentlyreading.yeargoal = $("#yeargoaltxt").val();
            $("#readingstatsimg").attr("src", canvas.toDataURL("image/png"));
            //localStorage.setItem("currentlyreading", JSON.stringify(currentlyreading));
        }

        $(document).ready(function () { createImage(); });

        function downloadImage() {
            var anchor = document.createElement("a");
            anchor.href = document.getElementById('canvas').toDataURL("image/png");
            anchor.download = "readingstats-" + $("#currentpagetxt").val() + ".png";
            anchor.click();
        }
    </script>
</asp:Content>

