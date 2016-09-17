<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.BrowsersData>" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>

<div class="epi-paddingHorizontal-small epi-marginVertical epi-overflowHidden">
	<h2 class="epi-heading-underlined"><%=Html.Translate("/EPiServer/Cmo/Gadgets/BrowserStatisticsTitle") %></h2>
    <% if (Model.IsEmpty) { %>
        <%=Html.DataIsNotAvailable() %>
    <% } else { %>
    <div class="epi-browsersPieChart">
        <%=Html.BrowserPieChart(Model, Page)%>
    </div>
    <% } %>
</div>