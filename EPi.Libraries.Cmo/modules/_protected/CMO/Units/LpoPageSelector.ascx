<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LpoPageSelector.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.LpoPageSelector" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages"%>
<%@ Import Namespace="EPiServer.Core"%>
<%@ Register Src="PageTree.ascx" TagName="PageTree" TagPrefix="cmo" %>
<%@ Register Src="PageVersionList.ascx" TagName="PageVersionList" TagPrefix="cmo" %>    
<%@ Register Src="LanguageSelectorControl.ascx" TagName="LanguageSelector" TagPrefix="cmo" %>    
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>    
<%@ Import Namespace="EPiServer.Framework.Localization" %>

<script type="text/javascript" >
    // <![CDATA[
        
        var LpoPageSelector;
        if (!LpoPageSelector)
        {
            LpoPageSelector = {};
        }

        // Variation page 2 visibility and validation manipulations
        LpoPageSelector.variation2div = "#variation2selector";
        //toggleVariation2Button
        LpoPageSelector.addVariation2Button = "#<%=AddVariation2Button.ClientID %>";
        LpoPageSelector.removeVariation2Button = "#<%=RemoveVariation2Button.ClientID %>";

        LpoPageSelector.variation1PublishedPageId = '#<%=Variation1PageSelector.PublishedPageIdHiddenField.ClientID %>';
        LpoPageSelector.variation1Version = '#<%=Variation1PageSelector.ValueControl.ClientID %>';
        LpoPageSelector.variation1PageVersion = '#<%=Variation1PageSelector.SelectorTextBox.ClientID %>';
        LpoPageSelector.variation1ValidationEnable = '#<%=Variation1PageSelector.ValidationEnable.ClientID %>';
        LpoPageSelector.variation1Button = '#<%=Variation1PageSelector.SelectButton.ClientID %>';

        LpoPageSelector.variation2PublishedPageId = '#<%=Variation2PageSelector.PublishedPageIdHiddenField.ClientID %>';
        LpoPageSelector.variation2Version = '#<%=Variation2PageSelector.ValueControl.ClientID %>';
        LpoPageSelector.variation2PageVersion = '#<%=Variation2PageSelector.SelectorTextBox.ClientID %>';
        LpoPageSelector.variation2Button = '#<%=Variation2PageSelector.SelectButton.ClientID %>';
        LpoPageSelector.variation2ValidationEnable = '#<%=Variation2PageSelector.ValidationEnable.ClientID %>';
        
        LpoPageSelector.languageControlId = '#<%= LanguageSelect.ClientID %>';

        LpoPageSelector.originalPageText = "#<%= OriginalPageSelector.SelectorTextBox.ClientID %>";
        LpoPageSelector.originalPageButton = "#<%= OriginalPageSelector.SelectButton.ClientID %>";
        LpoPageSelector.originalPageValue = "#<%= OriginalPageSelector.ValueControl.ClientID %>";
        LpoPageSelector.originalPageValidationEnable = "#<%= OriginalPageSelector.ValidationEnable.ClientID %>";
        
        LpoPageSelector.originalPageNotFound = <%= OriginalPageSelector.IsPageNotFound.ToString().ToLower() %>;

        LpoPageSelector.conversionPageText = "#<%= ConversionPageSelector.SelectorTextBox.ClientID %>";
        LpoPageSelector.conversionPageButton = "#<%= ConversionPageSelector.SelectButton.ClientID %>";
        LpoPageSelector.conversionPageValue = "#<%= ConversionPageSelector.ValueControl.ClientID %>";
        LpoPageSelector.conversionPageValidationEnable = "#<%= ConversionPageSelector.ValidationEnable.ClientID %>";

        LpoPageSelector.originalPageID = "#<%= OriginalPageSelector.SelectorTextBox.ClientID %>";
        LpoPageSelector.variation1PageID = "#<%= Variation1PageSelector.SelectorTextBox.ClientID %>";
        LpoPageSelector.variation2PageID = "#<%= Variation2PageSelector.SelectorTextBox.ClientID %>";
        LpoPageSelector.conversionPageID = "#<%= ConversionPageSelector.SelectorTextBox.ClientID %>";    


        LpoPageSelector.addVariation2 = function() {
            $(LpoPageSelector.variation2div).show();
            $(LpoPageSelector.addVariation2Button).parent().hide();
            var originalValue = $(LpoPageSelector.originalPageValue).val();
            $(LpoPageSelector.variation2ValidationEnable).val(originalValue ? true : false); 
            $(LpoPageSelector.variation2Button).focus(); 
        }

        LpoPageSelector.removeVariation2 = function() {
            $(LpoPageSelector.variation2div).hide();
            $(LpoPageSelector.addVariation2Button).parent().show();
            $(LpoPageSelector.variation2PublishedPageId).val('');
            $(LpoPageSelector.variation2Version).val('');
            $(LpoPageSelector.variation2PageVersion).val('');
            $(LpoPageSelector.variation2ValidationEnable).val('false');
            $(LpoPageSelector.variation2PageVersion).removeClass('deletedPage');
            
            LpoPageSelector.setSelectedPageTitle(LpoPageSelector.variation2PageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectvariation2pagetitle"))  %>');
        }
        
        //Tracking selected page title
        LpoPageSelector.setSelectedPageTitle = function(id, defaultTitle) {
            if ($(id).val() == '') {
                $(id).attr('title', defaultTitle);
            }
            else {
                $(id).attr('title', $(id).val());
            }
        }
        
        LpoPageSelector.clearVariation1 = function (value)
        {
            $(LpoPageSelector.variation1PageVersion).val('');
            $(LpoPageSelector.variation1PublishedPageId).val('');
            $(LpoPageSelector.variation1Version).val('');

            if (value)
                LpoPageSelector.enableVariation1();
            else
                LpoPageSelector.disableVariation1();
                
            $(LpoPageSelector.variation1ValidationEnable).val(value ? true : false);
            $(LpoPageSelector.variation1PageVersion).removeClass('deletedPage');
            
            LpoPageSelector.setSelectedPageTitle(LpoPageSelector.variation1PageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectvariation1pagetitle"))  %>');
            if (!value) {
                $(LpoPageSelector.variation1PageVersion).addClass("disable");
            }
            else {
                $(LpoPageSelector.variation1PageVersion).removeClass("disable");
            }
        }
        
        LpoPageSelector.clearVariation2 = function (value)
        {
            var valid = value && $(LpoPageSelector.variation2div).is(':visible');
            $(LpoPageSelector.variation2PageVersion).val('');
            $(LpoPageSelector.variation2PublishedPageId).val('');
            $(LpoPageSelector.variation2Version).val('');

            if (value)
                LpoPageSelector.enableVariation2();
            else
                LpoPageSelector.disableVariation2();
                
            $(LpoPageSelector.variation2ValidationEnable).val(valid);
            $(LpoPageSelector.variation2PageVersion).removeClass('deletedPage');
            
            LpoPageSelector.setSelectedPageTitle(LpoPageSelector.variation2PageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectvariation2pagetitle")) %>');
            if (!value) {
                $(LpoPageSelector.variation2PageVersion).addClass("disable");
            }
            else {
                $(LpoPageSelector.variation2PageVersion).removeClass("disable");
            }
        }
        
        LpoPageSelector.disableVariation1 = function() {
            $(LpoPageSelector.variation1PageVersion).attr('disabled', 'disabled');
            $(LpoPageSelector.variation1Button).attr('disabled', 'disabled');
        }
        
        LpoPageSelector.enableVariation1 = function() {
            $(LpoPageSelector.variation1PageVersion).attr('disabled', '');
            $(LpoPageSelector.variation1Button).attr('disabled', '');
        }

        LpoPageSelector.disableVariation2 = function() {
            $(LpoPageSelector.variation2PageVersion).attr('disabled', 'disabled');
            $(LpoPageSelector.variation2Button).attr('disabled', 'disabled');
        }
        
        LpoPageSelector.enableVariation2 = function() {
            $(LpoPageSelector.variation2PageVersion).attr('disabled', '');
            $(LpoPageSelector.variation2Button).attr('disabled', '');
        }

        LpoPageSelector.addVariation2ButtonClick = function() {
            if (!$(LpoPageSelector.addVariation2Button).attr('disabled')) {
                LpoPageSelector.addVariation2();
            }
        }

        LpoPageSelector.removeVariation2ButtonClick = function() {
            if (!$(LpoPageSelector.removeVariation2Button).attr('disabled')) {
                LpoPageSelector.removeVariation2();
            }
        }

         
        LpoPageSelector.languageChanged = function(value)
        {
            EPi.PageLeaveCheck.SetPageChanged(true);
           
            $(LpoPageSelector.originalPageValue).val('');
            $(LpoPageSelector.originalPageText).val('');
            $(LpoPageSelector.originalPageText).removeClass('deletedPage');            
            
            $(LpoPageSelector.originalPageValue).val('');

            $(LpoPageSelector.conversionPageValue).val('');
            $(LpoPageSelector.conversionPageText).val('');
            $(LpoPageSelector.conversionPageText).removeClass('deletedPage');
            
            $(LpoPageSelector.conversionPageValue).val('');
            
            LpoPageSelector.clearVariation1();
            LpoPageSelector.clearVariation2();
            
            var callbackFunc = function() { <%= Page.ClientScript.GetCallbackEventReference(this, "value", "LpoPageSelector.RefreshPageTree", null) %> };
            callbackFunc();            
        }
        
        LpoPageSelector.RefreshPageTree = function() {
            $("#<%=PageTree.ClientID %>").pageTree('treeRefresh');
        }
        
         // On document load finished
        $(document).ready(function () {
            
            if ($(LpoPageSelector.variation2PageVersion).val() != ''
                || $(LpoPageSelector.variation2PublishedPageId).val() != ''
                || $(LpoPageSelector.variation2Version).val() != '')
            {
                LpoPageSelector.addVariation2();
            }
            
            LpoPageSelector.originalPage = $(LpoPageSelector.originalPageID).val();
            LpoPageSelector.variation1Page = $(LpoPageSelector.variation1PageID).val();
            LpoPageSelector.variation2Page = $(LpoPageSelector.variation2PageID).val();
            LpoPageSelector.conversionPage = $(LpoPageSelector.conversionPageID).val();

            var originalPageControlId = '#<%=OriginalPageSelector.ValueControl.ClientID %>';
            var conversionControlId = '#<%=ConversionPageSelector.ValueControl.ClientID %>';

            LpoPageSelector.setSelectedPageTitle(LpoPageSelector.originalPageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectoriginalpagetitle")) %>');
            LpoPageSelector.setSelectedPageTitle(LpoPageSelector.variation1PageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectvariation1pagetitle")) %>');
            LpoPageSelector.setSelectedPageTitle(LpoPageSelector.variation2PageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectvariation2pagetitle")) %>');
            LpoPageSelector.setSelectedPageTitle(LpoPageSelector.conversionPageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectconversionpagetitle")) %>');

            PageVersionSelectorDlg._publishedPageControlId = originalPageControlId;
            PageVersionSelectorDlg._languageControlId = LpoPageSelector.languageControlId;            
            
            if (!LpoPageSelector.originalPage)
            {
                LpoPageSelector.clearVariation1();
                LpoPageSelector.clearVariation2();
            }
            
            if (LpoPageSelector.originalPageNotFound) {
               LpoPageSelector.disableVariation1();
               LpoPageSelector.disableVariation2();
            }

            $(originalPageControlId).change(function()
            {   
                LpoPageSelector.clearVariation1(this.value);
                LpoPageSelector.clearVariation2(this.value);
            });

            $(LpoPageSelector.variation1PageVersion).change(function()
            {  
                LpoPageSelector.setSelectedPageTitle(LpoPageSelector.variation1PageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectvariation1pagetitle")) %>');
            });

            $(LpoPageSelector.variation2PageVersion).change(function()
            {
                LpoPageSelector.setSelectedPageTitle(LpoPageSelector.variation2PageID, '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectvariation2pagetitle")) %>');
            });

            $(LpoPageSelector.originalPageText).change(function()  { EPi.PageLeaveCheck.SetPageChanged(true); });
            $(LpoPageSelector.variation1PageVersion).change(function() { EPi.PageLeaveCheck.SetPageChanged(true); });
            $(LpoPageSelector.variation2PageVersion).change(function() { EPi.PageLeaveCheck.SetPageChanged(true); });
            $(LpoPageSelector.conversionPageText).change(function() { EPi.PageLeaveCheck.SetPageChanged(true); });
        });
         
    // ]]>		        
</script>


<div> 
    <asp:Label runat="server" AssociatedControlID="LanguageSelect" Text="<%$ Resources: EPiServer, cmo.lpo.settings.language %>" />
    <cmo:LanguageSelector runat="server" ID="LanguageSelect" CmoModuleType="LPO" OnLanguageChangedClient="LpoPageSelector.languageChanged" />
</div>
<div>
    <asp:Label runat="server" AssociatedControlID="OriginalPageSelector" Text="<%$ Resources: EPiServer, cmo.lpo.settings.selectoriginalpagetext %>" />
    <cmo:PageSelector ID="OriginalPageSelector" CssClass="epi-inline" 
        SelectorTextBoxCssClass="inputTextField" ValidatorCssClass="inputValidation" SelectButtonCssClass="inputButton" 
        IsValidationEnable="true" ValidatorErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.originalpagevalidationmessage %>"
        PageDeletedNotificationText="<%$ Resources: EPiServer, cmo.lpo.settings.originalpagedeletedmessage %>"
        runat="server" />
</div>
<div>
    <asp:Label runat="server" AssociatedControlID="Variation1PageSelector" Text="<%$ Resources: EPiServer, cmo.lpo.settings.selectvariation1pagetext %>" />
    <cmo:PageVersionSelector ID="Variation1PageSelector" CssClass="epi-inline epi-alignMiddle" SelectorTextBoxCssClass="inputTextField"
        ValidatorCssClass="inputValidation" ValidatorErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.variation1pagevalidationmessage %>" SelectButtonCssClass="inputButton"
        PageDeletedNotificationText="<%$ Resources: EPiServer, cmo.lpo.settings.version1deletedmessage %>"
        runat="server" />
    <EPiServerUI:ToolButton ID="AddVariation2Button" OnClientClick="LpoPageSelector.addVariation2ButtonClick(); return false;" SkinID="Add" Text="<%$ Resources: EPiServer, cmo.lpo.settings.addpagebuttoncaption %>" runat="server" />
</div>
<div id="variation2selector" style="display: none;">
    <asp:Label runat="server" AssociatedControlID="Variation2PageSelector" Text="<%$ Resources: EPiServer, cmo.lpo.settings.selectvariation2pagetext %>" />
    <cmo:PageVersionSelector ID="Variation2PageSelector" CssClass="epi-inline epi-alignMiddle" SelectorTextBoxCssClass="inputTextField"
        ValidatorCssClass="inputValidation" IsValidationEnable="false" ValidatorErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.variation2pagevalidationmessage %>" SelectButtonCssClass="inputButton"
        PageDeletedNotificationText="<%$ Resources: EPiServer, cmo.lpo.settings.version2deletedmessage %>"
        runat="server" />
    <EPiServerUI:ToolButton ID="RemoveVariation2Button" OnClientClick="LpoPageSelector.removeVariation2ButtonClick(); return false;" SkinID="Delete" Text="<%$ Resources: EPiServer, cmo.lpo.settings.removepagebuttoncaption %>" runat="server" />
</div>


<div>
    <asp:Label runat="server" AssociatedControlID="ConversionPageSelector" Text="<%$ Resources: EPiServer, cmo.lpo.settings.selectconversionpagetext %>" />
    <cmo:PageSelector ID="ConversionPageSelector" CssClass="epi-inline" 
        SelectorTextBoxCssClass="inputTextField" ValidatorCssClass="inputValidation" SelectButtonCssClass="inputButton"
        IsValidationEnable="true" ValidatorErrorMessage="<%$ Resources: EPiServer, cmo.lpo.settings.conversionpagevalidationmessage %>"
        PageDeletedNotificationText="<%$ Resources: EPiServer, cmo.lpo.settings.conversionpagedeletedmessage %>"
        runat="server" />
</div>

<cmo:PageTree ID="PageTree" runat="server" />
<cmo:PageVersionList ID="PageVersionList" runat="server" />
