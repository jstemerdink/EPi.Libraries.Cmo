<%@ Page Language="C#" MasterPageFile="MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="CMPageReport.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.CMPageReport"
    Title="Untitled Page" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Globalization" %>
<%@ Import Namespace="EPiServer.Core" %>

<%@ Register Src="Units/CMReportValuesList.ascx" TagName="CMReportValuesList" TagPrefix="cmo" %>
<%@ Register Src="Units/CMCampaignLineChart.ascx" TagName="CMCampaignLineChart" TagPrefix="cmo" %>
<%@ Register Src="Units/CampaignReportPageSelector.ascx" TagName="CampaignReportPageSelector" TagPrefix="cmo" %>
<%@ Register Src="Units/BrowsersPieChart.ascx" TagName="BrowsersPieChart" TagPrefix="cmo" %>
<%@ Register Src="Units/CMCampaignCountryChart.ascx" TagName="CMCampaignCountryChart" TagPrefix="cmo" %>

<asp:Content ContentPlaceHolderID="CmoHeadContentPlaceHolder" runat="server">

    <script type="text/javascript">
       // <![CDATA[
       
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
       });

       // ]]>        
    </script>

</asp:Content>
<asp:Content ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <cmo:CMReportTabs runat="server" Id="ReportTabs" ActiveTab="GeneralStatistics" />

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
                            <cmo:CampaignReportPageSelector Title="<%$ Resources: EPiServer, cmo.settings.pageselector.generalstatistictitle %>" runat="server" ID="PageSelector" />
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

            <!-- VISITS AND PAGE VIEWS -->
            <table class="epi-default">
                <thead>
                    <tr>
                        <th colspan="4"><%=TranslateForHtml("/cmo/campaignMonitor/report/visitsandpageviews/sectiontitle")%></th>
                    </tr>
                </thead>
                <tbody>
                    <cmo:CMReportValuesList ID="CMReportValuesList" runat="server" LocalizationPrefix="/cmo/campaignMonitor/report/visitsandpageviews/valueNames/" />
                    <tr>
                        <td colspan="4" >
                            <cmo:CMCampaignLineChart runat="Server" ID="VisitsViewsLineChart" />
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- REFERRER -->
            <table class="epi-default">
                <thead>
                    <tr>
                        <th><%=TranslateForHtml("/cmo/campaignMonitor/report/referrer/sectiontitle")%></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><cmo:BrowsersPieChart ID="BrowsersPieChart" runat="server" /></td>
                    </tr>
                </tbody>
            </table>

        </div>
    </div>
</asp:Content>
