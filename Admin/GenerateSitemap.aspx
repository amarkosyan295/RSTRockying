<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="GenerateSitemap.aspx.cs" Inherits="Admin_GenerateSitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>Generate Sitemap XML File</h1>
            <asp:Label ID="lbMessage" runat="server" Visible="False" EnableViewState="False"></asp:Label>
            <asp:Button ID="btGenerateSitemap" CausesValidation="false" runat="server" Text="Generate Sitemap" CssClass="btn btn-primary btn-large" OnClick="btGenerateSitemap_Click" />
            <br />
            <asp:HyperLink ID="lnkSitemap" runat="server" Target="_blank" NavigateUrl="~/sitemap.xml" Visible="false" Text="Click Here to see Sitemap"></asp:HyperLink>
        </div>
    </div>
</asp:Content>

