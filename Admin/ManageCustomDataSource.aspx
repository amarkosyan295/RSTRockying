<%@ Page Title="Manage Custom Data Source" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="ManageCustomDataSource.aspx.cs" Inherits="Admin_ManageCustomDataSource" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <uc1:message ID="message1" runat="server" Visible="false" />

    <h1>
        <asp:Literal ID="HeadingLit" runat="server">Create Data Source</asp:Literal></h1>
    <div class="form-vertical">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="mb-2">
                    <label class="form-label" for="<%: NameTextBox.ClientID %>">
                        Name</label>
                    <asp:TextBox ID="NameTextBox" runat="server" MaxLength="190" AutoPostBack="True" CssClass="form-control"
                        OnTextChanged="NameTextBox_TextChanged"></asp:TextBox><asp:CustomValidator ID="CustomValidator1"
                            runat="server" ValidationGroup="validategrp" Display="Dynamic" ErrorMessage="Duplicate Name"
                            CssClass="text-danger" ControlToValidate="NameTextBox" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox"
                        CssClass="text-danger" Display="Dynamic" ErrorMessage="Required" SetFocusOnError="True"
                        ValidationGroup="validategrp"></asp:RequiredFieldValidator>
                </div>
                <div class="mb-2">
                    <label class="form-label" for="<%: QueryTextBox.ClientID %>">
                        Query</label>

                    <asp:TextBox ID="QueryTextBox" runat="server" TextMode="MultiLine" Rows="10" CssClass="form-control"
                        AutoPostBack="True" OnTextChanged="QueryTextBox_TextChanged"></asp:TextBox>
                    <asp:CustomValidator
                        ID="CustomValidator2" runat="server" ValidationGroup="validategrp" Display="Dynamic"
                        ErrorMessage="Insert, Delete, Update, Alter or Drop not allowed" CssClass="text-danger"
                        ControlToValidate="QueryTextBox" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
                    <p class="help-block">
                        All queries will automatically run with "FOR XML RAW, ELEMENTS;"
                    </p>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="mb-2">
            <label class="form-label" for="<%: QueryTextBox.ClientID %>">
                HTML / XSL Template</label>
            <asp:TextBox ID="TemplateTextBox" runat="server" TextMode="MultiLine" Rows="15" CssClass="form-control"></asp:TextBox>
            <p class="help-block">
                You can use XSL if you have provided query or you can only use HTML.
            </p>
        </div>
        <div class="mb-2">
            <asp:Button ID="SubmitButton" ValidationGroup="validategrp" class="btn btn-primary"
                runat="server" Text="Save" OnClick="SubmitButton_Click" />
            <a href="CustomDataSourceList.aspx" class="btn btn-link mx-5">Cancel</a>
        </div>
    </div>

</asp:Content>
