///<reference path="../jquery-1.3.2-vsdoc.js" />
(function ($, epi) {
    if (!epi.cmo) {
        epi.cmo = {};
    }

    epi.cmo.liveMonitorGadget = function () {

        var temp = {};

        var onloaded = function (e, gadgetInstance) {
            // Settings view
            var campaignSelectControl = $("select[name=CampaignID]", this);
            if (campaignSelectControl.length > 0) {
                if (campaignSelectControl.val() == null) {
                    campaignSelectControl.val($("option:first", campaignSelectControl).val());
                    campaignSelectControl.change();
                }
            }
        };

        temp.init = function (e, gadgetInstance) {
            $(this).bind("epigadgetloaded", onloaded);
        };

        return temp;
    } ();
} (epiJQuery, epi));
