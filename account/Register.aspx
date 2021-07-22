<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Register" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<%@ Register Src="~/control/Captcha.ascx" TagPrefix="uc1" TagName="Captcha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row-fluid">
        <div class="span8" style="padding-left: 10px; padding-right: 10px;">
            <h1>
                Register</h1>
            <p>
                All fields are mandatory. If you wish to recieve Rockying newsletter choose "Newsletter".
            </p>
            <form runat="server" id="MainForm" class="form-horizontal">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <fieldset>
                <uc1:message ID="message1" Visible="false" runat="server" />
                <div class="control-group">
                    <label class="control-label" for="<%: EmailTextBox.ClientID %>">
                        Email</label>
                    <div class="controls">
                        <asp:TextBox CssClass="input-xlarge" ID="EmailTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="EmailTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator><asp:CustomValidator
                                ID="CustomValidator1" CssClass="validate" ControlToValidate="EmailTextBox" ValidationGroup="logingrp"
                                Display="Dynamic" runat="server" ErrorMessage="Duplicate Email, please try different address"
                                OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="EmailTextBox"
                            CssClass="validate" ValidationGroup="logingrp" Display="Dynamic" ErrorMessage="Invalid Email"
                            SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: PasswordTextBox.ClientID %>">
                        Password</label>
                    <div class="controls">
                        <asp:TextBox CssClass="input-xlarge" ID="PasswordTextBox" MaxLength="20" TextMode="Password"
                            runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                runat="server" ControlToValidate="PasswordTextBox" Display="Dynamic" CssClass="validate"
                                ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: NameTextBox.ClientID %>">
                        First Name</label>
                    <div class="controls">
                        <asp:TextBox CssClass="input-xlarge" ID="NameTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="NameTextBox"
                            CssClass="validate" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: GenderDropDown.ClientID %>">
                        Gender</label>
                    <div class="controls">
                        <asp:DropDownList ID="GenderDropDown" runat="server">
                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                            <asp:ListItem Text="Other" Value="O"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: YearDropDown.ClientID %>">
                        Date of Birth</label>
                    <div class="controls">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="YearDropDown" CssClass="span3" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="YearDropDown_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Static"
                                    ControlToValidate="YearDropDown" CssClass="validate" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="MonthDropDown" CssClass="span2" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="MonthDropDown_SelectedIndexChanged">
                                    <asp:ListItem Value="1">Jan</asp:ListItem>
                                    <asp:ListItem Value="2">Feb</asp:ListItem>
                                    <asp:ListItem Value="3">Mar</asp:ListItem>
                                    <asp:ListItem Value="4">Apr</asp:ListItem>
                                    <asp:ListItem Value="5">May</asp:ListItem>
                                    <asp:ListItem Value="6">Jun</asp:ListItem>
                                    <asp:ListItem Value="7">Jul</asp:ListItem>
                                    <asp:ListItem Value="8">Aug</asp:ListItem>
                                    <asp:ListItem Value="9">Sep</asp:ListItem>
                                    <asp:ListItem Value="10">Oct</asp:ListItem>
                                    <asp:ListItem Value="11">Nov</asp:ListItem>
                                    <asp:ListItem Value="12">Dec</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Static"
                                    ControlToValidate="MonthDropDown" CssClass="validate" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="DateDropDown" runat="server" CssClass="span2">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Static"
                                    ControlToValidate="DateDropDown" CssClass="validate" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: WriterCheckBox.ClientID %>">
                        I am a Writer</label>
                    <div class="controls">
                        <label class="checkbox">
                            <asp:CheckBox ID="WriterCheckBox" Checked="true" runat="server" />
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="<%: NewsletterCheckBox.ClientID %>">
                        Newsletter</label>
                    <div class="controls">
                        <label class="checkbox">
                            <asp:CheckBox ID="NewsletterCheckBox" Checked="true" runat="server" />
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <uc1:Captcha runat="server" ID="Captcha" />
                    </div>
                <small>Please check our <a target="_blank" href="http://www.rockying.com/PrivacyPolicy" target="_blank">
                    Privacy Policy</a>, <a target="_blank" href="http://www.rockying.com/Terms-Of-Use">Terms of Use</a></small>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Submit" OnClick="SubmitButton_Click" />
                </div>
            </fieldset>
            </form>
        </div>
    </div>
    
</asp:Content>
