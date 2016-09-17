<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.KpiSummary.ViewDataApple>" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<div class="iPhone">
    <% Html.RenderPartial("IndexShared", Model); %>
</div>
