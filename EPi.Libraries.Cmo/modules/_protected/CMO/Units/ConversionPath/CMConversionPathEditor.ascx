 <%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMConversionPathEditor.ascx.cs" Inherits="EPiServer.Cmo.UI.CMO.Units.CMConversionPathEditor" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Register TagPrefix="EPiServer" Namespace="EPiServer.Web.WebControls" %>
<table class="epi-default" id="<%=ClientID %>" style='<%= GetVisibility() %>'>
    <thead>
        <tr>
            <th>
                <EPiServer:Translate runat="server" Text="/cmo/campaignMonitor/settings/conversionpath/newconversionpathtitle"  />
            </th>
        </tr>
    </thead> 
    <tbody>
        <tr>
            <td>
                <asp:ValidationSummary runat="server" ID="Summary" CssClass="EP-validationSummary"
                    ForeColor="Black" ValidationGroup="CampaingNewConversionPathEdit" />
                <div class="epi-formArea CP-settings-newName">
                    <div class="epi-size15"> 
                        <div>
                            <asp:Label runat="server" AssociatedControlID="ConversionPathNameTextBox" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.conversionpathname %>"></asp:Label>
                            <asp:TextBox ID="ConversionPathNameTextBox" runat="server" MaxLength="255"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ID="ConversionPathNameRequiredValidator" Display="Dynamic"
                                ControlToValidate="ConversionPathNameTextBox" ValidationGroup="CampaingNewConversionPathEdit"
                                EnableClientScript="true" Text="*" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.conversionpathnamerequirederror %>" />
                            <asp:CustomValidator runat="server" ID="ValidatorNameUnique" OnServerValidate="ValidatorNameUnique_ServerValidate"
                                ControlToValidate="ConversionPathNameTextBox" ValidationGroup="CampaingNewConversionPathEdit" Display="Dynamic" Text="*" EnableClientScript="false"
                                ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.conversionpathnameuniqueerror %>" />
                        </div>
                    </div>
                </div>
                <div id="selectors" class="CP-settings-pageSelector">
                    <div class="epi-floatLeft CP-settings-Select">
                        <span class="CP-settings-groupLabel"><%=CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/settings/conversionpath/campaingpagestitle")%></span>
                        <br />
                        <asp:ListBox runat="server" ID="CampaignPagesList" SkinID="Custom" SelectionMode="Multiple" CssClass="EPEdit-sidSelectList" DataTextField="PageName" DataValueField="CmsPageReference" />
                    </div>
                    <div class="epi-floatLeft epi-arrowButtonContainer">
                        <EPiServerUI:ToolButton ID="RightButton" GeneratesPostBack="False" runat="server"
                            SkinID="ArrowRight" Style="margin-bottom: 1.5em; margin-top: 1.5em;" OnClientClick='<%# GetWidgetFunctionCall("addRight") %>' />
                        <br />
                        <EPiServerUI:ToolButton ID="LeftButton" GeneratesPostBack="False" runat="server"
                            SkinID="ArrowLeft" OnClientClick='<%# GetWidgetFunctionCall("removeRight") %>' />
                    </div>
                    <div class="epi-floatLeft CP-settings-Select">
                        <span class="CP-settings-groupLabel"><%=CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/settings/conversionpath/selectedpagestitel")%></span>
                        <asp:CustomValidator runat="server" ID="ValidatorTooFewPages" OnServerValidate="ValidatorTooFewPages_OnServerValidate"
                            ClientValidationFunction='<%# "Cmo.Cpe.ValidateTooFewPages"+ClientID %>' ValidationGroup="CampaingNewConversionPathEdit"
                            Display="Dynamic" Text="*" EnableClientScript="true" ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.errorfewpagecount %>" />
                        <asp:CustomValidator runat="server" ID="ValidatorTooManyPages" OnServerValidate="ValidatorTooManyPages_OnServerValidate"
                            ValidationGroup="CampaingNewConversionPathEdit" Display="Dynamic" Text="*" EnableClientScript="false"
                            ErrorMessage="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.errortoomanypagescount %>" />
                        <br />
                        <select id="SelectedPagesList" class="EPEdit-sidSelectList" multiple="multiple"><option></option></select>
                        <asp:HiddenField runat="server" ID="SelectedPagesHidden" />
                    </div> 
                    <div class="epi-floatLeft epi-arrowButtonContainer">
                        <EPiServerUI:ToolButton ID="UpButton" GeneratesPostBack="False" runat="server" SkinID="Up"
                            Style="margin-bottom: 1.5em; margin-top: 1.5em;" OnClientClick='<%# GetWidgetFunctionCall("upRight") %>' />
                        <br />
                        <EPiServerUI:ToolButton ID="DownButton" GeneratesPostBack="False" runat="server"
                            SkinID="Down" OnClientClick='<%# GetWidgetFunctionCall("downRight") %>' />
                    </div>
                </div>
                <div class="CP-settings-buttonsArea">
                    <EPiServerUI:ToolButton ID="SaveButton" GeneratesPostBack="True" OnClick="SaveButton_OnClick"
                        runat="server" SkinID="Save" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.createtitle %>" 
                        DisablePageLeaveCheck="true" ValidationGroup="CampaingNewConversionPathEdit" />
                    <EPiServerUI:ToolButton ID="CancelButton" GeneratesPostBack="False" runat="server"
                        OnClientClick='<%# GetWidgetFunctionCall("hideEditor") %>' SkinID="Cancel" 
                        Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.canceltitle %>" />
                </div>
            </td>
        </tr>
    </tbody>    
</table>


<script type="text/javascript">
    var Cmo = Cmo || {}; 
    Cmo.Cpe = Cmo.Cpe || {};
    Cmo.Cpe.ValidateTooFewPages<%# ClientID %> = function(source, args) {
         var selectedPagesCount = $('#<%=this.ClientID %>').conversionPathEditor('getSelectedPagesCount');
         args.IsValid = selectedPagesCount >= <%=MinimalPagesCount %>;
    };

    $(function () {
        $('#<%=this.ClientID %>').conversionPathEditor({
            messages: {
                pageExistMessageText: '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/campaignMonitor/settings/conversionpath/erroraddingpagemessage"))  %>',
                cantAddMorePagesMessageText: '<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/campaignMonitor/settings/conversionpath/errortoomanypagescount"))  %>'
            },
            maximumPages: <%= MaximumPagesCount %>,
            minimumPages: <%= MinimalPagesCount %>,
            leftListId: '<%= CampaignPagesList.ClientID %>',
            rightListId: 'SelectedPagesList',
            rightListHiddenId: '<%= SelectedPagesHidden.ClientID %>',
            addRightButtonId: '<%= RightButton.ClientID %>',
            addLeftButtonId: '<%= LeftButton.ClientID %>', 
            upButtonId: '<%= UpButton.ClientID %>',
            downButtonId: '<%= DownButton.ClientID %>',
            pathNameTextBoxId: '<%=ConversionPathNameTextBox.ClientID %>',
            validationSummaryId: "<%=Summary.ClientID %>",                                
            validationGroupName: "CampaingNewConversionPathEdit"
        });  
        if(<%=ShowEditorOnLoad.ToString().ToLower()%>) { $('#<%=ClientID %>').conversionPathEditor('showEditor'); }
    });
</script>
