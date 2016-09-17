<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.KpiSummary.Settings>" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<div class="epi-paddingHorizontal-small epi-formArea">
    <%= Html.ShellValidationSummary() %>
    <% Html.BeginGadgetForm("EditSettings"); %>    
    <%= Html.AntiForgeryToken() %>
    <%= Html.Hidden("SelectedKpiKey", Model.KpiKey) %>
    <fieldset>
        <legend><%= Html.Translate("/EPiServer/Cmo/Gadgets/SettingsTitle")%></legend>
        <div>
            <label><%= Html.Translate("/EPiServer/Cmo/Gadgets/SelectCampaignLabel")%></label><br />
            <%= Html.DropDownList("CampaignID", Helpers.CreateSelectList(Model.Campaigns, Model.CampaignID),
                new { @class = "epi-width100 epi-KPIGadget-settings-select", @size = "10" })%>
        </div>
        <br />
        <div>
            <label><%= Html.Translate("/EPiServer/Cmo/Gadgets/SelectKpiLabel")%></label><br />
            <%= Html.DropDownList("KpiKey", new List<SelectListItem>(),
                new { @class = "epi-width100 epi-KPIGadget-settings-select", @size = "10" })%>
        </div>
    </fieldset>
    <div class="epi-buttonContainer-simple">
        <% =Html.AcceptButton(new { @class="epi-button-child-item"}) %>
        <% =Html.CancelButton(new { @class="epi-button-child-item"}) %>
    </div>
    <% Html.EndForm(); %>
</div>
