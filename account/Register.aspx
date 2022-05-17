<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Register" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<%@ Register Src="~/control/Captcha.ascx" TagPrefix="uc1" TagName="Captcha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <h1>Register</h1>
            <form runat="server" id="MainForm">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

                <uc1:message ID="message1" Visible="false" runat="server" />
                <div class="mb-3">
                    <label class="form-label" for="<%: EmailTextBox.ClientID %>">
                        Email</label>

                    <asp:TextBox CssClass="form-control" ID="EmailTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="EmailReqVal" runat="server" Display="Dynamic" ControlToValidate="EmailTextBox"
                        CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator><asp:CustomValidator
                            ID="CustomValidator1" CssClass="text-danger" ControlToValidate="EmailTextBox" ValidationGroup="logingrp"
                            Display="Dynamic" runat="server" ErrorMessage="Duplicate Email, please try different address"
                            OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="EmailTextBox"
                        CssClass="text-danger" ValidationGroup="logingrp" Display="Dynamic" ErrorMessage="Invalid Email"
                        SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>

                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: PasswordTextBox.ClientID %>">
                        Password</label>

                    <asp:TextBox CssClass="form-control" ID="PasswordTextBox" MaxLength="20" TextMode="Password"
                        runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                            runat="server" ControlToValidate="PasswordTextBox" Display="Dynamic" CssClass="text-danger"
                            ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>

                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: NameTextBox.ClientID %>">
                        First Name</label>

                    <asp:TextBox CssClass="form-control" ID="NameTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator2" runat="server" Display="Dynamic" ControlToValidate="NameTextBox"
                        CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>

                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: GenderDropDown.ClientID %>">
                        Gender</label>
                    <asp:DropDownList CssClass="form-select" Style="max-width: 150px;" ID="GenderDropDown" runat="server">
                        <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                        <asp:ListItem Text="Other" Value="O"></asp:ListItem>
                    </asp:DropDownList>

                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%: YearDropDown.ClientID %>">
                        Date of Birth</label>

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="row">
                                <div class="col-2">
                                    <asp:DropDownList ID="YearDropDown" CssClass="form-select" runat="server" AutoPostBack="True"
                                        OnSelectedIndexChanged="YearDropDown_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Static"
                                        ControlToValidate="YearDropDown" CssClass="text-danger" ValidationGroup="logingrp"
                                        ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-2">
                                    <asp:DropDownList ID="MonthDropDown" CssClass="form-select" runat="server" AutoPostBack="True"
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
                                        ControlToValidate="MonthDropDown" CssClass="text-danger" ValidationGroup="logingrp"
                                        ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-2">
                                    <asp:DropDownList ID="DateDropDown" runat="server" CssClass="form-select">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" Display="Static"
                                        ControlToValidate="DateDropDown" CssClass="text-danger" ValidationGroup="logingrp"
                                        ErrorMessage="required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="mb-3 form-check">
                    <label class="form-check-label" for="<%: WriterCheckBox.ClientID %>">
                        I am a Writer</label>
                    <input type="checkbox" id="WriterCheckBox" class="form-check-input" value="true" runat="server" />
                </div>
                <div class="mb-3 form-check">
                    <label class="form-check-label" for="<%: newsletterchk.ClientID %>">
                        Newsletter</label>
                    <input type="checkbox" id="newsletterchk" class="form-check-input" value="true" runat="server" />
                </div>
                <div class="mb-3">
                    <uc1:Captcha runat="server" ID="Captcha" />
                </div>
                <small>Please check our <a target="_blank" href="~/PrivacyPolicy" runat="server">Privacy Policy</a>, <a target="_blank" runat="server" href="~/Terms-Of-Use">Terms of Use</a></small>
                <div class="mb-3">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                        runat="server" Text="Register" OnClick="SubmitButton_Click" />
                </div>

            </form>
        </div>
    </div>

</asp:Content>
