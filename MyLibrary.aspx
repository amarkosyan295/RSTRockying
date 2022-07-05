<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyLibrary.aspx.cs" Inherits="MyLibrary" %>

<%@ Import Namespace="Rockying" %>
<%@ Import Namespace="Rockying.Models" %>

<%@ Register Src="control/BookSearch.ascx" TagName="BookSearch" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <%
        bool isempty = true;
    %>
    <div class="row">
        <div class="col-md-6">
            <h3>My Library</h3>
        </div>
        <div class="col-md-6">
            <form runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" ClientIDMode="Static" runat="server">
                    <ContentTemplate>
                        <uc1:BookSearch ID="BookSearch2" runat="server" />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </form>
        </div>
    </div>
    
    <div class="row row-cols-2 row-cols-md-5 g-4 my-2">
        <%
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                foreach (MemberBook mb in dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID && t.ReadStatus == (byte)ReadStatusType.Reading)
                    .OrderByDescending(t => t.ID))
                {
                    isempty = false;
        %>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>' style="text-align: center;">
                    <img src="<%: mb.Book.CoverPage %>" class="card-img-top bookphoto reading" style="width: auto; max-width: 128px;" alt="" /></a>
                <div class="card-body">
                    <%
                        var percentread = (int)(0.5f + ((100f * mb.CurrentPage) / mb.Book.PageCount));
                    %>
                    <div class="progress mt-1" style="height: 5px;">
                        <div class="progress-bar" role="progressbar" style='width: <%: percentread %>%;' aria-valuenow="<%:percentread %>" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="text-center"><%: mb.CurrentPage %> read of <%: mb.Book.PageCount %> pages</div>
                    <div class="text-center">
                        <a href='../book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>#<%= Utility.UpdateReadingProgressHash %>' class="btn btn-primary btn-sm">Update Progress</a>
                    </div>
                </div>
            </div>
        </div>
        <%}
            foreach (MemberBook mb in dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID && t.ReadStatus != (byte)ReadStatusType.Reading)
                .OrderByDescending(t => t.ID))
            {
                isempty = false;
                ReadStatusType rst = (ReadStatusType)Enum.Parse(typeof(ReadStatusType), mb.ReadStatus.ToString());
        %>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>' style="text-align: center;">
                    <img src="<%: mb.Book.CoverPage %>" class="card-img-top bookphoto <%= (rst == ReadStatusType.Read) ? "read" : "" %>" style="width: auto; max-width: 128px;" alt="" /></a>
                <div class="card-body">
                    <%if (rst != ReadStatusType.Reading)
                        { %>
                    <div class="dropdown text-center">
                        <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <% if (rst == ReadStatusType.Read)
                                {%>
                            Already Read
                            <%}
                                else if (rst == ReadStatusType.WanttoRead)
                                {%>
                            Want to Read
                            <%}%>
                        </button>
                        <ul class="dropdown-menu">
                            <% if (rst == ReadStatusType.Read)
                                {%>
                            <li><a class="dropdown-item" href='../handlers/book/add.ashx?rs=2&bookid=<%: mb.BookID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href='../handlers/book/add.ashx?rs=3&bookid=<%: mb.BookID %>'>Want to Read</a></li>
                            <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%:mb.ID%>&returnurl=~/mylibrary.aspx">Remove from Library</a></li>
                            <%}
                                else if (rst == ReadStatusType.WanttoRead)
                                {%>
                            <li><a class="dropdown-item" href='../handlers/book/add.ashx?rs=1&bookid=<%: mb.BookID %>'>Already Read</a></li>
                            <li><a class="dropdown-item" href='../handlers/book/add.ashx?rs=2&bookid=<%: mb.BookID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%:mb.BookID%>&returnurl=~/mylibrary.aspx">Remove from Library</a></li>
                            <%} %>
                        </ul>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
        <%}
            }%>
    </div>
    <%if (isempty)
        { %>
    <p class="text-center m-2 my-5">
        You have not added any books to your library, search your favourite books and add them to your library.
    </p>
    <%}
        else
        { %> 
    <div class=" text-center py-2 border fixed-bottom bg-light">
        <button type="button" class="btn btn-secondary me-2" data-bs-toggle="modal" data-bs-target="#shareLibraryModal">Library Picture</button>
        <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#shareBooksReadModal">Books Read Picture</button>
    </div>
    <div class="modal fade" id="shareLibraryModal" tabindex="-1" aria-labelledby="shareModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <div class="d-none">
                        <canvas id="librarycanvas" width="428" height="926" style="border: 1px solid #000;"></canvas>
                    </div>
                    <img id="libraryimg" src="" alt="" class="img-fluid" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="downloadImage()">Download</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="shareBooksReadModal" tabindex="-1" aria-labelledby="shareBooksReadModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <div class="d-none">
                        <canvas id="booksreadcanvas" width="428" height="926"></canvas>
                    </div>
                    <img id="booksreadimg" src="" alt="" class="img-fluid" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="downloadBooksReadImage()">Download</button>
                </div>
            </div>
        </div>
    </div>
    <%} %>
    <%if (!isempty)
        { %>
    <script>
        const canvas = document.getElementById('librarycanvas');
        const canvas2 = document.getElementById('booksreadcanvas');
        const context = canvas.getContext('2d');
        const context2 = canvas2.getContext('2d');

        function generateLibraryPhoto() {
            var xOffset = 0, yOffset = 0;
            var fwidth = 107;
            var arr = [];
            var arr2 = [];

            for (var i = 0; i < $(".bookphoto").length; i++)
                arr.push(i);
            for (var i = 0; i < 24; i++) {
                var randomindex = Math.floor(Math.random() * (arr.length - 1));
                arr2.push(arr[randomindex]);
                arr.splice(randomindex, 1);
                if (i >= ($(".bookphoto").length - 1))
                    break;
            }

            for (var index = 0; index < arr2.length; index++) {
                var bkimage = $(".bookphoto")[arr2[index]];
                var wrh = bkimage.width / bkimage.height;
                newWidth = bkimage.width > fwidth ? fwidth : bkimage.width;
                newHeight = newWidth / wrh;
                if (newHeight > canvas.height) {
                    newHeight = canvas.height;
                    newWidth = newHeight * wrh;
                }
                context.drawImage(bkimage, xOffset, yOffset, newWidth, newHeight);
                if ((index + 1) % 4 == 0) {
                    yOffset += newHeight;
                    xOffset = 0;
                } else {
                    xOffset += fwidth;
                }

                context.globalAlpha = 0.5;
                context.fillStyle = "#000000";
                context.fillRect(0, 450, canvas.width, 40);
                context.fillStyle = "#0d6efd";
                context.fillRect(0, 490, canvas.width, 40);
                context.fillStyle = "#198754";
                context.fillRect(0, 530, canvas.width, 40);

                context.globalAlpha = 1;
                context.font = '25px Verdana';
                context.fillStyle = '#ffffff';
                context.textAlign = 'center';
                context.textBaseline = 'middle';
                context.fillText($(".bookphoto").length + " Books In My Library", canvas.width / 2, 470);

                context.font = '20px Verdana';
                context.fillText("Reading " + $(".bookphoto.reading").length + " At Present", canvas.width / 2, 510);

                context.fillText("Read " + $(".bookphoto.read").length + " Till Now", canvas.width / 2, 550);

                context.globalAlpha = 0.5;
                context.fillStyle = "#000000";
                context.fillRect(0, 0, canvas.width, 25);
                context.globalAlpha = 1.0;

                context.font = '13px Verdana';
                context.fillStyle = '#ffffff';
                context.textAlign = 'center';
                context.textBaseline = 'middle';
                context.fillText("Generated by https://www.rockying.com", canvas.width / 2, 12);
            }

            $("#libraryimg").attr("src", canvas.toDataURL("image/png"));
        }

        function generateBooksReadPhoto() {
            var xOffset = 0, yOffset = 0;
            var fwidth = 107;
            var arr = [];
            var arr2 = [];

            for (var i = 0; i < $(".bookphoto.read").length; i++)
                arr.push(i);
            for (var i = 0; i < 24; i++) {
                var randomindex = Math.floor(Math.random() * (arr.length - 1));
                arr2.push(arr[randomindex]);
                arr.splice(randomindex, 1);
                if (i >= ($(".bookphoto.read").length - 1))
                    break;
            }

            for (var index = 0; index < arr2.length; index++) {
                var bkimage = $(".bookphoto.read")[arr2[index]];
                var wrh = bkimage.width / bkimage.height;
                newWidth = bkimage.width > fwidth ? fwidth : bkimage.width;
                newHeight = newWidth / wrh;
                if (newHeight > canvas.height) {
                    newHeight = canvas.height;
                    newWidth = newHeight * wrh;
                }
                context2.drawImage(bkimage, xOffset, yOffset, newWidth, newHeight);
                if ((index + 1) % 4 == 0) {
                    yOffset += newHeight;
                    xOffset = 0;
                } else {
                    xOffset += fwidth;
                }

                context2.globalAlpha = 0.5;
                context2.fillStyle = "#000000";
                context2.fillRect(0, 450, canvas.width, 40);

                context2.globalAlpha = 1;
                context2.font = '25px Verdana';
                context2.fillStyle = '#ffffff';
                context2.textAlign = 'center';
                context2.textBaseline = 'middle';
                context2.fillText("Read " + $(".bookphoto.read").length + " Books Till Now", canvas.width / 2, 470);

                context2.globalAlpha = 0.5;
                context2.fillStyle = "#000000";
                context2.fillRect(0, 0, canvas2.width, 25);
                context2.globalAlpha = 1.0;

                context2.font = '13px Verdana';
                context2.fillStyle = '#ffffff';
                context2.textAlign = 'center';
                context2.textBaseline = 'middle';
                context2.fillText("Generated by https://www.rockying.com", canvas2.width / 2, 12);
            }

            $("#booksreadimg").attr("src", canvas2.toDataURL("image/png"));
        }
        $(window).load(function () { generateLibraryPhoto(); generateBooksReadPhoto(); });

        function downloadImage() {
            var anchor = document.createElement("a");
            anchor.href = document.getElementById('librarycanvas').toDataURL("image/png");
            anchor.download = "mylibrary.png";
            anchor.click();
        }

        function downloadBooksReadImage() {
            var anchor = document.createElement("a");
            anchor.href = document.getElementById('booksreadcanvas').toDataURL("image/png");
            anchor.download = "booksread.png";
            anchor.click();
        }
    </script>
    <%} %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
    
</asp:Content>


