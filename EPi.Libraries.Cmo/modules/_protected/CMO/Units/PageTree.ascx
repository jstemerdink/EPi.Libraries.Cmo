<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageTree.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.PageTree" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>

<script type="text/javascript">

    $.widget("ui.pageTree",
    {
        options: {
            selectedPageLinkClientId: '',
            selectedPageNameClientId: ''
        },

        _init: function () {
            var self = this, o = this.options;

            this.selectedPageLink = $('#' + o.selectedPageLinkClientId);
            this.selectedPageName = $('#' + o.selectedPageNameClientId);
            this.noLang = false;

            // Ok dialog button event handler
            var okClick = function () {
                if (self.notPublished) {
                    Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectedpagenotpublished")) %>');
                    return;
                }
                if (self.noLang) {
                    Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectedpagehasnolang")) %>');
                    return;
                }
                if (self.notVisible) {
                    Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectedpagenotvisible")) %>');
                    return;
                }
                self._setValues(self.selectedPageLink.val(), self.selectedPageName.val());
                closeDialog();
            };

            // Cancel dialog button event handler
            var closeDialog = function () {
                self.element.dialog('close');
            };

            var restoreFocus = function () {
                $('#' + self.callerControlId).focus();
            };

            // dialog initialization
            this.element.dialog({ autoOpen: false, title: '<%= LocalizationService.GetString("/cmo/lpo/settings/selectpagedialogtitle") %>', position: 'center',
                modal: true, resizable: false, height: 280, width: 400, beforeclose: restoreFocus,
                buttons: {
                    '<%= LocalizationService.GetString("/cmo/lpo/settings/selectpageselectbutton") %>': okClick,
                    '<%= LocalizationService.GetString("/cmo/lpo/settings/selectpagecancelbutton") %>': closeDialog
                }
            });
            $(this.element).keydown(function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    self.pageTreeView.MouseDown(e);
                    self.pageTreeView.NodeClicked(e);
                    okClick();
                }
            });
            // Auto select on dbl click
            $('.pageSelectorItem').live('dblclick', okClick);
        },

        // helper methods
        _setValues: function (value, info) {
            this.pageIdControl.val(value);
            this.pageIdControl.triggerHandler("change");

            this.pageNameControl.val(info);
            this.pageNameControl.triggerHandler("change");
            this.pageNameControl.attr("title", info);
        },

        _setLocalValues: function (value, info) {
            this.selectedPageLink.val(value);
            this.selectedPageName.val(info);
        },

        // Tree navigation event handler
        _treeNavigation: function (itemDataPath) {
            var node = this.GetListNode(itemDataPath);
            this.pageTree.noLang = false;
            this.pageTree.notPublished = false;
            this.pageTree.notVisible = false;
            if ($(node).find("span.selected a.<%=NotPublishedCssClassName %>").length > 0) {
                this.pageTree._setLocalValues('', '');
                this.pageTree.notPublished = true;
                return;
            }
            if ($(node).find("span.selected a.<%=NotVisibleCssClassName %>").length > 0) {
                this.pageTree._setLocalValues('', '');
                this.pageTree.notVisible = true;
                return;
            }
            if ($(node).find("span.selected a.<%=NoLangCssClassName %>").length > 0) {
                this.pageTree._setLocalValues('', '');
                this.pageTree.noLang = true;
                return;
            }
            var pageName = this.GetPropertyValue(itemDataPath, "PageName");
            this.pageTree._setLocalValues(itemDataPath, pageName + " [" + itemDataPath + "]");
        },

        // Tree initialization event handler
        treeInit: function (treeView) {
            this.pageTreeView = treeView;
            treeView.OnNodeSelected = this._treeNavigation;
            treeView.pageTree = this;
        },

        treeRefresh: function () {
            this.pageTreeView.RefreshChildren();
        },


        // entry point - method to show dialog with tree
        showTree: function (pageIdControlClientId, pageNameControlClientId, callerId, isPageNotFound) {
            this.callerControlId = callerId;
            this.pageIdControl = $('#' + pageIdControlClientId);
            this.pageNameControl = $('#' + pageNameControlClientId);
            this._setLocalValues(this.pageIdControl.val(), this.pageNameControl.val());
            this.element.dialog('open');

            if (this.pageIdControl.val() == '' || isPageNotFound) {

                this.element.find('a:contains("Root")').focus();
                this.element.find('span.selected').removeClass("selected");
            }
            else {
                var nodeIsNull = this.pageTreeView.GetListNode(this.pageIdControl.val()) == null;
                this.pageTreeView.NavigateToNode(this.pageIdControl.val(), true);
                window.setTimeout(
                    function () {
                        if (nodeIsNull) {
                            this.element.find('a:contains("Root")').focus();
                        }
                    }, 300);
            }
        }

    });

    $(function () {
        $('#<%=this.ClientID %>').pageTree({ selectedPageLinkClientId: '<%=selectedPageLink.ClientID %>', selectedPageNameClientId: '<%=selectedPageName.ClientID %>' });
    })
    
</script>

<div id="<%=this.ClientID %>" style="display: none;">
   <div class="dialogPageSelectDiv">
    <input type="hidden" id="selectedPageLink" name="selectedPageLink" runat="server" />
    <input type="hidden" id="selectedPageName" name="selectedPageName" runat="server" />
    <cmo:PageTreeView ID="pageTreeView" DataSourceID="pageDataSource" CssClass="episerver-pagetreeview"
        runat="server" ExpandDepth="2" ExpandOnSelect="false" DataTextField="PageName"
        DataNavigateUrlField="LinkURL" EnableViewState="false" DataAttributeFields="Created,Changed,PageLink,PageName"
        MultiSelectEnabled="false">
        <treenodetemplate>
            <a class="pageSelectorItem <%# AnchorCssClass((EPiServer.Cmo.UI.Units.PageTreeNode)Container.DataItem)%>" href="<%# ((PageTreeNode)Container.DataItem).NavigateUrl %>"><%# HttpUtility.HtmlEncode(((PageTreeNode)Container.DataItem).Text) %></a><%# GetUsedText((PageTreeNode)Container.DataItem) %> 
        </treenodetemplate>
    </cmo:PageTreeView>
    <cmo:CmoPageDataSource ID="pageDataSource" UseFallbackLanguage="true" AccessLevel="NoAccess" 
        runat="server" IncludeRootPage="false" PageLink="<%# EPiServer.Core.PageReference.RootPage %>"
        EvaluateHasChildren="true" EnableVisibleInMenu="false" PublishedStatus="Ignore" />
   </div>
</div>