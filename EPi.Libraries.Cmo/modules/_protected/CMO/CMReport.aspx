<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="MasterPages/Cmo.Master" EnableViewState="false"
    CodeBehind="CMReport.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.CMReport" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities"%>
<%@ Import Namespace="EPiServer.Cmo.UI.Globalization" %>

<%@ Register Src="Units/CMReportValuesList.ascx" TagName="CMReportValuesList" TagPrefix="cmo" %>
<%@ Register Src="Units/CMCampaignLineChart.ascx" TagName="CMCampaignLineChart" TagPrefix="cmo" %>
<%@ Register Src="Units/CMCampaignFunnelChart.ascx" TagName="CMCampaignFunnelChart" TagPrefix="cmo" %>
<%@ Register Src="Units/BrowsersPieChart.ascx" TagName="BrowsersPieChart" TagPrefix="cmo" %>
<%@ Register Src="Units/CMCampaignCountryChart.ascx" TagName="CMCampaignCountryChart" TagPrefix="cmo" %>
<%@ Register Src="Units/Kpi/CMKpiSummary.ascx" TagName="CMKpiSummary" TagPrefix="cmo" %>
<%@ Register Src="Units/Kpi/CmReportGauge.ascx" TagName="CmGauge" TagPrefix="cmo" %>

