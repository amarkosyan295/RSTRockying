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
    <%}
        else
        {%>
    <style>
        .jumbotron {
            margin: 30px 0;
            text-align: center;
            border: none;
        }

            .jumbotron h1 {
                font-size: 100px;
                line-height: 1;
            }

            .jumbotron .lead {
                font-size: 24px;
                line-height: 1.25;
            }

            .jumbotron .btn {
                font-size: 21px;
                padding: 14px 24px;
            }
    </style>
    <%} %>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <%if (HPM == null)
        { %>
    <%= CP.Body %>
    <%}
        else
        { %>
    <div class="row-fluid">
        <ul class="thumbnails">
            <%for (int i = 0; i < 3 && i < HPM.HeroList.Count; i++)
                { %>
            <li class="span4">
                <div class="thumbnail">
                    <%if (!string.IsNullOrEmpty(HPM.HeroList[i].OGImage))
                        { %>
                    <a href="//www.rockying.com/a/<%= HPM.HeroList[i].URL %>">
                        <span class="articleimage" style="display: block; background-image: url(<%= HPM.HeroList[i].OGImage %>)"></span></a>
                    <%} %>
                    <div class="caption">
                        <h3><a href="//www.rockying.com/a/<%= HPM.HeroList[i].URL %>" style="">
                            <%: HPM.HeroList[i].Title %>
                        </a></h3>
                        <p><%:HPM.HeroList[i].OGDescription %> </p>
                    </div>
                </div>
            </li>
            <%} %>
        </ul>
        <div class="jumbotron well">
            <h1>Rockying</h1>
            <p class="lead">Write on any topic of your choice, build an audience.</p>
            <a class="btn btn-large btn-success" href="//www.rockying.com/account/register">Write for us</a>
        </div>
        <ul class="thumbnails">
            <%for (int i = 3; i < HPM.HeroList.Count; i++)
                { %>
            <li class="span4">
                <div class="thumbnail">
                    <%if (!string.IsNullOrEmpty(HPM.HeroList[i].OGImage))
                        { %>
                    <a href="//www.rockying.com/a/<%= HPM.HeroList[i].URL %>">
                        <span class="articleimage" style="display: block; background-image: url(<%: HPM.HeroList[i].OGImage %>)"></span></a>
                    <%} %>
                    <div class="caption">
                        <h3><a href="//www.rockying.com/a/<%= HPM.HeroList[i].URL %>">
                            <%= HPM.HeroList[i].Title %>
                        </a></h3>
                        <p><%:HPM.HeroList[i].OGDescription %> </p>
                    </div>
                </div>
            </li>
            <% if (i == 5 || i == 8 || i == 12)
                { %>
        </ul>
        <ul class="thumbnails">
            <%} %>
            <%} %>
        </ul>
    </div>
    <% } %>
</asp:Content>
