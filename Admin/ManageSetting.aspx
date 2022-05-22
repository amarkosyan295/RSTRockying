<%@ Page Title="Website Setting" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="ManageSetting.aspx.cs" Inherits="Admin_ManageSetting" %>

<%@ Import Namespace="Rockying.Models" %>
<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col">
            <h1>Settings</h1>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <div class="mb-2">
                <label class="form-label">
                    Site Name
                </label>
                <asp:TextBox ID="SiteNameTextBox" class="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                    ControlToValidate="SiteNameTextBox" runat="server" ErrorMessage="Required" CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>
            <div class="mb-2">
                <label class="form-label">
                    Site URL
                </label>
                <asp:TextBox ID="SiteURLTextBox" class="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="CategoryGrp"
                    Display="Dynamic" ControlToValidate="SiteURLTextBox" runat="server" ErrorMessage="Required"
                    CssClass="text-danger"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                        ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid URL" ControlToValidate="SiteURLTextBox"
                        CssClass="text-danger" Display="Dynamic" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"
                        ValidationGroup="CategoryGrp"></asp:RegularExpressionValidator>

            </div>
            <div class="mb-2">
                <label class="form-label">
                    Site Title
                </label>
                <asp:TextBox ID="SiteTitleTextBox" class="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ValidationGroup="CategoryGrp"
                    Display="Dynamic" ControlToValidate="SiteTitleTextBox" runat="server" ErrorMessage="Required"
                    CssClass="text-danger"></asp:RequiredFieldValidator>

            </div>
            <div class="mb-2">
                <label class="form-label">
                    Universal Password
                </label>

                <asp:TextBox ID="UPasswordTextBox" MaxLength="100" class="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="CategoryGrp"
                    Display="Dynamic" ControlToValidate="UPasswordTextBox" runat="server" ErrorMessage="Required"
                    CssClass="text-danger"></asp:RequiredFieldValidator>

            </div>
            <div class="mb-2">
                <label class="form-label">
                    Newsletter Email
                </label>

                <asp:TextBox ID="NewsletterEmailTextBox" MaxLength="300" class="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="CategoryGrp"
                    Display="Dynamic" ControlToValidate="NewsletterEmailTextBox" runat="server" ErrorMessage="Required"
                    CssClass="text-danger"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email"
                    ControlToValidate="NewsletterEmailTextBox" CssClass="text-danger" Display="Dynamic"
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="CategoryGrp"></asp:RegularExpressionValidator>

            </div>
            <div class="mb-2">
                <label class="form-label">
                    Admin Name
                </label>

                <asp:TextBox ID="NewsletterNameTextBox" MaxLength="200" class="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="CategoryGrp"
                    Display="Dynamic" ControlToValidate="NewsletterNameTextBox" runat="server" ErrorMessage="Required"
                    CssClass="text-danger"></asp:RequiredFieldValidator>

            </div>
            <div class="mb-2">
                <label class="form-label">
                    Address
                </label>

                <asp:TextBox ID="AddressTextBox" class="form-control" runat="server" MaxLength="500"></asp:TextBox>

            </div>
            <div class="mb-2">
                <label class="form-label">
                    Phone
                </label>

                <asp:TextBox ID="PhoneTextBox" class="form-control" runat="server" MaxLength="100"></asp:TextBox>

            </div>
            
            <div class="mb-2">
                <label class="form-label">
                    Contact Email
                </label>
                <div>
                    <asp:TextBox ID="ContactTextBox" class="form-control" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ErrorMessage="Invalid Email"
                        ControlToValidate="ContactTextBox" CssClass="text-danger" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ValidationGroup="CategoryGrp"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="mb-2">
                <label class="form-label">
                    Email Signature
                </label>
                <div>
                    <asp:TextBox ID="EmailSignatureTextBox" CssClass="form-control" Rows="6" TextMode="MultiLine"
                        runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ValidationGroup="SettingGrp"
                        Display="Dynamic" ControlToValidate="EmailSignatureTextBox" runat="server" ErrorMessage="Required"
                        CssClass="text-danger" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="mb-2">
                <label class="form-label">
                    Common Head Content
                </label>
                <div>
                    <asp:TextBox ID="HeadContentTextBox" CssClass="form-control" Rows="15" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="mb-2">
                <label class="form-label">
                    Site Header
                </label>
                <div>
                    <asp:TextBox ID="HeaderTextBox" CssClass="form-control" Rows="7" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="mb-2">
                <label class="form-label">
                    Site Footer
                </label>
                <div>
                    <asp:TextBox ID="FooterTextBox" CssClass="form-control" Rows="7" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="mb-2">
                <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary"
                    runat="server" Text="Save Settings" OnClick="SubmitButton_Click" />
            </div>

        </div>
    </div>
</asp:Content>
