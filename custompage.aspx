<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="custompage.aspx.cs" Inherits="custompage" %>

<%@ MasterType VirtualPath="~/Site.master" %>
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
                    <p class="card-text"><%:item.CategoryName %> story written by <%:item.WriterName %></p>
                    <p class="card-text"><%:item.OGDescription %></p>
                </div>
            </div>
        </div>
        <%} %>
    </div>
    <div class="jumbotron well">
        <h1>Rockying</h1>
        <p class="lead">Write on any topic of your choice, build an audience.</p>
        <a class="btn btn-large btn-success" href="//www.rockying.com/account/register">Write for us</a>
    </div>
    <% } %>
</asp:Content>
