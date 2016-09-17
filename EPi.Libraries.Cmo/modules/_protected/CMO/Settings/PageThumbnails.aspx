<%@ Page Title="" Language="C#" MasterPageFile="../MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="PageThumbnails.aspx.cs" Inherits="EPiServer.Cmo.UI.CMO.Settings.PageThumbnails" %>
<%@ Register TagPrefix="EPiServerUI" Assembly="EPiServer.UI" Namespace="EPiServer.UI.WebControls" %>
<asp:Content ID="Content4" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <div class="epi-contentContainer epi-padding-small">
        <div class="epi-formArea">
            <div class="epi-size25">
                <div>
                    <asp:Label runat="server" AssociatedControlID="ThumbnailServiceUrl" Text="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceUrl %>"  title="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceUrltooltip %>" />
                    <asp:TextBox ID="ThumbnailServiceUrl" runat="server" CssClass="EP-requiredField" />&nbsp;
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="UseThumbnailServiceAuthentication" Text="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceUseAuthentication %>" title="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceUseAuthenticationtooltip %>" />
                    <asp:CheckBox ID="UseThumbnailServiceAuthentication" runat="server" OnCheckedChanged="HandleThumbnailServiceCmsCredentialChange" />
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="ThumbnailServiceCmsLogin" Text="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceCmsLogin %>" title="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceCmsLogintooltip %>"/>
                    <asp:TextBox ID="ThumbnailServiceCmsLogin" runat="server" OnTextChanged="HandleThumbnailServiceCmsCredentialChange"
                        CssClass="EP-requiredField" AutoCompleteType="None" />&nbsp;
                    <asp:CustomValidator ID="ThumbnailServiceCmsLoginValidator" ControlToValidate="ThumbnailServiceCmsLogin" OnServerValidate="ValidateAuthenticationLogin"
                        runat="server" ValidateEmptyText="true" ErrorMessage="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceCmsLoginIsRequired %>"
                        Text="*" />
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="ThumbnailServiceCmsPassword" Text="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceCmsPassword %>" title="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceCmsPasswordtooltip %>" />
                    <asp:TextBox ID="ThumbnailServiceCmsPassword" OnTextChanged="HandleThumbnailServiceCmsCredentialChange" TextMode="Password"
                        runat="server" CssClass="EP-requiredField" AutoCompleteType="None" />&nbsp;
                    <asp:CustomValidator ID="ThumbnailServiceCmsPasswordValidator" ControlToValidate="ThumbnailServiceCmsPassword" OnServerValidate="ValidateAuthenticationPassword"
                        runat="server" ValidateEmptyText="true" ErrorMessage="<%$ Resources: EPiServer, cmo.admin.ThumbnailServiceCmsPasswordIsRequired %>"
                        Text="*" />
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="DefaultThumbnailPath" Text="<%$ Resources: EPiServer, cmo.admin.defaultThumbnailPath %>" />
                    <asp:TextBox ID="DefaultThumbnailPath" runat="server" CssClass="EP-requiredField" />&nbsp;
                    <asp:RequiredFieldValidator ControlToValidate="DefaultThumbnailPath" runat="server" ID="DefaultThumbnailPathRequiredValidator">*</asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        // <![CDATA[

        $(function () {

            var checkBox = $("#<%= UseThumbnailServiceAuthentication.ClientID %>");
            var loginInput = $("#<%=ThumbnailServiceCmsLogin.ClientID %>");
            var passInput = $("#<%=ThumbnailServiceCmsPassword.ClientID %>");

            var loginValidator = $("#<%=ThumbnailServiceCmsLoginValidator.ClientID %>")[0];
            var passValidator = $("#<%=ThumbnailServiceCmsPasswordValidator.ClientID %>")[0];
            

            var setCridentialsAvailability = function () {
                if (checkBox.is(':checked')) {
                    loginInput.removeAttr('disabled');
                    passInput.removeAttr('disabled');
                }
                else {
                    loginInput.attr('disabled', 'disabled');
                    passInput.attr('disabled', 'disabled');
                }

            }
            checkBox.click(setCridentialsAvailability);
            checkBox.keydown(setCridentialsAvailability);

            setCridentialsAvailability();

            passInput.passwordInput({
                    changeButtonText:'<%=Translate("/cmo/admin/ThumbnailServiceCmsChangepasswordbuttontext") %>',
                    noPassword: !checkBox.is(':checked') || !(passValidator.isvalid && loginValidator.isvalid)
                });   
        });

        // ]]>        
    </script>
</asp:Content>
