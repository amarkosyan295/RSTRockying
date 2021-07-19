<%@ Page Title="Run Query" Language="C#" MasterPageFile="~/Admin/AdminSite.master"
    AutoEventWireup="true" CodeFile="RunQuery.aspx.cs" Inherits="Admin_RunQuery" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <uc1:message ID="message1" runat="server" HideClose="true" Visible="false" />
            <fieldset>
                <legend>Run Simple Query</legend>
                <div class="control-group">
                    <label class="control-label">
                        Query Text
                    </label>
                    <div class="controls">
                        <asp:TextBox MaxLength="300" CssClass="span12" Rows="7" ID="QueryTextBox" TextMode="MultiLine"
                            runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" class="btn btn-primary" runat="server" Text="Run" OnClick="SubmitButton_Click" />
                </div>
            </fieldset>
        </div>
    </div>
</asp:Content>
