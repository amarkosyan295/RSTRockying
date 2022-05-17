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
    <div class="row row-cols-2 row-cols-md-6 g-4 mt-2">
        <%foreach (PopularBook bm in PopularList)
            { %>
        <%if (!string.IsNullOrEmpty(bm.CoverPage))
            {%>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(bm.Title)%>-<%= bm.ID %>' style="text-align: center;">
                    <img src="<%= bm.CoverPage %>" class="card-img-top" style="width: auto;" alt="<%: bm.Title %>" /></a>
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
                    <div class="dropdown d-none">
                        <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            Add to Library
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=1&bookid=" + bm.ID %>'>Already Read</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=2&bookid=" + bm.ID %>'>Reading Now</a></li>
                            <li><a class="dropdown-item" href='<%: "../handlers/book/add.ashx?rs=3&bookid=" + bm.ID %>'>Want to Read</a></li>
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

