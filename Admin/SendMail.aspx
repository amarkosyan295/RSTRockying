<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="SendMail.aspx.cs" Inherits="Admin_SendMail" %>

<%@ Import Namespace="Rockying.Models" %>
<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span12">
            <h1>Send Mail</h1>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <fieldset>
                <legend></legend>
                <div class="control-group">
                    <label class="control-label">
                        Send To Email:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="ToEmailTextBox" MaxLength="200" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                            ControlToValidate="ToEmailTextBox" runat="server" ErrorMessage="Required" CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Sent To Name:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="ToNameTextBox" MaxLength="200" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Email Type:
                    </label>
                    <div class="controls">
                        <asp:DropDownList ID="ETypeList" runat="server">
                            <asp:ListItem Value="3">Newsletter</asp:ListItem>
                            <asp:ListItem Value="5">Reminder</asp:ListItem>
                            <asp:ListItem Value="6">Communication</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Email Group:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="EGroupTextBox" MaxLength="50" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Subject:
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="SubjectTextBox" MaxLength="200" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="SubjectTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Message:
                    </label>
                    <div class="controls">
                        <p>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('undo', false, '');">Undo</button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('redo', false, '');">Redo</button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('bold', false, '');"><i class="icon-bold"></i></button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('italic', false, '');"><i class="icon-italic"></i></button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('justifyLeft', false, '');"><i class="icon-align-left"></i></button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('justifyCenter', false, '');"><i class="icon-align-center"></i></button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('justifyRight', false, '');"><i class="icon-align-right"></i></button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('justifyFull', false, '');"><i class="icon-align-justify"></i></button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('insertUnorderedList', false, '');" title="Bullet List"><i class="icon-list"></i></button>
                            <button class="btn" type="button" onclick="ExecuteScriptCommand('insertOrderedList', false, '');" title="Numbered List"><i class="icon-list-alt"></i></button>
                            <a href="#driveModal" class="btn" data-toggle="modal" role="button" title="Insert Picture"><i class="icon-picture"></i></a>
                        </p>
                        <div>
                            <div id="editor" class="htmleditor" contenteditable onkeyup="$('#MessageTextBox').val(document.getElementById('editor').innerHTML);" style="">
                            </div>
                        </div>
                        <asp:TextBox ID="MessageTextBox" ClientIDMode="Static" TextMode="MultiLine" Rows="10" Style="width: 100%; display: none;"
                            runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="MessageTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary"
                        runat="server" Text="Send Mail" OnClick="SubmitButton_Click" />
                </div>
            </fieldset>
        </div>
    </div>
    <div id="driveModal" class="modal hide fade" tabindex="-1" role="dialog">
        <div class="modal-header">
            <button type="button" id="closedrivemodalbtn" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3>Drive</h3>
        </div>
        <div class="modal-body">
            <iframe style="border: none; width: 100%; height: 370px;" src="viewdrive.aspx?callback=ExecuteImageCommand"></iframe>
            <div style="text-align: center;">Click image file to select, after selecting close the pop up.</div>
        </div>
    </div>
    <script>
        function ExecuteScriptCommand(cmd, defaultUI, value) {
            document.execCommand(cmd, defaultUI, value);
            $("#MessageTextBox").val(document.getElementById("editor").innerHTML);
        }

        function ExecuteImageCommand(src) {
            document.execCommand("insertImage", false, src);
            $("#closedrivemodalbtn").click();
        }
    </script>
</asp:Content>
