<%@ Page Title="Rockying" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Import Namespace="Rockying.Models" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div class="row-fluid">
        <div class="span8">
            <div class="rst-scroller" id="carousel1" style="width: 100%; height: 100px;">
                <%
                    foreach (Article a in HPM.HeroList)
                    { %>
                <div class="rst-scroller-item">
                    <div style="padding: 5px; width: 300px; height: 100%;">
                        <!--<a href="http://<%: Request.Url.Host %>/a/<%: a.ID.ToString() %>?ref=homecar">
                            <img src="<%: a.OGImage %>" alt="" style="height: 100px; max-width: 200px;" /></a>
                        <div style="position: absolute; right: 0; bottom: 0; left: 0; margin: 5px; font-size: 11px;
                            font-weight: bold; color: #fff; background-color: rgba(0, 0, 0, 0.60)">
                            <%: a.Title %>
                        </div>-->
                        <div class="row-fluid">
                            <div class="span6">
                                <a href="http://<%: Request.Url.Host %>/a/<%: a.ID.ToString() %>?ref=homecar">
                                    <img src="<%: a.OGImage %>" alt="" /></a></div>
                            <div class="span6">
                                <small>
                                    <%: a.Title %></small>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <div class="rst-slides" style="width: 100%; min-height: 300px;">
                <%
                    foreach (Article a in HPM.HeroList)
                    { %>
                <div class="rst-slide" style="height: auto;">
                    <a href="http://<%: Request.Url.Host %>/a/<%: a.ID.ToString() %>?ref=homeslide">
                        <img src="<%: a.OGImage %>" alt="" style="width: 100%;" /></a>
                    <div class="carousel-caption">
                        <h4>
                            <%: a.Title %></h4>
                        <p>
                            <%: a.OGDescription %></p>
                    </div>
                </div>
                <% } %>
            </div>
            <br />
        </div>
        <div class="span4">
            <div class="adjusting-block" style="width: 250px;">
                <a href="http://www.rockying.com/a/207?title=the-modern-indian-inventors&ref=home">
                    <img src="http://www.rudrasofttech.com/rockying/art/Initiative/Modern-Inventors/Dr-Kalam-Home-page.jpg"
                        alt="" /></a> <a href="http://www.rockying.com/a/207?title=the-modern-indian-inventors&ref=home">
                            <h4>
                                The Modern Indian Inventors</h4>
                        </a>
                <p>
                    Life gave them lemons. And they turned them into as perfect lemonades. They are
                    the ones that felt the necessity to invent. They took the initiative to not only
                    mend their own torn shoes but also the society’s.</p>
                <span class="label label-info">Viewed 1702 Times</span>
            </div>
            <div class="adjusting-block" style="width: 250px;">
                <a href="http://www.rockying.com/a/163?title=jugaad-or-a-common-mans-innovation&ref=home">
                    <img src="http://rudrasofttech.com/rockying/art/Initiative/Mansukhbhai-Mitticool-initiative/Mansukhbhai-Prajapati-of-Mitti-Cool.jpg"
                        alt="" /></a> <a href="http://www.rockying.com/a/163?title=jugaad-or-a-common-mans-innovation&ref=home">
                            <h4>
                                Jugaad? Or a Common Man’s Innovation?</h4>
                        </a>
                <p>
                    Mansukh Prajapati was not looking for some competitive advantage with Mitticool
                    but was trying to respond to the turbulent times in Gujarat.He is a potter by profession
                    and his experimentation with durable goods and clay has given birth to the Mitticool
                    refrigerator that runs without electricity...</p>
                <span class="label label-info">Viewed 1155 Times</span>
            </div>
        </div>
    </div>
</asp:Content>
