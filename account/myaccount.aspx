<%@ Page Title="My Account" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="myaccount.aspx.cs" Inherits="myaccount" %>

<%@ Register Src="../control/message.ascx" TagName="message" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="http://<%: Request.Url.Host %>/bootstrap/css/smoothness/jquery-ui-1.8.23.custom.css"
        rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row justify-content-center">
        <div class="col-6">
            <form runat="server" id="MainForm" class="form-horizontal span12">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <fieldset>
                    <legend >Account Info</legend>
                    <uc1:message Visible="false" ID="message1" runat="server" />
                    <div class="mb-3">
                        <label class="form-label">
                            Registered Email
                        </label>
                        <asp:TextBox MaxLength="100" CssClass="form-control" ID="EmailTextBox" ReadOnly="true" runat="server"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="<%: NameTextBox.ClientID %>">
                            First Name (Required)</label>
                        <asp:TextBox MaxLength="100" CssClass="form-control" ID="NameTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="NameReqVal" runat="server" Display="Dynamic" ControlToValidate="NameTextBox"
                            CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="<%: LastNameTextBox.ClientID %>">
                            Last Name (Required)</label>
                        <asp:TextBox MaxLength="100" CssClass="form-control" ID="LastNameTextBox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                            ID="RequiredFieldValidator5" runat="server" Display="Dynamic" ControlToValidate="LastNameTextBox"
                            CssClass="text-danger" ValidationGroup="logingrp" ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="<%: YearDropDown.ClientID %>">
                            Date of Birth (Required)</label>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="YearDropDown" CssClass="span3" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="YearDropDown_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Static"
                                    ControlToValidate="YearDropDown" CssClass="text-danger" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="MonthDropDown" CssClass="span2" runat="server" AutoPostBack="True"
                                    OnSelectedIndexChanged="MonthDropDown_SelectedIndexChanged">
                                    <asp:ListItem Value="1">Jan</asp:ListItem>
                                    <asp:ListItem Value="2">Feb</asp:ListItem>
                                    <asp:ListItem Value="3">Mar</asp:ListItem>
                                    <asp:ListItem Value="4">Apr</asp:ListItem>
                                    <asp:ListItem Value="5">May</asp:ListItem>
                                    <asp:ListItem Value="6">Jun</asp:ListItem>
                                    <asp:ListItem Value="7">Jul</asp:ListItem>
                                    <asp:ListItem Value="8">Aug</asp:ListItem>
                                    <asp:ListItem Value="9">Sep</asp:ListItem>
                                    <asp:ListItem Value="10">Oct</asp:ListItem>
                                    <asp:ListItem Value="11">Nov</asp:ListItem>
                                    <asp:ListItem Value="12">Dec</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Static"
                                    ControlToValidate="MonthDropDown" CssClass="text-danger" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <asp:DropDownList ID="DateDropDown" runat="server" CssClass="span2">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Static"
                                    ControlToValidate="DateDropDown" CssClass="text-danger" ValidationGroup="logingrp"
                                    ErrorMessage="*"></asp:RequiredFieldValidator>
                                <small>Please check our <a href="http://www.rockying.com/PrivacyPolicy" target="_blank">Privacy Policy</a></small>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="<%: CountryDropDown.ClientID %>">
                            Country (Required)</label>

                        <asp:DropDownList ID="CountryDropDown" CssClass="form-select" runat="server">
                            <asp:ListItem Selected="True" Value="">Country</asp:ListItem>
                            <asp:ListItem Value="USA">United States of America</asp:ListItem>
                            <asp:ListItem Value="CAN">Canada</asp:ListItem>
                            <asp:ListItem Value="GBR">United Kingdom</asp:ListItem>
                            <asp:ListItem Value="IND">India</asp:ListItem>
                            <asp:ListItem Value="AUS">Australia</asp:ListItem>
                            <asp:ListItem Value="IRL">Ireland</asp:ListItem>
                            <asp:ListItem Value="NZL">New Zealand</asp:ListItem>
                            <asp:ListItem Value="DEU">Germany</asp:ListItem>
                            <asp:ListItem Value="MEX">Mexico</asp:ListItem>
                            <asp:ListItem Value="NLD">Netherlands</asp:ListItem>
                            <asp:ListItem Value="NOR">Norway</asp:ListItem>
                            <asp:ListItem Value="DNK">Denmark</asp:ListItem>
                            <asp:ListItem Value="SWE">Sweden</asp:ListItem>
                            <asp:ListItem Value="ROU">Romania</asp:ListItem>
                            <asp:ListItem Value="FRA">France</asp:ListItem>
                            <asp:ListItem Value="ZAF">South Africa</asp:ListItem>
                            <asp:ListItem Value="UAE">United Arab Emirates</asp:ListItem>
                            <asp:ListItem Value="ITA">Italy</asp:ListItem>
                            <asp:ListItem Value="ESP">Spain</asp:ListItem>
                            <asp:ListItem Value="PRT">Portugal</asp:ListItem>
                            <asp:ListItem Value="">-----------------------</asp:ListItem>
                            <asp:ListItem Value="AFG">Afghanistan</asp:ListItem>
                            <asp:ListItem Value="ALB">Albania</asp:ListItem>
                            <asp:ListItem Value="DZA">Algeria</asp:ListItem>
                            <asp:ListItem Value="ASM">American Samoa</asp:ListItem>
                            <asp:ListItem Value="AND">Andorra</asp:ListItem>
                            <asp:ListItem Value="AGO">Angola</asp:ListItem>
                            <asp:ListItem Value="AIA">Anguilla</asp:ListItem>
                            <asp:ListItem Value="ATA">Antarctica</asp:ListItem>
                            <asp:ListItem Value="ATG">Antigua &amp; Barbuda</asp:ListItem>
                            <asp:ListItem Value="ARG">Argentina</asp:ListItem>
                            <asp:ListItem Value="ARM">Armenia</asp:ListItem>
                            <asp:ListItem Value="ABW">Aruba</asp:ListItem>
                            <asp:ListItem Value="AUT">Austria</asp:ListItem>
                            <asp:ListItem Value="AZE">Azerbaijan</asp:ListItem>
                            <asp:ListItem Value="BHS">Bahamas</asp:ListItem>
                            <asp:ListItem Value="BHR">Bahrain</asp:ListItem>
                            <asp:ListItem Value="BGD">Bangladesh</asp:ListItem>
                            <asp:ListItem Value="BRB">Barbados</asp:ListItem>
                            <asp:ListItem Value="BLR">Belarus</asp:ListItem>
                            <asp:ListItem Value="BEL">Belgium</asp:ListItem>
                            <asp:ListItem Value="BLZ">Belize</asp:ListItem>
                            <asp:ListItem Value="BEN">Benin</asp:ListItem>
                            <asp:ListItem Value="BMU">Bermuda</asp:ListItem>
                            <asp:ListItem Value="BTN">Bhutan</asp:ListItem>
                            <asp:ListItem Value="BOL">Bolivia</asp:ListItem>
                            <asp:ListItem Value="BIH">Bosnia &amp; Herzegovina</asp:ListItem>
                            <asp:ListItem Value="BWA">Botswana</asp:ListItem>
                            <asp:ListItem Value="BRA">Brazil</asp:ListItem>
                            <asp:ListItem Value="VGB">British Virgin Islands</asp:ListItem>
                            <asp:ListItem Value="IOT">British Indian Ocean Ter</asp:ListItem>
                            <asp:ListItem Value="BRN">Brunei</asp:ListItem>
                            <asp:ListItem Value="BGR">Bulgaria</asp:ListItem>
                            <asp:ListItem Value="BFA">Burkina Faso</asp:ListItem>
                            <asp:ListItem Value="BDI">Burundi</asp:ListItem>
                            <asp:ListItem Value="KHM">Cambodia</asp:ListItem>
                            <asp:ListItem Value="CMR">Cameroon</asp:ListItem>
                            <asp:ListItem Value="CPV">Cape Verde</asp:ListItem>
                            <asp:ListItem Value="CYM">Cayman Islands</asp:ListItem>
                            <asp:ListItem Value="CAF">Central African Republic</asp:ListItem>
                            <asp:ListItem Value="TCD">Chad</asp:ListItem>
                            <asp:ListItem Value="CHL">Chile</asp:ListItem>
                            <asp:ListItem Value="CHN">China</asp:ListItem>
                            <asp:ListItem Value="CXR">Christmas Island</asp:ListItem>
                            <asp:ListItem Value="CCK">Cocos Island</asp:ListItem>
                            <asp:ListItem Value="COL">Colombia</asp:ListItem>
                            <asp:ListItem Value="COM">Comoros</asp:ListItem>
                            <asp:ListItem Value="COK">Cook Islands</asp:ListItem>
                            <asp:ListItem Value="CRC">Costa Rica</asp:ListItem>
                            <asp:ListItem Value="HRV">Croatia</asp:ListItem>
                            <asp:ListItem Value="CUB">Cuba</asp:ListItem>
                            <asp:ListItem Value="CYP">Cyprus</asp:ListItem>
                            <asp:ListItem Value="CZE">Czech Republic</asp:ListItem>
                            <asp:ListItem Value="COD">Congo</asp:ListItem>
                            <asp:ListItem Value="DJI">Djibouti</asp:ListItem>
                            <asp:ListItem Value="DMA">Dominica</asp:ListItem>
                            <asp:ListItem Value="DOM">Dominican Republic</asp:ListItem>
                            <asp:ListItem Value="ECU">Ecuador</asp:ListItem>
                            <asp:ListItem Value="EGY">Egypt</asp:ListItem>
                            <asp:ListItem Value="SLV">El Salvador</asp:ListItem>
                            <asp:ListItem Value="GNQ">Equatorial Guinea</asp:ListItem>
                            <asp:ListItem Value="ERI">Eritrea</asp:ListItem>
                            <asp:ListItem Value="EST">Estonia</asp:ListItem>
                            <asp:ListItem Value="ETH">Ethiopia</asp:ListItem>
                            <asp:ListItem Value="FLK">Falkland Islands</asp:ListItem>
                            <asp:ListItem Value="FRO">Faroe Islands</asp:ListItem>
                            <asp:ListItem Value="FJI">Fiji</asp:ListItem>
                            <asp:ListItem Value="FIN">Finland</asp:ListItem>
                            <asp:ListItem Value="PYF">French Polynesia</asp:ListItem>
                            <asp:ListItem Value="GAB">Gabon</asp:ListItem>
                            <asp:ListItem Value="GMB">Gambia</asp:ListItem>
                            <asp:ListItem Value="GEO">Georgia</asp:ListItem>
                            <asp:ListItem Value="GHA">Ghana</asp:ListItem>
                            <asp:ListItem Value="GIB">Gibraltar</asp:ListItem>
                            <asp:ListItem Value="GRC">Greece</asp:ListItem>
                            <asp:ListItem Value="GRL">Greenland</asp:ListItem>
                            <asp:ListItem Value="GRD">Grenada</asp:ListItem>
                            <asp:ListItem Value="GUM">Guam</asp:ListItem>
                            <asp:ListItem Value="GTM">Guatemala</asp:ListItem>
                            <asp:ListItem Value="GIN">Guinea</asp:ListItem>
                            <asp:ListItem Value="GNB">Guinea-Bissau</asp:ListItem>
                            <asp:ListItem Value="GUY">Guyana</asp:ListItem>
                            <asp:ListItem Value="HTI">Haiti</asp:ListItem>
                            <asp:ListItem Value="HND">Honduras</asp:ListItem>
                            <asp:ListItem Value="HKG">Hong Kong</asp:ListItem>
                            <asp:ListItem Value="HUN">Hungary</asp:ListItem>
                            <asp:ListItem Value="IS">Iceland</asp:ListItem>
                            <asp:ListItem Value="IDN">Indonesia</asp:ListItem>
                            <asp:ListItem Value="IRN">Iran</asp:ListItem>
                            <asp:ListItem Value="IRQ">Iraq</asp:ListItem>
                            <asp:ListItem Value="IMN">Isle of Man</asp:ListItem>
                            <asp:ListItem Value="ISR">Israel</asp:ListItem>
                            <asp:ListItem Value="CIV">Ivory Coast</asp:ListItem>
                            <asp:ListItem Value="JAM">Jamaica</asp:ListItem>
                            <asp:ListItem Value="JPN">Japan </asp:ListItem>
                            <asp:ListItem Value="JOR">Jordan</asp:ListItem>
                            <asp:ListItem Value="KAZ">Kazakhstan</asp:ListItem>
                            <asp:ListItem Value="KEN">Kenya</asp:ListItem>
                            <asp:ListItem Value="KIR">Kiribati</asp:ListItem>
                            <asp:ListItem Value="PRK">Korea North</asp:ListItem>
                            <asp:ListItem Value="KOR">Korea South</asp:ListItem>
                            <asp:ListItem Value="KWT">Kuwait</asp:ListItem>
                            <asp:ListItem Value="KGZ">Kyrgyzstan</asp:ListItem>
                            <asp:ListItem Value="LAO">Laos</asp:ListItem>
                            <asp:ListItem Value="LVA">Latvia</asp:ListItem>
                            <asp:ListItem Value="LBN">Lebanon</asp:ListItem>
                            <asp:ListItem Value="LSO">Lesotho</asp:ListItem>
                            <asp:ListItem Value="LBR">Liberia</asp:ListItem>
                            <asp:ListItem Value="LBY">Libya</asp:ListItem>
                            <asp:ListItem Value="LIE">Liechtenstein</asp:ListItem>
                            <asp:ListItem Value="LTU">Lithuania</asp:ListItem>
                            <asp:ListItem Value="LUX">Luxembourg</asp:ListItem>
                            <asp:ListItem Value="MAC">Macau</asp:ListItem>
                            <asp:ListItem Value="MKD">Macedonia</asp:ListItem>
                            <asp:ListItem Value="MDG">Madagascar</asp:ListItem>
                            <asp:ListItem Value="MYS">Malaysia</asp:ListItem>
                            <asp:ListItem Value="MWI">Malawi</asp:ListItem>
                            <asp:ListItem Value="MDV">Maldives</asp:ListItem>
                            <asp:ListItem Value="MLI">Mali</asp:ListItem>
                            <asp:ListItem Value="MLT">Malta</asp:ListItem>
                            <asp:ListItem Value="MHL">Marshall Islands</asp:ListItem>
                            <asp:ListItem Value="MRT">Mauritania</asp:ListItem>
                            <asp:ListItem Value="MUS">Mauritius</asp:ListItem>
                            <asp:ListItem Value="MYT">Mayotte</asp:ListItem>
                            <asp:ListItem Value="FSM">Micronesia</asp:ListItem>
                            <asp:ListItem Value="MDA">Moldova</asp:ListItem>
                            <asp:ListItem Value="MCO">Monaco</asp:ListItem>
                            <asp:ListItem Value="MNG">Mongolia</asp:ListItem>
                            <asp:ListItem Value="MSR">Montserrat</asp:ListItem>
                            <asp:ListItem Value="MNE">Montenegro</asp:ListItem>
                            <asp:ListItem Value="MAR">Morocco</asp:ListItem>
                            <asp:ListItem Value="MOZ">Mozambique</asp:ListItem>
                            <asp:ListItem Value="MMR">Myanmar</asp:ListItem>
                            <asp:ListItem Value="NAM">Namibia</asp:ListItem>
                            <asp:ListItem Value="NRU">Nauru</asp:ListItem>
                            <asp:ListItem Value="NPL">Nepal</asp:ListItem>
                            <asp:ListItem Value="ANT">Netherland Antilles</asp:ListItem>
                            <asp:ListItem Value="KNA">Nevis</asp:ListItem>
                            <asp:ListItem Value="NCL">New Caledonia</asp:ListItem>
                            <asp:ListItem Value="NIC">Nicaragua</asp:ListItem>
                            <asp:ListItem Value="NER">Niger</asp:ListItem>
                            <asp:ListItem Value="NGA">Nigeria</asp:ListItem>
                            <asp:ListItem Value="NIU">Niue</asp:ListItem>
                            <asp:ListItem Value="NFK">Norfolk Island</asp:ListItem>
                            <asp:ListItem Value="OMN">Oman</asp:ListItem>
                            <asp:ListItem Value="PAL">Pakistan</asp:ListItem>
                            <asp:ListItem Value="PLW">Palau Island</asp:ListItem>
                            <asp:ListItem Value="PAN">Panama</asp:ListItem>
                            <asp:ListItem Value="PNG">Papua New Guinea</asp:ListItem>
                            <asp:ListItem Value="PRY">Paraguay</asp:ListItem>
                            <asp:ListItem Value="PER">Peru</asp:ListItem>
                            <asp:ListItem Value="PHL">Philippines</asp:ListItem>
                            <asp:ListItem Value="PCN">Pitcairn Island</asp:ListItem>
                            <asp:ListItem Value="POL">Poland</asp:ListItem>
                            <asp:ListItem Value="PRI">Puerto Rico</asp:ListItem>
                            <asp:ListItem Value="QAT">Qatar</asp:ListItem>
                            <asp:ListItem Value="RUS">Russia</asp:ListItem>
                            <asp:ListItem Value="RWA">Rwanda</asp:ListItem>
                            <asp:ListItem Value="BLM">St Barthelemy</asp:ListItem>
                            <asp:ListItem Value="SHN">St Helena</asp:ListItem>
                            <asp:ListItem Value="KNA">St Kitts-Nevis</asp:ListItem>
                            <asp:ListItem Value="LCA">St Lucia</asp:ListItem>
                            <asp:ListItem Value="MAF">St Martin</asp:ListItem>
                            <asp:ListItem Value="SPM">St Pierre &amp; Miquelon</asp:ListItem>
                            <asp:ListItem Value="VCT">St Vincent &amp; Grenadines</asp:ListItem>
                            <asp:ListItem Value="WSM">Samoa</asp:ListItem>
                            <asp:ListItem Value="SMR">San Marino</asp:ListItem>
                            <asp:ListItem Value="STP">Sao Tome &amp; Principe</asp:ListItem>
                            <asp:ListItem Value="SAU">Saudi Arabia</asp:ListItem>
                            <asp:ListItem Value="SEN">Senegal</asp:ListItem>
                            <asp:ListItem Value="SRB">Serbia</asp:ListItem>
                            <asp:ListItem Value="SYC">Seychelles</asp:ListItem>
                            <asp:ListItem Value="SLE">Sierra Leone</asp:ListItem>
                            <asp:ListItem Value="SGP">Singapore</asp:ListItem>
                            <asp:ListItem Value="SVK">Slovakia</asp:ListItem>
                            <asp:ListItem Value="SVN">Slovenia</asp:ListItem>
                            <asp:ListItem Value="SLB">Solomon Islands</asp:ListItem>
                            <asp:ListItem Value="SOM">Somalia</asp:ListItem>
                            <asp:ListItem Value="LKA">Sri Lanka</asp:ListItem>
                            <asp:ListItem Value="SDN">Sudan</asp:ListItem>
                            <asp:ListItem Value="SUR">Suriname</asp:ListItem>
                            <asp:ListItem Value="SJM">Svalbard</asp:ListItem>
                            <asp:ListItem Value="SWZ">Swaziland</asp:ListItem>
                            <asp:ListItem Value="CHE">Switzerland</asp:ListItem>
                            <asp:ListItem Value="SYR">Syria</asp:ListItem>
                            <asp:ListItem Value="TWN">Taiwan</asp:ListItem>
                            <asp:ListItem Value="TJK">Tajikistan</asp:ListItem>
                            <asp:ListItem Value="TZA">Tanzania</asp:ListItem>
                            <asp:ListItem Value="THA">Thailand</asp:ListItem>
                            <asp:ListItem Value="TGO">Togo</asp:ListItem>
                            <asp:ListItem Value="TKL">Tokelau</asp:ListItem>
                            <asp:ListItem Value="TON">Tonga</asp:ListItem>
                            <asp:ListItem Value="TTO">Trinidad &amp; Tobago</asp:ListItem>
                            <asp:ListItem Value="TUN">Tunisia</asp:ListItem>
                            <asp:ListItem Value="TUR">Turkey</asp:ListItem>
                            <asp:ListItem Value="TKM">Turkmenistan</asp:ListItem>
                            <asp:ListItem Value="TCA">Turks &amp; Caicos Is</asp:ListItem>
                            <asp:ListItem Value="TUV">Tuvalu</asp:ListItem>
                            <asp:ListItem Value="UGA">Uganda</asp:ListItem>
                            <asp:ListItem Value="UKR">Ukraine</asp:ListItem>
                            <asp:ListItem Value="URY">Uruguay</asp:ListItem>
                            <asp:ListItem Value="UZB">Uzbekistan</asp:ListItem>
                            <asp:ListItem Value="VUT">Vanuatu</asp:ListItem>
                            <asp:ListItem Value="VAT">Vatican City State</asp:ListItem>
                            <asp:ListItem Value="VEN">Venezuela</asp:ListItem>
                            <asp:ListItem Value="VNM">Vietnam</asp:ListItem>
                            <asp:ListItem Value="VIR">Virgin Islands (USA)</asp:ListItem>
                            <asp:ListItem Value="ESH">Western Sahara</asp:ListItem>
                            <asp:ListItem Value="WLF">Wallis &amp; Futana Is</asp:ListItem>
                            <asp:ListItem Value="YEM">Yemen</asp:ListItem>
                            <asp:ListItem Value="ZMB">Zambia</asp:ListItem>
                            <asp:ListItem Value="ZWE">Zimbabwe</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic"
                            ControlToValidate="CountryDropDown" CssClass="text-danger" ValidationGroup="logingrp"
                            ErrorMessage="Required"></asp:RequiredFieldValidator>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="<%: GenderDropDown.ClientID %>">
                            Gender</label>

                        <asp:DropDownList ID="GenderDropDown" CssClass="form-select" runat="server">
                            <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                            <asp:ListItem Text="Other" Value="O"></asp:ListItem>
                        </asp:DropDownList>

                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="<%: WriterDropDown.ClientID %>">
                            Membership</label>

                        <asp:DropDownList ID="WriterDropDown" CssClass="form-select" runat="server">
                            <asp:ListItem Text="Writer" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Reader" Value="3"></asp:ListItem>
                        </asp:DropDownList>

                    </div>
                    <div class="mb-3 form-check">
                        <asp:CheckBox ID="SubscribeCheckBox" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label" for="<%: SubscribeCheckBox.ClientID %>">
                            Newsletter Subscription</label>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="<%: AltEmailTextBox.ClientID %>">
                            Alternate Email (optional)</label>
                        <asp:TextBox ID="AltEmailTextBox" MaxLength="245" CssClass="form-control" runat="server"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Email"
                            ControlToValidate="AltEmailTextBox" CssClass="text-danger" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="logingrp"></asp:RegularExpressionValidator>
                    </div>
                    <div class="mb-3">
                        <label class="control-label" for="<%: AltEmail2TextBox.ClientID %>">
                            Second Alternate Email (optional)</label>

                        <asp:TextBox ID="AltEmail2TextBox" MaxLength="245" CssClass="form-control" runat="server"></asp:TextBox><asp:RegularExpressionValidator
                            ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Email"
                            ControlToValidate="AltEmail2TextBox" CssClass="text-danger" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                            ValidationGroup="logingrp"></asp:RegularExpressionValidator>

                    </div>
                    <div class="mb-3">
                        <label class="control-label" for="<%: MobileTextBox.ClientID %>">
                            Mobile (optional)</label>

                        <asp:TextBox ID="MobileTextBox" MaxLength="17" CssClass="form-control" runat="server"></asp:TextBox>

                    </div>
                    <div class="mb-3">
                        <label class="control-label" for="<%: PhoneTextBox.ClientID %>">
                            Phone (optional)</label>
                        <asp:TextBox ID="PhoneTextBox" MaxLength="17" CssClass="form-control" runat="server"></asp:TextBox>

                    </div>
                    <div class="mb-3">
                        <label class="control-label" for="<%: AddressTextBox.ClientID %>">
                            Address (optional)</label>
                        <asp:TextBox ID="AddressTextBox" MaxLength="290" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <asp:Button ID="SubmitButton" class="btn btn-primary" ValidationGroup="logingrp"
                            runat="server" Text="Update" OnClick="SubmitButton_Click" />
                        <a class="btn" data-toggle="modal" href="#RemoveModal">Remove Account</a>
                        <a class="btn pull-right" href="changepassword">Change Password</a>
                    </div>
                </fieldset>
                <div class="modal hide" id="RemoveModal">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            ×</button>
                        <h3>Inactivate Account</h3>
                    </div>
                    <div class="modal-body">
                        <p>
                            Are you sure you want to inactivate your Rockying membership account?
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="#" class="btn" data-dismiss="modal">Close</a>
                        <asp:Button ID="DeleteButton" class="btn btn-primary" ValidationGroup="logingrp"
                            runat="server" Text="Yes" OnClick="DeleteButton_Click" />
                    </div>
                </div>
            </form>
        </div>
    </div>
</asp:Content>
