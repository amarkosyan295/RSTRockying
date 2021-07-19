<%@ Page Title="Delete Article" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="DeleteArticle.aspx.cs" Inherits="Admin_DeleteArticle" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>
                <asp:Literal ID="HeadingLit" runat="server">Delete Article</asp:Literal></h1>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <h2><%: a.Title %></h2>
            <p>Article Category: <%:a.CategoryName %></p>
            <p>Article Status: <%: a.Status.ToString() %></p>
            <asp:Button ID="DeleteButton" runat="server" CausesValidation="false" Text="Delete" CssClass="btn btn-primary" OnClick="DeleteButton_Click" />
        </div>
        <script type="text/javascript">
            <%= script %>
        </script>
    </div>
</asp:Content>

