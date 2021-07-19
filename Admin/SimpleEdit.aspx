<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="SimpleEdit.aspx.cs" Inherits="Admin_SimpleEdit" %>

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
            <h3>
                <asp:Literal ID="HeadingLit" runat="server">Create</asp:Literal></h3>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <div class="form-vertical">
                <div class="control-group">
                    <label class="control-label" for="<%: TitleTextBox.ClientID %>">
                        Title</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" spellcheck="true" AutoPostBack="true" ID="TitleTextBox" MaxLength="250" runat="server" OnTextChanged="TitleTextBox_TextChanged"></asp:TextBox>
                        <span class="help-block">Title of the story should be unique and catchy.</span>
                        <asp:RequiredFieldValidator ID="TitleReqVal" ValidationGroup="VideoGrp" ControlToValidate="TitleTextBox"
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
                                <span class="help-block">URL is generated from title but you can change it as well.</span>
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
                    <label class="control-label" for="<%: TextTextBox.ClientID %>">
                        Content</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" spellcheck="true" ClientIDMode="Static" ID="TextTextBox" TextMode="MultiLine" Rows="15" runat="server"></asp:TextBox>
                        <span class="help-block">HTML Tags are not allowed. Story should be original and interesting to read. Always spell check your writing.</span> <asp:RequiredFieldValidator
                            ID="TextReqVal" ValidationGroup="VideoGrp" ControlToValidate="TextTextBox" runat="server"
                            ErrorMessage="Required" CssClass="validate" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: TagTextBox.ClientID %>">
                        Keywords</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" ID="TagTextBox" runat="server"></asp:TextBox>
                        <span class="help-block">Keywords help with search engine optimization. You can enter multiple keywords separated by comma.</span>
                        <asp:RequiredFieldValidator ID="TagReqVal" ValidationGroup="VideoGrp" ControlToValidate="TagTextBox"
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
                        <span class="help-block">Every story should have a picture associated with it. You can use the drive to store pictures for your stories. Only use pictures of which you own the copyright.</span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: FacebookDescTextBox.ClientID %>">
                        Short Description</label>
                    <div class="controls">
                        <asp:TextBox CssClass="span12" spellcheck="true" ID="FacebookDescTextBox" MaxLength="250" runat="server"></asp:TextBox>
                        <span class="help-block">Short description helps your story to get better visibility on search engines. Use this space to highlight the important points of the story.</span>
                        <asp:RequiredFieldValidator ID="FacebookDescReqVal" ValidationGroup="VideoGrp" ControlToValidate="FacebookDescTextBox"
                            runat="server" ErrorMessage="Required" CssClass="validate" Display="Dynamic"
                            SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                
                <div class="control-group">
                    <label class="control-label" for="<%: StatusDropDown.ClientID %>">
                        Status</label>
                    <div class="controls">
                        <asp:DropDownList ID="StatusDropDown" runat="server">
                            <asp:ListItem Selected="True" Value="1">Draft</asp:ListItem>
                            <asp:ListItem Value="2">Publish</asp:ListItem>
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
            <div style="text-align: center;">Click image file to select, after selecting close the pop up.</div>
        </div>
    </div>
</asp:Content>
