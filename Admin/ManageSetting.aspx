<%@ Page Title="Website Setting" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="ManageSetting.aspx.cs" Inherits="Admin_ManageSetting" %>

<%@ Import Namespace="Rockying.Models" %>
<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>
                Settings</h1>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <fieldset>
                <legend></legend>
                <div class="control-group">
                    <label class="control-label">
                        Site Name
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="SiteNameTextBox" class="span6" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                            ControlToValidate="SiteNameTextBox" runat="server" ErrorMessage="Required" CssClass="validate"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Site URL
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="SiteURLTextBox" class="span6" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="SiteURLTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validate"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid URL" ControlToValidate="SiteURLTextBox"
                                CssClass="validate" Display="Dynamic" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"
                                ValidationGroup="CategoryGrp"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Site Title
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="SiteTitleTextBox" class="span6" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="SiteTitleTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validate"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Universal Password
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="UPasswordTextBox" MaxLength="100" class="span6" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="UPasswordTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validate"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Newsletter Email
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="NewsletterEmailTextBox" MaxLength="300" class="span6" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="NewsletterEmailTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validate"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email"
                            ControlToValidate="NewsletterEmailTextBox" CssClass="validate" Display="Dynamic"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CategoryGrp"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Admin Name
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="NewsletterNameTextBox" MaxLength="200" class="span6" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="NewsletterNameTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validate"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Address
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="AddressTextBox" class="span6" runat="server" MaxLength="500"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Phone
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="PhoneTextBox" class="span6" runat="server" MaxLength="100"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Fax
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="FaxTextBox" class="span6" runat="server" MaxLength="300"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Contact Email
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="ContactTextBox" class="span6" runat="server"></asp:TextBox>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ErrorMessage="Invalid Email"
                            ControlToValidate="ContactTextBox" CssClass="validate" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="CategoryGrp"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Email Signature
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="EmailSignatureTextBox" class="span6" Rows="6" TextMode="MultiLine"
                            runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="SettingGrp"
                            Display="Dynamic" ControlToValidate="EmailSignatureTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validate" SetFocusOnError="True"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Common Head Content
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="HeadContentTextBox" class="span12" Rows="15" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Site Header
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="HeaderTextBox" class="span12" Rows="7" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Site Footer
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="FooterTextBox" class="span12" Rows="7" TextMode="MultiLine" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary"
                        runat="server" Text="Save Settings" OnClick="SubmitButton_Click" />
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>
