<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewdrive.aspx.cs" EnableViewState="false" Inherits="account_viewdrive" %>

<%@ Register Src="~/control/message.ascx" TagName="message" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet"
        type="text/css" />
    <link href="bootstrap/css/bootstrap-responsive.min.css"
        rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <style type="text/css">
        ul.filelist {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

            ul.filelist li {
                float: left;
                max-width: 150px;
                height: 120px;
                margin: 3px;
                overflow: hidden;
            }

                ul.filelist li div.thumbnail div {
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                    
                }

                ul.filelist li div.thumbnail:hover {
                    border-color: rgba(82,168,236,0.8);
                    outline: 0;
                    outline: thin dotted \9;
                    -webkit-box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 8px rgb(82 168 236 / 60%);
                    -moz-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075),0 0 8px rgba(82,168,236,0.6);
                    box-shadow: inset 0 1px 1px rgb(0 0 0 / 8%), 0 0 8px rgb(82 168 236 / 60%);
                }

                ul.filelist li a {
                    display: block;
                    text-align: center;
                    text-decoration: none;
                    color: #000;
                }

                    ul.filelist li a:hover {
                    }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <uc1:message ID="message4" Visible="false" runat="server" />
        <div class="row-fluid">
            <div class="span12">
                <ul class="breadcrumb" style="margin-bottom: 4px;">
                    <li><a href="viewdrive.aspx">Home</a> <span class="divider">/</span></li>
                    <%
                        StringBuilder temp = new StringBuilder();
                        foreach (string i in FolderList)
                        {
                            if (i != string.Empty)
                            {
                                temp.Append(i);
                                temp.Append("/");
                    %>
                    <li><a href="viewdrive.aspx?folderpath=<%= temp %>">
                        <%= i%></a> <span class="divider">/</span></li>
                    <%}
                        } %>
                </ul>
                <asp:Repeater ID="FolderTableRepeater" runat="server">
                    <HeaderTemplate>
                        <ul class="filelist">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li>
                            <div class="thumbnail">
                                <a href="viewdrive.aspx?folderpath=<%# DataBinder.Eval(Container.DataItem, "Location").ToString().Replace("\\", "/")%>">
                                    <img src='<%# DataBinder.Eval(Container.DataItem, "ThumbNail")%>' alt="" title='<%# DataBinder.Eval(Container.DataItem, "Name")%>' />
                                    <div><%# DataBinder.Eval(Container.DataItem, "Name")%></div>
                                </a>
                            </div>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                </asp:Repeater>
                <asp:Repeater ID="FileItemRepeater" runat="server">
                    <HeaderTemplate>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li>
                            <div class="thumbnail" onclick="callback('<%# DataBinder.Eval(Container.DataItem, "WebPath")%>')">
                                <img src='<%# DataBinder.Eval(Container.DataItem, "ThumbNail")%>' alt="" style="height: 90px; cursor: pointer;" title='<%# DataBinder.Eval(Container.DataItem, "Name")%>' />
                                <div><i class="icon-file"></i>&nbsp;<%# DataBinder.Eval(Container.DataItem, "Name")%></div>
                            </div>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function callback(val) {
            <%if (!string.IsNullOrEmpty(Request.QueryString["callback"]))
        { %>
            parent.<%= Request.QueryString["callback"] %>(val);
            <% } %>
        }
    </script>
</body>
</html>
