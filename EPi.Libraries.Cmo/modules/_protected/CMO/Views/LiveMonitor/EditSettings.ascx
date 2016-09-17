<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Trace.Models.LiveMonitor.Settings>" %>
<%@ Import Namespace="System.Web.Mvc.Html" %>
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
            <div>
                <%= Html.LabeledTextBox("Height", Html.Translate("/EPiServer/Cmo/Gadgets/LiveMonitorHeightLabel"), Model.Height, new { @class = "epi-size3" }, null)%>
                    <span><%= Html.Translate("/EPiServer/Cmo/Gadgets/PixelsLabel") %></span>
            </div>
        </div>
    </fieldset>
    <div class="epi-buttonContainer-simple">
        <% =Html.AcceptButton(new { @class="epi-button-child-item"}) %>
        <% =Html.CancelButton(new { @class="epi-button-child-item"}) %>
    </div>
    <% Html.EndForm(); %>
</div>
