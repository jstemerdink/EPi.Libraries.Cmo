///<reference path="../jquery-1.3.2-vsdoc.js" />
(function ($, epi) {
    if (!epi.cmo) {
        epi.cmo = {};
    }

    epi.cmo.campaignStatisticsGadget = function () {

        var temp = {};

        var updateData = function (gadgetInstance) {
            gadgetInstance.loadView("Index");
        };

        var runUpdateData = function (gadgetInstance) {
            if (!gadgetInstance.scheduleID) {
                gadgetInstance.scheduleID = 0;
            }
            var updateTimeout = 1800000; // 30 minutes
            if (gadgetInstance.scheduleID != 0) {
                updateData(gadgetInstance);
            }
            gadgetInstance.scheduleID = setTimeout(function () { runUpdateData(gadgetInstance); }, updateTimeout);
        };

        var clearUpdateSchedule = function (gadgetInstance) {
            if (gadgetInstance.scheduleID) {
                clearTimeout(gadgetInstance.scheduleID);
            }
            gadgetInstance.scheduleID = 0;
        };

        var loadPeriodTypes = function (gadgetInstance, campaignID) {
            var options =
            {
                url: gadgetInstance.getActionPath({ action: "GetPeriodTypes" }),
                data: { campaignID: campaignID },
                dataType: "html",
                feedbackMessage: "",
                success: function (data) {
                    var periodTypePanel = $("fieldset.periodTypes", gadgetInstance.element);
                    periodTypePanel.replaceWith(data);
                    setPeriodTypeVisibility(gadgetInstance);
                }
            }
            gadgetInstance.ajax(options);
        };

        var setPeriodTypeVisibility = function (gadgetInstance) {
            var visitsAndViews = $('input[name=ShowVisitsAndPageViews][type=checkbox]', gadgetInstance.element)
            if (visitsAndViews.is(':checked') && $("select[name=CampaignID]", gadgetInstance.element).val()) {
                $("fieldset.periodTypes", gadgetInstance.element).show();
            }
            else {
                $("fieldset.periodTypes", gadgetInstance.element).hide();
            }
        };

        var updateStyleForMobile = function (gadgetInstance) {
            var iPhonePanel = $("div.iPhone", gadgetInstance.element);
            if (iPhonePanel && iPhonePanel.length > 0) {
                $("div.epi-gadgetFeedback").addClass("epi-gadgetFeedback-iPhone");
            }
        };

        var onloaded = function (e, gadgetInstance) {
            updateStyleForMobile(gadgetInstance);
            clearUpdateSchedule(gadgetInstance);
            // Index view
            var controlOnIndexView = $("input[name=InvalidConfiguration]", gadgetInstance.element);
            if (controlOnIndexView.length > 0) {
                runUpdateData(gadgetInstance);
            }
            // Settings view
            var campaignSelectControl = $("select[name=CampaignID]", this);
            if (campaignSelectControl.length > 0) {

                campaignSelectControl.change(function () {
                    var campaignID = $(this).val();
                    if (campaignID) {
                        loadPeriodTypes(gadgetInstance, campaignID);
                    }
                });
                var visitsAndViews = $('input[name=ShowVisitsAndPageViews][type=checkbox]', gadgetInstance.element)
                visitsAndViews.click(function (e) {
                    setPeriodTypeVisibility(gadgetInstance);
                });
                visitsAndViews.keydown(function (e) {
                    setPeriodTypeVisibility(gadgetInstance);
                });
                setPeriodTypeVisibility(gadgetInstance);

                if (campaignSelectControl.val() == null) {
                    campaignSelectControl.val($("option:first", campaignSelectControl).val());
                    campaignSelectControl.change();
                }


            }
        };

        var onunload = function (e, gadgetInstance) {
            clearUpdateSchedule(gadgetInstance);
        };

        temp.init = function (e, gadgetInstance) {
            $(this).bind("epigadgetloaded", onloaded);
            $(this).bind("epigadgetunload", onunload);
        };

        return temp;
    } ();
} (epiJQuery, epi));
