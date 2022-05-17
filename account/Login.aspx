<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <h1>Login</h1>
            <p>
                Email and Password both are mandatory. If you want to preserve login please choose
                "Remember Me" option.
            </p>
            <form runat="server" id="MainForm" class="form-horizontal">
                <uc1:message ID="message1" Visible="false" runat="server" />
                <div class="mb-3">
                    <label class="form-label" for="<%: EmailTextBox.ClientID %>">
                        Email</label>
                    <asp:TextBox CssClass="form-control" TextMode="email" ID="EmailTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="EmailTextBox"
                        CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: PasswordTextBox.ClientID %>">
                        Password</label>
                    <asp:TextBox CssClass="form-control" ID="PasswordTextBox" TextMode="Password" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="PasswordTextBox"
                        Display="Dynamic" CssClass="text-danger" ValidationGroup="logingrp"
                        ErrorMessage="Required" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
                <div class="form-check mb-3">
                    <asp:CheckBox ID="RememberCheckBox" CssClass="form-check-input" runat="server" Checked="true" />
                    <label class="form-check-label" for="<%: RememberCheckBox.ClientID %>">
                        Remember Me</label>
                </div>
                <div class="col-12">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Login" OnClick="SubmitButton_Click" />
                    <a href="forgotpassword<%= !string.IsNullOrEmpty(Request.QueryString["returnurl"]) ? "?returnurl=" + Request.QueryString["returnurl"] : "" %>" class="btn btn-link float-end">Forgot Password?</a>
                    <a href="register<%= !string.IsNullOrEmpty(Request.QueryString["returnurl"]) ? "?returnurl=" + Request.QueryString["returnurl"] : "" %>" class="btn btn-link float-end">Register for Free</a>
                </div>
            </form>
        </div>
    </div>
</asp:Content>
