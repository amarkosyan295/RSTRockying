<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="article.aspx.cs" Inherits="_Article" %>

<%@ Import Namespace="Rockying.Models" %>

<asp:Content ID="conten3" ContentPlaceHolderID="TopContent" runat="server">
    <title><%: string.IsNullOrEmpty(PPM.Item.MetaTitle) ? PPM.Item.Title : PPM.Item.MetaTitle %></title>
    <meta name="description" content="<%: PPM.Item.OGDescription %>" />
    <meta name="keywords" content="<%: PPM.Item.Tag %>" />
    <meta name="author" content="<%: PPM.Item.WriterName %>" />
    <meta property="og:type" content="article" />
    <meta property="og:url" content="https://<%: Request.Url.Host %>/a/<%: PPM.Item.URL.ToString() %>" />
    <meta property="og:site_name" content="<%: Utility.SiteName %>" />
    <meta property="fb:admins" content="871950590" />
    <meta property="og:title" content="<%: string.IsNullOrEmpty(PPM.Item.MetaTitle) ? PPM.Item.Title : PPM.Item.MetaTitle %>" />
    <meta property="og:description" content="<%: PPM.Item.OGDescription %>" />
    <meta property="og:image" content="<%: PPM.Item.OGImage %>" />
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .checked {
            color: orange;
        }
    </style>
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
    <link href="//www.rudrasofttech.com/js-tools/bubble/bubble.css" rel="stylesheet" type="text/css" />
    <script src="//www.rudrasofttech.com/js-tools/bubble/bubble.js" type="text/javascript"></script>
    <% if (!string.IsNullOrEmpty(PPM.AudioURL))
        { %>
    <script src="//www.rockying.com/bootstrap/js/htmlslider.js" type="text/javascript"></script>
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
        <div class="span12" style="text-align: center;">
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
                <%if (PostRating > 0 && PostRating <= 1)
                    { %>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <%}
                    else if (PostRating > 1 && PostRating <= 2)
                    {%>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <%}
                    else if (PostRating > 2 && PostRating <= 3)
                    {%>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <%}
                    else if (PostRating > 3 && PostRating <= 4)
                    {%>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star"></span>
                <%}
                    else if (PostRating > 4 && PostRating <= 5)
                    {%>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <span class="fa fa-star checked"></span>
                <%} %>
            </p>
            <%
                //articles created by admin have their own images.
                if (PPM.ArticleCreator.UserType != (byte)MemberTypeType.Admin)
                { %>
            <div class="text-center">
                <img src="<%: PPM.Item.OGImage %>" class="img-rounded mx-2" alt="" />
            </div>
            <%} %>
            <% 
                //this html will only be added if there is an audio avialable
                if (!string.IsNullOrEmpty(PPM.AudioURL))
                { %>
            <div style="padding: 5px; background: #f8f9fa; text-align: center; max-width: 80%; border-radius: 10px; position: fixed; bottom: 2px; width: 300px; left: 50%; margin-left: -150px;">
                <h4>You can listen to this story</h4>
                <table style="width: 100%;">
                    <tbody>
                        <tr>
                            <td style="width: 30px;">
                                <button class="btn btn-danger show" type="button" id="btnPlay" onclick="playStoryAudio();"><i class="icon-play icon-white"></i></button>
                                <button class="btn btn-danger hide" id="btnPause" type="button" onclick="pauseStoryAudio();"><i class="icon-pause icon-white"></i></button>
                            </td>
                            <td style="width: 30px;"><span id="currenttime" class="label">0</span></td>
                            <td>
                                <input type="range" id="rngSeek" min="0" value="0" onchange="changeSeek(this.value)" /></td>
                            <td style="width: 30px;"><span id="totaltime" class="label"></span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <script>
                var saudio = new Audio('<%= PPM.AudioURL %>');
                saudio.onloadedmetadata = function () {
                    $('#totaltime').html(parseInt(saudio.duration, 10));
                }
                saudio.ontimeupdate = function () {
                    $('#rngSeek').val(saudio.currentTime);
                    $('#currenttime').html(parseInt(saudio.currentTime, 10));
                }
                saudio.onplay = function () {
                    $("#btnPlay").removeClass("show").addClass("hide");
                    $("#btnPause").removeClass("hide").addClass("show").focus();
                    $('#rngSeek').attr('max', saudio.duration);
                    $('#totaltime').html(parseInt(saudio.duration, 10));

                }
                saudio.onpause = function () {
                    $("#btnPause").removeClass("show").addClass("hide");
                    $("#btnPlay").removeClass("hide").addClass("show").focus();
                }
                function changeSeek(val) {
                    saudio.currentTime = val;
                }
                function playStoryAudio() {
                    saudio.play();
                }
                function pauseStoryAudio() {
                    saudio.pause();
                }
            </script>
            <%} %>
            <div id="article">
                <%= PPM.Item.Text %>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <h4>Rate The Story
                    </h4>
                    <div style="margin: 10px 0px; text-align: center;">
                        <div class="btn-toolbar" style="margin: 0;">
                            <div class="btn-group" data-bubbleid="ratingbubble" id="ratingbtngrp">
                                <button type="button" id="btn1star" class="btn btn-large" onclick="postRating(1)" onmouseover="toggleCheckedStar(1, true)" onmouseout="toggleCheckedStar(1, false)">1 <span class="fa fa-star"></span></button>
                                <button type="button" id="btn2star" class="btn btn-large" onclick="postRating(2)" onmouseover="toggleCheckedStar(2, true)" onmouseout="toggleCheckedStar(2, false)">2 <span class="fa fa-star"></span></button>
                                <button type="button" id="btn3star" class="btn btn-large" onclick="postRating(3)" onmouseover="toggleCheckedStar(3, true)" onmouseout="toggleCheckedStar(3, false)">3 <span class="fa fa-star"></span></button>
                                <button type="button" id="btn4star" class="btn btn-large" onclick="postRating(4)" onmouseover="toggleCheckedStar(4, true)" onmouseout="toggleCheckedStar(4, false)">4 <span class="fa fa-star"></span></button>
                                <button type="button" id="btn5star" class="btn btn-large" onclick="postRating(5)" onmouseover="toggleCheckedStar(5, true)" onmouseout="toggleCheckedStar(5, false)">5 <span class="fa fa-star"></span></button>
                            </div>
                        </div>
                        <div class="rst-bubble" id="ratingbubble">
                            <div class="rst-bubble-body" style="width: 300px; max-height: 300px;">
                                Please give a star rating to this story. You can click any button to give your desired rating.
                                <button type="button" onclick='$("#ratingbtngrp").bubble("close");' class="btn btn-small">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h4>Share It
                    </h4>
                    <div class="addthis_inline_share_toolbox" id="shareitbtngrp" data-bubbleid="shareitbubble"></div>
                    <div class="rst-bubble" id="shareitbubble">
                        <div class="rst-bubble-body" style="width: 300px; max-height: 300px;">
                            Share this story with your friends.
                                <button type="button" onclick='$("#shareitbtngrp").bubble("close");' class="btn btn-small">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin: 10px 0px;">
                <iframe src="//<%: Request.Url.Port != 80 ? Request.Url.Host + ":" + Request.Url.Port : Request.Url.Host %>/account/subscribe" style="width: 100%; height: 300px; border: 0px;"></iframe>
            </div>
            <h4 style="text-align: left;">Reader Views
            </h4>
            <div id="disqus_thread" style="padding: 15px;"></div>
            <script type="text/javascript">

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
    </div>
    <%if (PPM.RecommendationList.Count > 0)
        { %>

    <h6>Story Recommendations</h6>
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <%foreach (Article p in PPM.RecommendationList)
            { %>
        <div class="col">
            <div class="card h-100">
                <%if (!string.IsNullOrEmpty(p.OGImage))
                    { %>
                <a href="//<%: Request.Url.Port != 80 ? Request.Url.Host + ":" + Request.Url.Port : Request.Url.Host %>/a/<%= p.URL %>">
                    <img src="<%: p.OGImage %>" class="card-img-top" alt="" />
                </a>
                <%} %>
                <div class="card-body">
                    <h5 class="card-title"><a href="//<%: Request.Url.Port != 80 ? Request.Url.Host + ":" + Request.Url.Port : Request.Url.Host %>/a/<%= p.URL %>" class="text-decoration-none text-dark">
                        <%: p.Title %>
                    </a></h5>
                    <p class="card-text"><%:p.OGDescription %></p>
                </div>
            </div>
        </div>
        <%} %>
    </div>
    <%} %>
    <% if (CurrentUser != null)
        {
            if (CurrentUser.UserType == (byte)MemberTypeType.Admin || CurrentUser.ID == PPM.Item.CreatedBy)
            {%>
    <div style="padding-left: 10px; padding-top: 5px; padding-bottom: 5px; padding-right: 10px; position: fixed; top: auto; bottom: 0px; left: 0px; right: auto; background-color: #fff;">
        <a href="../../Admin/ManageArticle.aspx?id=<%: PPM.Item.ID.ToString()%>&mode=edit"
            target="_blank">Edit</a>
    </div>
    <% }
        }
    %>
</asp:Content>
<asp:Content ContentPlaceHolderID="BottomContent" ID="Content3" runat="server">
    <script>
        var RatingAction = { count: 0, status: "" };
        $(document).ready(
            function () {
                $("#shareitbtngrp").bubble({ Position: 'bottom' });
                $("#ratingbtngrp").bubble({ Position: 'bottom', OnClose: function () { $("#shareitbtngrp").bubble("open"); } });
            }
        );
        //if (sessionStorage.getItem("subscribeshown") == null) {
        //    setTimeout(function () { $("#subscribeBtn").click(); sessionStorage.setItem("subscribeshown", "true"); }, 5000);
        //}

        function toggleCheckedStar(val, toggle) {
            for (i = 1; i <= val; i++) {
                if (toggle) {
                    $("#btn" + i + "star > span.fa.fa-star").addClass("checked");
                } else {
                    $("#btn" + i + "star > span.fa.fa-star").removeClass("checked");
                }
            }
        }

        function postRating(val) {
            $.post("//www.rockying.com/handlers/rating.ashx",
                { star: val, post: parseInt("<%= PPM.Item.ID.ToString()%>", 10), comment: '', ip: visit.ip, visitid: visit.id, action: "add" },
                function () { }).done(function () {
                    RatingAction.status = "success";
                    for (i = 1; i <= 5; i++) {
                        $("#btn" + i + "star > span.fa.fa-star").removeClass("checked");
                    }

                    for (i = 1; i <= val; i++) {
                        $("#btn" + i + "star > span.fa.fa-star").addClass("checked");
                    }
                });
        }


        function TakeAction() {
            if (visit.timespent / 1000 >= 10 && isScrolledIntoView($("#ratingbtngrp").get(0))) {
                if (RatingAction.status != "success" && (RatingAction.count >= 0 && RatingAction.count < 5)) {
                    setTimeout(function () { $("#ratingbtngrp").bubble('open'); }, RatingAction.count * 2000);
                    RatingAction.count += 1;
                }
            }
        }

        function isScrolledIntoView(elem) {
            var docViewTop = $(window).scrollTop();
            var docViewBottom = docViewTop + $(window).height();

            var elemTop = $(elem).offset().top;
            var elemBottom = elemTop + $(elem).height();

            return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
        }

        setInterval(TakeAction, 2000);

    </script>
</asp:Content>
