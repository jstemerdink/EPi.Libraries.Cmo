<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.KpiSummary.ViewData>" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%=Html.ShellValidationSummary() %>
<div class="epi-padding-small">
    <%= Html.AntiForgeryToken() %>
    <h1>
        <%= Html.KpiReportTitle(Model.CampaignName, Model.CampaignLink, Model.CampaignStatus, Model.KpiKeyTitle, "epi-linkBlue", String.Empty)%>
    </h1>
    <div class="epi-KPIGadget-report">
        <% Html.RenderPartial(Model.KpiVisualizationView, Model); %>
        <div class="epi-KPIGadget-data">
            <%=Html.LabeledValue("PageName", Html.Translate("/EPiServer/Cmo/Gadgets/PageTitle"), Model.PageName, Model.PageLink)%>
            <%=Html.LabeledValue("KpiName", Html.Translate("/EPiServer/Cmo/Gadgets/KpiTitle"), Model.KpiName, string.Empty)%>
            <%=Html.LabeledValue("KpiType", Html.Translate("/EPiServer/Cmo/Gadgets/KpiTypeTitle"), Model.KpiType, string.Empty)%>
            <%=Html.KpiResultValue("ResultString", Model.ResultCssClassName, Model.ResultString)%>
            <%=Html.LabeledValue("AchievedValueString", Html.Translate("/EPiServer/Cmo/Gadgets/AllKpiAchievedValueTitle"), Model.AchievedValueString, string.Empty)%>
            <%=Html.LabeledValue("EstimatedValueString", Html.Translate("/EPiServer/Cmo/Gadgets/AllKpiEstimatedValueTitle"), Model.EstimatedValueString, string.Empty)%>
        </div>
        <%=Html.Hidden("InvalidConfiguration", Model.InvalidConfiguration)%>
        <%=Html.Hidden("SelectedKpiKey", Model.KpiKey)%>
    </div>
</div>