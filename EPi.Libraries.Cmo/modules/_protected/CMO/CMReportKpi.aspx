<%@ Page Title="" Language="C#" MasterPageFile="MasterPages/Cmo.Master" EnableViewState="false"
    AutoEventWireup="true" CodeBehind="CMReportKpi.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.CMReportKpi" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities"%>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Globalization" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>

<%@ Register Assembly="System.Web.Entity, Version=3.5.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089"
    Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="Units/CampaignReportPageSelector.ascx" TagName="CampaignReportPageSelector" TagPrefix="cmo" %>
<%@ Register Src="Units/Kpi/KpiReportRow.ascx" TagName="KpiReportRow" TagPrefix="cmo" %>

<asp:Content ID="CmoHeaderContent" ContentPlaceHolderID="CmoHeadContentPlaceHolder" runat="server">
    <script type="text/javascript">
        // <![CDATA[
        var Cmo;
        if (!Cmo) {
            Cmo = {};
        }
        
        Cmo.CheckKpiList = function(){
            var baseHash = $('#<%=KpiListBaseHidden.ClientID %>').val();
            var hash = $('#<%=KpiListHidden.ClientID %>').val();
            if (baseHash != hash)
            {
               Cmo.ReloadPage();
            }
        }
        
        $(document).ready(function() {
           var queryDateFormat = 'yy.mm.dd';
           $('#container_daterange').daterange({
               viewDateFormat: '<%= CultureHelper.DatepickerFormat %>',
               queryDateFormat: queryDateFormat,
               queryStartDateKey: '<%=StartDateKey %>',
               queryEndDateKey: '<%=EndDateKey %>',
               minDate: $.datepicker.parseDate(queryDateFormat, '<%=GetDateTimeGetParamString(CurrentCampaignDetached.StartDate) %>'),
               maxDate: $.datepicker.parseDate(queryDateFormat, '<%=GetDateTimeGetParamString(GetDefaultEndDate()) %>'),
               startDate: $.datepicker.parseDate(queryDateFormat, '<%=GetDateTimeGetParamString(ReportStartDate) %>'),
               endDate: $.datepicker.parseDate(queryDateFormat, '<%=GetDateTimeGetParamString(ReportEndDate) %>'),
               popupAlign: 'right',
               popupParent: '.bodyMain',
               delimiter: '—',
               wrongRangeMessage: '<%=TranslateForScript("/cmo/campaignMonitor/report/wrongReportPeriod")%>'
           });

            <% if (CurrentCampaignDetached.State == State.Run && !IsPrintMode) { %>
                Cmo.SetupUpdateTimeout();
            <%} %>
        });
        
        Cmo.UpdateKpiPanel = function() {
            $("#<%=updatePanelButton.ClientID %>").click()
            Cmo.SetupUpdateTimeout();
        }
        
        Cmo.SetupUpdateTimeout = function(){
           setTimeout("Cmo.UpdateKpiPanel()", 30000);
        }
         // ]]> 
    </script>

</asp:Content>
<asp:Content ID="CmoBodyContent" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <cmo:CMReportTabs runat="server" Id="ReportTabs" ActiveTab="Kpi" />

    <div class="epi-contentContainer">
        <div class="epi-padding-small">
            <!-- PAGE SELECTOR -->
            <table class="epi-default pageSelectorTable">
                <thead>
                    <tr>
                        <th><%= TranslateForHtml("/cmo/settings/pageselector/generalstatistictitle")%></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <cmo:CampaignReportPageSelector Title="<%$ Resources: EPiServer, cmo.settings.pageselector.generalstatistictitle %>" runat="server" ID="PageSelector"
                            AddItemForCampaign="true" ItemForCampaignTitle="<%$ Resources: EPiServer, cmo.campaignMonitor.report.kpisummary.overallcapmaign %>" />
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- REPORT PERIOD -->
            <div class="epi-dateRange">
                <div class="epi-floatRight">
                    <span class="epi-floatLeft"><%=TranslateForHtml("/cmo/campaignMonitor/report/reportperiodtitle")%></span>
                    <span class="epi-floatLeft" id="container_daterange"></span>
                </div>
            </div>
            <asp:HiddenField runat="server" ID="KpiListBaseHidden" />

            <asp:UpdatePanel ID="KpiUpdatePanel" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <asp:Button runat="server" CssClass="hidden" ID="updatePanelButton" Text="Update" /> 
                    <asp:HiddenField runat="server" ID="KpiListHidden" />
                </ContentTemplate>
            </asp:UpdatePanel>            

            <table class="epi-default">
                <thead>
                    <tr>
                        <th><%=TranslateForHtml("/cmo/campaignMonitor/report/kpisummary/pageKpiSummury")%></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <cmo:KpiReportRow ID="KpiReportSummary" ReportType="Summary" KpiName="<%$ Resources: EPiServer, cmo.campaignMonitor.report.kpisummary.selectedpagesummary %>" runat="server" />
                        </td>
                    </tr>
                </tbody>
            </table>

            <asp:PlaceHolder runat="server" ID="PageKpiDetailsReportSection">
                <table class="epi-default">
                    <thead>
                        <tr>
                            <th><%=TranslateForHtml("/cmo/campaignMonitor/report/kpisummary/pagekpidetails")%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="KpiReportRepeater" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td>
                                        <cmo:KpiReportRow ReportType="Details"
                                            KpiID='<%# DataBinder.Eval(Container.DataItem, "KpiID") %>'
                                            KpiName='<%# DataBinder.Eval(Container.DataItem, "Name") %>'
                                            PageKpiType='<%# DataBinder.Eval(Container.DataItem, "PageKpiType") %>'
                                            EstimatedValue='<%# DataBinder.Eval(Container.DataItem, "EstimatedValue") %>'
                                            AchievedValue='<%# DataBinder.Eval(Container.DataItem, "AchievedValue") %>'
                                            Result='<%# DataBinder.Eval(Container.DataItem, "Result") %>'
                                            EventCount='<%# DataBinder.Eval(Container.DataItem, "EventCount") %>'
                                            KpiEntityType='<%# DataBinder.Eval(Container.DataItem, "KpiEntityType") %>'
                                            IsPrintVersion="<%# ((CmoPageBase)Page).IsPrintMode %>"
                                            runat="server" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </asp:PlaceHolder>
        </div>
    </div>

<script type="text/javascript">
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);
    function endRequest(sender, e) {
        Cmo.CheckKpiList();
    }
</script>

</asp:Content>
