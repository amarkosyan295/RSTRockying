<%@ Page Title="Browse Rockying Categories" Language="C#" MasterPageFile="~/Site.master"
    AutoEventWireup="true" CodeFile="categories.aspx.cs" Inherits="categories" %>

<%@ Import Namespace="Rockying.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="server">
    <title>More Stories on <%: Utility.SiteName %></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <%foreach (Category c in CategoryList)
            { %>
        <div class="col">
            <div class="card">
                <a href="../<%:c.UrlName %>/index">
                    <img src="../art/category/icons/<%:c.Name.ToLower()%>.jpg" class="card-img-top" alt="<%:c.Name%>">
                    </a>
            </div>
        </div>
        <%} %>
    </div>
</asp:Content>
