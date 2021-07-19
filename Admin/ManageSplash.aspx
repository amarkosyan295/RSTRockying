<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="ManageSplash.aspx.cs" Inherits="Admin_ManageSplash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="CategorySource" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>" DataSourceMode="DataReader"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT ID, Name FROM Category WHere Status=0"></asp:SqlDataSource>
    <div id="driveModal" class="modal hide fade" tabindex="-1" role="dialog">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3>
                Drive</h3>
        </div>
        <div class="modal-body">
            <iframe style="border: none; width: 100%; height: 400px;" src="viewdrive.aspx">
            </iframe>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <h1>
                <asp:Literal ID="HeadingLit" runat="server">Create</asp:Literal></h1>
            <div class="form-vertical">
                <div class="control-group">
                    <label class="control-label" for="<%: TitleTextBox.ClientID %>">
                        Title</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span11" ID="TitleTextBox" MaxLength="250" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="TitleReqVal" ValidationGroup="VideoGrp" ControlToValidate="TitleTextBox"
                            runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: LinkTextBox.ClientID %>">
                        Photo Link</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span11" ID="LinkTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="LinkReqVal" ValidationGroup="VideoGrp" ControlToValidate="LinkTextBox" runat="server"
                            ErrorMessage="Required"></asp:RequiredFieldValidator>
                        <p>
                            <a href="#driveModal" data-toggle="modal" role="button">Choose Photo From Drive</a></p>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: DescriptionTextBox.ClientID %>">
                        Description</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span11" MaxLength="500" ID="DescriptionTextBox" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TagTextBox.ClientID %>">
                        Tag</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span11" MaxLength="255" ID="TagTextBox" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: CategoryDropDown.ClientID %>">
                        Category</label>
                    <div class="controls">
                        <asp:DropDownList ID="CategoryDropDown" runat="server" DataMember="DefaultView" DataSourceID="CategorySource"
                            DataTextField="Name" DataValueField="ID">
                            <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="CategoryReqVal" ValidationGroup="VideoGrp" ControlToValidate="CategoryDropDown"
                            runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
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
                    <asp:Button ID="SubmitButton" ValidationGroup="VideoGrp" class="btn btn-primary"
                        runat="server" Text="Save" OnClick="SubmitButton_Click" />
                    <a href="SplashList.aspx" class="btn">Cancel</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
