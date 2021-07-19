<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="SplashList.aspx.cs" EnableViewState="false" Inherits="Admin_SplashList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SplashSource" runat="server" ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT Picture.ID, Picture.Title, Picture.CreateDate, Picture.ImageUrl, Category.Name AS Category, Picture.Viewed, PostStatus.Name AS Status FROM Picture INNER JOIN Category ON Picture.CategoryID = Category.ID INNER JOIN PostStatus ON Picture.Status = PostStatus.ID WHERE (Picture.CategoryID = @Category) AND (Picture.Status = @Status) AND (Picture.Video = 0 OR Picture.Video IS NULL) ORDER BY Picture.CreateDate DESC"
        DeleteCommand="UPDATE Picture SET Status = 3 WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="SplashGridView" Name="ID" PropertyName="SelectedValue" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="CategoryDropDown" Name="Category" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="StatusDropDown" Name="Status" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="CategorySource" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>" DataSourceMode="DataReader"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT ID, Name FROM Category"></asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12">
        <h1>Comics</h1>
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="<%: CategoryDropDown.ClientID %>">
                        Category</label>
                    <div class="controls">
                        <asp:DropDownList ID="CategoryDropDown" runat="server" DataMember="DefaultView" DataSourceID="CategorySource"
                            DataTextField="Name" DataValueField="ID">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: StatusDropDown.ClientID %>">
                        Status</label>
                    <div class="controls">
                        <asp:DropDownList ID="StatusDropDown" runat="server">
                            <asp:ListItem Value="1">Draft</asp:ListItem>
                            <asp:ListItem Selected="True" Value="2">Publish</asp:ListItem>
                            <asp:ListItem Value="3">Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" runat="server" Text="Filter" />
                </div>
            </div>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <asp:GridView ID="SplashGridView" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
                DataKeyNames="ID" DataMember="DefaultView" DataSourceID="SplashSource" GridLines="None"
                PageSize="50" EmptyDataText="No photo found.">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                        SortExpression="ID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:ImageField DataImageUrlField="ImageUrl">
                        <ControlStyle Width="60px" />
                    </asp:ImageField>
                    <asp:BoundField DataField="CreateDate" DataFormatString="{0:d MMM y}" HeaderText="CreateDate"
                        SortExpression="CreateDate" />
                    <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                    <asp:BoundField DataField="Viewed" HeaderText="Viewed" SortExpression="Viewed" />
                    <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="managesplash.aspx?id={0}&amp;mode=edit"
                        Text="Edit" />
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                Text="Delete" OnClientClick="return confirm('Are you sure you want delete this video?');"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
