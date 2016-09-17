<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConversionPathSettings.ascx.cs" Inherits="EPiServer.Cmo.UI.CMO.Units.ConversionPath.ConversionPathSettings" %>
<%@ Register Src="CMConversionPathEditor.ascx" TagName="CMConversrionPathEditor" TagPrefix="cmo" %>
<%@ Register Src="ConversionPathList.ascx" TagName="ConversionPathList" TagPrefix="cmo" %>
 
<asp:Panel ID="ConversionPathToolbar" runat="server" CssClass="epitoolbararea epi-toolbarOnPage">
    <EPiServerUI:ToolButtonContainer runat="server" ID="ToolButtonContainerAdd">
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonAddConversionPath" SkinID="Add" 
            DisablePageLeaveCheck="true" GeneratesPostBack="false" OnClientClick="Cmo.AddNewConversionPath();"
            CausesValidation="false" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.conversionpath.addnewconversionpath %>" />
    </EPiServerUI:ToolButtonContainer>
</asp:Panel>

<script type="text/javascript">
    Cmo.AddNewConversionPath = function () {
        $('#<%=ConversionPathEditor.ClientID %>').conversionPathEditor('showEditor');
    };
</script>

<div class="epi-contentContainer"> 
    <div class="epi-padding-small">           
        <cmo:cmconversrionpatheditor runat="server" id="ConversionPathEditor" />      
        <cmo:ConversionPathList id="ConversionPathList" runat="server"/>
    </div>
</div>
