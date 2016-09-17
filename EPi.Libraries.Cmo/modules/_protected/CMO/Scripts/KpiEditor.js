/// <reference path="jQuery/jquery-1.3.2-vsdoc.js" />
(function ($) {
    $.widget("ui.kpiEditor",
    {
        _init: function () {
            var self = this,
                o = this.options;

            this.editorState = { "initial": 1, "editKpi": 2, "addKpi": 3 };
            this.currentState = this.editorState.initial;

            this.settingsHidden = o.uiElements.settingsHidden;

            this.kpiItemSelector = $(o.uiElements.kpiItemSelector);
            this.kpiItemRegionSelector = $(o.uiElements.kpiItemRegionSelector);

            this.kpiList = o.kpiList;

            this.settingsPanel = $("#" + o.uiElements.settingsPanelID);
            this.addKpiElement = $("#" + o.uiElements.addKpiElementID);
            this.hideWhenEditorShownElement = $("#" + o.uiElements.hideWhenEditorShownElementID);
            this.hideSettingsElement = $("#" + o.uiElements.hideSettingsElementID);
            this.saveElement = $("#" + o.uiElements.saveElementID);
            this.resetElement = $("#" + o.uiElements.resetElementID);
            this.settingsTitleElement = $("#" + o.uiElements.settingsTitleElementID);

            this.kpiIDControl = $("#" + o.uiElements.kpiIDControlID);
            this.kpiNameControl = $("#" + o.uiElements.kpiNameControlID);
            this.kpiValueControl = $("#" + o.uiElements.kpiValueControlID);
            this.kpiExpectedValueControl = $("#" + o.uiElements.kpiExpectedValueControlID);
            this.kpiTypeControl = $("#" + o.uiElements.kpiTypeControlID);

            this.validators = $(o.uiElements.validatorSelector);
            this.validationSummary = $("#" + o.uiElements.validationSummaryID);

            $.each(o.kpiTypeData, function (index, item) {
                if (item.selectControl && item.editControl) {
                    item.selectControl.change(function (e) {
                        self._updateSettingsForSelected(item);
                    });
                }
            });

            this.kpiItemSelector.click(function (e) {
                self._selectKpi(this);
            });

            this.kpiItemSelector.hover(function (e) { $(this).css("cursor", "pointer"); }, function (e) { $(this).css("cursor", "default"); });

            this.addKpiElement.click(function (e) {
                self._addKpi();
            });

            this.hideSettingsElement.click(function (e) {
                self._hideSettings();
            });

            this.resetElement.click(function (e) {
                self._reset();
            });

            this.kpiTypeControl.change(function (e) {
                self._updateSettingsForKpiType();
            });

            this.kpiTypeControl.change();

            if (o.uiElements.settingsHidden && $("#" + o.uiElements.validationSummaryID).text().trim() == "") {
                this._hideSettings();
            }
            else {
                this._showSettings();
                var kpiID = this.kpiIDControl.val();
                if (kpiID) {
                    var kpiItem = this.kpiItemSelector.filter("#" + kpiID);
                    if (kpiItem) {
                        this._selectKpiInList(kpiItem);
                    }
                }
            }
        },

        // Workaround to select option when value contains quote
        _setSelectedOption: function (selectSelector, value) {
            var options = $("option", selectSelector);
            var foundOption = false;
            options.each(function () {
                if ($(this).val() == value) {
                    selectSelector.val(value);
                    foundOption = true;
                }
            })
            return foundOption;
        },

        _addKpi: function () {
            this._reset();
            this.currentState = this.editorState.addKpi;
            this._showSettings();
        },

        _showSettings: function (checkIfHidden) {
            if (!checkIfHidden || this.settingsHidden) {
                if (this.hideWhenEditorShownElement) {
                    this.hideWhenEditorShownElement.hide();
                }
                this.settingsPanel.show();
                this.settingsPanel.find(':input:enabled:eq(0)').focus();
                this.settingsHidden = false;
            }
        },

        _hideSettings: function () {
            if (!this.settingsHidden) {
                this.settingsPanel.hide();
                this.settingsHidden = true;
                if (this.hideWhenEditorShownElement) {
                    this.hideWhenEditorShownElement.show();
                }
            }
        },

        _reset: function () {
            this.currentState = this.editorState.initial;
            this._resetKpiList();
            this._resetSettings();
        },

        _resetSettings: function () {
            this.kpiTypeControl.val("");
            this.kpiIDControl.val("");
            this.kpiNameControl.val("");
            this.kpiValueControl.val("");
            this.kpiExpectedValueControl.val("");
            for (var index in this.options.kpiTypeData) {
                var kpiTypeDataItem = this.options.kpiTypeData[index];
                if (kpiTypeDataItem.editControl) {
                    kpiTypeDataItem.editControl.val("");
                    kpiTypeDataItem.editControl.removeAttr("disabled");
                }
                if (kpiTypeDataItem.selectControl) {
                    kpiTypeDataItem.selectControl.val("");
                    kpiTypeDataItem.selectControl.removeAttr("disabled");
                }
            }
            this.validators.hide();
            this.validationSummary.hide();
            this.kpiTypeControl.removeAttr("disabled");
            this.kpiTypeControl.change();
            this._updateSettingTexts();
        },

        _resetKpiList: function () {
            this.kpiItemRegionSelector.removeClass(this.options.uiElements.kpiItemSelectedClass);
        },

        _selectKpiInList: function (kpiElement) {
            this._resetKpiList();
            $(kpiElement).parents(this.options.uiElements.kpiItemRegionSelector).addClass(this.options.uiElements.kpiItemSelectedClass);
        },

        _fillSettings: function (id, type, name, value, expectedValue, parameter) {
            this.kpiIDControl.val(id);
            this.kpiTypeControl.val(type);
            this.kpiNameControl.val(name);
            this.kpiValueControl.val(value);
            this.kpiExpectedValueControl.val(expectedValue);
            for (var index in this.options.kpiTypeData) {
                var kpiTypeDataItem = this.options.kpiTypeData[index];
                if (kpiTypeDataItem.typeName == type) {
                    if (kpiTypeDataItem.selectControl) {
                        // we use workaround to select option when value contains quote - see method _setSelectedOption.
                        // The problem is that jQuery cannot find select option where value contains quote and 
                        // context is used in query, code like this throws exception: 
                        // $("option[value='" + parameter + "']", kpiTypeDataItem.selectControl),
                        if (!parameter || parameter == "" || !this._setSelectedOption(kpiTypeDataItem.selectControl, parameter)) {
                            kpiTypeDataItem.selectControl.val(this.options.uiElements.manualInputValue);
                        }
                        if (!this.options.uiElements.canEditKpiParameter) {
                            kpiTypeDataItem.selectControl.attr("disabled", true);
                        }
                    }
                    if (kpiTypeDataItem.editControl) {
                        kpiTypeDataItem.editControl.val(parameter);
                        if (!this.options.uiElements.canEditKpiParameter) {
                            kpiTypeDataItem.editControl.attr("disabled", true);
                        }
                    }
                    break;
                }
            }
            this.kpiTypeControl.change();
            this.kpiTypeControl.attr("disabled", true);
        },

        _selectKpi: function (element) {
            var kpiID = $(element).attr("id").replace('kpi_', '');
            var selectedKpi;
            for (var index in this.kpiList) {
                var kpi = this.kpiList[index];
                if (kpi.id == kpiID) {
                    selectedKpi = kpi;
                    break;
                }
            }
            if (!selectedKpi) {
                return;
            }
            this.currentState = this.editorState.editKpi;
            this._selectKpiInList(element);
            this.validators.hide();
            this.validationSummary.hide();
            this._fillSettings(kpi.id, kpi.type, kpi.name, kpi.value, kpi.expectedValue, kpi.parameter);
            this._updateSettingTexts();
            this._showSettings();
        },

        _updateSettingTexts: function () {
            switch (this.currentState) {
                case this.editorState.editKpi:
                    this.saveElement.val(this.options.uiTexts.editKpiButtonText);
                    this.settingsTitleElement.text(this.options.uiTexts.editKpiTitleText);
                    break;

                case this.editorState.initial:

                case this.editorState.addKpi:

                default:
                    this.saveElement.val(this.options.uiTexts.addKpiButtonText);
                    this.settingsTitleElement.text(this.options.uiTexts.addKpiTitleText);
                    break;
            }
        },

        _updateSettingsForKpiType: function () {
            var selectedType = this.kpiTypeControl.val();
            if (!selectedType) {
                return;
            }
            for (var index in this.options.kpiTypeData) {
                var kpiTypeDataItem = this.options.kpiTypeData[index];
                var isSelectedType = kpiTypeDataItem.typeName == selectedType;

                if (isSelectedType) {
                    if (kpiTypeDataItem.editPanel) {
                        kpiTypeDataItem.editPanel.show();
                    }
                    if (kpiTypeDataItem.selectControl && kpiTypeDataItem.editControl) {
                        kpiTypeDataItem.selectControl.change();
                    }
                }
                else {
                    if (kpiTypeDataItem.editPanel) {
                        kpiTypeDataItem.editPanel.hide();
                    }
                }

                for (var validatorItem in kpiTypeDataItem.validators) {
                    var validator = $("#" + kpiTypeDataItem.validators[validatorItem])[0];
                    ValidatorEnable(validator, isSelectedType);
                }
            }
        },

        _updateSettingsForSelected: function (kpiTypeDataItem) {
            var selectedValue = kpiTypeDataItem.selectControl.val();
            if (selectedValue && selectedValue != this.options.uiElements.manualInputValue) {
                var selectedOption = $("option[selected]", kpiTypeDataItem.selectControl);
                if (selectedOption.length > 0) {
                    kpiTypeDataItem.selectControl.attr("title", selectedOption.text());
                }
                kpiTypeDataItem.editControl.val(selectedValue);
                kpiTypeDataItem.editControl.hide();
                $("label[for='" + kpiTypeDataItem.editControl.attr("id") + "']").hide();
                $.each(kpiTypeDataItem.validators, function (index, item) {
                    var validator = $("#" + item)[0];
                    ValidatorEnable(validator, false);
                });
            }
            else {
                kpiTypeDataItem.selectControl.attr("title", "");
                $("label[for='" + kpiTypeDataItem.editControl.attr("id") + "']").show();
                if (this.currentState == this.editorState.addKpi) {
                    kpiTypeDataItem.editControl.val("");
                }
                kpiTypeDataItem.editControl.show();
                $.each(kpiTypeDataItem.validators, function (index, item) {
                    var validator = $("#" + item)[0];
                    ValidatorEnable(validator, true);
                });
            }
        }
    });


    $.extend($.ui.kpiEditor, {
        defaults: {
            uiElements:
            {
                settingsPanelID: "",
                kpiIDControlID: "",
                kpiNameControlID: "",
                kpiValueControlID: "",
                kpiExpectedValueControlID: "",
                kpiTypeControlID: "",
                canEditKpiParameter: true,
                manualInputValue: "DC3009E4E9B841D39F0C47029D7556B7",
                validatorSelector: "",
                validationSummaryID: "",
                addKpiElementID: "",
                hideWhenEditorShownElementID: "",
                hideSettingsElementID: "",
                resetElementID: "",
                saveElementID: "",
                settingsTitleElementID: "",
                kpiItemSelector: "",
                kpiItemRegionSelector: "",
                kpiItemSelectedClass: "",
                settingsHidden: true
            },
            uiTexts:
            {
                addKpiButtonText: "Add",
                editKpiButtonText: "Apply",
                addKpiTitleText: "New KPI",
                editKpiTitleText: "Edit KPI"
            },
            kpiList: [],
            kpiTypeData: []
        }
    });

})(jQuery)