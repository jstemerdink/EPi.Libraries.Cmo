<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Trace.Models.LiveMonitor.ViewData>" %>
<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Cmo.Trace" %>
<%@ Import Namespace="EPiServer.ServiceLocation" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="System.Web.Mvc.Html" %>
<%=Html.ShellValidationSummary() %>
<div class="epi-padding-small">
    <h3><%= Html.LinkOrSpan("CampaignName", Model.CampaignName, Model.CampaignLink, "epi-linkBlue", string.Empty) %></h3>
    <div class="epi-livemonitorGadget-livemonitor">
        <% if (!Model.GadgetIsNotConfigured && Model.CampaignIsActive && Model.LiveMonitorIsInstalled)
           { %>
        <div style="height: <%=Model.Height%>px;" class="epi-width100">
            <%= Model.EmbeddedDashboard %>
        </div>
        <% } %>
    </div>
    <div class="epi-gadget-notconfigured">
        <%=Html.LiveMonitorGadgetStatusMessage(Model.GadgetIsNotConfigured, Model.CampaignIsActive, Model.LiveMonitorIsInstalled) %>
    </div>
</div>