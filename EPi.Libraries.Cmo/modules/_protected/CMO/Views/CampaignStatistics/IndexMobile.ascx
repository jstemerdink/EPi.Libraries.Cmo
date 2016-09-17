<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.ViewData>" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<div class="iPhone">
    <%= Html.AntiForgeryToken() %>
    <%= Html.ShellValidationSummary() %>
    <% Html.RenderPartial("CampaignDetails", Model); %>
    <% if (Model.Summary != null) { Html.RenderPartial("SummaryMobile", Model.Summary); } %>
    <% if (Model.VisitsAndPageViews != null) { Html.RenderPartial("VisitsAndPageViewsMobile", Model.VisitsAndPageViews); } %>
    <% if (Model.Browsers != null) { Html.RenderPartial("BrowserStatisticsMobile", Model.Browsers); } %>
    <%=Html.Hidden("InvalidConfiguration", Model.InvalidConfiguration)%>
</div>
