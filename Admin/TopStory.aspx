<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="TopStory.aspx.cs" Inherits="Admin_TopStory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
        <h2>Top Story</h2>
        <asp:SqlDataSource ID="TopStorySource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>" 
                ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>" 
                
                
                
                SelectCommand="SELECT P.Title, C.Name AS Category, P.Viewed, P.DateCreated, P.DateModified, TS.id FROM Post AS P INNER JOIN TopStory AS TS ON P.ID = TS.PostId INNER JOIN Category AS C ON P.Category = C.ID ORDER BY P.DateCreated DESC" 
                DeleteCommand="DELETE FROM TopStory WHERE (id = @id)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="TopStoryGridView" Name="id" 
                    PropertyName="SelectedValue" />
            </DeleteParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="TopStoryGridView" AllowSorting="True"
                AutoGenerateColumns="False" GridLines="None"
                PageSize="30" EmptyDataText="No top stories found." 
                CssClass="table table-striped table-bordered table-condensed" runat="server" 
                DataKeyNames="id" DataSourceID="TopStorySource" DataMember="DefaultView">
                <Columns>
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:BoundField DataField="Category" HeaderText="Category" 
                        SortExpression="Category" />
                    <asp:BoundField DataField="Viewed" HeaderText="Viewed" 
                        SortExpression="Viewed" />
                    <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" 
                        SortExpression="DateCreated" />
                    <asp:BoundField DataField="DateModified" HeaderText="DateModified" 
                        SortExpression="DateModified" />
                    <asp:BoundField DataField="id" 
                        HeaderText="id" Visible="false" SortExpression="id" InsertVisible="False" 
                        ReadOnly="True" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to remove this article from top story list?');"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
