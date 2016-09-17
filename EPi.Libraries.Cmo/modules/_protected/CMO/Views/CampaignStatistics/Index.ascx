<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.ViewData>" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>

<%= Html.ShellValidationSummary() %>
<%= Html.AntiForgeryToken() %>
<% Html.RenderPartial("CampaignDetails", Model); %>
<% if (Model.Summary != null ) {Html.RenderPartial("Summary", Model.Summary);} %>
<% if (Model.VisitsAndPageViews != null) { Html.RenderPartial("VisitsAndPageViews", Model.VisitsAndPageViews); } %>
<% if (Model.Browsers != null ) { Html.RenderPartial("BrowserStatistics", Model.Browsers);} %>
<%=Html.Hidden("InvalidConfiguration", Model.InvalidConfiguration)%>