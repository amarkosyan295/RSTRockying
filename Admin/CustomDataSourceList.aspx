<%@ Page Title="Custom Data Source List" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="CustomDataSourceList.aspx.cs" Inherits="Admin_CustomDataSourceList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT CDS.ID, CDS.Name, CDS.DateCreated, CDS.DateModified, CM.MemberName AS CreatedBy, MM.MemberName AS ModifiedBy FROM CustomDataSource AS CDS INNER JOIN Member AS CM ON CDS.CreatedBy = CM.ID LEFT OUTER JOIN Member AS MM ON CDS.ModifiedBy = MM.ID"></asp:SqlDataSource>

    <h1>Custom Data Sources</h1>
    <div class="table-responsive">
        <asp:GridView ID="SourceGridView" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
            DataKeyNames="ID" DataMember="DefaultView" DataSourceID="SqlDataSource1" GridLines="None"
            PageSize="30" EmptyDataText="No custom data sources found." OnRowCommand="SourceGridView_RowCommand">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                    SortExpression="ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="DateModified" NullDisplayText="--" HeaderText="DateModified"
                    SortExpression="DateModified" />
                <asp:BoundField DataField="ModifiedBy" HeaderText="Modified By" NullDisplayText="--"
                    SortExpression="ModifiedBy" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>'
                            CommandName="DeleteCommand" OnClientClick="return confirm('Are you sure you want to delete this data source? \n Please be careful, if you delete this data source it will affect on all pages which use this data source.');">Delete</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="RefreshButton" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name") %>'
                            CommandName="RefreshCommand">Refresh</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:HyperLinkField DataNavigateUrlFields="ID" DataNavigateUrlFormatString="managecustomdatasource.aspx?id={0}&amp;mode=edit"
                    Text="Edit" />
                <asp:HyperLinkField DataNavigateUrlFields="Name" Target="_blank" DataNavigateUrlFormatString="runcustomdatasource.aspx?dsname={0}"
                    Text="Run" />
            </Columns>
            <PagerSettings Mode="NumericFirstLast" Position="TopAndBottom" />
        </asp:GridView>
    </div>
</asp:Content>
