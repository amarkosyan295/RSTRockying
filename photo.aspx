<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="photo.aspx.cs" Inherits="photo" %>

<%@ Import Namespace="Rockying.Models" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>
        <%: VPM.Current.Title %></title>
    <script type="text/javascript">        $('#subscribemodal').modal(); </script>
    <meta property="og:title" content="<%: VPM.Current.Title%>" />
    <meta property="og:url" content="http://<%: Request.Url.Host %>/p/<%: VPM.Current.ID.ToString() %>" />
    <meta property="og:image" content="<%: VPM.Current.ImageURL%>" />
    <meta property="og:site_name" content="<%: Utility.SiteName %>" />
    <meta property="fb:admins" content="871950590" />
    <meta property="og:description" content="<%: VPM.Current.Description %>" />
    <meta property="og:type" content="article" />
    <link href="http://www.rudrasofttech.com/js-tools/bubble/bubble.css" rel="stylesheet"
        type="text/css" />
    <script src="http://www.rudrasofttech.com/js-tools/bubble/bubble.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#facebookbutton").bubble({ Action: "hover", Position: "left", Distance: 2, PointerColor: '#D4D4D4' });
            $("#twitterbutton").bubble({ Action: "hover", Position: "bottom", Distance: 2, PointerColor: '#D4D4D4' });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row-fluid">
        <div class="span9">
            <h2>
                <%: VPM.Current.Title%></h2>
            <p class="smalltxt">
                Tags:
                <%: VPM.Current.Tag%>
                <% if (Request.IsAuthenticated)
                   {
                       MemberTypeType utype = MemberManager.UserType(User.Identity.Name);
                       if (utype == MemberTypeType.Admin || utype == MemberTypeType.Author)
                       {%>
                <a href="http://<%: Request.Url.Host%>/Admin/ManageSplash.aspx?id=<%: VPM.Current.ID.ToString()%>&mode=edit"
                    target="_blank">Edit</a>
                <% }
                   }%>
            </p>
            
            <div id="article">
                <img src="<%: VPM.Current.ImageURL %>" alt="<%: VPM.Current.Tag %>" />
                <p>
                    <%=VPM.Current.Description%>
                </p>
                <p style="text-align: center;">
                    <%if (VPM.Prev != null)
                      {
                          if (VPM.Prev > 0)
                          {%>
                    <a class="btn" style="margin-right: 20px; width: 60px;" href="http://<%: Request.Url.Host%>/p/<%: VPM.Prev.ToString()%>">
                        Previous</a><%}
                      }%>
                    <%if (VPM.Next != null)
                      {
                          if (VPM.Next > 0)
                          {%><a class="btn" style="width: 60px;" href="http://<%: Request.Url.Host%>/p/<%: VPM.Next.ToString()%>">Next</a><%}
                      }%>
                </p>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <h4 class="sectionheading">
                        Popular Photos</h4>
                    <% 
                        foreach (PictureModel a in VPM.Related)
                        {
                    %>
                    <div class="adjusting-block">
                        <a href="http://<%: Request.Url.Host %>/p/<%: a.ID %>?title=<%: Utility.Slugify(a.Title) %>&ref=popularphoto">
                            <div style="width: 100%; max-height: 150px; overflow: hidden;">
                                <img src="<%: a.ImageURL %>" alt="" /></div>
                            <%: a.Title%>
                        </a><span class="label label-info">
                            <%: a.Viewed%>
                            Views</span>
                    </div>
                    <%} %>
                </div>
            </div>
            <div class="row-fluid hidden-phone">
                <div class="span12">
                    <h4>
                        <span class="sectionheading">Comments</span></h4>
                    <div class="fb-comments" data-href="http://<%: Request.Url.Host %>/p/<%: VPM.Current.ID %>"
                        data-width="600" data-num-posts="50" data-colorscheme="dark">
                    </div>
                </div>
            </div>
        </div>
        <div class="span3">
            <h4>
                <span class="sectionheading">Connect With Us</span>
            </h4>
            <div>
                <img alt="Facebook" id="facebookbutton" data-bubbleid="facebooklikebox" src="http://www.rockying.com/bootstrap/img/icons/social_facebook_box_white_32.png" />
                <a href="https://plus.google.com/105807062026940382320" target="_blank">
                    <img alt="Google+" src="http://www.rockying.com/bootstrap/img/icons/social_google_box_white_32.png" /></a>
                <img alt="twitter" id="twitterbutton" data-bubbleid="twitterfollowbox" src="http://www.rockying.com/bootstrap/img/icons/social_twitter_box_white_32.png" />
                <a href="http://www.rockying.com/rss" target="_blank">
                    <img alt="twitter" src="http://www.rockying.com/bootstrap/img/icons/social_rss_box_white_32.png" /></a>
                <div id="twitterfollowbox" class="rst-bubble">
                    <div class="rst-bubble-body">
                        <iframe allowtransparency="true" frameborder="0" scrolling="no" src="//platform.twitter.com/widgets/follow_button.html?screen_name=rockyingmag"
                            style="width: 300px; height: 20px;"></iframe>
                    </div>
                </div>
                <div id="facebooklikebox" class="rst-bubble" style="width: 315px;">
                    <div class="rst-bubble-body">
                        <div class="fb-like-box" data-href="http://www.facebook.com/rockyingmag" data-width="292"
                            data-show-faces="true" data-stream="false" data-header="false">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
