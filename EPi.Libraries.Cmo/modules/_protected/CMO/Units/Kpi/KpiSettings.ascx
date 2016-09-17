<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KpiSettings.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.Kpi.KpiSettings" %>
<%@ Register Src="KpiSettingsEditor.ascx" TagName="KpiSettingsEditor" TagPrefix="cmo" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities" %>
<div class="epi-contentContainer">
    <div class="epi-formArea epi-paddingHorizontal-small">
        <div class="epi-paddingVertical-small">
            <div class="epi-marginVertical-small">
                <asp:Label runat="server" AssociatedControlID="KpiEntitySelect" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.settings.kpi.kpientity %>" />
                <asp:DropDownList ID="KpiEntitySelect" runat="server" OnSelectedIndexChanged="HandleKpiEntityChange"
                    Enabled="<%# CanEditCampaignKpi %>" />
            </div>
            <table class="epi-default KPI-settings-campaignKPI">
                <thead>
                    <tr>
                        <th>
                            <%= LocalizationService.GetString("/cmo/campaignMonitor/settings/kpi/campaignkpistitle")%>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div class="KPI-settings-container">
                                <div class="KPI-settings-thumbnail">                                    
                                    <img src="<%= EPiServer.Cmo.Cms.Helpers.UrlHelper.ResolveUrlInCmoFromSettings("Styles/Resources/campaignThumb.png") %>"
                                        alt="<%= LocalizationService.GetString("/cmo/campaignMonitor/settings/kpi/campaignkpistitle")%>" />
                                </div>
                                <cmo:kpisettingseditor runat="server" id="EditCampaignKpiForm" />
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <asp:Repeater runat="server" ID="PageListRepeater" OnItemCreated="HandleItemCreatedInPageListRepeater"
                OnItemDataBound="HandleItemDataBoundInPageListRepeater">
                <HeaderTemplate>
                    <table class="epi-default">
                        <thead>
                            <tr>
                                <th>
                                    <%= LocalizationService.GetString("/cmo/campaignMonitor/settings/kpi/selectcampaignpages")%>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <div class="KPI-settings-container">
                                <div class="KPI-settings-pageName">
                                    <h4 <%# GetStyleIfDeleted((CMPage)Container.DataItem, "deleted") %>>
                                    <%# HttpUtility.HtmlEncode(DataBinder.Eval(Container.DataItem, "Name")) %></h4>
                                    <asp:HiddenField runat="server" ID="PageReference" Value='<%# DataBinder.Eval(Container.DataItem, "Reference") %>' />
                                </div>
                                <div class="KPI-settings-thumbnail">
                                    <asp:Image runat="server" ID="PageThumbnail" AlternateText='<%# DataBinder.Eval(Container.DataItem, "Name") %>'
                                        ImageUrl="<%# CreatePageThumbnailUrl((CMPage)Container.DataItem) %>" />
                                </div>
                                        <cmo:kpisettingseditor runat="server" id="EditKpiForm" />

                            </div>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody> </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </div>
</div>
