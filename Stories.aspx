<%@ Page Title="Popular Stories" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Stories.aspx.cs" Inherits="Stories" %>

<%@ Import Namespace="Rockying" %>
<%@ Import Namespace="Rockying.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row row-cols-2 row-cols-md-5 g-4 mt-2 mt-2">
        <%using (RockyingDataClassesDataContext dc = new RockyingDataClassesDataContext(Utility.ConnectionString))
            {
                var list = dc.Posts.Where(t => t.Status == (byte)PostStatusType.Publish).OrderByDescending(t => t.DateCreated).Take(10);
                foreach (var p in list)
                {
        %>
        <div class="col">
            <div class="card border-0 h-100">
                <%if (!string.IsNullOrEmpty(p.OGImage))
                    { %>
                <a href="../a/<%= p.URL %>">
                    <img src="<%= p.OGImage %>" class="card-img-top" alt="">
                </a>
                <%} %>
                <div class="card-body">
                    <h5 class="card-title"><a href="../a/<%= p.URL %>" class="text-decoration-none text-dark">
                        <%: p.Title %>
                    </a></h5>
                    <p class="card-text"><%:p.Category1.Name %> story written by <%:p.WriterName %></p>
                    <p class="card-text"><%:p.OGDescription %></p>
                </div>
            </div>
        </div>
        <%
                }
            } %>
        <div class="col">
            <div class="card border-0 h-100">
                <div class="card-body">
                    <h5 class="card-title"><a href="../more-categories" class="text-decoration-none text-dark">More Stories
                    </a></h5>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
    
</asp:Content>

