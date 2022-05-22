<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="CategoryList.aspx.cs" Inherits="Admin_CategoryList" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="CategorySource" runat="server"
        ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>" ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT C.ID, C.Name, C.UrlName, P.Name AS Parent, MS.Name AS Status, Count(Po.ID) as Stories FROM Category AS C LEFT OUTER JOIN MemberStatus AS MS ON C.Status = MS.ID LEFT OUTER JOIN Category AS P ON C.Parent = P.ID
LEFT OUTER JOIN Post as Po on C.ID = Po.Category Group By C.ID, C.Name, C.UrlName, P.Name , MS.Name "
        DeleteCommand="Delete from Category WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="CategoryView" Name="ID" PropertyName="SelectedValue" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <h1>Categories</h1>
    <uc1:message ID="message2" runat="server" Visible="false" />
    <asp:Label Font-Bold="true" EnableViewState="false" ID="HeadingLiteral" runat="server">Add</asp:Label>
    <div class="row">
        <div class="col">
            <label class="form-label" for="<%: NameTextBox.ClientID %>">
                Name</label>
            <asp:TextBox ID="NameTextBox" MaxLength="100" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                ControlToValidate="NameTextBox" runat="server" ErrorMessage="Required" CssClass="text-danger"></asp:RequiredFieldValidator>
        </div>
        <div class="col">
            <label class="form-label" for="<%: UrlNameTextBox.ClientID %>">
                Url Name</label>
            <asp:TextBox ID="UrlNameTextBox" CssClass="form-control" MaxLength="100" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="UrlNameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                ControlToValidate="UrlNameTextBox" runat="server" CssClass="text-danger" ErrorMessage="Required"></asp:RequiredFieldValidator>
        </div>
        <div class="col">
            <label class="form-label" for="<%: KeywordTextBox.ClientID %>">
                Keywords</label>
            <asp:TextBox ID="KeywordTextBox" MaxLength="995" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="col">
            <label class="form-label" for="<%: ParentDropDown.ClientID %>">
                Parent Category</label>
            <asp:DropDownList ID="ParentDropDown" runat="server" CssClass="form-select">
            </asp:DropDownList>
        </div>
        <div class="col">
            <label class="form-label" for="<%: StatusDropDown.ClientID %>">
                Status</label>
            <asp:DropDownList ID="StatusDropDown" runat="server" CssClass="form-select">
                <asp:ListItem Value="0" Selected="True">Active</asp:ListItem>
                <asp:ListItem Value="1">Inactive</asp:ListItem>
                <asp:ListItem Value="2">Deleted</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="col">
            <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary" runat="server"
                Text="Save" OnClick="SubmitButton_Click" />
        </div>
    </div>
    <h2>Category List</h2>
    <div class="table-responsive">
        <asp:GridView ID="CategoryView" AllowSorting="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
            DataMember="DefaultView" DataSourceID="CategorySource" GridLines="None" runat="server"
            DataKeyNames="ID">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                    SortExpression="ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                <asp:BoundField DataField="UrlName" HeaderText="UrlName" SortExpression="UrlName" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                <asp:BoundField DataField="Parent" HeaderText="Parent" SortExpression="Parent" />
                <asp:BoundField DataField="Stories" HeaderText="Stories" SortExpression="Stories" />
                <asp:HyperLinkField DataNavigateUrlFields="ID"
                    DataNavigateUrlFormatString="categorylist.aspx?id={0}&amp;mode=edit"
                    Text="Edit" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
