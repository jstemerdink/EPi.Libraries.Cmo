<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CMReportValuesList.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.CMReportValuesList" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages"%>
<%@ Import Namespace="EPiServer.Core" %>

<asp:Repeater runat="server" ID="ValuesRepeater_2Columns">
    <ItemTemplate>
        <tr>
            <td class="cellFieldName" width="35%"><%# GetValueName(DataBinder.Eval(Container.DataItem, "ValueName").ToString())%></td>
            <td class="cellFieldValue cellPaddingRight" width="15%"><%# DataBinder.Eval(Container.DataItem,"Value") %></td>
    </ItemTemplate>
    <AlternatingItemTemplate>
            <td class="cellFieldName cellPaddingLeft" width="35%"><%# GetValueName(DataBinder.Eval(Container.DataItem, "ValueName").ToString())%></td>
            <td class="cellFieldValue cellPaddingRight" width="15%"><%# DataBinder.Eval(Container.DataItem,"Value") %></td>
        </tr>
    </AlternatingItemTemplate>
</asp:Repeater>

<asp:Repeater runat="server" ID="ValuesRepeater_1Column">
    <ItemTemplate>
        <tr>
            <td class="cellFieldName cellNoBorder" width="45%"><%# GetValueName(DataBinder.Eval(Container.DataItem, "ValueName").ToString())%></td>
            <td class="epi-noWrap cellNoBorder cellFieldValue cellPaddingRight" width="5%"><%# DataBinder.Eval(Container.DataItem,"Value") %></td>
        </tr>
    </ItemTemplate>
</asp:Repeater>
