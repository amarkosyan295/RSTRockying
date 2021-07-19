<%@ Page Language="C#" AutoEventWireup="true" Trace="false" TraceMode="SortByCategory" EnableViewState="false" CodeFile="subscribe.aspx.cs" Inherits="control_subscribe" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link href="https://fonts.googleapis.com/css?family=Lato|Roboto" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous" />
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    <script
        src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha256-3edrmyuQ0w65f8gfBsqowzjJe2iM6n0nKciPUp8y+7E="
        crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Lato', sans-serif;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Roboto', sans-serif;
        }
        .form-control{
            border-radius:0px;
        }
    </style>
</head>
<body>
    <div class="container-fluid" style="padding: 0px;">
        <div style="border: 1px solid gainsboro;">
            <h3 style="background-color:#000;color:#fff; padding:5px;">Get Our Latest Post In Your Inbox</h3>
            <form id="form1" runat="server" class="needs-validation" novalidate style="padding:5px;">
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <input type="text" class="form-control" id="nametxt" placeholder="Name" value="" required="required" runat="server" enableviewstate="false" />

                        <div class="invalid-feedback">
                            Name Required!
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <input type="email" class="form-control" id="emailtxt" placeholder="Email" name="emailtxt" required="required" enableviewstate="false" />
                        <div class="invalid-feedback">
                            Email Required!
                        </div>
                    </div>
                </div>
                <asp:Button ID="SubmitBtn" CssClass="btn btn-success" runat="server" Text="Subscribe" OnClick="SubmitBtn_Click" />
                <p>
                    We respect your privacy and your email address is safe with us. Check our <a target="_blank" href="http://www.rockying.com/Terms-Of-Use">terms and conditions</a> & <a href="http://www.rockying.com/PrivacyPolicy" target="_blank">privacy policy</a>
                </p>
                <%if (ShowMessage)
                    { %>
                <div class="alert alert-success fixed-bottom" id="message" role="alert" style="margin-top: 20px;">
                    Thanks for signing up with Rockying, we have sent an email with activation link. 
                Please go to that link to activate your subscription.
                </div>
                <script>
                    setTimeout(function () { $("#message").remove(); }, 2000);
                </script>
                <%} %>
            </form>
        </div>
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
