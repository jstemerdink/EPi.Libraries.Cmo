<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PageVersionList.ascx.cs"
    Inherits="EPiServer.Cmo.UI.Units.PageVersionList" %>
<%@ Register TagPrefix="cmo" Namespace="EPiServer.Cmo.UI.Units" %>
<%@ Import Namespace="EPiServer.Core" %>
<%@ Import Namespace="EPiServer.Cmo.Cms" %>
<%@ Import Namespace="EPiServer.Framework.Localization" %>

<script type="text/javascript">
    // <![CDATA[
    var PageVersionSelectorDlg;    

    if (!PageVersionSelectorDlg) {
        PageVersionSelectorDlg =
        {
            _callerControlId: '',
            _publishedPageControlId: '',
            _languageControlId: '',
            _bulletedListControlId: '#<%= this.PageVersionsViewControl.PageVersionsBulletedList.ClientID %>',
            _hiddenPublishedPageIdControlId: '',
            _hiddenLanguageControlId: '',
            _hiddenVersionControlId: '',
            _publishedVersionStatus: '<%= LocalizationService.GetString("/episerver/cms/versionstatus/published") %>'
        };
    }

    PageVersionSelectorDlg.ActionToProcessWhenSelectPage = function() { };
    PageVersionSelectorDlg.ActionToProcessWhenCancelSelectPage = function() { };

    PageVersionSelectorDlg.InitPageVersionsDialog = function (dialogId) {
        var dialogIdSelector = '#' + dialogId;

        PageVersionSelectorDlg.OkClick = function () {
            var selectedLiElementSelector = PageVersionSelectorDlg._bulletedListControlId + ' li[class$=picked]';
            if ($(selectedLiElementSelector).length != 0) {
                $(PageVersionSelectorDlg._callerControlId).val($(selectedLiElementSelector + ' span:nth-child(2)').text() + ' [' + $(selectedLiElementSelector + ' span:last').text() + ']');
                $(PageVersionSelectorDlg._callerControlId).triggerHandler('change');
                $(PageVersionSelectorDlg._hiddenPublishedPageIdControlId).val($(PageVersionSelectorDlg._publishedPageControlId).val());
                $(PageVersionSelectorDlg._hiddenVersionControlId).val($(selectedLiElementSelector + ' span:last').text());
                $(PageVersionSelectorDlg._hiddenLanguageControlId).val($(PageVersionSelectorDlg._languageControlId).attr('value'));
            }
            $(dialogIdSelector).dialog('close');
            $(PageVersionSelectorDlg._callerControlId).focus();

        };

        PageVersionSelectorDlg.CloseDialog = function () {
            PageVersionSelectorDlg.ActionToProcessWhenCancelSelectPage();
            $(dialogIdSelector).dialog('close');
            $(PageVersionSelectorDlg._callerControlId).focus();
        };

        PageVersionSelectorDlg.VersionsLoadComplete = function (response, context) {
            var responseArray = response.split('::');
            PageVersionSelectorDlg.loadElements(responseArray);
            if ((responseArray.length == 1 && responseArray[0].indexOf(PageVersionSelectorDlg._publishedVersionStatus) != -1) || response.length == 0) {
                Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectpagenonotpublishedpageversions")) %>');
            }
            else {
                $(dialogIdSelector).dialog('open');
                // set selected row
                var selectedVersionId = $(PageVersionSelectorDlg._hiddenVersionControlId).val();
                if (selectedVersionId != "") {
                    $("li span.col6:contains('" + selectedVersionId + "')").parent().find('a').focus();
                }
            }
        }

        PageVersionSelectorDlg.ShowVersionsList = function (callerControlId, publishedPageIdControlId, versionControlId, languageControlId) {

            PageVersionSelectorDlg._callerControlId = '#' + callerControlId;
            PageVersionSelectorDlg._hiddenPublishedPageIdControlId = '#' + publishedPageIdControlId;
            PageVersionSelectorDlg._hiddenVersionControlId = '#' + versionControlId;
            PageVersionSelectorDlg._hiddenLanguageControlId = '#' + languageControlId;

            if ($(PageVersionSelectorDlg._publishedPageControlId).val() != '') {
                var argument = $(PageVersionSelectorDlg._publishedPageControlId).val() + '|' + $(PageVersionSelectorDlg._languageControlId).attr('value');
                PageVersionsView_DoCallback(argument, PageVersionSelectorDlg.VersionsLoadComplete);
            }
            else {
                Cmo.ShowAlert('<%= ScriptResourceHelper.PrepareResourceForScript(LocalizationService.GetString("/cmo/lpo/settings/selectoriginalpagefirstwarning")) %>');
            }
        }

        PageVersionSelectorDlg.loadElements = function (dataArray) {
            $(PageVersionSelectorDlg._bulletedListControlId).empty();

            var header = $("<li class='versionListHeader'></li>");
            header.append("<span class='versionListItem col1'>" + '<%= LocalizationService.GetString("/cmo/lpo/selectversion/versionnumber") %>' + "</span>")
            header.append("<span class='versionListItem col2'>" + '<%= LocalizationService.GetString("/cmo/lpo/selectversion/name") %>' + "</span>")
            header.append("<span class='versionListItem col3'>" + '<%= LocalizationService.GetString("/cmo/lpo/selectversion/status") %>' + "</span>")
            header.append("<span class='versionListItem col4'>" + '<%= LocalizationService.GetString("/cmo/lpo/selectversion/saved") %>' + "</span>")
            header.append("<span class='versionListItem col5'>" + '<%= LocalizationService.GetString("/cmo/lpo/selectversion/savedby") %>' + "</span>");
            header.append("<span class='versionListItem col6'>" + '<%= LocalizationService.GetString("/cmo/lpo/selectversion/versionid") %>' + "</span>");

            $(PageVersionSelectorDlg._bulletedListControlId).append(header);
            $.each(dataArray, function (index, rowItem) {
                var itemElementsArray = rowItem.split('||');
                if (itemElementsArray[1] != PageVersionSelectorDlg._publishedVersionStatus) {
                    var row = $("<li class='versionListRow'></li>");
                    row.append("<span class='versionListItem col1'>" + (index + 1) + "</span>");
                    $.each(itemElementsArray, function (index, item) {
                        if (index > 0) {
                            row.append($('<span class="versionListItem col' + (index + 2) + '" title="' + item + '">' + item + '</span>'));
                        }
                        else { // add anchor around the name
                            var itemAnchor = $('<a href="#" />').append(item).focus(function (e) {
                                $(PageVersionSelectorDlg._bulletedListControlId + ' li').removeClass('picked');
                                row.addClass('picked');
                            }).keydown(function (e) {
                                if (e.keyCode == 13) { //enter
                                    e.preventDefault();
                                    PageVersionSelectorDlg.OkClick();
                                }
                            });
                            row.append($('<span class="versionListItem col' + (index + 2) + '" title="' + item + '"></span>').append(itemAnchor));
                        }
                    });
                    row.dblclick(PageVersionSelectorDlg.OkClick);
                    row.click(function () {
                        $(this).find('a').focus();
                    });
                    $(PageVersionSelectorDlg._bulletedListControlId).append(row);
                }
            });
        }
        $(dialogIdSelector).dialog({ autoOpen: false, title: '<%= LocalizationService.GetString("/cmo/lpo/settings/selectpageversiondialogtitle") %>', position: 'center',
            modal: true, resizable: false, width: 620, height: 300, dialogClass: 'versionDialog',
            buttons:
            {
                '<%= LocalizationService.GetString("/cmo/lpo/settings/selectpageselectbutton") %>': PageVersionSelectorDlg.OkClick,
                '<%= LocalizationService.GetString("/cmo/lpo/settings/selectpagecancelbutton") %>': PageVersionSelectorDlg.CloseDialog
            }
        });
    }

    $(function() {
        PageVersionSelectorDlg.InitPageVersionsDialog('<%= this.ClientID %>');
    });
    // ]]>  
</script>

<div id="<%= this.ClientID %>" style="display: none;">
    <cmo:PageVersionsView ID="PageVersionsViewControl" BulletedListCssClass="versionList" runat="server">
    </cmo:PageVersionsView>
</div>