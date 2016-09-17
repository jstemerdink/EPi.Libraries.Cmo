<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<EPiServer.Cmo.Gadgets.Models.CampaignStatistics.ViewData>" %>

<%@ Import Namespace="EPiServer.Cmo.Gadgets.Util" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Import Namespace="EPiServer.Shell.Web.Mvc.Html" %>

<div class="epi-padding-small epi-overflowHidden">
	<h1><%: Model.Name %> (<%=Model.State %>)</h1>
	<div>
		<span class="epi-CMOGadget-headingMeta">
			<span class="epi-CMOGadget-headingMeta-Name"><%=Html.Translate("/EPiServer/Cmo/Gadgets/LanguageTitle")%></span>
            <%=Html.LanguageLabel(Model.Language) %>
			
		</span>
		<span class="epi-CMOGadget-headingMeta">
			<span class="epi-CMOGadget-headingMeta-Name"><%=Html.Translate("/EPiServer/Cmo/Gadgets/CampaignPeriod")%></span>
			<span class="epi-CMOGadget-headingMeta-Value"><%=Model.Period %></span>
		</span>
	</div>
</div>
