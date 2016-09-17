<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.VisitsAndPageViewsData>" %>
<%@ Import Namespace="EPiServer.Cmo.Gadgets.Models.CampaignStatistics" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<div class="epi-paddingHorizontal-small epi-marginVertical epi-overflowHidden">
    <h2 class="epi-heading-underlined"><%=Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsVisitsAndPageViews") %> (<%=Model.PeriodTypeString %>)</h2>
    <% if (Model.IsEmpty) { %>
        <%=Html.DataIsNotAvailable() %>
    <% } else { %>
        <object name="gaugeObject" data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="100%" height="250px">
            <param name="source" value='<%=EPiServer.Cmo.Cms.Helpers.UrlHelper.ResolveUrlInCmoFromSettings("ClientBin/EPiServer.Cmo.Chart.xap") %>' />
            <param name="onError" value="onSilverlightError" />
            <param name="background" value="Transparent" />
            <param name="windowless" value="true" />
            <param name="minRuntimeVersion" value="3.0.40624.0" />
            <param name="autoUpgrade" value="true" />
            <param name="initParams" value="<%= String.Format("ChartType=VisitsAndPageViews,HiddenFieldID={0}", "hiddenLineChart" + Model.UniqueID ) %>" />
            <a href="http://go.microsoft.com/fwlink/?LinkID=149156&v=3.0.40624.0" style="text-decoration: none">
                <img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight"
                    style="border-style: none" />
            </a>
        </object>
        <%= Html.VisitsAndPageViewsChartDataHidden("hiddenLineChart" + Model.UniqueID, Model) %>
    <% } %>
</div>
