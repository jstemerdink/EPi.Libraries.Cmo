<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageTreeMultiSelect.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.PageTreeMultiSelect" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>

<script type="text/javascript">
    // <![CDATA[

    $.widget("ui.pageTreeMultiselect",
    {
        _init: function () {
            var self = this, o = this.options;

            this._refreshSelectedPages();
            this.Overlay = Cmo.CreateOverlay('pageTreeOverlay');
            this.Overlay.hide();
            $('body').append(this.Overlay);

            this.element.dialog({ autoOpen: false, title: '<%= LocalizationService.GetString("/cmo/lpo/settings/selectpagedialogtitle") %>', position: 'center',
                height: 280, width: 600, modal: false, resizable: false, beforeclose: function () { $('#pageTreeOverlay').hide(); self._restoreFocus(); },
                buttons: {
                    '<%= LocalizationService.GetString("/button/ok") %>': function () { self._okClick() },
                    '<%= LocalizationService.GetString("/button/cancel") %>': function () { self._closeClick() }
                }
            });

            this.element.parent().attr('id', 'MultiselectDialogDiv');

            $("#<%=AddPageButton.ClientID %>").click(function () {
                self._addSelectedPage();
                return false;
            });

            $("#<%=RemovePageButton.ClientID %>").click(function () {
                self._removeSelectedPage();
                return false;
            });

            $(this.element).keydown(function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    o.tree.MouseDown(e);
                    o.tree.NodeClicked(e);
                    self._addSelectedPage();
                }
            });

            $('.pageSelectorItem').live('dblclick', function () {
                self._addSelectedPage();
            });
        },

        _addSelectedPage: function () {
            if (this.options.selectedPageInTree == undefined) { return };
            if (this.options.selectedPageInTree.notVisible) {
                Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectedpagenotvisible")) %>');
                return;
            }
            if (this.options.selectedPageInTree.noLang) {
                Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectedpagehasnolang")) %>');
                return;
            }
            for (var i = 0; i < this.options.selectedPages.length; i++) {
                if (this.options.selectedPages[i].reference == this.options.selectedPageInTree.reference) {
                    Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectpagedialogalerttext")) %>');
                    return;
                }
            }
            this.options.selectedPages[this.options.selectedPages.length] = this.options.selectedPageInTree;
            this._refreshSelectedPages();
            $("#selectedPages").scrollTop($("#selectedPages").attr("scrollHeight"));
            return false;
        },

        _removeSelectedPage: function () {

            var pagesArray = this.options.selectedPages;
            $('#selectedPages ul li a').each(function (index) {
                if ($(this).parent().hasClass('selected')) {
                    pagesArray[index].del = true;
                }
            });

            for (var i = this.options.selectedPages.length - 1; i >= 0; i--) {
                if (this.options.selectedPages[i].del == true) {
                    this.options.selectedPages.splice(i, 1);
                }
            }
            this._refreshSelectedPages();
            return false;
        },

        _restoreFocus: function () {
            if (this.options.callerControlId) {
                $('#' + this.options.callerControlId).focus();
            }
        },

        _okClick: function () {
            this._trigger("onSelectionOk", null, { pages: this.options.selectedPages });
            this._closeClick();
        },

        _closeClick: function () {
            this.options.selectedPages = new Array();
            this.element.dialog('close'); ;
        },

        _selectedPages: function () {
            return this.options.selectedPages;
        },

        _setData: function (key, value) {
            switch (key) {
                case 'selectedPages':
                    this.options.selectedPages = value.slice();
                    this._refreshSelectedPages();
                    this._trigger('change', null, {});
                    break;
            }
        },

        _refreshSelectedPages: function () {
            $('#selectedPages ul').empty();
            if (this.options.selectedPages == undefined) return;
            var self = this;
            for (var index = 0; index < this.options.selectedPages.length; index++) {
                var name = this.options.selectedPages[index].name;
                var regExp1 = new RegExp("<", "g");
                var regExp2 = new RegExp(">", "g");
                name = name.replace(regExp1, '&lt;');
                name = name.replace(regExp2, '&gt;');
                var pageRef = $('<a href="#">' + name + '</a>');
                pageRef[0].index = index;
                var pageItem = $('<li></li>').append(pageRef);

                $('#selectedPages ul').append(pageItem);
                pageRef.click(function () {
                    $(this).parent().toggleClass('selected');
                    return false;
                })
                .dblclick(function () {
                    self.options.selectedPages.splice(this.index, 1);
                    self._refreshSelectedPages();
                    return false;
                });
                ;
            }
        },

        selectedPages: function (pages) {
            if (pages == undefined) {
                return this._selectedPages();
            }
            this._setData('selectedPages', pages);
            return this;
        },

        callerControlId: function (id) {
            if (id == undefined)
                return this.options.callerControlId;
            this.options.callerControlId = id;
            return this;
        },

        show: function () {
            this.Overlay.show();
            this.element.dialog('open');
            this._refreshSelectedPages();
        },

        treeInit: function (treeView) {
            this.options.tree = treeView;
            treeView.OnNodeSelected = this.treeNavigation;
            treeView.pageTreeMultiselect = this;
        },

        treeNavigation: function (itemDataPath) {

            var node = this.GetListNode(itemDataPath);
            var noLang = ($(node).find("span.selected a.<%=NoLangCssClassName %>").length > 0);
            var notVisible = ($(node).find("span.selected a.<%=NotVisibleCssClassName %>").length > 0);

            var pageName = this.GetPropertyValue(itemDataPath, "PageName");
            this.pageTreeMultiselect.options.selectedPageInTree = { name: pageName, reference: itemDataPath, noLang: noLang, notVisible: notVisible };
        },

        treeRefresh: function () {
            this.options.tree.RefreshChildren();
        }

    });

    $.extend($.ui.pageTreeMultiselect, {
        eventPrefix:"pageSelect_",
        defaults: {
            selectedPages: new Array(),
            onSelectionOk: null
        }
    });

    $(function() {
        $('#<%=this.ClientID %>').pageTreeMultiselect();
    })
    // ]]>	
