<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMKpiSummary.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.Kpi.CMKpiSummary" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages"%>
<tr>
    <td class="cellFieldName" width="30%"><%= CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/report/kpisummary/allkpiachievedvalue")%></td>
    <td class="cellFieldValue cellPaddingRight"  width="20%" id="kpiAchievedId"><%=FormatValue(AchievedValue) %></td>
    <td class="cellFieldName cellPaddingLeft" width="30%"><%= CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/report/kpisummary/totalresult")%></td>
    <td class="cellFieldValue cellPaddingRight" width="20%" id="kpiTotalResultId"><%=FormatResult(Result) %></td>
</tr>
<tr>
    <td class="cellFieldName"><%= CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/report/kpisummary/allkpiestimatedvalue")%></td>
    <td class="cellFieldValue cellPaddingRight"  id="kpiEstimatedResultId"><%=FormatValue(EstimatedValue)%></td>
    <td class="cellFieldName cellPaddingLeft"></td>
    <td class="cellFieldValue cellPaddingRight"></td>
</tr> 
