<%@ Page Title="Books" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="Books.aspx.cs" Inherits="Admin_Books" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Books</h1>
    <div class="my-2">
        <div class="row">
            <div class="col-md-6 col-9"><asp:TextBox ID="KeywordTextBox" CssClass="form-control" MaxLength="1000" placeholder="ISBN or Author or Title or Publisher" runat="server"></asp:TextBox></div>
            <div class="col-md-6 col-3" >
                <asp:Button ID="SearchButton" CausesValidation="false" CssClass="btn btn-primary" runat="server" Text="Filter" OnClick="SearchButton_Click" />
            </div>
        </div>
    </div>
    <asp:GridView ID="BooksGridView"  runat="server" AllowSorting="True" AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" PageSize="50" OnPageIndexChanging="BooksGridView_PageIndexChanging" OnRowCommand="BooksGridView_RowCommand">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <img src='<%# Eval("CoverPage") %>' CssClass="img-fluid" style="width:60px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" InsertVisible="False" ReadOnly="True" Visible="False" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Author" HeaderText="Author" SortExpression="Author" />
            <asp:BoundField DataField="ISBN13" HeaderText="ISBN13" SortExpression="ISBN13" />
            <asp:BoundField DataField="ISBN10" HeaderText="ISBN10" SortExpression="ISBN10" />
            <asp:BoundField DataField="PageCount" HeaderText="PageCount" SortExpression="PageCount" />
            <asp:BoundField DataField="Publisher" HeaderText="Publisher" SortExpression="Publisher" />
            <asp:BoundField DataField="PublishDate" HeaderText="PublishDate" SortExpression="PublishDate" />
            <asp:BoundField DataField="Identifiers" HeaderText="Identifiers" SortExpression="Identifiers" />
            <asp:BoundField DataField="Categories" HeaderText="Categories" SortExpression="Categories" />
            <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="~/admin/managebook.aspx?id={0}" Text="Edit" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" CommandArgument='<%# Eval("ID") %>' runat="server" CausesValidation="False" CommandName="Remove" OnClientClick="return confirm('Are you sure you want to delete this book, it will be removed from all libraries as well?');" Text="Delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <PagerSettings Position="TopAndBottom" />
</asp:GridView>
</asp:Content>

