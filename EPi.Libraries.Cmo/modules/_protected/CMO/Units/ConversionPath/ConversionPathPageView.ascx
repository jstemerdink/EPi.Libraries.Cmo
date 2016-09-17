<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConversionPathPageView.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.ConversionPathPageView" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>

<div class="conversionPathContainer">
    <div class="conversionPathBlock conversionPathSide">
        <div class="conversionPathLinks conversionPathLinksLeft">
            <asp:Repeater runat="server" ID="RepeaterEnterUrls">
                <HeaderTemplate>
                    <strong><%# GetFromTitle() %></strong><br />
                </HeaderTemplate>
                <ItemTemplate>
                    <span><%# GetValue(Container.DataItem) %></span>
                    <span>
                        <cmo:ConversionPathItemLink runat="server" Value="<%# GetKey(Container.DataItem) %>" DeletedCssClass="deleted"
                            DefaultText="<%$ Resources: EPiServer, cmo.campaignMonitor.report.conversionPath.list.fromexternaltitle %>" />
                    </span><br />
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="conversionPathArrow in">
            <span class="reportCampaignLabel"><%# Value.EnterCount %></span>
            <span class="arrowInOut">&rarr;</span>
        </div>
    </div>

    <div class="conversionPathBlock conversionPathThumb">
        <img class="conversionPathThumbImage" alt="<%# Value.Page.Name %>" src="<%# ThumbnailUrl %>" title="<%# Value.Page.Name %>" />
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" Visible="<%# ExistsInCms %>" CssClass="pageNameLink" NavigateUrl="<%# Url %>" Text="<%# Value.Page.Name %>" />
        <asp:Label ID="Label1" runat="server" Visible="<%# !ExistsInCms %>" CssClass="pageNameLink deleted" Text="<%# Value.Page.Name %>" />
        <br />
        <asp:PlaceHolder runat="server" Visible="<%# !Value.IsLast %>">
            <span><%# CmoPageBase.TranslateForHtml("/cmo/campaignMonitor/report/conversionPath/list/conversions", Value.ConversionCount, Value.DirectConversionCount) %></span>
            <br />
            <span class="arrowTransition">&darr;</span>
        </asp:PlaceHolder>
    </div>

    <div class="conversionPathBlock conversionPathSide">
        <div class="conversionPathLinks">
            <asp:Repeater runat="server" ID="RepeaterExitUrls">
                <HeaderTemplate>
                    <strong><asp:Literal ID="Literal1" runat="server" Text="<%$ Resources: EPiServer, cmo.campaignMonitor.report.conversionPath.list.totitle %>" /></strong><br />
                </HeaderTemplate>
                <ItemTemplate>
                    <span><%# GetValue(Container.DataItem) %></span>
                    <span>
                        <cmo:ConversionPathItemLink runat="server" Value="<%# GetKey(Container.DataItem) %>" DeletedCssClass="deleted"
                            DefaultText="<%$ Resources: EPiServer, cmo.campaignMonitor.report.conversionPath.list.toexternaltitle %>" />
                    </span><br />
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="conversionPathArrow out">
            <span class="reportCampaignLabel"><%# Value.ExitCount %></span>
            <span class="arrowInOut">&rarr;</span>
        </div>
    </div>
</div>