<%@ Page Language="C#" MasterPageFile="MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="CMSettings.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.CMSettings"
    MaintainScrollPositionOnPostback="false" %>
<%@ Register Src="Units/CampaignSettingsPageSelector.ascx" TagName="CampaignSettingsPageSelector"
    TagPrefix="cmo" %>
<%@ Register Src="Units/ReportSection.ascx" TagName="ReportSection" TagPrefix="cmo" %>
<%@ Register Src="Units/ConversionPath/ConversionPathSettings.ascx" TagName="ConversionPathSettings"    TagPrefix="cmo" %>
<%@ Register Src="Units/LanguageSelectorControl.ascx" TagName="LanguageSelector"    TagPrefix="cmo" %>
<%@ Register Src="Units/Kpi/KpiSettings.ascx" TagName="KpiSettings" TagPrefix="cmo" %>
<%@ Register Src="Units/CampaignGeneralSettings.ascx" TagName="CampaignGeneralSettings" TagPrefix="cmo" %>
<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<asp:Content ID="HeaderPlaceholder" ContentPlaceHolderID="CmoHeadContentPlaceHolder"
    runat="server">
    <script type="text/javascript">
        // <![CDATA[

        var Cmo;
        if (!Cmo) {
            Cmo = {};
        }

        Cmo.hiddenChanged = '#<%= HiddenPageChanged.ClientID %>';
        Cmo.activeViewIndex = <%= MultiView.ActiveViewIndex %>;
        Cmo.conversionPathList = '#<%= ConversionPathSettings.ConversionPathListClientID %>';

        Cmo.ConversionPathConfirm = function() {
            if (Cmo.activeViewIndex != '2') {
                return true;
            }

            var func = $(Cmo.conversionPathList).get(0).conversionPathShouldBeSaved;
            return $.isFunction(func) && func()
                ? Cmo.ShowConfirmation('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/campaignMonitor/settings/conversionpath/confirmnavigatestepmessage")) %>')
                : true;
        };

        // On document load finished
        $(document).ready(function() {
            EPi.AddEventListener(window, "beforeunload", function () {
                $(Cmo.hiddenChanged).val(EPi.PageLeaveCheck._pageChanged);
            });

            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded( function (sender, args) { 
                    EPi.PageLeaveCheck.SetPageChanged(eval($(Cmo.hiddenChanged).val().toLowerCase())); 
            }) ;
        });


        // ]]>			                
    </script>
</asp:Content>
<asp:Content ID="ContentPlaceholder" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <asp:UpdatePanel runat="server" ID="HiddenFieldsPanel" UpdateMode="Always">
        <ContentTemplate>
            <asp:hiddenfield runat="server" id="HiddenSessionKey" />
            <asp:hiddenfield runat="server" id="HiddenPageChanged" value="false" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <cmo:tabstrip runat="server" id="SettingsTabs" ontabclick="SettingsTabs_TabClick" postbackmode="true">
        <cmo:Tab runat="server" ID="DetailsTab" TextKey="/cmo/campaignmonitor/settings/pages/details" OnClientClick="Cmo.DisablePageLeaveCheck(); if (!Cmo.ConversionPathConfirm()) {return false;}" />
        <cmo:Tab runat="server" ID="KpiTab" TextKey="/cmo/campaignmonitor/settings/pages/kpisettings" OnClientClick="Cmo.DisablePageLeaveCheck(); if (!Cmo.ConversionPathConfirm()) {return false;}" />
        <cmo:Tab runat="server" ID="ConvPathTab" TextKey="/cmo/campaignmonitor/settings/pages/conversionpath" OnClientClick="Cmo.DisablePageLeaveCheck();" />
    </cmo:tabstrip>
    <asp:multiview id="MultiView" runat="server" OnActiveViewChanged="MultiView_ActiveViewChanged" >
        <asp:View runat="server" ID="DetailsWizardStep">
            <cmo:CampaignGeneralSettings runat="server" ID="CampaignGeneralSettings" OnCampaignUpdated="SettingsControl_CampaignUpdated" />
        </asp:View>
        <asp:View ID="KPIWizardStep" runat="server">            
            <cmo:KpiSettings ID="KpiSettings" runat="server" OnCampaignUpdated="SettingsControl_CampaignUpdated" />                                        
        </asp:View>
        <asp:View ID="ConversionPathWizardStep" runat="server">
            <cmo:ConversionPathSettings runat="server" ID="ConversionPathSettings" OnCampaignUpdated="SettingsControl_CampaignUpdated" />
        </asp:View>
    </asp:MultiView>
</asp:Content>
