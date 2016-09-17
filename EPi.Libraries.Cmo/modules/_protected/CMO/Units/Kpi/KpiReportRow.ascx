<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="KpiReportRow.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.Kpi.KpiReportRow" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Register Src="CmReportGauge.ascx" TagName="CmGauge" TagPrefix="cmo" %>

<div class="KPI-report" >
    <asp:UpdatePanel runat="server" UpdateMode="Always" >
        <ContentTemplate>
            <asp:HiddenField ID="ReportDataHidden" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>

    <div class="KPI-report-gauge">
        <cmo:CmGauge ID="ReportGauge"  runat="server" RenderDataAsParams="true"/>
    </div>
    <div class="KPI-report-data">
        <div>
            <asp:Label ID="KpiNameLabel" CssClass="KPI-report-name" runat="server"></asp:Label>
        </div>

        <div>
            <asp:Label ID="KpiResultLabel" CssClass="KPI-report-result" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.report.kpisummary.notavailablelabeltext%>" runat="server"></asp:Label>
        </div>

        <div>
            <asp:Label ID="AchievedValueTextLabel" CssClass="KPI-report-label" runat="server"></asp:Label>
            <asp:Label ID="AchievedValueLabel" CssClass="KPI-report-value" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.report.kpisummary.notavailablelabeltext%>"></asp:Label>
        </div>

        <div>
            <asp:Label ID="EstimatedValueTextLabel" CssClass="KPI-report-label" runat="server"></asp:Label>
            <asp:Label ID="EstimatedValueLabel" CssClass="KPI-report-value" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.report.kpisummary.notavailablelabeltext%>"></asp:Label>
        </div>

        <div>
            <asp:Label ID="KpiEventNumberTextLabel" CssClass="KPI-report-label" runat="server"></asp:Label>
            <asp:Label ID="KpiEventNumberLabel" CssClass="KPI-report-value" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.report.kpisummary.notavailablelabeltext%>"></asp:Label>
        </div>
    </div>
</div>