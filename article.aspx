<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="article.aspx.cs" Inherits="_Article" %>

<%@ Import Namespace="Rockying.Models" %>

<asp:Content ID="conten3" ContentPlaceHolderID="TopContent" runat="server">
    <title><%: string.IsNullOrEmpty(PPM.Item.MetaTitle) ? PPM.Item.Title : PPM.Item.MetaTitle %></title>
    <meta name="description" content="<%: PPM.Item.OGDescription %>" />
    <meta name="keywords" content="<%: PPM.Item.Tag %>" />
    <meta name="author" content="<%: PPM.Item.WriterName %>" />
    <meta property="og:type" content="article" />
    <meta property="og:url" content="http://<%: Request.Url.Host %>/a/<%: PPM.Item.URL.ToString() %>" />
    <meta property="og:site_name" content="<%: Utility.SiteName %>" />
    <meta property="fb:admins" content="871950590" />
    <meta property="og:title" content="<%: string.IsNullOrEmpty(PPM.Item.MetaTitle) ? PPM.Item.Title : PPM.Item.MetaTitle %>" />
    <meta property="og:description" content="<%: PPM.Item.OGDescription %>" />
    <meta property="og:image" content="<%: PPM.Item.OGImage %>" />

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <!--<link href="//www.rudrasofttech.com/js-tools/bubble/bubble.css" rel="stylesheet"
        type="text/css" />
    <script src="//www.rudrasofttech.com/js-tools/bubble/bubble.js" type="text/javascript"></script>-->
    <script src="//code.jquery.com/ui/1.10.3/jquery-ui.js" type="text/javascript"></script>
    <%if (PPM.Item.Text != null && PPM.Item.Text.Contains("rstquestion"))
        { %>
    <link href="//www.rockying.com/bootstrap/css/customquestion.css" rel="stylesheet"
        type="text/css" />
    <link href="//www.rudrasofttech.com/js-tools/question/question.css" rel="stylesheet"
        type="text/css" />
    <script src="//<%: Request.Url.Host %>/bootstrap/js/rstquestion.js" type="text/javascript"></script>
    <script src="//www.rudrasofttech.com/js-tools/question/question.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(window).load(function () {
            $(".rstquestion").question({ Attempts: 3, Effect: false });
        });
    </script>
    <%} %>
    <%if (PPM.Item.Text != null && PPM.Item.Text.Contains("slideshow"))
        { %>
    <link href="//www.rudrasofttech.com/js-tools/slideshow/slides.css" rel="stylesheet"
        type="text/css" />
    <script src="//www.rudrasofttech.com/js-tools/slideshow/slides.js" type="text/javascript"></script>
    <script src="//www.rudrasofttech.com/js-tools/swipe/swipe.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(window).load(function () {
            $(".slideshow").slides({ ItemSelector: ".slide", ScrollInterval: 60000, Circular: true, HoverPause: true, NextHandle: $("#nextslide"), PrevHandle: $("#prevslide") });
        });
    </script>
    <style type="text/css">
        .slideshow {
            width: 100%;
            background-color: #fff;
            overflow: hidden;
        }
    </style>
    <%} %>
    <script type="text/javascript">
        $(window).load(function () {
            $(".youtube").modalbox({
                Type: 'iframe',
                Width: 560,
                Height: 315,
                Modal: true
            });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row-fluid">
        <div class="span9">
            <h1>
                <%: PPM.Item.Title%>
            </h1>
            <p class="smalltxt" style="color: #333333;">
                Written By <%: PPM.Item.WriterName%>, 
                <%if (PPM.ArticleCategory == null)
                    { %>
                <%: PPM.Item.CategoryName%> Story
                <%}
                    else
                    { %><a href="<%= string.Format("../{0}/index", PPM.ArticleCategory.UrlName) %>"><%: PPM.Item.CategoryName%> Story</a>
                <%} %>
            </p>
            <%
                //articles created by admin have their own images.
                if (PPM.ArticleCreator.UserType != (byte)MemberTypeType.Admin)
                { %>
            <div style="text-align: center;">
                <img src="<%: PPM.Item.OGImage %>" class="img-rounded" alt="" style="margin-top: 5px; margin-bottom: 10px;" />
            </div>
            <%} %>
            <div id="article">
                <%= PPM.Item.Text %>
            </div>
            <h4 style="margin-top: 20px;">
                <span class="sectionheading">Share It</span>
            </h4>
            <div class="addthis_inline_share_toolbox"></div>
            <div style="margin: 10px 0px;">
                <iframe src="//www.rockying.com/account/subscribe" style="width: 100%; height: 300px; border: 0px;"></iframe>
            </div>
            <div id="disqus_thread"></div>
            <script>

                /**
                *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
                *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
                /*
                var disqus_config = function () {
                this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
                this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
                };
                */
                (function () { // DON'T EDIT BELOW THIS LINE
                    var d = document, s = d.createElement('script');
                    s.src = 'https://rockying.disqus.com/embed.js';
                    s.setAttribute('data-timestamp', +new Date());
                    (d.head || d.body).appendChild(s);
                })();
            </script>
            <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>

            <script type="text/javascript">
                /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
                var disqus_shortname = 'rockying'; // required: replace example with your forum shortname

                /* * * DON'T EDIT BELOW THIS LINE * * */
                (function () {
                    var s = document.createElement('script'); s.async = true;
                    s.type = 'text/javascript';
                    s.src = '//' + disqus_shortname + '.disqus.com/count.js';
                    (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
                }());
            </script>
        </div>
        <div class="span3">
            <h6>
                <span class="sectionheading">Connect With Us</span>
            </h6>
            <!-- Go to www.addthis.com/dashboard to customize your tools -->
            <div class="addthis_inline_follow_toolbox"></div>
            <h6>
                <span class="sectionheading">Recommendations</span>
            </h6>
            <%if (PPM.NextByWriter != null)
                { %>
            <div class="adjusting-block">
                <%if (!string.IsNullOrEmpty(PPM.NextByWriter.OGImage))
                    { %>
                <a href="//www.rockying.com/a/<%: PPM.NextByWriter.URL %>">
                    <span style="display: block; width: 100%; max-height: 250px; overflow: hidden;">
                        <img src="<%: Utility.TrimStartHTTP(PPM.NextByWriter.OGImage) %>" alt="" />
                    </span>
                </a>
                <%} %>

                <h5 class="refertitle">
                    <a href="//www.rockying.com/a/<%: PPM.NextByWriter.URL %>">
                        <%: PPM.NextByWriter.Title %>
                    </a>
                </h5>
                <div style="text-align: center; margin-bottom:5px;"><%:PPM.NextByWriter.Category1.Name %> Story By <%: PPM.NextByWriter.WriterName %></div>
                <p style="text-align: justify;"><%: PPM.NextByWriter.OGDescription %></p>
            </div>
            <br />
            <%} %>

            <%if (PPM.PrevByWriter != null)
                { %>

            <div class="adjusting-block">
                <%if (!string.IsNullOrEmpty(PPM.PrevByWriter.OGImage))
                    { %>
                <a href="//www.rockying.com/a/<%= PPM.PrevByWriter.URL %>">
                    <span style="display: block; width: 100%; max-height: 250px; overflow: hidden;">
                        <img src="<%= Utility.TrimStartHTTP(PPM.PrevByWriter.OGImage) %>" alt="" />
                    </span>
                </a>
                <%} %>
                <h5 class="refertitle"><a href="//www.rockying.com/a/<%= PPM.PrevByWriter.URL %>">
                    <%: PPM.PrevByWriter.Title %>
                </a></h5>
                <div style="text-align: center; margin-bottom:5px;"><%:PPM.PrevByWriter.Category1.Name %> Story By <%: PPM.PrevByWriter.WriterName %></div>
                <p style="text-align: justify;"><%: PPM.PrevByWriter.OGDescription %></p>
            </div>
            <br />
            <%} %>
            <%if (PPM.RecommendationList.Count > 0)
                { %>
            <%foreach (Article p in PPM.RecommendationList)
                { %>
            <div class="adjusting-block">
                <a href="//www.rockying.com/a/<%= p.URL %>">
                    <div style="width: 100%; max-height: 250px; overflow: hidden;">

                        <img src="<%= Utility.TrimStartHTTP(p.OGImage) %>" alt="" />
                    </div>
                </a>

                <h5 class="refertitle"><a href="//www.rockying.com/a/<%= p.URL %>">
                    <%: p.Title %>
                </a></h5>
                <div style="text-align: center; margin-bottom:5px;">Story By <%: p.WriterName %></div>
                <p style="text-align: justify;"><%: p.OGDescription %></p>
            </div>
            <%} %>
            <%} %>
        </div>
    </div>
    <% if (CurrentUser != null)
        {
            if (CurrentUser.UserType == (byte)MemberTypeType.Admin || CurrentUser.ID == PPM.Item.CreatedBy)
            {%>
    <div style="padding-left: 10px; padding-top: 5px; padding-bottom: 5px; padding-right: 10px; position: fixed; top: auto; bottom: 0px; left: 0px; right: auto; background-color: #fff;">
        <a href="//<%: Request.Url.Host%>/Admin/ManageArticle.aspx?id=<%: PPM.Item.ID.ToString()%>&mode=edit"
            target="_blank">Edit</a>
    </div>
    <% }
        }%>
</asp:Content>
