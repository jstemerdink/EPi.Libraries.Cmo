<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LpoTestResults.aspx.cs" EnableViewState="false" 
    Inherits="EPiServer.Cmo.UI.Pages.LpoTestResults" MasterPageFile="MasterPages/Cmo.Master" %>

<%@ Register Src="Units/LpoGaugeChart.ascx" TagName="LpoGauge" TagPrefix="cmo" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Entities" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Utility" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Core" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CmoHeadContentPlaceHolder" runat="server">
    <script type="text/javascript">
        // <![CDATA[

        var Cmo;
        if (!Cmo) Cmo = {};

        Cmo.UpdateAllGauges = function () {
            var result = $('#<%= GaugeData.ClientID %>').val();
            var serverResponseData = eval('(' + result + ')');
            var gaugesData = serverResponseData.gaugesData;
            $.each(gaugesData, Cmo.UpdateGauge);
        }

        Cmo.UpdateGauge = function (index, data) {
            var slGauge = $('#' + data.ObjectId)[0];
            if (slGauge) {
                var updateFunc = function () {
                    if (slGauge != undefined && slGauge.Content != undefined)  {
                        slGauge.Content.LpoGauge.UpdateGauge(data.IsOriginal, data.RateValue, data.RateValueConfidenceInterval,
                            data.BaseRateValue, data.BaseRateValueConfidenceInterval, data.CompareResults, data.ToolTip, data.IsPrintVersion);
                    } 
                }
                if (slGauge.isLoaded) {
                    updateFunc();
                }
                else {
                    window['onLoad' + data.ObjectId] = updateFunc;
                }
            }
        }

        // ]]>        
    </script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="CmoContentPlaceHolder">
    <asp:updatepanel runat="server" id="UpdatePanelMain">
        <ContentTemplate>
            <asp:HiddenField runat="server" ID="GaugeData" />
            <asp:Timer runat="server" ID="TimerMain" Interval="30000" Enabled="<%# Test.State == State.Run %>" />
        </ContentTemplate>
    </asp:updatepanel>
    <div class="epi-contentContainer">
        <div class="epi-paddingVertical">
            <div class="LPOReportHeading"><%= TranslateForHtml("/cmo/lpo/report/conversionraterange") %></div>
            <cmo:lpotestresultsview runat="server" id="TestResults">
                <ItemTemplate>
                    <div class='LPOReportItem<%# Container.IsWinner ? " LPOReportWinner" : string.Empty %>'>
                        <div class='LPOReportItemInner'>
                            <div class='LPOReportName'>
                                <strong><%# Container.PageTypeText %></strong>
                                <cmo:PageLink runat="server" LpoTestPage="<%# Container.TestPage %>" DeletedCssClass="deleted" />
                            </div>
                            <div class='epi-clear'>
                                <div class='LPOReportThumbnail'>
                                    <img src='<%# Container.SnapshotUrl %>' alt='<%# Container.ShapshotText %>' />
                                </div>
                                <div class='LPOReportGauge'> 
                                    <cmo:LpoGauge runat="server" IsPrintVersion="<%# IsPrintMode %>" RenderDataAsParams="true" ObjectID="<%# GetGaugeID(Container.TestPage.ID) %>" />
                                </div>
                                <div class='LPOReportStats'>
                                    <asp:updatepanel runat="server">
                                        <ContentTemplate>
                                            <div class='LPOReport-mainValue
                                                <%# GetValueCssClass((LpoTestPageContainer)Container, "LPOReport-mainValue-worst", "LPOReport-mainValue-best") %>'>
                                                <span class='LPOReport-mainValue-major'>
                                                    <%# TextRepresentation.GetFormatedPercentageValue(((LpoTestPageContainer)Container).Results.ConversionRate * 100, null, 1, false, false) %>
                                                </span>
                                                <asp:Label runat="server" CssClass="LPOReport-mainValue-minor" Visible="<%# ((LpoTestPageContainer)Container).Results.ConversionRateRange.HasValue %>">
                                                    &plusmn; <%# TextRepresentation.GetFormatedPercentageValue(((LpoTestPageContainer)Container).Results.ConversionRateRange, null, 1, true, false)%>
                                                </asp:Label>
                                            </div>
                                            <span class='LPOReport-value'>
                                                <%= TranslateForHtml("/cmo/lpo/report/chancetobeatoriginal") %>
                                                <span><%# TextRepresentation.GetFormatedPercentageValue(((LpoTestPageContainer)Container).Results.ChanceToBeatOriginal, null, 1, true, false)%></span>
                                            </span>
                                            <span class='LPOReport-value'>
                                                <%= TranslateForHtml("/cmo/lpo/report/chancetobeatall") %>
                                                <span><%# TextRepresentation.GetFormatedPercentageValue(((LpoTestPageContainer)Container).Results.ChanceToBeatAll, null, 1, true, false)%></span>
                                            </span>
                                            <span class='LPOReport-value'>
                                                <%= TranslateForHtml("/cmo/lpo/report/observedimprovement") %>
                                                <span><%# TextRepresentation.GetFormatedPercentageValue(((LpoTestPageContainer)Container).Results.ObservedImprovement, null, 1, true, true)%></span>
                                            </span>
                                            <span class='LPOReport-value'>
                                                <%= TranslateForHtml("/cmo/lpo/report/conversions") %>
                                                <span><%# TextRepresentation.GetFormatedPercentageValue(((LpoTestPageContainer)Container).Results.Conversions, null, 0, false, false)%>
                                                    / <%# TextRepresentation.GetFormatedPercentageValue(((LpoTestPageContainer)Container).Results.Impressions, null, 0, false, false)%></span>
                                            </span>
                                        </ContentTemplate>
                                    </asp:updatepanel>
                                    <div class='LPOReport-winnerHolder'>
                                        <asp:Label runat="server" CssClass="LPOReport-winnerMark" Visible="<%# Container.IsWinner %>">
                                            <span class='LPOReport-winnerMark-icon'></span>
                                            <span class='LPOReport-winnerMark-text'><%= TranslateForHtml("/cmo/lpo/report/winnerlabel") %></span>
                                        </asp:Label>
                                        <EPiServerUI:ToolButton runat="server" CommandArgument="<%# Container.TestPage.ID %>" OnCommand="ToolButtonWinner_Command"
                                            Text="<%$ Resources: EPiServer, cmo.lpo.report.finalize %>" EnableClientConfirm="true"
                                            ConfirmMessage='<%# string.Format(LocalizationService.GetString("/cmo/lpo/report/finalizeconfirm"), Container.TestPage.Name) %>'
                                            Visible="<%# Container.TestPage.LpoTest.CanBeFinalized %>" Enabled="<%# Container.TestPage.IsValid %>" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>   
            </cmo:lpotestresultsview>
        </div>
    </div>
</asp:Content>
