<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Login.aspx.cs" Inherits="Login" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row-fluid">
        <div class="span6">
            <h1>
                Login</h1>
            <p>
                Email and Password both are mandatory. If you want to preserve login please choose
                "Remember Me" option.</p>
            <form runat="server" id="MainForm" class="form-horizontal">
            <uc1:message ID="message1" Visible="false" runat="server" />
            <div class="control-group">
                <label class="control-label" for="<%: EmailTextBox.ClientID %>">
                    Email</label>
                <div class="controls">
                    <asp:TextBox CssClass="input-xlarge" ID="EmailTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="EmailTextBox"
                        CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required" 
                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="<%: PasswordTextBox.ClientID %>">
                    Password</label>
                <div class="controls">
                    <asp:TextBox CssClass="input-xlarge" ID="PasswordTextBox" TextMode="Password" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="PasswordTextBox"
                        Display="Dynamic" CssClass="validate" ValidationGroup="logingrp" 
                        ErrorMessage="Required" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="<%: RememberCheckBox.ClientID %>">
                    Remember Me</label>
                <div class="controls">
                    <label class="checkbox">
                        <asp:CheckBox ID="RememberCheckBox" runat="server" Checked="true" />
                    </label>
                </div>
            </div>
            <div class="form-actions">
                <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                    runat="server" Text="Login" OnClick="SubmitButton_Click" /> <a href="forgotpassword" class="btn pull-right">Forgot Password? Click Here</a>
            </div>
            </form>
        </div>
    </div>
</asp:Content>
