<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="ManageDrive.aspx.cs" Inherits="Admin_ManageDrive" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h3>Drive
    </h3>
    <uc1:message ID="message4" Visible="false" runat="server" />
    <div class="row-fluid">
        <div class="col">


            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a runat="server" href="~/admin/managedrive.aspx">Home</a></li>
                    <%
                        StringBuilder temp = new StringBuilder();
                        foreach (string folder in FolderList)
                        {
                            if (folder != string.Empty)
                            {
                                temp.Append(folder);
                                temp.Append("/");
                    %>
                    <li class="breadcrumb-item"><a href="../admin/managedrive.aspx?folderpath=<%= temp %>"><%= folder%></a></li>
                    <%}
                        } %>
                </ol>
            </nav>
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#thlist" type="button" role="tab" aria-controls="home" aria-selected="true">Home</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="folder-tab" data-bs-toggle="tab" data-bs-target="#foldertab" type="button" role="tab" aria-controls="profile" aria-selected="false">Add Folder</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="upload-tab" data-bs-toggle="tab" data-bs-target="#uploadtab" type="button" role="tab" aria-controls="contact" aria-selected="false">Upload</button>
                </li>
            </ul>
            <%--            <ul id="folderTab" class="nav nav-tabs">
                <li class="active"><a href="#thlist" data-toggle="tab"><i class="icon-th-list"></i>&nbsp;</a>
                </li>
                <li class="pull-right"><a href="#foldertab" data-toggle="tab"><i class="icon-plus"></i>
                    Add Folder</a> </li>
                <li class="pull-right visible-desktop"><a href="#uploadtab" data-toggle="tab"><i
                    class="icon-upload"></i>Upload</a></li>
            </ul>--%>
            <div class="tab-content" id="folderTabContent">
                <div class="tab-pane fade show active" id="thlist" role="tabpanel" aria-labelledby="home-tab">
                    <asp:Repeater ID="FolderTableRepeater" runat="server" OnItemCommand="FolderTableRepeater_ItemCommand">
                        <HeaderTemplate>
                            <table id="folderitemtable" class="table table-hover table-condensed cursor-pointer">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th class="type-string cursor-pointer">Name
                                        </th>
                                        <th class="type-int cursor-pointer">Size
                                        </th>
                                        <th class="type-date cursor-pointer">Created
                                        </th>
                                        <th class="type-date cursor-pointer">Modified
                                        </th>
                                        <th class="type-string cursor-pointer">Type
                                        </th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td style="width: 30px;">
                                    <img src='<%# DataBinder.Eval(Container.DataItem, "ThumbNail")%>' alt="" style="width: 20px;" />
                                </td>
                                <td>
                                    <a href="http://<%: Request.Url.Host %>/admin/managedrive.aspx?folderpath=<%# DataBinder.Eval(Container.DataItem, "Location").ToString().Replace("\\", "/")%>">
                                        <%# DataBinder.Eval(Container.DataItem, "Name")%></a>
                                </td>
                                <td></td>
                                <td>
                                    <%# DateTime.Parse(DataBinder.Eval(Container.DataItem, "CreateDate").ToString()).ToString("d MMM y")%>
                                </td>
                                <td>
                                    <%# DateTime.Parse(DataBinder.Eval(Container.DataItem, "ModifyDate").ToString()).ToString("d MMM y")%>
                                </td>
                                <td></td>
                                <td>
                                    <asp:LinkButton ID="RenameButton" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name")%>'
                                        CommandName='Rename' runat="server" Visible='<%# DataBinder.Eval(Container.DataItem, "Editable")%>'
                                        OnClientClick="return confirm('You will have to change path of all references made to this folder, ARE YOU SURE YOU WANT TO DO THIS?');"><i class="icon-pencil"></i></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="DeleteButton" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name")%>'
                                        CommandName='Delete' runat="server" Visible='<%# DataBinder.Eval(Container.DataItem, "Deletable")%>'
                                        OnClientClick="return confirm('IMPORTANT!!!! You want to delete this item? Once deleted you wont be able to restore it. Any links pointing to this folder will not work.');"><i class="icon-remove"></i></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                        </FooterTemplate>
                    </asp:Repeater>
                    <asp:Repeater ID="FileItemRepeater" runat="server" OnItemCommand="FileItemRepeater_ItemCommand">
                        <HeaderTemplate>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td></td>
                                <td>
                                    <a href='<%# DataBinder.Eval(Container.DataItem, "WebPath")%>' target="_blank">
                                        <%# DataBinder.Eval(Container.DataItem, "Name")%></a>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "Size")%>
                                </td>
                                <td>
                                    <%# DateTime.Parse(DataBinder.Eval(Container.DataItem, "CreateDate").ToString()).ToString("d MMM y")%>
                                </td>
                                <td>
                                    <%# DateTime.Parse(DataBinder.Eval(Container.DataItem, "ModifyDate").ToString()).ToString("d MMM y")%>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "ItemType")%>
                                </td>
                                <td>
                                    <asp:LinkButton ID="RenameButton" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name")%>'
                                        CommandName='Rename' runat="server" Visible='<%# DataBinder.Eval(Container.DataItem, "Editable")%>'
                                        OnClientClick="return confirm('Any links made to this file will not work after renaming, ARE YOU SURE YOU WANT TO DO THIS?');"><i class="icon-pencil"></i></asp:LinkButton>
                                </td>
                                <td>
                                    <asp:LinkButton ID="DeleteButton" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "Name")%>'
                                        CommandName='Delete' runat="server" Visible='<%# DataBinder.Eval(Container.DataItem, "Deletable")%>'
                                        OnClientClick="return confirm('You want to delete this item? Once deleted you wont be able to restore it and any links make to this file will not work.');"><i class="icon-remove"></i></asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </tbody> </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <div class="tab-pane fade" id="foldertab" role="tabpanel" aria-labelledby="folder-tab">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <uc1:message ID="message1" Visible="false" runat="server" />
                            <div class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label" for="inputEmail">
                                        Folder Name</label>
                                    <div class="controls">
                                        <asp:TextBox ID="FolderTextBox" CssClass="span5" MaxLength="100" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                            ID="RequiredFieldValidator1" ValidationGroup="foldergrp" runat="server" ErrorMessage="Required"
                                            CssClass="validate" ControlToValidate="FolderTextBox"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="form-actions">
                                    <asp:Button ID="CreateFolderButton" runat="server" ValidationGroup="foldergrp" Text="Create"
                                        CssClass="btn" OnClick="CreateFolderButton_Click" />
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="tab-pane fade" id="uploadtab" role="tabpanel" aria-labelledby="upload-tab">
                    <iframe src="../admin/simpleupload.aspx?folderpath=<%= FolderPath.Replace("\\", "/") %>"
                        style="width: 99%; border: none; min-height: 500px;"></iframe>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdatePanel ID="RenameFolderUPanel" runat="server">
        <ContentTemplate>
            <asp:Panel ID="RenameFolderPanel" Visible="false" runat="server">
                <div class="modal" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <asp:LinkButton ID="RenameFolderCancelButton" runat="server" CssClass="close" CausesValidation="false"
                                    OnClick="RenameFolderCancelButton_Click" Text="&times;"></asp:LinkButton>
                                <h3>Rename</h3>
                            </div>
                            <div class="modal-body">
                                <uc1:message ID="message2" Visible="false" HideClose="false" runat="server" />
                                <div class="form-forizontal">
                                    <div class="control-group">
                                        <label class="control-label" for="<%: RenameFolderNameTextBox.ClientID%>">
                                            Name</label>
                                        <div class="controls">
                                            <asp:HiddenField ID="RenameFolderSourceHdn" runat="server" />
                                            <asp:TextBox ID="RenameFolderNameTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator2" runat="server" ValidationGroup="FolderNameGrp" ControlToValidate="RenameFolderNameTextBox"
                                                ErrorMessage="Required"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button ID="RenameFolderButton" runat="server" ValidationGroup="FolderNameGrp"
                                    CssClass="btn btn-primary" Text="Save Changes" OnClick="RenameFolderButton_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <asp:Panel ID="RenameFilePanel" Visible="false" runat="server">
                <div class="modal" tabindex="-1">
                    <div class="modal-header">
                        <asp:LinkButton ID="RenameFileCancelButton" runat="server" CssClass="close" CausesValidation="false"
                            OnClick="RenameFileCancelButton_Click" Text="&times;"></asp:LinkButton>
                        <h3>Rename</h3>
                    </div>
                    <div class="modal-body">
                        <uc1:message ID="message3" Visible="false" HideClose="false" runat="server" />
                        <div class="form-forizontal">
                            <div class="control-group">
                                <label class="control-label" for="<%: RenameFileNameTextBox.ClientID%>">
                                    Name</label>
                                <div class="controls">
                                    <asp:HiddenField ID="RenameFileSourceHdn" runat="server" />
                                    <asp:TextBox ID="RenameFileNameTextBox" MaxLength="200" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                        ID="RequiredFieldValidator3" runat="server" ValidationGroup="FileNameGrp" ControlToValidate="RenameFileNameTextBox"
                                        ErrorMessage="Required"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="RenameFileButton" runat="server" ValidationGroup="FileNameGrp" CssClass="btn btn-primary"
                            Text="Save Changes" OnClick="RenameFileButton_Click" />
                    </div>
                </div>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="FolderTableRepeater" EventName="ItemCommand" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
