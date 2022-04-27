<%@ Page Language="C#" AutoEventWireup="true" Trace="false" TraceMode="SortByCategory" EnableViewState="true" CodeFile="subscribe.aspx.cs" Inherits="control_subscribe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="https://fonts.googleapis.com/css?family=Merriweather:400,900|Open+Sans:400,700 " rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script
        src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha256-3edrmyuQ0w65f8gfBsqowzjJe2iM6n0nKciPUp8y+7E="
        crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Merriweather', sans-serif;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Merriweather', sans-serif;
        }

        .form-control {
            border-radius: 0px;
        }
    </style>
</head>
<body>
    <div class="container-fluid p-3" >
        <h3>Get Our Latest Post In Your Inbox</h3>
        <form id="form1" runat="server" class="needs-validation" novalidate style="padding: 5px;">
            <div class="form-row">
                <!--<div class="col-md-6 mb-3">
                    <input type="text" class="form-control" id="nametxt" placeholder="Name" value="" required="required" runat="server" enableviewstate="false" />

                    <div class="invalid-feedback">
                        Name Required!
                    </div>
                </div>-->
                <div class="col-md-6 mb-3">
                    <input type="email" class="form-control" id="emailtxt" placeholder="Email" name="emailtxt" required="required" enableviewstate="true" value="<%= email %>" />
                    <div class="invalid-feedback">
                        Email Required!
                    </div>

                </div>
                <div class="col-md-1 mb-3">
                    <asp:Button ID="GenerateOTPBtn" CssClass="btn btn-primary" runat="server" Text="Get OTP" OnClick="GenerateOTPBtn_Click" /></div>
                <asp:PlaceHolder ID="OTPPlaceHolder" Visible="false" runat="server">
                    <div class="col-md-2 mb-3">
                        <input type="text" maxlength="20" class="form-control" id="otptxt" placeholder="OTP" name="otptxt" required="required" enableviewstate="true" />
                        <div class="invalid-feedback">
                            OTP Required!
                        </div>
                    </div>
                </asp:PlaceHolder>

            </div>
            <asp:Button ID="SubmitBtn" Visible="false" CssClass="btn btn-success" runat="server" Text="Subscribe" OnClick="SubmitBtn_Click" />
            <p>
                We respect your privacy and your email address is safe with us. Check our <a target="_blank" href="http://www.rockying.com/Terms-Of-Use">terms and conditions</a> & <a href="http://www.rockying.com/PrivacyPolicy" target="_blank">privacy policy</a>
            </p>
            <asp:PlaceHolder ID="OTPMessagePlaceHolder" Visible="false" EnableViewState="false" runat="server">
                <div class="alert alert-info" role="alert" style="margin-top: 20px;">
                    You will receive an OTP in email from <strong><%= Rockying.Models.Utility.NewsletterEmail %></strong>, please provide this OTP so that your email address is verified.
                                You may have to check the "SPAM" folder of your mail account for the email.
                </div>
            </asp:PlaceHolder>
            <asp:PlaceHolder ID="OTPMistmatchPlaceHolder" Visible="false" EnableViewState="false" runat="server">
                <div class="alert alert-danger fixed-bottom" role="alert" style="margin-top: 20px;">
                    OTP mismatch.
                </div>
            </asp:PlaceHolder>
            <%if (ShowMessage)
                { %>
            <div class="alert alert-success" id="message" role="alert" style="margin-top: 20px;">
                Thanks for signing up with Rockying.
            </div>
            <script>
                setTimeout(function () { $("#message").remove(); }, 10000);
            </script>
            <%} %>
        </form>

    </div>
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (function () {
            'use strict';
            window.addEventListener('load', function () {
                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.getElementsByClassName('needs-validation');
                // Loop over them and prevent submission
                var validation = Array.prototype.filter.call(forms, function (form) {
                    form.addEventListener('submit', function (event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();
    </script>
    <style>
        body::-webkit-scrollbar {
            width: 0.8em;
        }

        body::-webkit-scrollbar-track {
            box-shadow: none;
            background: none;
            -webkit-box-shadow: none;
        }

        body::-webkit-scrollbar-thumb {
            background-color: darkgrey;
            outline: 0px;
            border-radius: 5px;
        }
    </style>
</body>
</html>
