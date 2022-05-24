<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyLibrary.aspx.cs" Inherits="MyLibrary" %>

<%@ Import Namespace="Rockying" %>
<%@ Import Namespace="Rockying.Models" %>

<%@ Register Src="control/BookSearch.ascx" TagName="BookSearch" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.0/knockout-min.js"></script>
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
    <div class="row row-cols-2 row-cols-md-5 g-4 mt-2">
        <%
            using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            { %>
        <%
            foreach (MemberBook mb in dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID && t.ReadStatus == (byte)ReadStatusType.Reading)
                .OrderByDescending(t => t.ID))
            {
                isempty = false;
        %>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>' style="text-align: center;">
                    <img src="<%: mb.Book.CoverPage %>" class="card-img-top" style="width: auto; max-width: 128px;" alt="" /></a>
                <div class="card-body">
                    <%
                        var percentread = (int)(0.5f + ((100f * mb.CurrentPage) / mb.Book.PageCount));
                    %>
                    <div class="progress mt-1" style="height: 5px;">
                        <div class="progress-bar" role="progressbar" style='width: <%: percentread %>%;' aria-valuenow="<%:percentread %>" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <div class="text-center"><%: mb.CurrentPage %> read of <%: mb.Book.PageCount %> pages</div>
                    <div class="text-center">
                        <a href='../book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>' class="btn btn-primary btn-sm">Update Progress</a>
                    </div>
                </div>
            </div>
        </div>
        <%} %>

        <%
            foreach (MemberBook mb in dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID && t.ReadStatus != (byte)ReadStatusType.Reading)
                .OrderByDescending(t => t.ID))
            {
                isempty = false;
        %>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>' style="text-align: center;">
                    <img src="<%: mb.Book.CoverPage %>" class="card-img-top" style="width: auto; max-width: 128px;" alt="" /></a>
                <div class="card-body">
                    <%
                        ReadStatusType rst = (ReadStatusType)Enum.Parse(typeof(ReadStatusType), mb.ReadStatus.ToString());
                    %>
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
        <%} %>
        <%
            }%>
    </div>
    <%if (isempty)
        { %>
    <p class="text-center m-2 my-5">
        You have not added any books to your library, search your favourite books and add them to your library.
    </p>
    <%} %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>


