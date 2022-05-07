<%@ Control Language="C#" AutoEventWireup="true" CodeFile="message.ascx.cs" Inherits="control_message" %>

<div class="alert alert-dismissible fade show <%: Block %>" role="alert">
    <%if (!HideClose)
        { %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    <%} %>
    <strong>
        <asp:Literal ID="HeadingLit" runat="server"></asp:Literal></strong>
    <asp:Literal ID="TextLit" runat="server"></asp:Literal>
</div>
