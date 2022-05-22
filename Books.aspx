<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Books.aspx.cs" Inherits="Books" %>

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
        <%foreach (PopularBook bm in PopularList)
            { %>
        <%if (!string.IsNullOrEmpty(bm.CoverPage))
            {%>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(bm.Title)%>-<%= bm.ID %>' style="text-align: center;">
                    <img src="<%= bm.CoverPage %>" class="card-img-top" style="width: auto; max-width:130px;" alt="<%: bm.Title %>" /></a>
                <div class="card-body">
                    <h5 class="card-title d-none"><a href='../book/<%: Utility.Slugify(bm.Title)%>-<%= bm.ID %>' class="text-dark text-decoration-none"><%: bm.Title %></a></h5>
                    <%if (!string.IsNullOrEmpty(bm.Author))
                        {%>
                    <p class="card-text d-none">
                        written by <%: bm.Author %>
                    </p>
                    <%} %>
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

                    <div class="dropdown text-center">
                        <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <%if (!rst.HasValue)
                                { %>
                            Add to Library
                            <%}
                                else if (rst.Value == ReadStatusType.Read)
                                {%>
                            Already Read
                            <%}
                                else if (rst.Value == ReadStatusType.WanttoRead)
                                {%>
                            Want to Read
                            <%} %>
                        </button>
                        <ul class="dropdown-menu">
                            <%if (!rst.HasValue)
                                { %>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=1&bookid=" + bm.ID %>'>Already Read</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=2&bookid=" + bm.ID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=3&bookid=" + bm.ID %>'>Want to Read</a></li>
                            <%}
                                else if (rst.Value == ReadStatusType.Read)
                                {%>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=2&bookid=" + bm.ID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=3&bookid=" + bm.ID %>'>Want to Read</a></li>
                            <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%:bm.ID%>&returnurl=~/popular-books">Remove from Library</a></li>
                            <%}
                                else if (rst.Value == ReadStatusType.WanttoRead)
                                {%>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=1&bookid=" + bm.ID %>'>Already Read</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=2&bookid=" + bm.ID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href="../handlers/book/removefromlibrary.ashx?bookid=<%:bm.ID%>&returnurl=~/popular-books">Remove from Library</a></li>
                            <%} %>
                            
                        </ul>
                    </div>
                </div>

            </div>
        </div>
        <%} %>
        <%} %>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>

