<%@ Page Title="" Language="C#" MasterPageFile="../MasterPages/Cmo.Master" AutoEventWireup="true"
    CodeBehind="General.aspx.cs" Inherits="EPiServer.Cmo.UI.CMO.Settings.General" %>
<%@ Register TagPrefix="EPiServerUI" Assembly="EPiServer.UI" Namespace="EPiServer.UI.WebControls" %>
<asp:Content ID="Content4" ContentPlaceHolderID="CmoContentPlaceHolder" runat="server">
    <div class="epi-contentContainer epi-padding-small">
        <div class="epi-formArea">
            <div class="epi-size25">
                <div> 
                    <asp:Label runat="server" AssociatedControlID="ExcludeIPs" Text="<%$ Resources: EPiServer, cmo.admin.excludeIPs %>" />
                    <asp:TextBox TextMode="MultiLine" runat="server" ID="ExcludeIPs" Rows="4" />
                    <asp:CustomValidator ID="ExcludeIPsValidator" runat="server" ControlToValidate="ExcludeIPs" EnableClientScript="false" 
                        OnServerValidate="ValidateExcludeIPs" ValidateEmptyText="false" Text="*" 
                        ErrorMessage="<%$ Resources: EPiServer, cmo.admin.excludeIPsInvalidMessage %>" />
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="CacheTimeout" Text="<%$ Resources: EPiServer, cmo.admin.cacheTimeout %>" title="<%$ Resources: EPiServer, cmo.admin.cacheTimeouttooltip %>"/>
                    <asp:TextBox Columns="20" ID="CacheTimeout" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="CacheTimeout" runat="server" ID="CacheTimeoutRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="CacheTimeout" Type="Integer" MinimumValue="0" MaximumValue="604800" runat="server"
                        ID="CacheTimeoutRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="StatisticsHandlerUrl" Text="<%$ Resources: EPiServer, cmo.admin.statisticsHandlerUrl %>" />
                    <asp:TextBox ID="StatisticsHandlerUrl" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="StatisticsHandlerUrl" runat="server" ID="StatisticsHandlerUrlRequiredValidator">*</asp:RequiredFieldValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="PageViewCountThreshold" Text="<%$ Resources: EPiServer, cmo.admin.pageViewCountThreshold %>" title="<%$ Resources: EPiServer, cmo.admin.pageViewCountThresholdtooltip %>"/>
                    <asp:TextBox ID="PageViewCountThreshold" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="PageViewCountThreshold" runat="server" ID="PageViewCountThresholdRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="PageViewCountThreshold" Type="Integer" MinimumValue="25" MaximumValue="1000" runat="server"
                        ID="PageViewCountThresholdRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="MinimalConversionsDifference" Text="<%$ Resources: EPiServer, cmo.admin.minimalConversionsDifference %>" title="<%$ Resources: EPiServer, cmo.admin.minimalConversionsDifferencetooltip %>" />
                    <asp:TextBox ID="MinimalConversionsDifference" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="MinimalConversionsDifference" runat="server" ID="MinimalConversionsDifferenceRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="MinimalConversionsDifference" Type="Integer" MinimumValue="5" MaximumValue="100" runat="server"
                        ID="MinimalConversionsDifferenceRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="RecentlyPeriod" Text="<%$ Resources: EPiServer, cmo.admin.recentlyPeriod %>" title="<%$ Resources: EPiServer, cmo.admin.recentlyPeriodtooltip %>" />
                    <asp:TextBox ID="RecentlyPeriod" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="RecentlyPeriod" runat="server" ID="RecentlyPeriodRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="RecentlyPeriod" Type="Integer" MinimumValue="0" MaximumValue="365" runat="server"
                        ID="RecentlyPeriodRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="CookieExpiration" Text="<%$ Resources: EPiServer, cmo.admin.cookieExpiration %>" title="<%$ Resources: EPiServer, cmo.admin.cookieExpirationtooltip %>" />
                    <asp:TextBox ID="CookieExpiration" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ControlToValidate="CookieExpiration" runat="server" ID="CookieExpirationRequiredValidator">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ControlToValidate="CookieExpiration" Type="Integer" MinimumValue="0" MaximumValue="365" runat="server"
                        ID="CookieExpirationRangeValidator">*</asp:RangeValidator>
                </div>
                <div>
                    <asp:Label runat="server" AssociatedControlID="CountImpressionsAndConversionsMultipleTimesCheckBox" Text="<%$ Resources: EPiServer, cmo.admin.countimpressionsandconversionsmultipletimes %>" title="<%$ Resources: EPiServer, cmo.admin.countimpressionsandconversionsmultipletimestooltip %>" />
                    <asp:CheckBox ID="CountImpressionsAndConversionsMultipleTimesCheckBox" runat="server" Text="" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
