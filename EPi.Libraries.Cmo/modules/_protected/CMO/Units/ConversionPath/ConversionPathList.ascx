<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConversionPathList.ascx.cs"
    Inherits="EPiServer.Cmo.UI.CMO.Units.ConversionPathList" %>
<%@ Register Src="ConversionPathEditor.ascx" TagName="ConversionPathEditor" TagPrefix="cmo" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" Assembly="EPiServer.Cmo.UI" %>

<%@ Import Namespace="EPiServer.Core" %>
<cmo:CMConversionPathListView ID="ConversionPathListView" runat="server">
    <ItemTemplate>
        <div class="reportCampaignRow">
            <cmo:ConversionPathEditor ID="CMConversionPathEditor" ConversionPath="<%# Container.Path %>"
                runat="server">
            </cmo:ConversionPathEditor>
        </div>
    </ItemTemplate>
</cmo:CMConversionPathListView>