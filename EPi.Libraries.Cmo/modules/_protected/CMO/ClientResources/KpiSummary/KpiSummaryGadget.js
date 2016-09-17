///<reference path="../jquery-1.3.2-vsdoc.js" />
(function ($, epi) {
    if (!epi.cmo) {
        epi.cmo = {};
    }

    epi.cmo.kpiSummaryGadget = function () {

        var temp = {};

        var runUpdateData = function (gadgetInstance) {
            if (!gadgetInstance.scheduleID) {
                gadgetInstance.scheduleID = 0;
            }
            var updateTimeout = 30000;
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

        var updateData = function (gadgetInstance) {

            var options = {
                url: gadgetInstance.getActionPath({ action: "GetData" }),
                type: 'POST',
                success: function (data) {
                    var viewData = data.data;
                    var gadgetIsNotConfigured = $('input[name=InvalidConfiguration]', gadgetInstance.element).val();
                    var kpiKey = $('input[name=SelectedKpiKey]', gadgetInstance.element).val();
                    if (kpiKey == "") {
                        kpiKey = null;
                    }
                    if (viewData.KpiKey == "") {
                        viewData.KpiKey = null;
                    }
                    if (gadgetIsNotConfigured.toLowerCase() != viewData.InvalidConfiguration.toString().toLowerCase()
                            || kpiKey != viewData.KpiKey) {
                        gadgetInstance.loadView(null);
                        return;
                    }
                    if (data.errors) {
                        gadgetInstance.setErrorMessage(data.errors);
                        return;
                    }
                    gadgetInstance.clearErrorMessage();
                    
                    $.each(viewData, function (index, value) {
                        var elementToUpdate = $('.' + index, gadgetInstance.element);
                        if (elementToUpdate.length > 0) {
                            elementToUpdate.text(value);
                        }
                    });

                    $('.ResultString', gadgetInstance.element).parent().removeClass();
                    $('.ResultString', gadgetInstance.element).parent().addClass("epi-KPIGadget-result");
                    $('.ResultString', gadgetInstance.element).parent().addClass(viewData.ResultCssClassName);

                    // check if data is generated for Apple device, refresh bars.
                    if (viewData.KpiVisualizationView == "KpiBar") {
                        $('.epi-KPIGadget-bar-tick', gadgetInstance.element).css('left', viewData.AchievedWidth + '%');
                        $('.epi-KPIGadget-bar-value', gadgetInstance.element)
                            .attr('style', viewData.AnnotationValuePosition)
                            .text(viewData.ResultString);
                        $('.epi-KPIGadget-termometer-100', gadgetInstance.element).css('left', viewData.EstimatedWidth + '%');
                        $('.epi-KPIGadget-termometer-value', gadgetInstance.element)
                            .css('width', viewData.AchievedWidth + '%')
                            .removeClass('positive negative')
                            .addClass(viewData.ValueCssClass);
                    }
                    // data is generated for not Apple device, refresh gauges
                    if (viewData.KpiVisualizationView == "KpiGauge") {
                        var slGauge = $('object[name=gaugeObject]', gadgetInstance.element)[0];
                        if (slGauge) {
                            var updateFunc = function () {
                                if (slGauge != undefined && slGauge.Content != undefined) {
                                    slGauge.Content.CMGauge.UpdateGaugeValues(viewData.AchievedValue, viewData.EstimatedValue, false);
                                }
                            };
                            if (slGauge.isLoaded) {
                                updateFunc();
                            }
                        }
                    }
                }
            };

            gadgetInstance.ajax(options);
        };
        var loadKpiList = function (gadgetInstance, campaignID) {
            var options =
            {
                url: gadgetInstance.getActionPath({ action: "GetCampaignKpis" }),
                data: { campaignID: campaignID },
                dataType: "json",
                feedbackMessage: "",
                success: function (data) {
                    var kpiListControl = $("select[name=KpiKey]", gadgetInstance.element);
                    kpiListControl.empty();
                    var selectedKpi = $("input#SelectedKpiKey[type=hidden]", gadgetInstance.element).val();
                    $.each(data, function (index, item) {
                        var isDelimiter = item.Value == null || item.Value == "";
                        var option = $("<option></option>").attr("title", item.Text).text(item.Text);
                        if (isDelimiter) {
                            option.attr("disabled", "disabled");
                        } else {
                            option.val(item.Value);
                            if (item.Value == selectedKpi) {
                                option.attr("selected", "selected");
                            }
                        }
                        kpiListControl.append(option);
                    });
                    kpiListControl.change();
                }
            };
            gadgetInstance.ajax(options);
        };

        var updateStyleForMobile = function (gadgetInstance) {
            var iPhonePanel = $("div.iPhone", gadgetInstance.element);
            if (iPhonePanel && iPhonePanel.length > 0) {
                $("div.epi-gadgetFeedback").addClass("epi-gadgetFeedback-iPhone");
            }
        };

        var onloaded = function (e, gadgetInstance) {
            clearUpdateSchedule(gadgetInstance);
            updateStyleForMobile(gadgetInstance);
            // Index view
            var gadgetIsNotConfigured = $('input[name=InvalidConfiguration]', gadgetInstance.element).val();
            if (gadgetIsNotConfigured && gadgetIsNotConfigured !== "True") {
                runUpdateData(gadgetInstance);
            }
            // Settings view
            var campaignSelectControl = $("select[name=CampaignID]", this);
            if (campaignSelectControl.length > 0) {
                campaignSelectControl.change(function () {
                    var campaignID = $(this).val();
                    var kpiListPanel = $(".cms-XFormsViewer-fieldListPanel:has(select[name=KpiKey])", gadgetInstance.element);
                    if (campaignID) {
                        loadKpiList(gadgetInstance, campaignID);
                    }
                });

                if (campaignSelectControl.val() == null) {
                    campaignSelectControl.val($("option:first", campaignSelectControl).val());
                }
                campaignSelectControl.change();
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
