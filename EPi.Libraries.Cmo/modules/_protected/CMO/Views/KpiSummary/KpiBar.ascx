<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.KpiSummary.ViewDataApple>" %>
<div class="epi-KPIGadget-bar">
    <div class="epi-KPIGauge-annotation">
        <div class="epi-KPIGadget-bar-tick" style="left: <%= Model.AchievedWidth %>%;">
        </div>
        <div class="epi-KPIGadget-bar-value" style="<%= Model.AnnotationValuePosition %>">
            <%= Model.ResultString %></div>
    </div>
    <div class="epi-KPIGadget-termometer">
        <div class="epi-KPIGadget-termometer-100" style="left: <%= Model.EstimatedWidth %>%;">
        </div>
        <div class="epi-KPIGadget-termometer-value <%= Model.ValueCssClass %>" style="width: <%= Model.AchievedWidth %>%;">
        </div>
    </div>
</div>
