<%@ Page Language="C#" MasterPageFile="MasterPages/Cmo.Master" AutoEventWireup="true" CodeBehind="CMConversionReport.aspx.cs" Inherits="EPiServer.Cmo.UI.Pages.CMConversionReport" Title="Untitled Page" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities"%>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Globalization" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>

<%@ Register Src="Units/ConversionPath/CMConversionReport.ascx" TagName="ConversionReport" TagPrefix="cmo" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" Assembly="EPiServer.Cmo.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="CmoHeadContentPlaceHolder" runat="server">

   <script type="text/javascript">
       // <![CDATA[
       var Cmo;
       if (!Cmo) {
           Cmo = {};
       }
       
       $(document).ready(function () {
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

           var requestUrl = document.location.toString();
           if (requestUrl.match('#')) {
               var sectionAnchor = $('#' + requestUrl.split('#')[1]);
               if (sectionAnchor.length > 0) {
                   setTimeout(function () {
                       sectionAnchor.removeClass('conversionPathTableCollapsed');
                       $('.bodyMain').scrollTop(sectionAnchor.positionAncestor('.bodyMain').top); 
                   }, 500);
               }
           }

           $('.conversionPathExpandLink').click(function (e) {
               e.preventDefault();
               $(this).closest('.conversionPathTable').removeClass('conversionPathTableCollapsed');
           });
           $('.conversionPathCollapseLink').click(function (e) {
               e.preventDefault();
               $(this).closest('.conversionPathTable').addClass('conversionPathTableCollapsed');
           });
       });
       // ]]>  
    </script>
    
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <cmo:CMReportTabs runat="server" Id="ReportTabs" ActiveTab="ConversionPath" />

    <div class="epi-contentContainer">
        <div class="epi-padding-small">
            <!-- REPORT PERIOD -->
            <asp:Panel ID="ReportPeriod" runat="server" CssClass="epi-dateRange">
                <div class="epi-floatRight">
                    <span class="epi-floatLeft"><%=TranslateForHtml("/cmo/campaignMonitor/report/reportperiodtitle")%></span>
                    <span class="epi-floatLeft" id="container_daterange"></span>
                </div>
            </asp:Panel>

            <asp:Panel id="noConversionPathWarningPanel" runat="server" enableviewstate="false" visible="false">
                <%=TranslateForHtml("/cmo/campaignMonitor/report/conversionPath/NoConversionPathCreated")%>
            </asp:Panel>
            <cmo:CMConversionPathListView ID="ConversionPathListView" runat="server">
                <ItemTemplate>
                    <table class="epi-default conversionPathTable conversionPathTableCollapsed" id="section<%#Container.Path.ID %>">
                        <thead>
                            <tr>
                                <th colspan="2"><%#Container.Path.Name %></th>
                            </tr>
                        </thead>
                        <tbody>
                            <cmo:ConversionReport runat="server" ID="ConversionReport" ConversionPathReport="<%#GetConversionReport(Container.Path)%>" IsPrintVersion="<%#IsPrintMode%>"></cmo:ConversionReport>
                        </tbody>
                    </table>
                </ItemTemplate>
            </cmo:CMConversionPathListView>                           
        </div>
    </div>
</asp:Content>
