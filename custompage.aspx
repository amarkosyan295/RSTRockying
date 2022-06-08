<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="custompage.aspx.cs" Inherits="custompage" %>

<%@ MasterType VirtualPath="~/Site.master" %>
<%@ Import Namespace="Rockying" %>
<%@ Import Namespace="Rockying.Models" %>

<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="server">
    <%if (HPM == null)
        { %>
    <title><%: CP.Title %></title>
    <%= CP.PageMeta %>
    <%}
        else
        { %>
    <title><%: Utility.SiteName %> <%: Utility.SiteTitle %></title>
    <meta name="keywords" content="Bollywood movie reviews, Vacation Recommendation, Travel Stories, Fiction and Non Fiction Stories" />
    <meta name="description" content="Write Stories, Build an Audience" />
    <% } %>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%if (HPM == null)
        { %>
    <%= CP.Head %>
    <%}%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%if (HPM == null)
        { %>
    <%= CP.Body %>
    <%}
        else
        { %>
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <%
            if (CurrentUser != null)
            {
                using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
                {
                    foreach (MemberBook mb in dc.MemberBooks.Where(t => t.MemberID == CurrentUser.ID && t.ReadStatus == (byte)ReadStatusType.Reading)
                        .OrderByDescending(t => t.ID))
                    {
        %>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>' style="text-align: center;">
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
                        <a href='book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>#<%= Utility.UpdateReadingProgressHash %>' class="btn btn-primary btn-sm">Update Progress</a>
                    </div>
                </div>
            </div>
        </div>
        <%}
                }
            }%>
        <%foreach (Article item in HPM.HeroList)
            { %>
        <div class="col">
            <div class="card border-0 h-100">
                <%if (!string.IsNullOrEmpty(item.OGImage))
                    { %>
                <a href="/a/<%= item.URL %>">
                    <img src="<%= item.OGImage %>" class="card-img-top" alt="">
                </a>
                <%} %>
                <div class="card-body">
                    <h5 class="card-title"><a href="/a/<%= item.URL %>" class="text-decoration-none text-dark">
                        <%: item.Title %>
                    </a></h5>
                    <p class="card-text"><a href="<%= item.CategoryUrlName %>/index"><%:item.CategoryName %></a> story written by <a href="member/<%: item.CreatedByUserName %>"><%:item.WriterName %></a></p>
                    <p class="card-text"><%:item.OGDescription %></p>
                </div>
            </div>
        </div>
        <%} %>
    </div>
    <div class="jumbotron well">
        <h1>Rockying</h1>
        <p class="lead">Write on any topic of your choice, build an audience.</p>
        <a class="btn btn-large btn-success" href="<%= Page.ResolveUrl("~/account/register") %>">Write for us</a>
    </div>
    <% } %>
</asp:Content>
