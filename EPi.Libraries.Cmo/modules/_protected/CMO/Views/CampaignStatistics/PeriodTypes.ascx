<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.Settings>" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<fieldset class="periodTypes">
    <legend><%=Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsReportPeriodScale")%></legend>
    <% =Html.PeriodTypeRadioButtons("PeriodType", Model.PeriodTypes, Model.PeriodType, "periodType" + Model.GadgetID)%>
</fieldset>

