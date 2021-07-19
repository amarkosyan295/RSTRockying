<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="account_ChangePassword" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row-fluid">
        <div class="span6" style="padding-left: 10px; padding-right: 10px;">
            <form runat="server" id="MainForm" class="form-horizontal">
            <fieldset>
                <legend>Change Password</legend>
                <uc1:message ID="message1" Visible="false" runat="server" />
                <div class="control-group">
                    <label class="control-label" for="<%: OldPasswordTextBox.ClientID %>">
                        Old Password</label>
                    <div class="controls">
                        <asp:TextBox CssClass="input-xlarge" ID="OldPasswordTextBox" TextMode="Password" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="OldPasswordTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: NewPasswordTextBox.ClientID %>">
                        New Password</label>
                    <div class="controls">
                        <asp:TextBox CssClass="input-xlarge" ID="NewPasswordTextBox" TextMode="Password" MaxLength="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="NewPasswordTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Submit" OnClick="SubmitButton_Click" />
                </div>
            </fieldset>
            </form>
        </div>
</asp:Content>
