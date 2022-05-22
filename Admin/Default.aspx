<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<%@ Import Namespace="Rockying.Models" %>
<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" type="text/css" rel="Stylesheet" />
    <script type="text/javascript" src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="ArticleSource" runat="server" ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT P.ID, P.Title, P.DateCreated, P.WriterName, P.Viewed, C.Name AS Category, PS.Name AS Status, P.URL FROM Category AS C INNER JOIN Post AS P ON C.ID = P.Category INNER JOIN PostStatus AS PS ON P.Status = PS.ID "></asp:SqlDataSource>
    <asp:SqlDataSource ID="CategorySource" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>" DataSourceMode="DataReader"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT ID, Name FROM Category WHERE NAME not like '%deleted%'"></asp:SqlDataSource>
    <uc1:message ID="message1" Visible="false" EnableViewState="false" runat="server" />

    <h3>Stories</h3>
    <%if (CurrentUser.UserType == (byte)MemberTypeType.Admin)
        {%>
    <p class="text-right">
        <asp:Button CssClass="btn" Style="padding-right: 20px;" OnClientClick="return confirm('Are you sure you want to delete all inactive articles?');" ID="DeleteInactiveButton" runat="server" Text="Delete All Inactive" OnClick="DeleteInactiveButton_Click" />
        <asp:Button CssClass="btn" Enabled="false" OnClientClick="return confirm('Are you sure you want to delete all draft articles?');" ID="DeleteDraftButton" runat="server" Text="Delete All Draft" OnClick="DeleteDraftButton_Click" />
    </p>
    <%} %>
    <div class="table-responsive">
        <table class="table table-striped table-bordered " id="articletable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Date Created</th>
                    <th>Status</th>
                    <th>Writer</th>
                    <!--<th>Viewed</th>-->
                    <th>Category</th>
                    <%if (CurrentUser.UserType == (byte)MemberTypeType.Admin)
                        {%>
                    <th>Top Story</th>
                    <%} %>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="Repeater1" OnItemCommand="Repeater1_ItemCommand" DataSourceID="ArticleSource" DataMember="DefaultView" ClientIDMode="Static" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%#Eval("ID") %></td>
                            <td><%# HttpUtility.HtmlEncode(Eval("Title")) %></td>
                            <td><%#Eval("DateCreated") %></td>
                            <td><%#Eval("Status") %></td>
                            <td><%#Eval("WriterName") %></td>
                            <!--<td><a class="viewed" target="_blank" href='<%# string.Format("http://rudrasofttech.com/vtracker/report/WebpagePublicStats?id=1&path={0}{1}", HttpContext.Current.Server.UrlEncode("http://www.rockying.com/a/"), DataBinder.Eval(Container.DataItem, "URL")) %>'
                                    vhref='<%# string.Format("http://www.rockying.com/a/{0}", DataBinder.Eval(Container.DataItem, "URL")) %>'></a></td>-->
                            <td><%#Eval("Category") %></td>
                            <%if (CurrentUser.UserType == (byte)MemberTypeType.Admin)
                                {%>
                            <td>
                                <asp:LinkButton ID="SetTopStoryButton" runat="server" CausesValidation="False" CommandName="TopStory"
                                    CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' Text="Top Story"></asp:LinkButton>
                            </td>
                            <td>
                                <a href='<%# string.Format("managearticle.aspx?id={0}&mode=edit", DataBinder.Eval(Container.DataItem, "ID")) %>'>Edit</a>
                            </td>
                            <%}
                                else
                                { %>
                            <td>
                                <a href='<%# string.Format("simpleedit.aspx?id={0}&mode=edit", DataBinder.Eval(Container.DataItem, "ID")) %>'>Edit</a>
                            </td>
                            <%} %>

                            <td>
                                <a href='<%# string.Format("deletearticle.aspx?id={0}", DataBinder.Eval(Container.DataItem, "ID")) %>'>Delete</a>
                            </td>
                            <td><a target="_blank" href='<%# string.Format("//www.rockying.com/a/{0}?preview=true", DataBinder.Eval(Container.DataItem, "URL")) %>'>Preview</a></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#articletable').DataTable({
                "lengthMenu": [[-1, 50, 30], ["All", 50, 30]]
            });
            $(".viewed").each(function () {
                var ele = $(this);
                $.get("../handlers/visitsinfo.ashx?u=" + encodeURI(ele.attr("vhref")), function (data) { ele.html(data); });
            });
        });


    </script>
</asp:Content>
