<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CampaignGeneralSettings.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.CampaignGeneralSettings" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Globalization" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Register Src="CampaignSettingsPageSelector.ascx" TagName="CampaignSettingsPageSelector" TagPrefix="cmo" %>
<%@ Register Src="LanguageSelectorControl.ascx" TagName="LanguageSelector" TagPrefix="cmo" %>
<script type="text/javascript">
    // <![CDATA[

    var Cmo;
    if (!Cmo) {
        Cmo = {};
    }

    Cmo.dateFrom = '#<%= TextBoxStartDate.ClientID %>';
    Cmo.dateTo = '#<%= TextBoxEndDate.ClientID %>';
    Cmo.languageControl = '#<%= LanguageSelector.ClientID %>';

    // Dates validation functions
    Cmo.validateStartDate = function (source, args) {
        args.Value = $(Cmo.dateFrom).val();
        Cmo.ValidateDate(source, args);
    }

    Cmo.validateEndDate = function (source, args) {
        args.Value = $(Cmo.dateTo).val();
        Cmo.ValidateDate(source, args);
    }

    //Campaign Pages Validation function
    Cmo.validatePages = function (source, args) {
        args.IsValid = Cmo.csps.items.length > 0;
    }

    //if anguage is chnaged we need to perform next actions
    // - raise callback
    // - clear items in page selector
    //
    Cmo.languageChanged = function(value) { 
        var okFunc = function () {
            EPi.PageLeaveCheck.SetPageChanged(true);            
            Cmo.csps.languageID = value;
            Cmo.csps.clearItems();
            <%= Page.ClientScript.GetCallbackEventReference(this, "value", "Cmo.langChangedCallback", "") %>
        };

        var cancelFunc = function () {
            $(Cmo.languageControl).ddselector('rollback');
        };
            
        if (Cmo.csps.items.length) { 
            return Cmo.ShowConfirmation('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/settings/CampaignLanguageChangeConfirmationMessage")) %>', okFunc, cancelFunc);
        }   
        else {
            setTimeout(okFunc, 100);
        }
    }

    //refresh page selector tree after callback
    Cmo.langChangedCallback = function(result) {
        Cmo.csps.refreshTree();
    }

     // On document load finished
    $(document).ready(function() {
        Cmo.SetupDatePicker($(Cmo.dateFrom), '<%= CultureHelper.DatepickerLocale %>', '<%= CultureHelper.DatepickerFormat %>', '-1d');
        Cmo.SetupDatePicker($(Cmo.dateTo), '<%= CultureHelper.DatepickerLocale %>', '<%= CultureHelper.DatepickerFormat %>', '-1d');
    }); 
     
    // ]]>
