<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.Settings>" %>
<%@ Import Namespace="EPiServer.Cmo.Gadgets.Models.CampaignStatistics" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<div class="epi-paddingHorizontal-small epi-formArea">
    <%= Html.ShellValidationSummary() %>
    <% Html.BeginGadgetForm("EditSettings"); %>    
    <%= Html.AntiForgeryToken() %>
    <fieldset>
        <legend><%= Html.Translate("/EPiServer/Cmo/Gadgets/SettingsTitle")%></legend>
        <div class="epi-size15">
            <div>
                <label><%= Html.Translate("/EPiServer/Cmo/Gadgets/SelectCampaignLabel") %></label><br />
                <%= Html.DropDownList("CampaignID", Helpers.CreateSelectList(Model.Campaigns, Model.CampaignID),
                    new { @class = "epi-width100", @size = "10" })%>
            </div>
            <br />
            <div>
                <%= Html.LabeledCheckBox("ShowSummary", Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsShowSummary"), Model.ShowSummary)%>
            </div>
            <div>
                <%= Html.LabeledCheckBox("ShowVisitsAndPageViews", Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsShowVisitsAndPageViews"), Model.ShowVisitsAndPageViews)%>
            </div>
            <div>
                <%= Html.LabeledCheckBox("ShowBrowsers", Html.Translate("/EPiServer/Cmo/Gadgets/CampaignStatisticsShowBrowserStatistics"), Model.ShowBrowsers)%>
            </div>
            <% Html.RenderPartial("PeriodTypes", Model); %>
        </div>
    </fieldset>
    <div class="epi-buttonContainer-simple">
        <% =Html.AcceptButton(new { @class="epi-button-child-item"}) %>
        <% =Html.CancelButton(new { @class="epi-button-child-item"}) %>
    </div>
    <% Html.EndForm(); %>
</div>
