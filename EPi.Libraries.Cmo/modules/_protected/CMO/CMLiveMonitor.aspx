<%@ Page Language="C#" MasterPageFile="MasterPages/Cmo.Master" AutoEventWireup="true" CodeBehind="CMLiveMonitor.aspx.cs"
    Inherits="EPiServer.Cmo.Trace.Pages.CMLiveMonitor" Title="Live Monitor" %>
<asp:Content  ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <cmo:CMReportTabs runat="server" Id="ReportTabs" ActiveTab="LiveMonitor" />
    <div class="epi-padding-small" style="height:76%;">
        <%= LiveMonitorEmbeddedDashboard %>
    </div>
</asp:Content>