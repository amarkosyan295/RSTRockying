<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MyLibrary.aspx.cs" Inherits="MyLibrary" %>
<%@ Import Namespace="Rockying.Models" %>

<%@ Register src="control/BookSearch.ascx" tagname="BookSearch" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.0/knockout-min.js"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <form runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:HiddenField ID="MemberIDHdn" runat="server" />
        <uc1:BookSearch ID="BookSearch2" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" ClientIDMode="Static" runat="server">
            <ContentTemplate>
                <h3>My Library</h3>
                <div class="row row-cols-1 row-cols-md-3 g-4 mt-1">                  
                    <asp:Repeater ID="MyBooksRepeater"  runat="server" OnItemDataBound="MyBooksRepeater_ItemDataBound" OnItemCommand="MyBooksRepeater_ItemCommand">
                        <ItemTemplate>
                            <div class="col">
                                <div class="card special h-100" onclick="location.href='book/<%# Utility.Slugify(Eval("Book.Title").ToString()) %>-<%# Eval("Book.ID") %>'">
                                    <div class="row g-0">
                                        <div class="col-md-4">
                                            <img src="<%# Eval("Book.CoverPage") %>" class="card-img-top" alt="" />
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-body">
                                                <h5 class="card-title"><%# Eval("Book.Title") %></h5>
                                                <p class="card-text">
                                                    <asp:Literal ID="AuthorLt" Mode="PassThrough" runat="server" Text='<%# Eval("Book.Author") %>'></asp:Literal>
                                                    <asp:Literal ID="ReadStatusLt" runat="server" Visible="false" Text='<%# Eval("ReadStatus") %>'></asp:Literal>
                                                </p>
                                                <asp:Literal ID="ReadStatusBadgeLt" Mode="PassThrough" runat="server" ></asp:Literal>
                                                <asp:LinkButton ID="RemoveBtn" CssClass="btn btn-secondary btn-sm" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to remove this book from your library?')" runat="server" CommandArgument='<%# Eval("ID") %>' CommandName="remove">Remove</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
    
</asp:Content>


