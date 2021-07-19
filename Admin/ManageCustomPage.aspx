<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="ManageCustomPage.aspx.cs" Inherits="Admin_ManageCustomPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>
                <asp:Literal ID="HeadingLit" runat="server">Create Page</asp:Literal></h1>
            <div class="form-vertical">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="control-group">
                            <label class="control-label" for="<%: NameTextBox.ClientID %>">
                                Page Name</label>
                            <div class="controls">
                                <asp:TextBox CssClass="span11" ID="NameTextBox" CausesValidation="true" MaxLength="200"
                                    runat="server" AutoPostBack="True" OnTextChanged="NameTextBox_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="PageGrp" ControlToValidate="NameTextBox"
                                    runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator1" ControlToValidate="NameTextBox" ValidationGroup="PageGrp"
                                    runat="server" ErrorMessage="Duplicate Name" CssClass="validate" Display="Dynamic"
                                    OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Enabled="false"
                                    ControlToValidate="NameTextBox" CssClass="validate" Display="Dynamic" ErrorMessage="Space, &amp;, #, ? not allowed"
                                    ValidationExpression="^[a-zA-Z0-9!\-]{2,200}$" ValidationGroup="PageGrp"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="control-group">
                    <label class="control-label" for="<%: TitleTextBox.ClientID %>">
                        Page Title</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span11" ID="TitleTextBox" MaxLength="300" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="TitleReqVal" ValidationGroup="PageGrp" ControlToValidate="TitleTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: StatusDropDown.ClientID %>">
                        Status</label>
                    <div class="controls">
                        <asp:DropDownList ID="StatusDropDown" runat="server">
                            <asp:ListItem Value="1">Draft</asp:ListItem>
                            <asp:ListItem Value="2">Publish</asp:ListItem>
                            <asp:ListItem Value="3">Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: NoTemplateCheckBox.ClientID %>">
                        No Template</label>
                    <div class="controls">
                        <asp:CheckBox ID="NoTemplateCheckBox" Checked="true" runat="server" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: PageMetaTextBox.ClientID %>">
                        Page Meta (optional)</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="PageMetaTextBox" TextMode="MultiLine" Rows="7" runat="server"></asp:TextBox>
                        <span class="help-block">Place Meta tag for keywords and description here.</span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: HeadTextBox.ClientID %>">
                        Page Head (optional)</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="HeadTextBox" TextMode="MultiLine" Rows="7" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: BodyTextBox.ClientID %>">
                        Page Body (<a href="#driveModal" data-toggle="modal" role="button">Open Drive</a>) </label>
                    <div class="controls">
                    
                        <asp:TextBox CssClass="span11" ID="BodyTextBox" TextMode="MultiLine" Rows="20" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="BodyReqVal" ValidationGroup="PageGrp" ControlToValidate="BodyTextBox"
                            runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="PageGrp" class="btn btn-primary" runat="server"
                        Text="Save" OnClick="SubmitButton_Click" />
                    <a href="CustomPageList.aspx" class="btn">Cancel</a>
                </div>
            </div>
        </div>
    </div>
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
</asp:Content>