</script>
<div class="epi-contentContainer">
    <div class="epi-formArea epi-paddingHorizontal-small">
        <div class="epi-size15 epi-paddingVertical-small">
            <div>
                <strong><%= CmoPageBase.TranslateForHtml("/cmo/settings/detailsheader") %></strong>
            </div>
            <div>
                <asp:Label runat="server" AssociatedControlID="TextBoxName" Text="<%$ Resources: EPiServer, cmo.settings.campaignnameinputname %>" />
                <asp:TextBox ID="TextBoxName" runat="server" Enabled="true" MaxLength="255"
                    ToolTip="<%$ Resources: EPiServer, cmo.settings.campaignnameinputtitle %>" AutoCompleteType="None" />
                <asp:RequiredFieldValidator runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.settings.campaignnamevalidationmessage %>"
                    Enabled="true" Display="Dynamic" ForeColor="#FF3322"
                    CssClass="inputValidation" ControlToValidate="TextBoxName" Text="*" Font-Size="0.8em" />
                <asp:CustomValidator runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.settings.campaignnameexistvalidationmessage %>"
                    Enabled="true" Display="Dynamic" ForeColor="#FF3322" CssClass="inputValidation" Text="*" Font-Size="0.8em"
                    OnServerValidate="ValidateName" />
            </div>
            <div>
                <asp:Label runat="server" AssociatedControlID="TextBoxOwner" Text="<%$ Resources: EPiServer, cmo.settings.ownertext %>" />
                <asp:TextBox ID="TextBoxOwner" runat="server" Enabled="true"
                    ToolTip="<%$ Resources: EPiServer, cmo.settings.ownerinputtitle %>" MaxLength="255" />
            </div>
            <div>
                <asp:Label runat="server" AssociatedControlID="TextBoxStartDate" Text="<%$ Resources: EPiServer, cmo.settings.startdatetext %>" />
                <asp:TextBox ID="TextBoxStartDate" runat="server"
                    Enabled="<%# EnabledBeforeStarted %>" ToolTip="<%$ Resources: EPiServer, cmo.settings.startdatetitle %>"
                    AutoCompleteType="None" />
                <asp:CustomValidator runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.settings.datestartvalidationmessage %>"
                    Enabled="<%# EnabledBeforeStarted %>" Display="Dynamic" ForeColor="#FF3322" Font-Size="0.8em"
                    CssClass="inputValidation" OnServerValidate="ValidateStartDate" EnableClientScript="true"
                    Text="*" ClientValidationFunction="Cmo.validateStartDate" />
            </div> 
            <div> 
                <asp:Label runat="server" AssociatedControlID="TextBoxEndDate" Text="<%$ Resources: EPiServer, cmo.settings.enddatetext %>" />
                <asp:TextBox ID="TextBoxEndDate" runat="server" 
                    Enabled="<%# EnabledBeforeArchived %>" ToolTip="<%$ Resources: EPiServer, cmo.settings.enddatetitle %>"
                    AutoCompleteType="None" />
                <asp:CustomValidator runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.settings.dateendvalidationmessage %>"
                    Enabled="<%# EnabledBeforeArchived %>" Display="Dynamic" ForeColor="#FF3322"
                    Font-Size="0.8em" CssClass="inputValidation" OnServerValidate="ValidateEndDate"
                    EnableClientScript="true" Text="*" ClientValidationFunction="Cmo.validateEndDate" />
            </div>
            <div>
                <asp:Label runat="server" AssociatedControlID="TextBoxDescription" Text="<%$ Resources: EPiServer, cmo.settings.descriptiontext %>" />
                <asp:TextBox ID="TextBoxDescription" runat="server"
                    Enabled="true" ToolTip="<%$ Resources: EPiServer, cmo.settings.descriptioninputtitle %>"
                    Rows="4" TextMode="MultiLine" Wrap="true" AutoCompleteType="None" />
            </div>
        </div>
        <div class="epi-size15">
            <div>
                <strong><%= CmoPageBase.TranslateForHtml("/cmo/settings/pagesheader") %></strong>
            </div>
            <div>
                <asp:Label runat="server" AssociatedControlID="LanguageSelector" Text="<%$ Resources: EPiServer, cmo.lpo.settings.language %>" />
                <cmo:languageselector runat="server" id="LanguageSelector" cmomoduletype="CM" 
                    enabled="<%# EnabledBeforeStarted %>" onlanguagechangedclient="Cmo.languageChanged" />
            </div>
        </div>
        <table class="epi-default">
            <thead>
                <tr>
                    <th>
                        <span><%= CmoPageBase.TranslateForHtml("/cmo/settings/pageselector/title")%></span>
                        <asp:CustomValidator runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.settings.campaignpagesvalidationmessage %>"
                            Display="Dynamic" ForeColor="#FF3322" Font-Size="0.8em" CssClass="inputValidation"
                            OnServerValidate="ValidatePages" Enabled="<%# EnabledBeforeArchived %>" EnableClientScript="true"
                            Text="*" ClientValidationFunction="Cmo.validatePages" />
                    </th>
                </tr>
            </thead> 
            <tbody>
                <tr>
                    <td>
                        <cmo:campaignsettingspageselector id="CampaignSettingsPageSelector" runat="server"
                            readonly="<%# !EnabledBeforeArchived %>" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
