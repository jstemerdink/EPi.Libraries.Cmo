<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CampaignSettingsPageSelector.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.CampaignSettingsPageSelector" %>
<%@ Register Src="PageTreeMultiSelect.ascx" TagName="PageTreeMultiSelect" TagPrefix="cmo" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>
<%@ Register TagPrefix="EPiServerUI" Namespace="EPiServer.UI.WebControls" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>
<div id="<%= ClientID %>" class="widgetWindow">
    <cmo:PageTreeMultiSelect runat="server" ID="PageTreeMulti" />
    <asp:HiddenField ID="HiddenPages" runat="server" />

    <div class="widgetHeader">
        <div class="epi-floatLeft">
            <EPiServerUI:ToolButton runat="server" Enabled="<%# !ReadOnly %>" SkinID="Add" OnClientClick="Cmo.csps.showTree();" GeneratesPostBack="false"
                Text="<%$ Resources: EPiServer, cmo.settings.pageselector.add %>"/>
        </div>
        <div class="epi-floatRight">
            <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-iconOnly epi-cmsButton-ViewThumbnails" OnClientClick="Cmo.csps.cps.switchView(0); Cmo.csps.arrangeThumbnails();" GeneratesPostBack="false" 
                ToolTip="<%$ Resources: EPiServer, cmo.settings.pageselector.thumbnailsview %>" />
            <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-iconOnly epi-cmsButton-ViewList" OnClientClick="Cmo.csps.cps.switchView(1);" GeneratesPostBack="false"
                ToolTip="<%$ Resources: EPiServer, cmo.settings.pageselector.listview %>" />
        </div>
    </div>
    <div class="widgetBody">
        <div id="DivThumbnails" style="display: none">
            <div class="pageViewCellThumb">                
                <img alt="[[name]]" class="pageViewThumb" title="<%=GetThumbnailHandlerUrlTemplate() %>" src=""  />
                <div class="pageName">
                    <a class="pageNameLink" title="[[name]]" href="<%= Path %>[[reference]]" target="_blank">[[name]]</a>
                    <asp:HyperLink runat="server" CssClass="pageNameLink epi-color-red" Text="<%$ Resources: EPiServer, cmo.settings.pageselector.remove %>"
                        Visible="<%# !ReadOnly %>" onclick="Cmo.csps.removeItem('[[index]]'); return false;" />
                </div>
            </div>
            <div title="Cmo.IsPageSelectorItemDeleted" class="pageViewCellThumb">                
                <img alt="[[name]]" class="pageViewThumb" title="<%=GetThumbnailHandlerUrlTemplate() %>" src=""  />
                <div class="pageName">
                    <span class="pageNameLink deleted" title="[[name]]">[[name]]</span>
                    <asp:HyperLink ID="HyperLink1" runat="server" CssClass="pageNameLink" Text="<%$ Resources: EPiServer, cmo.settings.pageselector.remove %>"
                        Visible="<%# !ReadOnly %>" onclick="Cmo.csps.removeItem('[[index]]'); return false;" />
                </div>
            </div>
        </div>
        <div id="DivStrings" style="display: none" class="pageScrollContent">
            <div class="pageViewCellList">
                <span class="reportCampaignLabel">
                    <a class="pageNameLink" href="<%= Path %>[[reference]]" title="[[name]]" target="_blank">[[name]]</a>
                </span>
                <asp:Label runat="server" CssClass="deletePageLink" Visible="<%# !ReadOnly %>">
                    <a href="#" onclick="Cmo.csps.removeItem('[[index]]'); return false;"><%= CmoPageBase.TranslateForHtml("/cmo/settings/pageselector/remove")%></a>
                </asp:Label>
            </div>
            <div title="Cmo.IsPageSelectorItemDeleted" class="pageViewCellList">
                <span class="reportCampaignLabel">
                    <span class="pageNameLink deleted" title="[[name]]">[[name]]</span>
                </span>
                <asp:Label runat="server" CssClass="deletePageLink" Visible="<%# !ReadOnly %>">
                    <a href="#" onclick="Cmo.csps.removeItem('[[index]]'); return false;"><%= CmoPageBase.TranslateForHtml("/cmo/settings/pageselector/remove")%></a>
                </asp:Label>
            </div>
        </div>
    </div>

    <div id="DivContent" class="widgetContentBlock">
    </div>
</div>

