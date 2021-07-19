<%@ Control Language="C#" AutoEventWireup="true" CodeFile="message.ascx.cs" Inherits="control_message" %>

<div class="alert <%: Block %>">
<%if (!HideClose)
  { %>
  <a class="close" data-dismiss="alert" href="#">×</a><%} %>
  <h4 class="alert-heading">
      <asp:Literal ID="HeadingLit" runat="server"></asp:Literal></h4>
    <asp:Literal ID="TextLit" runat="server"></asp:Literal>
</div>