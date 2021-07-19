<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="ManageArticle.aspx.cs" Inherits="Admin_ManageArticle" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        function setArticleImage(src) {
            $("#FacebookImageTextBox").val(src);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="CategorySource" runat="server" CacheExpirationPolicy="Sliding"
        ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>" DataSourceMode="DataReader"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT ID, Name FROM Category Where Status = 0"></asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12">
            <h1>
                <asp:Literal ID="HeadingLit" runat="server">Create Article</asp:Literal></h1>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <div class="form-vertical">
                <div class="control-group">
                    <label class="control-label" for="<%: TitleTextBox.ClientID %>">
                        Article Title</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="TitleTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="TitleReqVal" ValidationGroup="VideoGrp" ControlToValidate="TitleTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: MetaTitleTextBox.ClientID %>">
                        Meta Title</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="MetaTitleTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="VideoGrp" ControlToValidate="MetaTitleTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: URLTextBox.ClientID %>">
                        URL</label>
                    <div class="controls">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <div class="input-prepend">
                                    <span class="add-on">http://www.rockying.com/a/</span>
                                    <asp:TextBox CssClass="span6" ID="URLTextBox" MaxLength="250" runat="server"
                                        AutoPostBack="True" OnTextChanged="URLTextBox_TextChanged"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="VideoGrp"
                                    ControlToValidate="URLTextBox" runat="server" ErrorMessage="Required" CssClass="validate"
                                    Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CustomValidator
                                        ID="CustomValidator1" runat="server" ValidationGroup="VideoGrp" ControlToValidate="URLTextBox"
                                        ErrorMessage="Duplicate URL, Please change the title or modify the url." CssClass="validate"
                                        Display="Dynamic" OnServerValidate="CustomValidator1_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="TitleTextBox" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TextTextBox.ClientID %>">
                        Text</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="TextTextBox" TextMode="MultiLine" Rows="25" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="TextReqVal" ValidationGroup="VideoGrp" ControlToValidate="TextTextBox" runat="server"
                            ErrorMessage="Required" CssClass="validate" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TagTextBox.ClientID %>">
                        Tag</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="TagTextBox" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="TagReqVal" ValidationGroup="VideoGrp" ControlToValidate="TagTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: WriterTextBox.ClientID %>">
                        Writer Name</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="WriterTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="WriterReqVal" ValidationGroup="VideoGrp" ControlToValidate="WriterTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: WriterEmailTextBox.ClientID %>">
                        Writer Email</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="WriterEmailTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="WriterEmailReqVal" ValidationGroup="VideoGrp" ControlToValidate="WriterEmailTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email"
                            ControlToValidate="WriterEmailTextBox" CssClass="validate" Display="Dynamic"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="VideoGrp"
                            SetFocusOnError="True"></asp:RegularExpressionValidator>
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
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: FacebookImageTextBox.ClientID %>">
                        Image</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="FacebookImageTextBox" MaxLength="250" runat="server" ClientIDMode="Static"></asp:TextBox>
                        <p>
                            <a href="#driveModal" data-toggle="modal" role="button">Choose Image From Drive</a>
                        </p>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: FacebookDescTextBox.ClientID %>">
                        Description</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="FacebookDescTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="FacebookDescReqVal" ValidationGroup="VideoGrp" ControlToValidate="FacebookDescTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TemplateDropDown.ClientID %>">
                        Template</label>
                    <div class="controls">
                        <asp:DropDownList ID="TemplateDropDown" runat="server">
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
                    <asp:Button ID="SubmitButton" ValidationGroup="VideoGrp" class="btn btn-primary"
                        runat="server" Text="Save" OnClick="SubmitButton_Click" />

                    <asp:Button ID="SubmitStayButton" ValidationGroup="VideoGrp" class="btn btn-primary"
                        runat="server" Text="Save &amp; Stay" OnClick="SubmitButton_Click" />
                    <a href="Default.aspx" class="btn" style="margin-left: 100px;">Cancel</a>
                </div>
            </div>
        </div>
    </div>
    <div id="driveModal" class="modal hide fade" tabindex="-1" role="dialog">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3>Drive</h3>
        </div>
        <div class="modal-body">
            <iframe style="border: none; width: 100%; height: 370px;" src="viewdrive.aspx?callback=setArticleImage"></iframe>
            <div style="text-align:center;">Click image file to select, after selecting close the pop up.</div>
        </div>
    </div>

</asp:Content>
