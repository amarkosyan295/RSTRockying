<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Books.aspx.cs" Inherits="Books" %>

<%@ Import Namespace="Rockying" %>
<%@ Import Namespace="Rockying.Models" %>
<%@ Register Src="~/control/BookSearch.ascx" TagPrefix="uc1" TagName="BookSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <h1 class="fs-4">Popular Books</h1>
        </div>
        <div class="col-md-6 align-content-end">
            <form runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <uc1:BookSearch runat="server" ID="BookSearch" />
            </form>
        </div>
    </div>
    <div class="row row-cols-2 row-cols-md-5 g-4 mt-2 mt-2">
        <%
            if (CurrentUser != null)
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                { %>
        <%
            foreach (MemberBook mb in dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID && t.ReadStatus == (byte)ReadStatusType.Reading)
                .OrderByDescending(t => t.ID))
            {%>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(mb.Book.Title)%>-<%: mb.Book.ID %>' style="text-align: center;">
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
                        <a href='../book/<%: Utility.Slugify(mb.Book.Title)%>-<%: mb.Book.ID %>' class="btn btn-primary btn-sm">Update Progress</a>
                    </div>
                </div>
            </div>
        </div>
        <%}
                }
            }%>
        <%foreach (PopularBook bm in PopularList.Values)
            { %>
        <%if (!string.IsNullOrEmpty(bm.CoverPage) && (!MemberBooks.ContainsKey(bm.ID) || (MemberBooks.ContainsKey(bm.ID) && MemberBooks[bm.ID].ReadStatus != (byte)ReadStatusType.Reading)))
            {%>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(bm.Title)%>-<%= bm.ID %>' style="text-align: center;">
                    <img src="<%= bm.CoverPage %>" class="card-img-top" style="width: auto; max-width: 130px;" alt="<%: bm.Title %>" /></a>
                <div class="card-body">
                    <%if (bm.ShelfCount > 1)
                        { %>
                    <span class="d-block badge bg-light text-dark text-center mb-1">on <%: bm.ShelfCount %> book shelves</span>
                    <%}
                        else if (bm.ShelfCount == 1)
                        { %>
                    <span class="d-block badge bg-light text-dark text-center mb-1">on one book shelf</span>
                    <%} %>
                    <%
                        ReadStatusType? rst = null;
                        if (MemberBooks.ContainsKey(bm.ID))
                        {
                            rst = (ReadStatusType)Enum.Parse(typeof(ReadStatusType), MemberBooks[bm.ID].ReadStatus.ToString());
                        }
                    %>
                    <%if (!rst.HasValue)
                        { %>
                    <div class="dropdown text-center">
                        <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Add to Library</button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=1&bookid=" + bm.ID %>'>Already Read</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=2&bookid=" + bm.ID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=3&bookid=" + bm.ID %>'>Want to Read</a></li>
                        </ul>
                    </div>
                    <%}
                        else if (rst.Value == ReadStatusType.Read)
                        {%>
                    <div class="dropdown text-center">
                        <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Already Read</button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=2&bookid=" + bm.ID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=3&bookid=" + bm.ID %>'>Want to Read</a></li>
                            <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%:bm.ID%>&returnurl=~/popular-books">Remove from Library</a></li>
                        </ul>
                    </div>
                    <%}
                        else if (rst.Value == ReadStatusType.WanttoRead)
                        {%>
                    <div class="dropdown text-center">
                        <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">Already Read</button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=1&bookid=" + bm.ID %>'>Already Read</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=2&bookid=" + bm.ID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%:bm.ID%>&returnurl=~/popular-books">Remove from Library</a></li>
                        </ul>
                    </div>
                    <%} %>
                </div>
            </div>
        </div>
        <%} %>
        <%} %>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>

