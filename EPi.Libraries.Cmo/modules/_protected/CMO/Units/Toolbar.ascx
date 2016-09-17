<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Toolbar.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.Toolbar" %>
<asp:Panel ID="PanelMain" runat="server" CssClass="epitoolbararea epi-toolbarOnPage">
    <EPiServerUI:ToolButtonContainer runat="server" ID="ToolButtonContainerAdd">
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonAddTest" SkinID="Add" DisablePageLeaveCheck="true" CausesValidation="false" />
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonAddCampaign" SkinID="Add" DisablePageLeaveCheck="true" CausesValidation="false" />
    </EPiServerUI:ToolButtonContainer>
    <EPiServerUI:ToolButtonContainer runat="server" ID="ToolButtonContainerEdit">
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonSave" SkinID="Save" DisablePageLeaveCheck="true" CausesValidation="true" />
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonCancel" SkinID="Cancel" DisablePageLeaveCheck="false" CausesValidation="false" EnableClientConfirm="False" />
    </EPiServerUI:ToolButtonContainer>
    <EPiServerUI:ToolButtonContainer runat="server" ID="ToolButtonContainerRun" >
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonStart" CssClassInnerButton="epi-cmsButton-Start" DisablePageLeaveCheck="false" CausesValidation="false" />
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonStop" CssClassInnerButton="epi-cmsButton-Stop" DisablePageLeaveCheck="false" CausesValidation="false" />
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonArchive" CssClassInnerButton="epi-cmsButton-Archive" DisablePageLeaveCheck="false" CausesValidation="false" />
    </EPiServerUI:ToolButtonContainer>
    <EPiServerUI:ToolButtonContainer runat="server" ID="ToolButtonContainerDelete">
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonDelete" SkinID="Delete" DisablePageLeaveCheck="true" CausesValidation="false"/>
    </EPiServerUI:ToolButtonContainer>
    <EPiServerUI:ToolButtonContainer runat="server" ID="ToolButtonContainerThumbnails">
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonRefreshThumbnails" SkinID="Refresh" DisablePageLeaveCheck="false" CausesValidation="false"/>
    </EPiServerUI:ToolButtonContainer>
    <EPiServerUI:ToolButtonContainer runat="server" ID="ToolButtonContainerTools">
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonExport" CssClassInnerButton="epi-cmsButton-ExportCMO" DisablePageLeaveCheck="true" CausesValidation="false" />
        <EPiServerUI:ToolButton runat="server" ID="ToolButtonPrint" SkinID="Print" DisablePageLeaveCheck="true" CausesValidation="false" GeneratesPostBack="false" />
    </EPiServerUI:ToolButtonContainer>
</asp:Panel>