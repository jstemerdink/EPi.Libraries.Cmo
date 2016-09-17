<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.KpiSummary.ViewData>" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<% Html.RenderPartial("IndexShared", Model); %>