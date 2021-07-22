<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Captcha.ascx.cs" Inherits="control_Captcha" %>
<table>
    <tbody>
        <tr>
            <td style="width:170px;"><img src="<%= captchaImage %>" /></td>
            <td><input type="text" class="form-control" id="captchatxt" name="captchatxt" required="required" enableviewstate="false" style="width:100px;padding:11px;" /></td>
        </tr>
    </tbody>
</table>