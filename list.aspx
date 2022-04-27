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
    <div class="row">
        <div class="col-12">
            <h3>
                <%: CPM.Current.Name %> Stories
            </h3>
            <div class="row row-cols-1 row-cols-md-4 g-4 ">
                <%
                    foreach (Article a in CPM.ArticleList)
                    {
                %>
                <div class="col">
                    <div class="card h-100">
                        <%if (!string.IsNullOrEmpty(a.OGImage))
                            { %>
                        <a href="../a/<%: a.URL %>">
                            <img src="<%: a.OGImage %>" class="card-img-top" alt="" />
                        </a>
                        <%} %>
                        <div class="card-body">
                            <h5 class="card-title"><a href="../a/<%: a.URL %>" class="text-decoration-none text-dark">
                                <%: a.Title %>
                            </a></h5>
                        </div>
                    </div>
                </div>

                <%} %>
            </div>
        </div>
    </div>
</asp:Content>