<script type="text/javascript">
    //<![CDATA[
    var Cmo;
    if (!Cmo) { 
        Cmo = {};
    }

    Cmo.CampaignSettingsPageSelector = function () {
        var self = this;
        
        var divMain = $('#<%= ClientID %>');
        var divThumbnails = $('#DivThumbnails', divMain);
        var divStrings = $('#DivStrings', divMain);
        var divTree = $('#<%= PageTreeMulti.ClientID %>', divMain);
        var hidden = $('#<%= HiddenPages.ClientID %>', divMain);

        var pageDataValueSeparator = '<%= EPiServer.Cmo.UI.Units.PageValues.ValueSeparator %>';

        this.items = <%= GetItemsString() %>;
        this.views = [divThumbnails, divStrings];
        this.languageID = '<%= PageTreeMulti.Language %>';
        
        this.isDeleted = function (index, item) {
            return item.deleted;
        }

        this.removeItem = function (index) {
            var func = function () {
                var scroll = $('.bodyMain').scrollTop();
                self.cps.activeView().list('remove', eval(index));
                self.arrangeThumbnails();
                $('.bodyMain').scrollTop(scroll);
            }

            Cmo.ShowConfirmation('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/settings/pageselector/removemessage"))  %>', func);
        }

        this.clearItems = function () {
            self.items = [];
            self.cps.items = self.items;
            self.cps.showList();
        }

        this.showTree = function () {
            divTree.pageTreeMultiselect('selectedPages', self.items);
            divTree.pageTreeMultiselect('show');
        }

        this.addPage = function (event, ui) {
            // Remove deleted pages first
            for (var i=self.items.length-1; i>=0; i--)
            {
                var curPage = self.items[i];
                var pageDeleted = true;
                $.each(ui.pages, function() {
                    if (this.reference == curPage.reference) {
                        pageDeleted = false;
                    }
                });
                if (pageDeleted) {
                    self.items.splice(i, 1);
                }
            }

            // Add added pages
            $.each(ui.pages, function () {
                var curPage = { reference: this.reference, name: this.name };
                var pageFound = false;
                $.each(self.items, function () {
                    if (this.reference == curPage.reference) {
                        pageFound = true;
                        return false;
                    }
                });
                if (!pageFound) {
                    curPage.id = 0;
                    curPage.modified = '';
                    curPage.language = self.languageID;
                    curPage.deleted = false;
                    self.items[self.items.length] = curPage;
                }
            });

            self.cps.items = self.items;
            self.cps.showList();
            self.arrangeThumbnails();
        }       

        this.getPageDataString = function () {
            var result = '';
            for (var item in self.items) {
                result += (result ? ',' : '') + self.items[item].reference
                    + pageDataValueSeparator + self.items[item].id
                    + pageDataValueSeparator + encodeURI(self.items[item].name)
                    + pageDataValueSeparator + self.items[item].modified
                    + pageDataValueSeparator + self.items[item].language
                    + pageDataValueSeparator + self.items[item].deleted
                    ;
            }
            return result;
        }

        this.onChange = function () {
            self.cps.items = self.cps.activeView().list('items');
            self.items = self.cps.items;
            var result = self.getPageDataString();
            if (hidden.val() == result) {
                return;
            }
            
            hidden.val(result);
            EPi.PageLeaveCheck.SetPageChanged(true);
        }

        this.refreshTree = function () {
            divTree.pageTreeMultiselect('treeRefresh');
        }

        this.onReady = function () {
            hidden.val(self.getPageDataString());
            self.cps.showList();
            self.arrangeThumbnails();
            divTree.bind('pageSelect_onSelectionOk', self.addPage);
        }

        this.arrangeThumbnails = function() {
            var containerWidth = divMain.closest('.epi-contentContainer').width();
            var widgetWidth = containerWidth - 48;
            $('.widgetHeader', divMain).width(widgetWidth);
            $('.widgetBody', divMain).width(widgetWidth);
            if (self.items.length != 0) {
                var itemWidth = $('> div:first-child', divThumbnails).width();
                var itemMinWidth = itemWidth + 4;
                var n = parseInt(widgetWidth / itemMinWidth);
                var pad = (widgetWidth - n * (itemWidth)) / (n - 1);
                divThumbnails.width(n * (itemWidth + pad) + 10);
                $('> div', divThumbnails).css('padding-right', pad);
            }

            //adjust height
            var thumbs = $('> div', divThumbnails);
            thumbs.height('auto');
            for (var i = 0; i < Math.ceil(thumbs.length / 4); i++) {
                var maxH = 0;
                for (var j = 4*i; j < 4*i + 4; j++) {
                    maxH = Math.max(maxH, thumbs.eq(j).height());
                }
                for (var j = 4*i; j < 4*i + 4; j++) {
                    thumbs.eq(j).height(maxH);
                }
            }
        }
        $(window).resize(this.arrangeThumbnails);

        $('img', divThumbnails).each(function () {
            this.src = this.title;
            this.title = this.alt;
        });

        this.cps = new Cmo.CampaignPageSelector(self.items, self.views, { onChange : self.onChange });
    }

    Cmo.csps = new Cmo.CampaignSettingsPageSelector();

    $(document).ready(Cmo.csps.onReady);
    //]]>

</script>

