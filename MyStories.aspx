<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyStories.aspx.cs" Inherits="MyStories" %>

<%@ Import Namespace="Rockying.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
        <div class="row">
            <div class="col-6">
                <h3>My Stories</h3>
            </div>
            <div class="col-6 text-end">
                <asp:LinkButton ID="CreatePostBtn" runat="server" CausesValidation="false" CssClass="btn btn-primary" OnClick="CreatePostBtn_Click">Create Story</asp:LinkButton>
            </div>
        </div>
        <div class="row row-cols-1 row-cols-md-4 g-4 my-2">
            <asp:Repeater ID="StoryRepeater" runat="server" OnItemCommand="StoryRepeater_ItemCommand">
                <ItemTemplate>
                    <div class="col">
                        <div class="card h-100">
                            <img src="<%# Eval("OGImage") %>" class="card-img-top" alt="" />
                            <div class="card-body">
                                <h5 class="card-title"><a href="../a/<%# Eval("URL") %>" class="text-decoration-none text-dark">
                                    <%# Eval("Title") %>
                                </a></h5>
                                <p class="card-text"><%# Eval("OGDescription") %></p>
                                <asp:LinkButton ID="deletestorybtn" OnClientClick="return confirm('This action is permanent, once deleted you will not be able to recover this story?')" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="delete" Text='Delete' CssClass="card-link"></asp:LinkButton>
                                <a href="editstory.aspx?id=<%# Eval("ID") %>" class="card-link">Edit</a>
                                <a href="../a/<%# Eval("URL") %>" class="card-link">View</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <%if (Stories.Count == 0)
            {%>
        <p class="text-center my-5">
            You have not written any stories yet. Write some stories and they will appear here.
        </p>
        <%} %>
    </form>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>

