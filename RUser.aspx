<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="RUser.aspx.cs" Inherits="RUser" %>
<%@ Import Namespace="Rockying" %>
<%@ Import Namespace="Rockying.Models" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <%if (Member != null)
        { %>
    <%using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
        {
            var stories = dc.Posts.Where(t => t.Status == (byte)PostStatusType.Publish && t.CreatedBy == Member.ID);
    %>
    <h4 class="mt-2"><%: Member.MemberName %>'s Stories</h4>
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <%foreach (var item in stories)
            { %>
        <div class="col">
            <div class="card border-0 h-100">
                <%if (!string.IsNullOrEmpty(item.OGImage))
                    { %>
                <a href="../a/<%= item.URL %>">
                    <img src="<%= item.OGImage %>" class="card-img-top" alt="">
                </a>
                <%} %>
                <div class="card-body">
                    <h5 class="card-title"><a href="../a/<%= item.URL %>" class="text-decoration-none text-dark">
                        <%: item.Title %>
                    </a></h5>
                    <p class="card-text"><a href="../<%:item.Category1.UrlName %>/index"><%:item.Category1.Name %></a> story written by <%:item.WriterName %></p>
                    <p class="card-text"><%:item.OGDescription %></p>
                </div>
            </div>
        </div>
        <%} %>
    </div>
    <%
        var library = dc.MemberBooks.Where(t => t.MemberID == t.Member.ID);
    %>
    <h4 class="mt-2"><%: Member.MemberName %>'s Library</h4>
    <div class="row row-cols-2 row-cols-md-6 g-2">
        <%foreach (MemberBook mb in library)
            { %>
        <div class="col">
            <div class="card h-100 special border-0 bg-transparent">
                <a href='../book/<%: Utility.Slugify(mb.Book.Title, "book")%>-<%: mb.Book.ID %>' style="text-align: center;">
                    <img src="<%: mb.Book.CoverPage %>" class="card-img-top bookphoto" style="width: auto; max-width: 128px;" alt="" /></a>
            </div>
        </div>
        <%} %>
    </div>
    <%} %>
    <%} %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>

