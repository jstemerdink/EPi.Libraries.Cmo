<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMConversionReport.ascx.cs" Inherits="EPiServer.Cmo.UI.CMO.Units.CMConversionReport" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages"%>
<%@ Register Src="../CMCampaignFunnelChart.ascx" TagName="CMCampaignFunnelChart" TagPrefix="cmo" %>
<%@ Register Src="../CMReportValuesList.ascx" TagName="CMReportList" TagPrefix="cmo" %>
<%@ Register Src="ConversionPathView.ascx" TagName="CMConversionReport" TagPrefix="cmo" %>

<tr>
    <td>
        <cmo:CMCampaignFunnelChart runat="server" ID="FunnelChart"></cmo:CMCampaignFunnelChart>
    </td>
    <td>
        <table class="epi-simple">
            <tbody>
                <cmo:CMReportList ID="ReportValuesList" runat="server" IsOneColumnPresentation="true" LocalizationPrefix="/cmo/campaignMonitor/report/conversionPath/valueNames/" />
            </tbody>
        </table>
    </td>
</tr>
<tr class="conversionPathRowCollapseExpand">
    <td colspan="2">
        <a href="#" class="conversionPathExpandLink"><%=CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/report/conversionPath/showDetails")%></a>
        <a href="#" class="conversionPathCollapseLink"><%=CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/report/conversionPath/hideDetails")%></a>
    </td>
</tr>
<cmo:CMConversionReport runat="server" ID="ConversionReport" />