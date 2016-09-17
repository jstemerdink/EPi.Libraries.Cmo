<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMCampaignFunnelChart.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.CMCampaignFunnelChart" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Import Namespace="System.Web.UI.DataVisualization.Charting" %>

<asp:Chart runat="server" ID="ConversionPathFunnel" Width="330px" Height="180px" ImageType="Png" BackColor="#FFFFFF">
    <ChartAreas>
        <asp:ChartArea Name="MainArea" BackColor="#FFFFFF" BackSecondaryColor="#FFFFFF" Area3DStyle-Enable3D="false">
        </asp:ChartArea>
    </ChartAreas>
    <Series>
        <asp:Series Name="PageViews" ChartType="Funnel" CustomProperties="FunnelStyle=YIsWidth,FunnelLabelStyle=OutsideInColumn,FunnelOutsideLabelPlacement=Right,FunnelPointGap=1,CalloutLineColor=#000000">
        </asp:Series> 
    </Series>
</asp:Chart>

<asp:Panel runat="server" ID="ConversionPathNoData" CssClass="CM-report-funnel-noData">
    <asp:Literal runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.report.conversionpath.FunnelNotEnoughData %>" />
</asp:Panel>