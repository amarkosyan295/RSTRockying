<%@ Page Title="Edit Story" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditStory.aspx.cs" Inherits="EditStory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <h3>Edit Story</h3>
    <form runat="server" id="mainform">
        <asp:SqlDataSource ID="CategorySource" runat="server" CacheExpirationPolicy="Sliding"
            ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>" DataSourceMode="DataReader"
            ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
            SelectCommand="SELECT ID, Name FROM Category Where Status = 0"></asp:SqlDataSource>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="mb-3">
                    <label for="TitleTextBox" class="form-label">Title (Required)</label>
                    <asp:TextBox ID="TitleTextBox" MaxLength="200" ClientIDMode="Static" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="TitleTextBox_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="TitleReqVal" ValidationGroup="VideoGrp" ControlToValidate="TitleTextBox"
                        runat="server" ErrorMessage="*" CssClass="text-danger" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label for="UrlTextBox" class="form-label">URL (Required)</label>
                    <div class="input-group">
                        <span class="input-group-text" id="url-addon3">https://rockying.com/a/</span>
                        <asp:TextBox ID="UrlTextBox" MaxLength="250" ClientIDMode="Static" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="UrlTextBox_TextChanged"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="UrlReqVal" ValidationGroup="VideoGrp" ControlToValidate="TitleTextBox"
                        runat="server" ErrorMessage="*" CssClass="text-danger" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="UrlCustomVal" runat="server" SetFocusOnError="true" CssClass="text-danger" Display="Dynamic" ValidationGroup="VideoGrp" ErrorMessage="Url is used by other story, change it." OnServerValidate="UrlCustomVal_ServerValidate"></asp:CustomValidator>
                </div>
                <div class="mb-3">
                    <label for="CategoryDropDown" class="form-label">Category (Required)</label>
                    <asp:DropDownList ID="CategoryDropDown" runat="server" CssClass="form-select" DataMember="DefaultView" DataSourceID="CategorySource"
                        DataTextField="Name" DataValueField="ID" AutoPostBack="True" OnSelectedIndexChanged="CategoryDropDown_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="CategoryReqVal" ValidationGroup="VideoGrp" ControlToValidate="CategoryDropDown"
                        runat="server" ErrorMessage="*" CssClass="text-danger" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="TextTextBox">
                        Content</label>
                    <asp:TextBox CssClass="form-control" spellcheck="true" ClientIDMode="Static" ID="TextTextBox" TextMode="MultiLine" Rows="15" runat="server" AutoPostBack="True" OnTextChanged="TextTextBox_TextChanged"></asp:TextBox>
                    <span class="help-block">HTML Tags are not allowed. Story should be original and interesting to read. Always spell check your writing.</span>
                    <asp:RequiredFieldValidator
                        ID="TextReqVal" ValidationGroup="VideoGrp" ControlToValidate="TextTextBox" runat="server"
                        ErrorMessage="Required" CssClass="text-danger" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: TagTextBox.ClientID %>">
                        Keywords</label>
                    <asp:TextBox CssClass="form-control" ID="TagTextBox" runat="server" AutoPostBack="True" OnTextChanged="TagTextBox_TextChanged"></asp:TextBox>
                    <span class="help-block">Keywords help with search engine optimization. You can enter multiple keywords separated by comma.</span>
                    <asp:RequiredFieldValidator ID="TagReqVal" ValidationGroup="VideoGrp" ControlToValidate="TagTextBox"
                        runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: WriterTextBox.ClientID %>">
                        Writer Name</label>
                    <asp:TextBox CssClass="form-control" ID="WriterTextBox" MaxLength="250" runat="server" AutoPostBack="True" OnTextChanged="WriterTextBox_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="WriterReqVal" ValidationGroup="VideoGrp" ControlToValidate="WriterTextBox"
                        runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: FacebookImageTextBox.ClientID %>">
                        Image</label>
                    <asp:TextBox CssClass="form-control" ID="FacebookImageTextBox" MaxLength="250" runat="server" ClientIDMode="Static" AutoPostBack="True" OnTextChanged="FacebookImageTextBox_TextChanged"></asp:TextBox>
                    <span class="help-block">Every story should have a picture associated with it. You can use the drive to store pictures for your stories. Only use pictures of which you own the copyright.</span>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: FacebookDescTextBox.ClientID %>">
                        Short Description</label>
                    <asp:TextBox CssClass="form-control" spellcheck="true" ID="FacebookDescTextBox" MaxLength="250" runat="server" AutoPostBack="True" OnTextChanged="FacebookDescTextBox_TextChanged"></asp:TextBox>
                    <span class="help-block">Short description helps your story to get better visibility on search engines. Use this space to highlight the important points of the story.</span>
                    <asp:RequiredFieldValidator ID="FacebookDescReqVal" ValidationGroup="VideoGrp" ControlToValidate="FacebookDescTextBox"
                        runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: StatusDropDown.ClientID %>">
                        Status</label>
                    <asp:DropDownList CssClass="form-select" ID="StatusDropDown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="StatusDropDown_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="1">Draft</asp:ListItem>
                        <asp:ListItem Value="2">Publish</asp:ListItem>
                        <asp:ListItem Value="3">Inactive</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="mb-3">
                    <asp:Button ID="SubmitButton" ValidationGroup="VideoGrp" class="btn btn-primary"
                        runat="server" Text="Save" OnClick="SubmitButton_Click" />
                    <a runat="server" href="~/mystories.aspx" class="btn btn-link ms-5">Cancel</a>
                </div>

            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server" DisplayAfter="0">
            <ProgressTemplate>
                <div class="fixed-bottom bg-light p-2 border">
                    <span>Saving Data ...</span>
                    <div class="progress">
                        <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </form>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>

