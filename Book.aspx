<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Book.aspx.cs" Inherits="RockyingBook" %>

<%@ Import Namespace="Rockying.Models" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">

    <%if (CurrentBook != null)
        {
    %>
    <div class="row">
        <div class="col-md-2 text-center">
            <img src="<%: CurrentBook.CoverPage %>" class="img-fluid" />
        </div>
        <div class="col-md-7">
            <h1><%: CurrentBook.Title %></h1>
            <p>Author: <%: CurrentBook.Author %></p>
            <%if (!string.IsNullOrEmpty(CurrentBook.ISBN13) || !string.IsNullOrEmpty(CurrentBook.ISBN10))
                {  %>
            <p>ISBN 13: <%: CurrentBook.ISBN13 %>, ISBN 10: <%: CurrentBook.ISBN10 %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.Identifiers))
                {%>
            <p><%: CurrentBook.Identifiers %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.Publisher))
                {%>
            <p>Publisher: <%: CurrentBook.Publisher %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.PublishDate))
                {%>
            <p>Publish Date: <%: CurrentBook.PublishDate %></p>
            <%} %>
            <%if (!string.IsNullOrEmpty(CurrentBook.Categories))
                {%>
            <p>Categories: <%: CurrentBook.Categories %></p>
            <%} %>
            <%if (CurrentBook.PageCount > 0)
                {%>
            <p><%: CurrentBook.PageCount %> Pages</p>
            <%} %>

            <%if (CurrentUser != null)
                {%>
            <div class="dropdown">
                <%if (MemberBook != null && MemberBook.ReadStatus == (byte)ReadStatusType.Read)
                    { %>
                <button class="btn btn-success dropdown-toggle" type="button" id="readStatusBtn" data-bs-toggle="dropdown" aria-expanded="false">Already Read</button>
                <%}
                    else if (MemberBook != null && MemberBook.ReadStatus == (byte)ReadStatusType.Reading)
                    {%>
                <button class="btn btn-primary dropdown-toggle" type="button" id="readStatusBtn" data-bs-toggle="dropdown" aria-expanded="false">Reading Now</button>
                <%}
                    else if (MemberBook != null && MemberBook.ReadStatus == (byte)ReadStatusType.WanttoRead)
                    {%>
                <button class="btn btn-secondary dropdown-toggle" type="button" id="readStatusBtn" data-bs-toggle="dropdown" aria-expanded="false">Want to Read</button>
                <%}
                    else
                    {%>
                <button class="btn btn-success dropdown-toggle" type="button" id="readStatusBtn" data-bs-toggle="dropdown" aria-expanded="false">Add to Library</button>
                <%} %>
                <ul class="dropdown-menu" aria-labelledby="readStatusBtn">
                    <li><a class="dropdown-item" href='<%# "~/handlers/book/add.ashx?rs=1&bookid=" + CurrentBook.ID %>' runat="server">Already Read</a></li>
                                                <li><a class="dropdown-item" href='<%# "~/handlers/book/add.ashx?rs=2&bookid=" + CurrentBook.ID %>' runat="server">Reading Now</a></li>
                                                <li><a class="dropdown-item" href='<%# "~/handlers/book/add.ashx?rs=3&bookid=" + CurrentBook.ID %>' runat="server">Want to Read</a></li>
                </ul>
            </div>
            <asp:PlaceHolder ID="ReadingUpdatePlaceHolder" runat="server">
                
            </asp:PlaceHolder>
            <%}
                else
                { %>
            <a class="btn btn-primary" href="../account/login?returnurl=~/book/<%= Utility.Slugify(CurrentBook.Title) %>-<%= CurrentBook.ID %>">Add to Library</a>
            <%} %>
        </div>
    </div>
    <p><%: CurrentBook.Description %></p>
    <h5 class="mt-3">Reviews</h5>
    <form runat="server">
        <asp:PlaceHolder ID="ReviewFormPlaceHolder" runat="server">
            <div class="mb-1">
                <asp:TextBox ID="ReviewTextBox" TextMode="MultiLine" MaxLength="3000" Rows="5" CssClass="form-control" placeholder="Write a review of the book..." runat="server"></asp:TextBox>
                <div class="text-end pt-2">
                    <asp:Button ID="SaveReviewButton" runat="server" Text="Post Review" CssClass="btn btn-secondary" CausesValidation="false" OnClick="SaveReviewButton_Click" />
                </div>
            </div>
        </asp:PlaceHolder>
        <asp:GridView ID="ReviewGridView" ShowHeader="false" BorderWidth="0" runat="server"
            AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="ID" EmptyDataText="No Reviews posted on this book."
            PageSize="100" Width="100%" OnPageIndexChanging="ReviewGridView_PageIndexChanging">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class="mb-2 p-2 border-bottom">
                            <div><strong><%# Eval("MemberName") %> <%# Eval("LastName") %></strong></div>
                            <p class="bg-light">
                                <asp:Literal ID="reviewlt" runat="server" Text='<%# Bind("Review") %>'></asp:Literal>
                            </p>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
    <%}
        else
        { %>
    <p class="py-3 text-center">We could not find any book.</p>
    <%} %>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>

