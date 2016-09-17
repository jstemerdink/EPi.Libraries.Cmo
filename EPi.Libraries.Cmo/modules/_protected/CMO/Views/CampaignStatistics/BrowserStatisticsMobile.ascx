<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.BrowsersData>" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<div class="epi-paddingHorizontal-small epi-marginVertical epi-overflowHidden">
    <h2 class="epi-heading-underlined"><%= Html.Translate("/EPiServer/Cmo/Gadgets/BrowserStatisticsTitle") %></h2>
    <% if (Model.IsEmpty) { %>
        <%=Html.DataIsNotAvailable() %>
    <% } else { %>
        <table class="epi-CMGadget-browserStatsTable">
            <tbody>
            <% foreach (var item in Model.ChartBrowsers) { %>
                <tr>
                    <td class="epi-CMGadget-browserName"><%= item.Name %></td>
                    <td class="epi-CMGadget-browserBar">
                        <div>
                            <%= Html.DynamicDiv(item.Value, Model.ChartBrowsers[0].Value, "width", null, null) %>
                        </div>
                    </td>
                    <td class="epi-CMGadget-browserVolume"><%= item.ValueString %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    <% } %>
</div>