<asp:Content ContentPlaceHolderID="CmoHeadContentPlaceHolder" runat="server">

    <script type="text/javascript">
        // <![CDATA[
        var Cmo;
        if (!Cmo) {
            Cmo = {};
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
                attachPopupElement: $('.bodyMain'),
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

         Cmo.UpdateAllGauges = function() {
            var result = $('#<%=KpiDataHidden.ClientID %>').val();
            var serverResponseData = eval('('+result+')');
            var kpiGaugesData = serverResponseData.kpiGaugesData;
            var isKpiExist = serverResponseData.kpisExists;
            if(isKpiExist == false)
            {
                $('#KpiSummaryPanel').hide();
            }
            else{
                $('#KpiSummaryPanel').show();
                $.each(kpiGaugesData, Cmo.UpdateGauge);
            }
        }
                
        Cmo.UpdateGauge = function(index, data) {
            
            var slGauge = $('#'+data.ObjectId)[0];
            var containerDiv = $('#'+data.ObjectId).closest('div.alignCenter.epi-floatLeft');
            if (containerDiv){
                if (data.Disabled) {
                    containerDiv.hide();
                }
                else {
                    containerDiv.show();
                }
            }
            if (slGauge)
            {
                var updateFunc = function() {
                    if (slGauge != undefined && slGauge.Content != undefined) {
                        slGauge.Content.CMGauge.UpdateGaugeValues(data.Achieved, data.Estimated, data.Disabled);
                    }
                }
                if (slGauge.isLoaded) {
                    updateFunc();
                }
                else {
                    window["onLoad"+data.ObjectId] = updateFunc;
                }
            }
        }
        
        // ]]>        
    </script>

</asp:Content>
<asp:Content ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <cmo:CMReportTabs runat="server" Id="ReportTabs" ActiveTab="Overview" />

    <div class="epi-contentContainer">
        <div class="epi-padding-small">
            <!-- REPORT PERIOD -->
            <div class="epi-dateRange">
                <div class="epi-floatRight">
                    <span class="epi-floatLeft"><%=TranslateForHtml("/cmo/campaignMonitor/report/reportperiodtitle")%></span>
                    <span class="epi-floatLeft" id="container_daterange"></span>
                </div>
            </div>

            <!-- CAMPAIGN -->
            <asp:PlaceHolder runat="server" ID="ReportDetails">
                <table class="epi-default">
                    <thead>
                        <tr>
                            <th colspan="4"><%=TranslateForHtml("/cmo/campaignMonitor/report/details/sectiontitle") %></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="cellFieldName" width="35%"><%=TranslateForHtml("/cmo/campaignMonitor/report/details/owner")%></td>
                            <td class="cellFieldValue cellPaddingRight" width="15%"><%= HttpUtility.HtmlEncode(CurrentCampaignDetached.Owner)%></td>
                            <td class="cellNoBorder cellFieldName cellPaddingLeft" width="35%"><%=TranslateForHtml("/cmo/campaignMonitor/report/details/description")%></td>
                            <td class="cellFieldValue cellNoBorder" width="15%"></td>
                        </tr>
                        <tr>
                            <td class="cellFieldName"><%=TranslateForHtml("/cmo/campaignMonitor/report/details/startdate")%></td>
                            <td class="cellFieldValue cellPaddingRight"><%=FormatDate(CurrentCampaignDetached.StartDate)%></td>
                            <td class="cellPaddingLeft" rowspan="2" colspan="2"><%= HttpUtility.HtmlEncode(CurrentCampaignDetached.Description ?? String.Empty).Replace(Environment.NewLine, "<br />")%></td>
                        </tr>
                        <tr>
                            <td class="cellFieldName"><%=TranslateForHtml("/cmo/campaignMonitor/report/details/enddate")%></td>
                            <td class="cellFieldValue cellPaddingRight"><%=FormatDate(CurrentCampaignDetached.EndDate)%></td>
                        </tr>
                    </tbody>
                </table>
            </asp:PlaceHolder>

            <!-- VISITS AND PAGE VIEWS -->
            <asp:PlaceHolder runat="server" ID="VisitsAndPageViewsReport">
                <table class="epi-default">
                    <thead>
                        <tr>
                            <th colspan="4"><%=TranslateForHtml("/cmo/campaignMonitor/report/visitsandpageviews/sectiontitle")%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <cmo:CMReportValuesList ID="ReportValuesList" runat="server"  LocalizationPrefix="/cmo/campaignMonitor/report/visitsandpageviews/valueNames/" />
                        <tr>
                            <td colspan="4">
                                <cmo:CMCampaignLineChart runat="Server" ID="VisitsViewsLineChart" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </asp:PlaceHolder>

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

            <div class="pagebreak"></div>

            <!-- KPI SUMMARY -->
            <asp:UpdatePanel ID="KpiSummaryUpdatePanel" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                    <asp:Button runat="server" CssClass="hidden" ID="updatePanelButton" />
                    <asp:HiddenField runat="server" ID="KpiDataHidden" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <table class="epi-default" id="KpiSummaryPanel">
                <thead>
                    <tr>
                        <th colspan="4"><%=TranslateForHtml("/cmo/campaignMonitor/report/kpisummary/sectiontitle")%></th>
                    </tr>
                </thead>
                <tbody>
                    <cmo:CMKpiSummary runat="server" id="KpiSummary"></cmo:CMKPISummary>
                    <tr>
                        <td colspan="4">
                            <div class="epi-inlineBlock" style="width: 98.5%">
                                <asp:Repeater runat="server" id="KpiGaugesRepeater">
                                    <ItemTemplate>
                                        <div class="epi-floatLeft epi-padding alignCenter" style='display:<%# (bool)Eval("Disabled") ? "none" : "block" %>'>
                                            <span><%# Eval("HeaderText")%></span><br />
                                            <cmo:CmGauge ID="KpiGauge" runat="server" ObjectID='<%# Eval("ObjectId") %>' RenderDataAsParams="true" Disabled='<%# Eval("Disabled") %>' 
                                                AchievedValue='<%# Eval("AchievedValue") %>' EstimatedValue='<%# Eval("EstimatedValue") %>'
                                                IsPrintVersion="<%# IsPrintMode %>" OnClickRedirectUrl='<%# Eval("RedirectUrl") %>'/><br />
                                            <span><%= TranslateForHtml("/cmo/campaignMonitor/report/kpisummary/resultlabeltext")%></span>
                                            <asp:UpdatePanel ID="KpiResultsUpdatePanel" runat="server">
                                                <ContentTemplate>
                                                    <asp:Label runat="server" ID="KpiResultLabel" CssClass='<%# Eval("ResultCssClass") %>' Text='<%# Eval("ResultText") %>' />
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>            
            <!-- CONVERSION PATH FUNNELS -->
            <asp:PlaceHolder runat="server" ID="ConversionPaths">
                <table class="epi-default">
                    <thead>
                        <tr>
                            <th colspan="2"><%= TranslateForHtml("/cmo/campaignMonitor/report/conversionPath/conversionpathstitle")%></th>
                        </tr>
                    </thead>
                    <tbody>
                        <cmo:CMConversionPathListView ID="ConversionPathListView" runat="server" DoNotRenderWrappingTag="true">
                            <ItemTemplate>
                                <tr>
                                    <td class="alignCenter epi-width50">
                                        <div class="CM-report-funnel">
                                            <div><%# Container.Path.Name %></div>
                                            <cmo:CMCampaignFunnelChart runat="server" IsPrintVersion="<%#IsPrintMode%>" ConversionPathReport="<%# GetConversionReport(Container.Path) %>" NavigateUrl="<%# Container.GetNavigateUrl() %>"></cmo:CMCampaignFunnelChart>
                                        </div>
                                    </td>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                    <td class="alignCenter epi-width50">
                                        <div class="CM-report-funnel">
                                            <div><%# Container.Path.Name %></div>
                                            <cmo:CMCampaignFunnelChart runat="server" IsPrintVersion="<%#IsPrintMode%>" ConversionPathReport="<%# GetConversionReport(Container.Path) %>" NavigateUrl="<%# Container.GetNavigateUrl() %>"></cmo:CMCampaignFunnelChart>
                                        </div>
                                    </td>
                                </tr>
                            </AlternatingItemTemplate>
                            <ClosingItemTemplate>
                                    <td class="epi-width50"></td>
                                </tr>
                            </ClosingItemTemplate>
                        </cmo:CMConversionPathListView>
                    </tbody>
                </table>
            </asp:PlaceHolder>
        </div>
    </div>
</asp:Content>
