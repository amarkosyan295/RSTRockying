<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="list.aspx.cs" Inherits="list" %>

<%@ Import Namespace="Rockying.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="server">
    <title>Read <%: CPM.Current.Name %> stories on <%: Utility.SiteName %></title>
    <meta name="keywords" content="<%: CPM.Current.Keywords %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1 class="sectionheading">
                <%: CPM.Current.Name %>
                Stories
            </h1>
            <br />
            <ul class="thumbnails">
                <%
                    int counter = 0;
                    foreach (Article a in CPM.ArticleList)
                    {
                        counter++;
                %>
                <li class="span4">

                    <div class="thumbnail">
                        <%if (!string.IsNullOrEmpty(a.OGImage))
                            { %>
                        <a href="//www.rockying.com/a/<%: a.URL %>">
                            <span class="articleimage" style="display: block; background-image: url(<%: a.OGImage %>)"></span></a>
                        <%} %>
                        <div class="caption">
                            <h3><a href="//www.rockying.com/a/<%: a.URL %>" style="">
                                <%: a.Title %>
                            </a></h3>
                        </div>
                    </div>
                </li>
                <% if (counter % 3 == 0)
                    { %>
            </ul>
            <ul class="thumbnails">
                <%} %>
                <%} %>
            </ul>
        </div>
    </div>
</asp:Content>
