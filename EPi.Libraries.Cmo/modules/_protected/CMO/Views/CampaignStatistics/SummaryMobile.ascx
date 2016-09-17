<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.SummaryData>" %>

<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<div class="epi-paddingHorizontal-small epi-marginVertical epi-overflowHidden">
    <h2 class="epi-heading-underlined"><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryHeading") %></h2>
    <ul class="epi-CMGadget-summary epi-floatLeft">
        <li>
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryVisits") %></span>
            <span><%= Model.Visits %></span>
        </li>
        <li class="even">
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryPageViews") %></span>
            <span><%= Model.PageViews %></span>
        </li>
        <li>
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryPageViewPerVisit") %></span>
            <span><%= Model.PageViewPerVisit %></span>
        </li>
        <li class="even">
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryAveragePageViewsPerVisitor") %></span>
            <span><%= Model.AveragePageViewsPerVisitor %></span>
        </li>
        <li>
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryAverageTimeOnCampaign") %></span>
            <span><%= Model.AverageTimeOnCampaign %></span>
        </li>    
        <li class="even">
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryNewVisitors") %></span>
            <span><%= Model.NewVisitors %></span>
        </li>
        <li>
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryReturningVisitors") %></span>
            <span><%= Model.ReturningVisitors %></span>
        </li>
        <li class="even">
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryNewVsReturningVisitors") %></span>
            <span><%= Model.NewVsReturningVisitors %></span>
        </li>
        <li>
            <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsSummaryUniqueVisitors")%></span>
            <span><%= Model.UniqueVisitors %></span>
        </li>
    </ul>
</div>
