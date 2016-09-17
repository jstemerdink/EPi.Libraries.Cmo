<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConversionPathView.ascx.cs" Inherits="EPiServer.Cmo.UI.CMO.ConversionPathView" %>
<%@ Register Src="ConversionPathPageView.ascx" TagPrefix="cmo" TagName="ConversionPathPageView" %>
<asp:Repeater runat="server" ID="RepeaterValue">
    <ItemTemplate>
        <tr class="conversionPathRow">
            <td colspan="2">
                <cmo:ConversionPathPageView runat="server" Value="<%# Container.DataItem %>" IsLast="<%# IsLast(Container.DataItem) %>" />
            </td>
        </tr>
    </ItemTemplate>
</asp:Repeater>
