<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="ManageCustomPage.aspx.cs" Inherits="Admin_ManageCustomPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>
        <asp:Literal ID="HeadingLit" runat="server">Create Page</asp:Literal></h1>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="mb-2">
                <label class="form-label" for="<%: NameTextBox.ClientID %>">
                    Page Name</label>
                <div class="controls">
                    <asp:TextBox CssClass="form-control" ID="NameTextBox" CausesValidation="true" MaxLength="200"
                        runat="server" AutoPostBack="True" OnTextChanged="NameTextBox_TextChanged"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="PageGrp" ControlToValidate="NameTextBox"
                        runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CustomValidator1" ControlToValidate="NameTextBox" ValidationGroup="PageGrp"
                        runat="server" ErrorMessage="Duplicate Name" CssClass="text-danger" Display="Dynamic"
                        OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Enabled="false"
                        ControlToValidate="NameTextBox" CssClass="text-danger" Display="Dynamic" ErrorMessage="Space, &amp;, #, ? not allowed"
                        ValidationExpression="^[a-zA-Z0-9!\-]{2,200}$" ValidationGroup="PageGrp"></asp:RegularExpressionValidator>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="mb-2">
        <label class="form-label" for="<%: TitleTextBox.ClientID %>">
            Page Title</label>

        <asp:TextBox CssClass="form-control" ID="TitleTextBox" MaxLength="300" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="TitleReqVal" ValidationGroup="PageGrp" ControlToValidate="TitleTextBox"
            runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>

    </div>
    <div class="mb-2">
        <label class="form-label" for="<%: StatusDropDown.ClientID %>">
            Status</label>
        <asp:DropDownList ID="StatusDropDown" runat="server" CssClass="form-select">
            <asp:ListItem Value="1">Draft</asp:ListItem>
            <asp:ListItem Value="2">Publish</asp:ListItem>
            <asp:ListItem Value="3">Inactive</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="mb-2">
        <label class="form-label" for="<%: NoTemplateCheckBox.ClientID %>">
            No Template</label>
        <asp:CheckBox ID="NoTemplateCheckBox" Checked="true" runat="server" />
    </div>
    <div class="mb-2">
        <label class="form-label" for="<%: PageMetaTextBox.ClientID %>">
            Page Meta (optional)</label>
        <asp:TextBox CssClass="form-control" ID="PageMetaTextBox" TextMode="MultiLine" Rows="7" runat="server"></asp:TextBox>
        <span class="help-block">Place Meta tag for keywords and description here.</span>
    </div>
    <div class="mb-2">
        <label class="form-label" for="<%: HeadTextBox.ClientID %>">
            Page Head (optional)</label>
        <asp:TextBox CssClass="form-control" ID="HeadTextBox" TextMode="MultiLine" Rows="7" runat="server"></asp:TextBox>
    </div>
    <div class="mb-2">
        <label class="form-label" for="<%: BodyTextBox.ClientID %>">
            Page Body (<a href="#driveModal" data-toggle="modal" role="button">Open Drive</a>)
        </label>
            <asp:TextBox CssClass="form-control" ID="BodyTextBox" TextMode="MultiLine" Rows="20" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="BodyReqVal" ValidationGroup="PageGrp" ControlToValidate="BodyTextBox"
                runat="server" ErrorMessage="Required"></asp:RequiredFieldValidator>
    </div>
    <div class="mb-2">
        <asp:Button ID="SubmitButton" ValidationGroup="PageGrp" class="btn btn-primary" runat="server"
            Text="Save" OnClick="SubmitButton_Click" />
        <a href="CustomPageList.aspx" class="btn btn-light mx-5">Cancel</a>
    </div>
    <div class="modal fade" id="driveModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <iframe style="border: none; width: 100%; height: 370px;" src="viewdrive.aspx"></iframe>
                    <div style="text-align: center;">Click image file to select, after selecting close the pop up.</div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
