<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminSite.master" AutoEventWireup="true" CodeFile="ManageBook.aspx.cs" Inherits="Admin_ManageBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-md-6">
            <h3>Manage Book</h3>
            <div class="mb-2">
                
                <asp:HiddenField ClientIDMode="Static" ID="CoverPageHdn" runat="server" />
                <img src='<%= CoverPageHdn.Value %>' alt="" id="coverpageimg" class="img-fluid d-block" style="max-width:200px" />
                <br />
                <button onclick="clearCoverPage()" type="button" class="btn btn-dark btn-sm mb-2">Clear Image</button>
                <label class="form-label">
                    Cover Page</label>
                <input type="file" class="form-control" id="coverpagefile" onchange="handleImage(event);" />
                <script>

                    function clearCoverPage() {
                        document.getElementById("coverpageimg").src = "";
                        document.getElementById("CoverPageHdn").value = ""
                    }
                    function handleImage(e) {
                        reader = new FileReader();
                        reader.onload = function (event) {
                            document.getElementById("coverpageimg").src = event.target.result;
                            document.getElementById("CoverPageHdn").value = event.target.result;
                        }
                        reader.readAsDataURL(e.target.files[0]);
                    }
                </script>
            </div>
            <div class="mb-2">
                <label class="form-label" for="<%: TitleTextBox.ClientID %>">
                    Title</label>
                <asp:TextBox CssClass="form-control" ID="TitleTextBox" MaxLength="1000" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="TitleReqVal" ValidationGroup="VideoGrp" ControlToValidate="TitleTextBox"
                    runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="mb-2">
                <label class="form-label">Description</label>
                <asp:TextBox CssClass="form-control" ID="DescTextBox" MaxLength="3000" TextMode="MultiLine" Rows="5" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="VideoGrp" ControlToValidate="DescTextBox"
                    runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="mb-2">
                <label class="form-label">Author</label>
                <asp:TextBox CssClass="form-control" ID="AuthorTextBox" MaxLength="2000" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ValidationGroup="VideoGrp" ControlToValidate="AuthorTextBox"
                    runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="mb-2">
                <label class="form-label">ISBN 13</label>
                <asp:TextBox CssClass="form-control" ID="ISBN13TextBox" MaxLength="20" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="VideoGrp" ControlToValidate="ISBN13TextBox"
                    runat="server" ErrorMessage="Required" CssClass="text-danger" Display="Dynamic"
                    SetFocusOnError="True"></asp:RequiredFieldValidator>
            </div>
            <div class="mb-2">
                <label class="form-label">ISBN 10</label>
                <asp:TextBox CssClass="form-control" ID="ISBN10TextBox" MaxLength="20" runat="server"></asp:TextBox>
            </div>
            <div class="mb-2">
                <label class="form-label">Pages</label>
                <asp:TextBox CssClass="form-control" ID="PageCountTextBox" MaxLength="5" runat="server"></asp:TextBox>
            </div>
            <div class="mb-2">
                <label class="form-label">Publish Date</label>
                <asp:TextBox CssClass="form-control" ID="PublishDateTextBox" MaxLength="15" runat="server"></asp:TextBox>
            </div>
            <div class="mb-2">
                <label class="form-label">Publisher</label>
                <asp:TextBox CssClass="form-control" ID="PublisherTextBox" MaxLength="250" runat="server"></asp:TextBox>
            </div>
            <div class="mb-2">
                <label class="form-label">Categories</label>
                <asp:TextBox CssClass="form-control" ID="CategoriesTextBox" MaxLength="500" runat="server"></asp:TextBox>
            </div>
            <div class="mb-2">
                <label class="form-label">Identifiers</label>
                <asp:TextBox CssClass="form-control" ID="IdentifiersTextBox" MaxLength="2000" runat="server"></asp:TextBox>
            </div>
            <div class="mb-2">
                <asp:Button ID="SaveButton" runat="server" Text="Save Book" CssClass="btn btn-primary" ValidationGroup="VideoGrp" OnClick="SaveButton_Click" />
            </div>
        </div>
    </div>
</asp:Content>

