<%@ Page Title="Run Custom Data Source" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="RunCustomDataSource.aspx.cs" Inherits="Admin_RunCustomDataSource" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>
                <asp:Literal ID="HeadingLit" runat="server"></asp:Literal></h1>
            <div class="well">
                <%= Result %>
            </div>
        </div>
    </div>
</asp:Content>
