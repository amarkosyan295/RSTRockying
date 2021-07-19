<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true"
    CodeFile="EmailList.aspx.cs" Inherits="Admin_EmailList" %>

<%@ Import Namespace="Rockying.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:RockyingConnectionString %>"
        SelectCommand="SELECT DISTINCT [EmailGroup] FROM [EmailMessage]"></asp:SqlDataSource>
    <div class="row-fluid">
        <div class="span12 well well-small">
            <h1>Emails</h1>
            <div class="form-inline">
                <label class="control-label" for="<%: TypeDropDown.ClientID %>">
                    Type</label>
                <asp:DropDownList ID="TypeDropDown" runat="server">
                    <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                    <asp:ListItem Value="1">Activation</asp:ListItem>
                    <asp:ListItem Value="2">Unsubscribe</asp:ListItem>
                    <asp:ListItem Value="3">Newsletter</asp:ListItem>
                    <asp:ListItem Value="4">ChangePassword</asp:ListItem>
                    <asp:ListItem Value="5">Reminder</asp:ListItem>
                    <asp:ListItem Value="6">Communication</asp:ListItem>
                </asp:DropDownList>
                <label class="control-label" for="<%: GroupDropDown.ClientID %>">
                    Group</label>
                <asp:DropDownList ID="GroupDropDown" runat="server"
                    DataSourceID="SqlDataSource1" DataTextField="EmailGroup"
                    DataValueField="EmailGroup">
                </asp:DropDownList>
                <label class="control-label" for="<%: SentDropDown.ClientID %>">
                    Sent</label>
                <asp:DropDownList ID="SentDropDown" runat="server">
                    <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
                <label class="control-label" for="<%: ReadDropDown.ClientID %>">
                    Read</label>
                <asp:DropDownList ID="ReadDropDown" runat="server">
                    <asp:ListItem Selected="True" Value="">--Select--</asp:ListItem>
                    <asp:ListItem Value="1">Yes</asp:ListItem>
                    <asp:ListItem Value="0">No</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="SubmitButton" class="btn btn-primary" runat="server" Text="Filter"
                    OnClick="SubmitButton_Click" />

                <asp:Button ID="DeleteButton" OnClientClick="return confirm('Are you sure you want to delete these emails?');" class="btn" runat="server" Text="Delete Filtered" style="margin-left:20px;" OnClick="DeleteButton_Click"
                     />
            </div>
        </div>
    </div>
    <div class="row-fluid">
        <div class="span12">
            <asp:GridView ID="EmailGrid" AllowSorting="False" AllowPaging="true" PageSize="50"
                AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-condensed"
                GridLines="None" runat="server" DataKeyNames="ID"
                OnPageIndexChanging="EmailGrid_PageIndexChanging" EmptyDataText="Found No Emails.">
                <Columns>
                    <asp:BoundField DataField="ToAddress" HeaderText="ToAddress" SortExpression="ToAddress" />
                    <asp:BoundField DataField="LastAttempt" HeaderText="LastAttempt" SortExpression="Attempt"
                        DataFormatString="{0:d MMM y}" />
                    <asp:BoundField DataField="ToName" HeaderText="ToName" SortExpression="To" />
                    <asp:BoundField DataField="ReadDate" DataFormatString="{0:d MMM y}" HeaderText="Read"
                        SortExpression="ReadDate" />
                    <asp:BoundField DataField="EmailGroup" HeaderText="EmailGroup" SortExpression="EmailGroup" />
                    <asp:CheckBoxField DataField="IsSent" HeaderText="IsSent" SortExpression="IsSent" />
                    <asp:CheckBoxField DataField="IsRead" HeaderText="IsRead" SortExpression="IsRead" />
                    <asp:BoundField DataField="CreateDate" DataFormatString="{0:d MMM y}" HeaderText="Create"
                        SortExpression="CreateDate" />
                    <asp:BoundField DataField="SentDate" DataFormatString="{0:d MMM y}" HeaderText="Sent"
                        SortExpression="SentDate" />
                    <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
