<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DatabaseUpdate.aspx.cs"
    MasterPageFile="MasterPages/Cmo.Master" Inherits="EPiServer.Cmo.UI.CMO.DatabaseUpdate" %>
<asp:Content runat="server" ContentPlaceHolderID="CmoMenuPlaceHolder"></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="CmoContentPlaceHolder">
    <div class="epi-contentContainer epi-padding-small">
        <div class="epi-formArea">
            <div class="epi-size40">
                <div>
                    <asp:Label runat="server" ID="LabelMessage" Text="<%$ Resources: EPiServer, cmo.databaseupdate.updating %>" CssClass="processing" />
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var Cmo;
        if (!Cmo) Cmo = {};

        Cmo.SetUpgradeMessage = function (result) {
            var label = $('#<%= LabelMessage.ClientID %>');
            var text = eval(result)
                ? '<%= TranslateForScript("/cmo/databaseupdate/succeded") %>'
                : '<%= TranslateForScript("/cmo/databaseupdate/cancelled") %>';
            label.text(text);
            label.removeClass('processing');
        }

        $(document).ready(function () {
            <%= ClientScript.GetCallbackEventReference(this, string.Empty, "Cmo.SetUpgradeMessage", string.Empty) %>
        });

    </script>
</asp:Content>