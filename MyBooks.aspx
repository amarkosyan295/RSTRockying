<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyBooks.aspx.cs" Inherits="MyBooks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.0/knockout-min.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:HiddenField ID="MemberIDHdn" runat="server" />
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="input-group mb-1">
                    <input type="text" class="form-control" id="searchbook" placeholder="Search Book by Title or ISBN" aria-label="Search Book by Title or ISBN" aria-describedby="search-addon" />
                    <button type="button" class="input-group-text" id="search-addon" onclick="loadBook()">
                        Search
                        <div class="spinner-grow spinner-grow-sm d-none ms-1" role="status" id="searchspinner">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    </button>
                </div>
            </div>
        </div>
        <div id="search-result" class="d-none">
            <div class="row">
                <div class="col-md-6">Search Results</div>
                <div class="col-md-6 text-end">
                    <button type="button" class="btn btn-link btn-sm" onclick="clearSearch();">Clear</button></div>
            </div>
            <div class="row row-cols-2 row-cols-md-4 g-4 cardgrid"></div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" ClientIDMode="Static" runat="server">
            <ContentTemplate>
                <h5>My Books</h5>
                <div class="row row-cols-1 row-cols-md-3 g-4">
                    <asp:Repeater ID="MyBooksRepeater" runat="server" OnItemDataBound="MyBooksRepeater_ItemDataBound">
                        <ItemTemplate>
                            <div class="col">
                                <div class="card h-100">
                                    <div class="row g-0">
                                        <div class="col-md-4">
                                            <img src="<%# Eval("Book.CoverPage") %>" class="card-img-top" alt="" />
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <%# Eval("Book.Title") %>
                                                </h5>
                                                <asp:Literal ID="ReadStatusLt" runat="server" Visible="false" Text='<%# Eval("ReadStatus") %>'></asp:Literal>
                                                <p class="card-text">By <%# Eval("Book.Author") %></p>
                                                <asp:Literal ID="ReadStatusBadgeLt" Mode="PassThrough" runat="server" ></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="d-none">
                    <asp:HiddenField ID="BookTitleHdn" ClientIDMode="Static" runat="server" />
                    <asp:HiddenField ID="ISBN13Hdn" runat="server" ClientIDMode="Static" />
                    <asp:HiddenField ID="ISBN10Hdn" runat="server" ClientIDMode="Static" />
                    <asp:HiddenField ID="AuthorHdn" runat="server" ClientIDMode="Static" />
                    <asp:HiddenField ID="CoverPageHdn" runat="server" ClientIDMode="Static" />
                    <asp:HiddenField ID="DescriptionHdn" runat="server" ClientIDMode="Static" />
                    <asp:HiddenField ID="ReadStatusHdn" runat="server" ClientIDMode="Static" />
                    <asp:Button ID="AddBookButton" ClientIDMode="Static" runat="server" Text="Add Book" CssClass="" OnClick="AddBookButton_Click" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
    <script>
        function loadBook() {
            $("#search-result > .cardgrid").html('');
            $("#searchspinner").removeClass("d-none");


            jQuery.getJSON("https://www.googleapis.com/books/v1/volumes?q=" + $("#searchbook").val() + "&key=AIzaSyAKozbZaW6JSBL3FeymL8Fv6mMUxvR_H5M",
                function (data) {
                    console.log(data);
                    $("#searchspinner").addClass("d-none");
                    if (data.items) {
                        for (var k in data.items) {
                            var vi = data.items[k].volumeInfo;
                            var author = vi.authors.join(", ");
                            if (author !== "") {
                                author = "By " + author;
                            }
                            var thumbnail = "";
                            if (vi.imageLinks) {
                                if (vi.imageLinks.thumbnail) {
                                    thumbnail = vi.imageLinks.thumbnail;
                                }
                            }
                            var cardbody = $('<div class="card h-100"><div class="row g-0"><div class="col-md-4">' +
                                '<img src="' + thumbnail + '" class="card-img-top" alt="" /></div><div class="col-md-8">' +
                                '<div class="card-body">' +
                                '<h6 class="card-title">' + vi.title + '</h6>' +
                                '<p class="card-text">' + author + '</p>' +
                                '<div class="dropdown">' +
                                '<a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink' + data.items[k].id + '" data-bs-toggle="dropdown" aria-expanded="false">Add to Library</a>' +
                                '<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink' + data.items[k].id + '">' +
                                '<li><a class="dropdown-item" href="javascript:SaveBook(\'#' + data.items[k].id + '\',1);">Already Read</a></li>' +
                                '<li><a class="dropdown-item" href="javascript:SaveBook(\'#' + data.items[k].id + '\',2);">Reading Now</a></li>' +
                                '<li><a class="dropdown-item" href="javascript:SaveBook(\'#' + data.items[k].id + '\',3);">Want to Read</a></li>' +
                                '</ul></div>' +
                                '</div></div></div>');

                            var card = $("<div class='col'></div>");
                            var vihdn = $('<input type="hidden" id="' + data.items[k].id + '" />')
                            vihdn.val(JSON.stringify(vi));
                            card.append(vihdn);
                            card.append(cardbody);
                            $("#search-result > .cardgrid").append(card);
                        }
                    }
                    $("#search-result").removeClass("d-none");
                    $("#UpdatePanel1").addClass("d-none");
                });
        }

        function clearSearch() {
            $("#search-result > .cardgrid").html("");
            $("#searchbook").val("");
            $("#search-result").addClass("d-none");
            $("#UpdatePanel1").removeClass("d-none");
        }

        function SaveBook(hdnid, readstatus) {
            var vi = JSON.parse($(hdnid).val());
            $("#BookTitleHdn").val(vi.title);
            for (var k in vi.industryIdentifiers) {
                var ii = vi.industryIdentifiers[k];
                if (ii.type == "ISBN_13") {
                    $("#ISBN13Hdn").val(ii.identifier);
                } else if (ii.type == "ISBN_10") {
                    $("#ISBN10Hdn").val(ii.identifier);
                }
            }
            var author = vi.authors.join(", ");
            var thumbnail = "";
            if (vi.imageLinks) {
                if (vi.imageLinks.thumbnail) {
                    thumbnail = vi.imageLinks.thumbnail;
                }
            }
            $("#AuthorHdn").val(author);
            $("#CoverPageHdn").val(thumbnail);
            $("#DescriptionHdn").val(vi.description);
            $("#ReadStatusHdn").val(readstatus);
            $("#AddBookButton").click();
        }
    </script>
</asp:Content>

