﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CampaignsList.ascx.cs"
    Inherits="EPiServer.Cmo.UI.CMO.Units.CampaignsList" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages"%>
<%@ Import Namespace="EPiServer.Cmo.UI.Utility" %>
<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.CMO.Units" %>

<cmo:cmoitemlistview runat="server" id="CampaignListView">
    <HeaderTemplate>
        <table class="epi-default testsList">
            <thead>
                <tr>
                    <th> 
                        <cmo:ColumnHeader runat="server" SortFieldName="Name" SubModule="CM" Text="<%$ Resources: EPiServer, cmo.list.name %>"
                            AscendingCssClass="epi-sort-asc" DescendingCssClass="epi-sort-desc" />
                    </th>
                    <th>
                        <cmo:ColumnHeader runat="server" SortFieldName="Language" SubModule="CM" Text="<%$ Resources: EPiServer, cmo.list.language %>"
                            AscendingCssClass="epi-sort-asc" DescendingCssClass="epi-sort-desc" />
                    </th>
                    <th>
                        <cmo:ColumnHeader runat="server" SortFieldName="LastModifiedDate" SubModule="CM" Text="<%$ Resources: EPiServer, cmo.list.lastmodifieddate %>"
                            AscendingCssClass="epi-sort-asc" DescendingCssClass="epi-sort-desc" />
                    </th>
                    <th>
                        <cmo:ColumnHeader runat="server" SortFieldName="Owner" SubModule="CM" Text="<%$ Resources: EPiServer, cmo.list.owner %>"
                            AscendingCssClass="epi-sort-asc" DescendingCssClass="epi-sort-desc" />
                    </th>
                    <th>
                        <cmo:ColumnHeader runat="server" SortFieldName="LastModifiedBy" SubModule="CM" Text="<%$ Resources: EPiServer, cmo.list.lastmodifiedby %>"
                            AscendingCssClass="epi-sort-asc" DescendingCssClass="epi-sort-desc" />
                    </th>
                    <th>
                        <cmo:ColumnHeader runat="server" SortFieldName="State" SubModule="CM" Text="<%$ Resources: EPiServer, cmo.list.state %>"
                            AscendingCssClass="epi-sort-asc" DescendingCssClass="epi-sort-desc" />
                    </th>
                    <th>
                        <asp:Label runat="server" Text="<%$ Resources: EPiServer, cmo.list.edit %>" />
                    </th>
                    <th>
                        <asp:Label runat="server" Text="<%$ Resources: EPiServer, cmo.list.delete %>" />
                    </th>
                </tr>
            </thead> 
            <tbody>
    </HeaderTemplate>
    <EmptyListTemplate>
        <tr><td colspan="8"><%= CmoPageBase.TranslateForHtml("/cmo/emptyListLabel")%></td></tr>
    </EmptyListTemplate>
    <ItemTemplate>
        <tr>
            <td>
                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="<%# GetItemLink(Container.CmoItem) %>" ToolTip="<%# Container.CmoItem.Name %>">
                    <cmo:Label ID="Label1" runat="server" Text="<%# HttpUtility.HtmlEncode(Container.CmoItem.Name) %>" />
                </asp:HyperLink>
            </td>
            <td>
                <cmo:LanguageLabel runat="server" LanguageID="<%# Container.CmoItem.LanguageID %>" DisplayText="true" />
            </td>
            <td>
                <cmo:Label runat="server" Text="<%# Container.ItemDate %>" />
            </td>
            <td>
                <cmo:Label runat="server" Text="<%# HttpUtility.HtmlEncode(Container.CmoItem.Owner) %>" />
            </td>
            <td>
                <cmo:Label runat="server" Text="<%# HttpUtility.HtmlEncode(Container.CmoItem.LastModifiedBy) %>" />
            </td>
            <td>
                <cmo:Label runat="server" Text="<%# Container.CmoItem.GetLocalizedState() %>" />
            </td>
            <td>
                <EPiServerUI:ToolButton Enabled='<%# Container.CmoItem.CanBeEdited %>'
                    ToolTip='<%# String.Format(LocalizationService.GetString("/cmo/list/edittooltipformatted"), Container.CmoItem.Name) %>' 
                    CommandName="Edit" CommandArgument='<%# Container.CmoItem.ID %>' runat="server" SkinID="Edit" ID="EditButton"
                    OnCommand="OnCmoItemCommand" />
            </td>
            <td>
                <EPiServerUI:ToolButton Enabled='<%# Container.CmoItem.CanBeDeleted %>'
                    ToolTip='<%# String.Format(LocalizationService.GetString("/cmo/list/deletetooltipformatted"), Container.CmoItem.Name) %>' 
                    EnableClientConfirm="true"
                    ConfirmMessage='<%# String.Format(LocalizationService.GetString("/cmo/list/deleteconfirmformatted"), Container.CmoItem.Name) %>'
                    CommandName="Delete" CommandArgument='<%# Container.CmoItem.ID %>' runat="server" SkinID="Delete" ID="DeleteToolButton"
                    OnCommand="OnCmoItemCommand" />
            </td>
        </tr>
    </ItemTemplate>
    <FooterTemplate>
            </tbody>
        </table>
    </FooterTemplate>
</cmo:cmoitemlistview>
