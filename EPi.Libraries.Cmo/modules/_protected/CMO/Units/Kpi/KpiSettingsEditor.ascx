<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KpiSettingsEditor.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.Kpi.KpiSettingsEditor" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Register Src="../ProcessingProgress.ascx" TagPrefix="cmo" TagName="Progress" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<div id="<%= ClientID %>" class="KPI-settings-main">
    <asp:UpdatePanel runat="server" ID="KpiEditorPanel" ChildrenAsTriggers="true" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Repeater runat="server" ID="KpiListRepeater">
                <HeaderTemplate>
                    <table class="epi-simple KPI-settings-list" cellpadding="0" cellspacing="0" border="0"
                        style="width: 100%">
                        <tbody>
                            <tr class="hidden"><td></td></tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <a href="#" id="kpi_<%# DataBinder.Eval(Container.DataItem, "ID") %>">
                                <%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "Name").ToString()) %></a>
                        </td>
                        <td>
                            <EPiServerUI:ToolButton runat="server" ID="DeleteKpiButton" CommandName="DeleteKpi"
                                CommandArgument='<%# DataBinder.Eval(Container.DataItem, "ID") %>' OnCommand="OnKpiListCommand"
                                CausesValidation="false" DisablePageLeaveCheck="true" SkinID="Delete" ToolTip='<%# GetDeleteTooltip((string)DataBinder.Eval(Container.DataItem, "Name")) %>'
                                EnableClientConfirm="false" OnClientClick='<%# GetDeleteConfirmationScript((string)DataBinder.Eval(Container.DataItem, "Name")) %>'
                                Enabled="<%# CanDeleteKpi %>" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Panel runat="server" ID="ShowKpiEditorPanel" class="KPI-settings-addButton epi-buttonDefault">
                <EPiServerUI:ToolButton ID="ShowKpiEditorButton" SkinID="Add" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.kpinewtext %>"
                    runat="server" GeneratesPostBack="false" />
            </asp:Panel>
            <asp:Panel runat="server" ID="SettingsFormPanel" CssClass="KPI-settings-form epi-size10" Style="display: none;">
                <asp:HiddenField ID="HiddenID" runat="server" />
                <asp:HiddenField ID="PageIDField" runat="server" />
                <h4 runat="server" id="KpiSettingsTitle">
                    <asp:Literal runat="server" ID="KpiEditTitle"></asp:Literal></h4>
                <asp:ValidationSummary runat="server" ID="KpiSettingsValidationSummary" CssClass="EP-validationSummary"
                    ForeColor="Black" ValidationGroup="<%# ValidationGroupName%>" />
                <div>
                    <asp:Label ID="Label1" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.namelabel %>"
                        AssociatedControlID="TextBoxName" />
                    <asp:TextBox ID="TextBoxName" runat="server" MaxLength="40" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.namehint %>" />
                    <asp:RequiredFieldValidator ValidationGroup="<%# ValidationGroupName %>" ID="RequiredFieldValidatorName"
                        runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.nameerrorrequired %>"
                        Display="Dynamic" ControlToValidate="TextBoxName" Text="*" CssClass="kpiEditorValidator" />
                    <asp:CustomValidator ValidationGroup="<%# ValidationGroupName %>" ID="CustomValidatorName"
                        runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.nameerrorunique %>"
                        Display="Dynamic" OnServerValidate="ValidateKpiName" ControlToValidate="TextBoxName"
                        CssClass="kpiEditorValidator" Text="*" />
                </div>
                <div>
                    <asp:Label ID="Label2" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.valuelabel %>"
                        AssociatedControlID="TextBoxValue" />
                    <asp:TextBox ID="TextBoxValue" runat="server" MaxLength="255" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.valuehint %>" />
                    <asp:RequiredFieldValidator ValidationGroup="<%# ValidationGroupName %>" ID="RequiredFieldValidatorValue"
                        runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.valueerrorrequired %>"
                        Display="Dynamic" ControlToValidate="TextBoxValue" Text="*" CssClass="kpiEditorValidator" />
                    <asp:CompareValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                        ID="CompareValidatorValue" Display="Dynamic" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.valueerrorcompare %>"
                        Text="*" Type="Double" ControlToValidate="TextBoxValue" ValueToCompare="0.01" Operator="GreaterThanEqual"
                        CssClass="kpiEditorValidator" CultureInvariantValues="true" />
                </div>
                <div>
                    <asp:Label ID="Label3" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.expectedvaluelabel %>"
                        AssociatedControlID="TextBoxExpectedValue" />
                    <asp:TextBox ID="TextBoxExpectedValue" runat="server" MaxLength="255" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.expectedvaluehint %>" />
                    <asp:RequiredFieldValidator ValidationGroup="<%# ValidationGroupName %>" ID="RequiredFieldValidatorExpectedValue"
                        runat="server" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.expectedvalueerrorrequired %>"
                        Text="*" Display="Dynamic" ControlToValidate="TextBoxExpectedValue" CssClass="kpiEditorValidator" />
                    <asp:CompareValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                        ID="CompareValidatorExpectedValue" Display="Dynamic" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.expectedvalueerrorcompare %>"
                        Text="*" Type="Double" ControlToValidate="TextBoxExpectedValue" ControlToCompare="TextBoxValue"
                        Operator="GreaterThanEqual" CssClass="kpiEditorValidator" CultureInvariantValues="true" />
                </div>
                <div>
                    <asp:Label ID="Label4" CssClass="formLabel" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.typelabel %>"
                        AssociatedControlID="DropDownListType" />
                    <asp:DropDownList ID="DropDownListType" runat="server" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.typehint %>" />
                </div>
                <asp:Panel runat="server" ID="ReferrerPanel" Style="display: none;">
                    <asp:Label ID="Label5" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.referralslabel %>"
                        AssociatedControlID="TextBoxReferrals" />
                    <asp:TextBox ID="TextBoxReferrals" runat="server" MaxLength="255" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.referralshint %>" />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                        ID="RequiredFieldValidatorReferrals" Display="Dynamic" ControlToValidate="TextBoxReferrals"
                        ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.referralserrorrequired %>"
                        Text="*" CssClass="kpiEditorValidator" />
                    <asp:RegularExpressionValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                        ID="RegularExpressionValidatorReferrals" Display="Dynamic" ValidationExpression="^(https?://)?([\w\-]+\.?)+(:\d+)?(/[\w\-\%]+\.?\w*)*(\?.+)*/?"
                        ControlToValidate="TextBoxReferrals" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.referralserrorformat %>"
                        Text="*" CssClass="kpiEditorValidator" />
                </asp:Panel>
                <asp:Panel runat="server" ID="FormsPanel" Style="display: none;">
                    <div style="margin-bottom: 0.5em;">
                        <asp:Label ID="Label6" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.formslabel %>"
                            AssociatedControlID="DropDownListForm" />
                        <asp:DropDownList runat="server" ID="DropDownListForm" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.formshint %>" />
                    </div>
                    <div>
                        <asp:Label ID="Label7" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.formsmanuallabel %>"
                            AssociatedControlID="TextBoxForms" />
                        <asp:TextBox ID="TextBoxForms" runat="server" MaxLength="255" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.formsmanualhint %>" />
                        <asp:RequiredFieldValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                            ID="RequiredFieldValidatorForms" Display="Dynamic" ControlToValidate="TextBoxForms"
                            ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.formserrorrequired %>"
                            Text="*" CssClass="kpiEditorValidator" />
                    </div>
                </asp:Panel>
                <asp:Panel ID="DownloadPanel" runat="server" Style="display: none;">
                    <div style="margin-bottom: 0.5em;">
                        <asp:Label ID="Label8" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.downloadlabel %>"
                            AssociatedControlID="FileList" />
                        <asp:DropDownList runat="server" ID="FileList" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.downloadhint %>" />
                    </div>
                    <div>
                        <asp:Label ID="Label9" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.downloadmanuallabel %>"
                            AssociatedControlID="FileUrlTextBox" />
                        <asp:TextBox ID="FileUrlTextBox" runat="server" MaxLength="255" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.downloadmanualhint %>" />
                        <asp:RequiredFieldValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                            ID="FileUrlRequiredValidator" Display="Dynamic" ControlToValidate="FileUrlTextBox"
                            ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.downloaderrorrequired %>"
                            Text="*" CssClass="kpiEditorValidator" />
                        <asp:RegularExpressionValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                            ID="FileUrlFormatValidator" Display="Dynamic" ValidationExpression="<%# FileUrlValidationExpression %>"
                            ControlToValidate="FileUrlTextBox" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.downloaderrorformat %>"
                            Text="*" CssClass="kpiEditorValidator" />
                    </div>                    
                </asp:Panel>
                <asp:Panel runat="server" ID="GenericPanel" Style="display: none;">
                    <asp:Label runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.genericlabel %>"
                        AssociatedControlID="TextBoxReferrals" />
                    <asp:DropDownList runat="server" ID="KpiKeysList" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.generichint %>" />
                    <asp:RequiredFieldValidator runat="server" ValidationGroup="<%# ValidationGroupName %>"
                        ID="RequiredFieldValidatorKpiKey" Display="Dynamic" ControlToValidate="KpiKeysList"
                        ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.genericerrorrequired %>"
                        Text="*" CssClass="kpiEditorValidator" />
                    <asp:CustomValidator runat="server" ID="GenericKeyValidator" ControlToValidate="KpiKeysList" Display="Dynamic"
                        ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.genericerrorunique %>" EnableClientScript="false"
                        Text="*" CssClass="kpiEditorValidator" OnServerValidate="ValidateGeneric" ValidationGroup="<%# ValidationGroupName %>" />
                </asp:Panel>
                <asp:Panel runat="server" ID="ConversionPanel" Style="display: none;">
                    <asp:Label runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.conversionlabel %>" 
                    AssociatedControlID="ConversionPathList" />
                    <asp:DropDownList runat="server" ID="ConversionPathList" ToolTip="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.conversionhint %>" />
                    <asp:RequiredFieldValidator runat="server" ID="ConversionPathRequiredValidator" ControlToValidate="ConversionPathList" Display="Dynamic"
                        ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.conversionerrorrequired %>"
                        Text="*" CssClass="kpiEditorValidator" ValidationGroup="<%# ValidationGroupName %>" />
                    <asp:CustomValidator runat="server" ID="ConversionPathExistsValidator" ControlToValidate="ConversionPathList" Display="Dynamic"
                        ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.conversionerrornotfound %>" EnableClientScript="false"
                        Text="*" CssClass="kpiEditorValidator" OnServerValidate="ValidateConversionPath" ValidationGroup="<%# ValidationGroupName %>" />
                </asp:Panel>
                <div class="epi-indent">
                    <EPiServerUI:ToolButton ID="SaveKPIButton" SkinID="Save" runat="server" OnClick="SaveClick"
                        CausesValidation="true" ValidationGroup="<%# ValidationGroupName%>" DisablePageLeaveCheck="true" />
                    <EPiServerUI:ToolButton ID="CancelKPIButton" SkinID="Cancel" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.cancel %>"
                        runat="server" OnClick="CancelClick" CausesValidation="false" DisablePageLeaveCheck="true" />
                    <div class="epi-inlineBlock epi-alignMiddle">
                        <asp:UpdateProgress runat="server" ID="KpiSettingsUpdateProgress" AssociatedUpdatePanelID="KpiEditorPanel" DisplayAfter="100">
                            <ProgressTemplate>
                                <div class="epi-paddingHorizontal-small">
                                    <cmo:Progress runat="server" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </div>
            </asp:Panel>
            <asp:HiddenField runat="server" ID="KpiData" />
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
<script type="text/javascript">
    //<![CDATA[

    $(function () {
        
        var initializeKpiEditor = function ()
        {
            $('#<%= ClientID %>').kpiEditor({
                uiElements:
                {
                    settingsPanelID: "<%= SettingsFormPanel.ClientID %>",
                    kpiIDControlID: "<%= HiddenID.ClientID %>",
                    kpiNameControlID: "<%= TextBoxName.ClientID %>",
                    kpiValueControlID: "<%= TextBoxValue.ClientID %>",
                    kpiExpectedValueControlID: "<%= TextBoxExpectedValue.ClientID %>",
                    hideSettingsElementID: "<%=  CancelKPIButton.ClientID %>",
                    resetElementID: "<%=  CancelKPIButton.ClientID %>",
                    manualInputValue: "<%= SelectorManualValue %>",
                    kpiTypeControlID: "<%=  DropDownListType.ClientID %>",
                    canEditKpiParameter: <%= CanEditKpiParameter.ToString().ToLowerInvariant() %>,
                    addKpiElementID: "<%= ShowKpiEditorButton.ClientID %>",
                    hideWhenEditorShownElementID: "<%= ShowKpiEditorPanel.ClientID %>",
                    kpiItemSelector: "#<%= ClientID%> .KPI-settings-list tr td a",
                    kpiItemRegionSelector: "#<%= ClientID%> .KPI-settings-list tr",
                    kpiItemSelectedClass: "KPI-settings-list-currentItem",
                    saveElementID: "<%= SaveKPIButton.ClientID %>",
                    settingsTitleElementID: "<%= KpiSettingsTitle.ClientID %>",
                    validatorSelector: "#<%= ClientID %> .kpiEditorValidator",
                    validationSummaryID: "<%= KpiSettingsValidationSummary.ClientID %>",
                    settingsHidden: true
                },
                uiTexts:
                {
                    addKpiButtonText: '<%= LocalizationService.GetString("/cmo/campaignMonitor/settings/kpi/add") %>',
                    editKpiButtonText: '<%= LocalizationService.GetString("/cmo/campaignMonitor/settings/kpi/apply") %>',
                    addKpiTitleText: '<%= LocalizationService.GetString("/cmo/campaignMonitor/settings/kpi/kpinewdefaulttitle") %>',
                    editKpiTitleText: '<%= LocalizationService.GetString("/cmo/campaignMonitor/settings/kpi/kpieditkpititle") %>'                
                },
                kpiList: eval($("#<%= KpiData.ClientID %>").val()),
                kpiTypeData: 
                    [
                        {
                            typeName: "<%= KpiType.PagesStr %>",
                            editPanel: null,
                            editControl: null,
                            selectControl: null,
                            validators: []
                        },
                        {
                            typeName: '<%= KpiType.FormsStr %>',
                            editPanel: $("#<%= FormsPanel.ClientID %>"),
                            editControl: $("#<%= TextBoxForms.ClientID %>"),
                            selectControl: $("#<%= DropDownListForm.ClientID %>"),
                            validators: ['<%= RequiredFieldValidatorForms.ClientID %>']
                        },
                        {
                            typeName: '<%= KpiType.ReferralsStr %>',
                            editPanel: $("#<%= ReferrerPanel.ClientID %>"),
                            editControl: $("#<%= TextBoxReferrals.ClientID %>"),
                            selectControl: null,
                            validators: ['<%= RequiredFieldValidatorReferrals.ClientID %>', '<%= RegularExpressionValidatorReferrals.ClientID %>']
                        },
                        {
                            typeName: '<%= KpiType.DownloadsStr %>',
                            editPanel: $("#<%= DownloadPanel.ClientID %>"),
                            editControl: $("#<%= FileUrlTextBox.ClientID %>"),
                            selectControl: $("#<%= FileList.ClientID %>"),
                            validators: ['<%= FileUrlRequiredValidator.ClientID %>', '<%= FileUrlFormatValidator.ClientID %>']
                        },
                        {
                            typeName: '<%= KpiType.GenericStr %>',
                            editPanel: $("#<%= GenericPanel.ClientID %>"),
                            editControl: null,
                            selectControl: $("#<%= KpiKeysList.ClientID %>"),
                            validators: ['<%= RequiredFieldValidatorKpiKey.ClientID %>']
                        },
                        {
                            typeName: '<%= KpiType.ConverionsStr %>',
                            editPanel: $("#<%= ConversionPanel.ClientID %>"),
                            editControl: null,
                            selectControl: $("#<%= ConversionPathList.ClientID %>"),
                            validators: ['<%= ConversionPathRequiredValidator.ClientID %>']
                        }
                    ]
            });    
            
        };

        var onPageLoaded = function (sender, args)
        {            
            if (!Sys.WebForms.PageRequestManager.getInstance().get_isInAsyncPostBack())
            {
                return;
            }
            var updatedPanels = args.get_panelsUpdated();
            for (var i = 0; i < updatedPanels.length; i++) {            
                if (updatedPanels[i].id == "<%= KpiEditorPanel.ClientID %>")
                {
                    if ($("#<%= ClientID %>").kpiEditor && $.isFunction($("#<%= ClientID %>").kpiEditor))
                    {
                        $("#<%= ClientID %>").kpiEditor("destroy");
                    }
                    initializeKpiEditor();
                    break;
                }
            }            
        }

        initializeKpiEditor();
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded( onPageLoaded );
    });    

    //]]>
</script>
