<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="account_ChangePassword" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <h3>Change Password</h3>
            <form runat="server" id="MainForm">
                <uc1:message ID="message1" Visible="false" runat="server" />
                <div class="mb-3">
                    <label class="form-label" for="<%: OldPasswordTextBox.ClientID %>">
                        Old Password</label>

                    <asp:TextBox CssClass="form-control" ID="OldPasswordTextBox" TextMode="Password" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="OldPasswordTextBox"
                        CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: NewPasswordTextBox.ClientID %>">
                        New Password</label>
                    <asp:TextBox CssClass="form-control" ID="NewPasswordTextBox" TextMode="Password" MaxLength="50" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="NewPasswordTextBox"
                        CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-3">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Submit" OnClick="SubmitButton_Click" />
                </div>
            </form>
        </div>
    </div>
</asp:Content>
