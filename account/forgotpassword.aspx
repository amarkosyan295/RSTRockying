<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="forgotpassword.aspx.cs" Inherits="account_forgotpassword" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <h1>Forgot Password</h1>
            <p>
                Please provide your registered email address and we will send your password to you
                via email.
            </p>
            <form runat="server" id="MainForm">
                <uc1:message ID="message1" Visible="false" runat="server" />
                <div class="mb-3">
                    <label class="form-label" for="<%: EmailTextBox.ClientID %>">
                        Email</label>
                    <asp:TextBox CssClass="form-control" MaxLength="200" ID="EmailTextBox" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator
                        ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="EmailTextBox"
                        CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"
                        SetFocusOnError="True">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator
                        CssClass="text-danger" ID="RegularExpressionValidator1" runat="server" ValidationGroup="logingrp"
                        Display="Dynamic" ErrorMessage="Invalid Email"
                        ControlToValidate="EmailTextBox" SetFocusOnError="True"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Submit" OnClick="SubmitButton_Click" />
                </div>
            </form>
        </div>
    </div>
</asp:Content>
