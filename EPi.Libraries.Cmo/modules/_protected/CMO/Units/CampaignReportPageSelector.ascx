<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CampaignReportPageSelector.ascx.cs" Inherits="EPiServer.Cmo.UI.Units.CampaignReportPageSelector" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Core.Business" %>
<%@ Import Namespace="EPiServer.Cmo.UI.Pages" %>

<div id="<%= ClientID %>" class="widgetWindow">
    <div class="widgetHeader">
        <div class="epi-floatRight">
            <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-iconOnly epi-cmsButton-ViewThumbnails" OnClientClick="Cmo.crps.switchView(0);"
                GeneratesPostBack="false" ToolTip="<%$ Resources: EPiServer, cmo.settings.pageselector.thumbnailsview %>" />
            <EPiServerUI:ToolButton runat="server" CssClassInnerButton="epi-cmsButton-iconOnly epi-cmsButton-ViewList" OnClientClick="Cmo.crps.switchView(1);"
                GeneratesPostBack="false" ToolTip="<%$ Resources: EPiServer, cmo.settings.pageselector.listview %>" />
        </div>
    </div>
    <div class="widgetBody">
        <div id="DivContent" class="widgetContentBlock pageSelector" style='overflow: hidden'>
            <div id="DivThumbnails" style="display: none;" class="pageScrollContent pageSelector">
                <div class="pageViewCellThumb [[selected]]">
                    <div onclick="Cmo.crps.redirect('[[reference]]')">
                        <img alt="[[name]]" class="pageViewThumb" title="<%= GetThumbnailHandlerUrlTemplate() %>" src="" />
                        <div class="pageName">
                            <span class="pageNameContent" title="[[name]]">[[name]]</span>
                        </div>
                    </div>
                </div>
                <div title="Cmo.crps.IsItemForCampaign" class="pageViewCellThumb overallCampaign [[selected]]">
                    <div onclick="Cmo.crps.redirect('[[reference]]')">
                        <img alt="[[name]]" class="pageViewThumb" title="<%= EPiServer.Cmo.Cms.Helpers.UrlHelper.ResolveUrlInCmoFromSettings("Styles/Resources/campaignThumb.png") %>" src="" />
                        <div class="pageName">
                            <span class="pageNameContent" title="[[name]]">[[name]]</span>
                        </div>
                    </div>
                </div>
                <div title="Cmo.IsPageSelectorItemDeleted" class="pageViewCellThumb [[selected]]">
                    <div onclick="Cmo.crps.redirect('[[reference]]')">
                        <img alt="[[name]]" class="pageViewThumb" title="<%= GetThumbnailHandlerUrlTemplate() %>" src="" />
                        <div class="pageName">
                            <span class="pageNameContent deleted" title="[[name]]">[[name]]</span>
                        </div>
                    </div>
                </div>
            </div>
            <div id="DivStrings" style="display: none" class="pageScrollContent pageSelector">
                <div class="pageViewCellList [[selected]]">
                    <div onclick="Cmo.crps.redirect('[[reference]]')">
                        <span class="reportCampaignLabel" title="[[name]]">[[name]]</span>
                    </div>
                </div>
                <div title="Cmo.crps.IsItemForCampaign" class="pageViewCellList overallCampaign [[selected]]">
                    <div onclick="Cmo.crps.redirect('[[reference]]')">
                        <span class="reportCampaignLabel" title="[[name]]">[[name]]</span>
                    </div>
                </div>
                <div title="Cmo.IsPageSelectorItemDeleted" class="pageViewCellList [[selected]]">
                    <div onclick="Cmo.crps.redirect('[[reference]]')">
                        <span class="reportCampaignLabel deleted" title="[[name]]">[[name]]</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    //<![CDATA[
    var Cmo;
    if (!Cmo) { 
        Cmo = {};
    }

    Cmo.CampaignReportPageSelector = function () {
        var self = this;
        
        var divMain = $('#<%= ClientID %>');
        var divContent = $('#DivContent', divMain);
        var divThumbnails = $('#DivThumbnails', divContent);
        var divStrings = $('#DivStrings', divContent);
        
        var selectedReference = '<%= SelectedPageReference %>';
        var pageKey = '<%= CmoConstants.PageReferenceRequestParameter %>';
        var addItemForCampaign = <%= AddItemForCampaign.ToString().ToLower() %>;
        var itemForCampaignTitle = '<%= ItemForCampaignTitle %>';
        
        this.items = <%= GetItemsString() %>;
        this.views = [divThumbnails, divStrings];
    
        this.redirect = function (reference) {   
            var param = Cmo.getParsedGet();
            param[pageKey] = reference;
            var url = '';
            for (var key in param)
            {
                url += (url ? '&' : '?') + key + '=' + param[key];
            }
            location.href = location.pathname + url;
        }

        this.setupThumbnailsView = function () {
            if (self.cps.activeView().attr('id') != divThumbnails.attr('id')) {
                return;
            }

            self.arrangeThumbnails();
            var width = 0;
            $('> div:last-child', divThumbnails).css('padding-right', 0);
            $('> div', divThumbnails).each(function(){
                width += $(this).outerWidth();
            });
            divThumbnails.width(width);

            divContent.css('overflow-x', 'auto');
            
            for (var item in self.items)
            {
                if (self.items[item].reference == selectedReference)
                {
                    var div = $("> div:first-child", divThumbnails);
                    divContent.scrollLeft(item * div.outerWidth());
                    return;
                }
            }
            divContent.scrollLeft(0);
        }

        this.switchView = function (index) {
            self.cps.switchView(index);
            self.setupThumbnailsView();
        }

        this.functional = function (name, index, value) {
            switch (name) {
                case 'selected' :
                    return value.reference == selectedReference ? 'selected' : '';
            }
        }

        this.IsItemForCampaign = function(index, item) {
            return item.reference == '';
        }

        this.onReady = function() {
            self.cps.showList();
            self.setupThumbnailsView();
        }

        this.arrangeThumbnails = function() {
            var containerWidth = divMain.closest('.epi-contentContainer').width();
            var widgetWidth = containerWidth - 48;
            $('.widgetHeader', divMain).width(widgetWidth);
            $('.widgetBody', divMain).width(widgetWidth);
        }
        $(window).resize(this.arrangeThumbnails);

        $('img', divThumbnails).each(function () {
            this.src = this.title;
            this.title = this.alt;
        });

        if (addItemForCampaign) {
            var item = { id: 0, name: itemForCampaignTitle, reference: '' };
            self.items = $.merge([item], self.items);
        }

        this.cps = new Cmo.CampaignPageSelector(self.items, self.views, { functional : self.functional });
    }
    
    Cmo.crps = new Cmo.CampaignReportPageSelector()

    $(document).ready(Cmo.crps.onReady);
    //]]>

</script>