</script>         

<div id="<%=this.ClientID %>" style="display: none;">
    <div class="dialogPageSelectHeading">
        <div class="dialogPageSelectHeadingLeft"><%= LocalizationService.GetString("/cmo/settings/pageselector/availablepages")%></div>
        <div class="dialogPageSelectHeadingRight"><%= LocalizationService.GetString("/cmo/settings/pageselector/selectedpages")%></div>
    </div>
    <div class="dialogPageSelect">
        <div class="dialogPageSelectDiv">
            <input type="hidden" id="selectedPageLink" name="selectedPageLink" runat="server" />
            <input type="hidden" id="selectedPageName" name="selectedPageName" runat="server" />
            <cmo:PageTreeView ID="pageTreeView" DataSourceID="pageDataSource" CssClass="episerver-pagetreeview"
                runat="server" ExpandDepth="2" ExpandOnSelect="false" DataTextField="PageName"
                DataNavigateUrlField="LinkURL" EnableViewState="false" DataAttributeFields="Created,Changed,PageLink,PageName"
                MultiSelectEnabled="false">
                <treenodetemplate>
                    <a class="pageSelectorItem <%# AnchorCssClass((EPiServer.Cmo.UI.Units.PageTreeNode)Container.DataItem)%>" href="<%# ((EPiServer.Cmo.UI.Units.PageTreeNode)Container.DataItem).NavigateUrl %>"><%# HttpUtility.HtmlEncode(((EPiServer.Cmo.UI.Units.PageTreeNode)Container.DataItem).Text)%></a>
                </treenodetemplate>
            </cmo:PageTreeView>
            <cmo:CmoPageDataSource ID="pageDataSource" UseFallbackLanguage="true" AccessLevel="NoAccess"
                runat="server" IncludeRootPage="false" PageLink="<%# EPiServer.Core.PageReference.RootPage %>"
                EvaluateHasChildren="true" EnableVisibleInMenu="false" PublishedStatus="Ignore" />  
        </div>
        <div class="dialogPageSelectorChoice">
            <EPiServerUI:ToolButton runat="server" ID="AddPageButton" CssClassInnerButton="epi-cmsButton-Right" OnClientClick="" GeneratesPostBack="false" />
            <br /><br />
            <EPiServerUI:ToolButton runat="server" ID="RemovePageButton" CssClassInnerButton="epi-cmsButton-Left" OnClientClick="" GeneratesPostBack="false" />
        </div>
        <div class="dialogPageSelectDiv" id="selectedPages">
            <ul class="selectedPages"><li></li></ul>
        </div>
    </div>
</div>
