<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="NewsletterDesign.aspx.cs" Inherits="Admin_NewsletterDesign" %>

<%@ Import Namespace="Rockying.Models" %>
<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../bootstrap/js/jquery.tinyscrollbar.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $('.scrollbararea').tinyscrollbar();

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:SqlDataSource ID="ArticleSource" runat="server" ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>"
        ProviderName="<%$ ConnectionStrings:RockyingConnectionString.ProviderName %>"
        SelectCommand="SELECT P.ID, P.Title, C.Name AS Category FROM Category AS C INNER JOIN Post AS P ON C.ID = P.Category INNER JOIN PostStatus AS PS ON P.Status = PS.ID WHERE (P.Status = 2) ORDER BY P.DateCreated DESC">
    </asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12">
            <h1>
                Newsletter Design</h1>
            <uc1:message ID="message1" Visible="false" runat="server" />
            <fieldset>
                <legend></legend>
                <div class="control-group">
                    <label class="control-label">
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="KeyValueTextBox" TextMode="MultiLine" Rows="10" Style="width: 100%;"
                            runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NameReqVal" ValidationGroup="CategoryGrp" Display="Dynamic"
                            ControlToValidate="KeyValueTextBox" runat="server" ErrorMessage="Required" CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Email Group
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="EGroupTextBox" MaxLength="50" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="EGroupTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        Subject
                    </label>
                    <div class="controls">
                        <asp:TextBox ID="SubjectTextBox" MaxLength="100" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="CategoryGrp"
                            Display="Dynamic" ControlToValidate="EGroupTextBox" runat="server" ErrorMessage="Required"
                            CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button ID="SubmitButton" ValidationGroup="CategoryGrp" class="btn btn-primary"
                        runat="server" Text="Save Design" OnClick="SubmitButton_Click" />
                    <asp:Button ID="SendButton" ValidationGroup="CategoryGrp" class="btn btn-primary"
                        runat="server" Text="Save & Send" OnClick="SendButton_Click" />
                    <asp:Button ID="PreviewButton" class="btn btn-primary" runat="server" Text="Preview"
                        CausesValidation="false" OnClick="PreviewButton_Click" />
                    <a class="btn" data-toggle="modal" href="#articleModal">Choose Article</a>
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Literal ID="Literal1" runat="server" Mode="PassThrough"></asp:Literal>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="PreviewButton" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    <div class="modal hide" id="articleModal">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">
                ×</button>
            <h3>
                Article List</h3>
        </div>
        <div class="modal-body">
            <div class="scrollbararea" style="width: 500px;">
                <div class="scrollbar">
                    <div class="track">
                        <div class="thumb">
                            <div class="end">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="viewport" style="height: 400px; width: 480px">
                    <div class="overview">
                        <asp:CheckBoxList ID="ArticleList" runat="server" AutoPostBack="false" DataSourceID="ArticleSource"
                            DataTextField="Title" DataValueField="ID">
                        </asp:CheckBoxList>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer">
            <asp:Button ID="ArticleButton" CssClass="btn btn-primary" CausesValidation="false"
                runat="server" Text="Select" OnClick="ArticleButton_Click" />
        </div>
    </div>
</asp:Content>
