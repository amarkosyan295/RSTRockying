<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BookSearch.ascx.cs" Inherits="control_BookSearch" %>
<%@ Import Namespace="Rockying.Models" %>
<div style="position: relative;">
    <div class="input-group mb-1">
        <asp:TextBox ID="SearchKeywordTextBox" CssClass="form-control" placeholder="Search Book by Title or ISBN" MaxLength="300" runat="server"></asp:TextBox>
        <asp:Button ID="SearchButton" CssClass="input-group-text" ValidationGroup="searchbookgrp" runat="server" Text="Search" OnClick="SearchButton_Click" />
    </div>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="searchbookgrp" CssClass="text-danger" Display="Dynamic" ControlToValidate="SearchKeywordTextBox" runat="server" ErrorMessage="Missing Keywords"></asp:RequiredFieldValidator>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" DynamicLayout="true" DisplayAfter="0" runat="server">
        <ProgressTemplate>
            <div class="spinner-border" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Repeater ID="SearchResultRepeater" runat="server" EnableViewState="false" OnItemDataBound="SearchResultRepeater_ItemDataBound">
                <HeaderTemplate>
                    <div style="position: absolute; top: 40px; z-index: 10; width: 100%" class="bg-light p-2 border">
                        <div class="row mt-2">
                            <div class="col-6">
                                <h5>Search Results</h5>
                            </div>
                            <div class="col-6 text-end">
                                <asp:Button ID="ClearSearchButton" runat="server" Text="Clear" CssClass="btn btn-link btn-sm" OnClick="ClearSearchButton_Click" />
                            </div>
                        </div>
                        <div class="p-1" style="max-height: 500px; overflow-y: auto;">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="card special m-1 border-bottom">
                        <div class="row g-0">
                            <div class="col-mb-2 col-3">
                                <a runat="server" href='<%# "~/book/" + Utility.Slugify(Eval("Title").ToString()) + "-" + Eval("ID") %>'>
                                    <img src="<%# Eval("CoverPage") %>" class="card-img-top" alt="" /></a>
                            </div>
                            <div class="col-mb-10 col-9">
                                <div class="card-body">
                                    <h5 class="card-title "><a runat="server" class="text-dark text-decoration-none" href='<%# "~/book/" + Utility.Slugify(Eval("Title").ToString()) + "-" + Eval("ID") %>'><%# Eval("Title") %></a></h5>
                                    <p class="card-text">
                                        <asp:Literal ID="AuthorLt" Mode="PassThrough" runat="server" Text='<%# Eval("Author") %>'></asp:Literal>
                                    </p>
                                    <a runat="server" href='<%# "~/book/" + Utility.Slugify(Eval("Title").ToString()) + "-" + Eval("ID") %>' class="d-none">Read More</a>
                                    <div class="dropdown  d-none">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Add to Library
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href='<%# "~/handlers/book/add.ashx?rs=1&bookid=" + Eval("ID") %>' runat="server">Already Read</a></li>
                                            <li><a class="dropdown-item" href='<%# "~/handlers/book/add.ashx?rs=2&bookid=" + Eval("ID") %>' runat="server">Reading Now</a></li>
                                            <li><a class="dropdown-item" href='<%# "~/handlers/book/add.ashx?rs=3&bookid=" + Eval("ID") %>' runat="server">Want to Read</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                        </div>
                </FooterTemplate>
            </asp:Repeater>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</div>

