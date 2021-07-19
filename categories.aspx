<%@ Page Title="Browse Rockying Categories" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="categories.aspx.cs" Inherits="categories" %>

<%@ Import Namespace="Rockying.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="server">
    <title>More Stories on <%: Utility.SiteName %></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <ul class="thumbnails">
        <%
            int counter = 0;
            foreach (Category c in CategoryList)
            {

                if (c.Status == (byte)GeneralStatusType.Active)
                {
                    counter++;
        %>
        <li class="span3">
            <a href="//rockying.com/<%:c.UrlName %>/index" class="thumbnail">
                <img src="//rockying.com/art/category/icons/<%:c.Name.ToLower()%>.jpg" alt="<%:c.Name%>" />
            </a>
        </li>
        <% if (counter % 4 == 0)
            { %>
    </ul>
    <ul class="thumbnails">
        <%} %>
        <%}%>
        <% } %>
    </ul>
</asp:Content>
