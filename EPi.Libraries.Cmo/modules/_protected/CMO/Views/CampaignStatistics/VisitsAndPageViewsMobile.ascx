<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.VisitsAndPageViewsData>" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>

<div class="epi-paddingHorizontal-small epi-marginVertical epi-overflowHidden">
    <h2 class="epi-heading-underlined"><%=Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsVisitsAndPageViews") %> (<%=Model.PeriodTypeString %>)</h2>
    <% if (Model.IsEmpty) { %>
        <%=Html.DataIsNotAvailable() %>
    <% } else { %>
        <div class="epi-widget-pageViews">
            <table>
                <tbody>
                    <tr class="epi-widget-pageViews-bars">
                        <% foreach (var item in Model.Values) { %>
                            <td>
                                <div class="epi-widget-pageViews-bar">
                                    <%= Html.DynamicDiv(item.PageViews, Model.MaxValue, "height", item.PageViews.ToString(), new { @class = "epi-widget-pageViews-bar-views" }) %>
                                    <%= Html.DynamicDiv(item.Visits, Model.MaxValue, "height", item.Visits.ToString(), new { @class = "epi-widget-pageViews-bar-visitors" }) %>
                                </div>
                            </td>
                        <% } %>
                    </tr>
                    <tr class="epi-widget-pageViews-names">
                        <% foreach (var item in Model.Values) { %>
                            <td>
                                <div>
                                    <span><%= item.DateAnnotaton %></span>
                                </div>
                            </td>
                        <% } %>
                    </tr>				
                </tbody>
            </table>
        </div>
        <span class="epi-CMGadget-hint"><%=Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsChartScrollingTip") %></span>
    <% } %>
</div>
