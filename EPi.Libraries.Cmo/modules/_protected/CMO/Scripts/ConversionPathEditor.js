    /// <reference path="jQuery/jquery-1.3.2-vsdoc.js" />
(function ($) {
    $.widget("ui.conversionPathEditor", {

        _init: function () {
            var self = this, o = this.options;

            this.pathNameTextBox = $('#' + o.pathNameTextBoxId);

            this.addRightButton = $('#' + o.addRightButtonId);
            this.addLeftButton = $('#' + o.addLeftButtonId);
            this.upButton = $('#' + o.upButtonId);
            this.downButton = $('#' + o.downButtonId);

            this.leftSelect = this.element.find('#' + o.leftListId);
            this.rightSelect = this.element.find('#' + o.rightListId);
            this.rightHidden = this.element.find('#' + o.rightListHiddenId);

            this.rightSelect.empty();

            if (this.rightHidden.val()) {
                $.each(this.rightHidden.val().split(','), function (index, value) {
                    var leftOption = $(self.leftSelect).find('option[value=' + value + ']');
                    if (leftOption) {
                        leftOption.clone().appendTo(self.rightSelect);
                        leftOption.addClass(o.disabledOptionClass);
                    }
                });
            }

            // initial state setup
            this._afterListChange();

            this.leftSelect.dblclick(function (e) {
                self.addRight();
            });

            this.rightSelect.dblclick(function (e) {
                self.removeRight();
            });

            this.leftSelect.change(function (e) { self._changeButtonsState() });
            this.rightSelect.change(function (e) { self._changeButtonsState() });

            this.leftSelect.keydown(function (e) {
                if (e.keyCode == 13) {
                    self.addRight();
                }
            });

            this.rightSelect.keydown(function (e) {
                if (e.keyCode == 13) {
                    self.removeRight();
                }
            });

        },

        showEditor: function () {
            this.element.show();
        },

        hideEditor: function () {
            this._clearForm();
            this.element.hide();
            $("#" + this.options.validationSummaryId, this.element).hide();
            $("span[validationGroup=" + this.options.validationGroupName + "]", this.element).hide();
        },

        // add page from pages list to selected pages
        addRight: function () {
            var selectedOption = this.leftSelect.find('option:selected');
            if (this.rightSelect.find('option[value=' + selectedOption.attr('value') + ']').length > 0) {
                Cmo.ShowAlert(this.options.messages.pageExistMessageText);
            }
            else if (this.rightSelect.find('option').length >= this.options.maximumPages) {
                Cmo.ShowAlert(this.options.messages.cantAddMorePagesMessageText);
            }
            else {
                selectedOption.clone().appendTo(this.rightSelect);
                selectedOption.addClass(this.options.disabledOptionClass);
            }

            this._afterListChange();
        },

        // removes currently selected page from selected pages
        removeRight: function () {
            var selectedOption = this.rightSelect.find('option:selected');
            this.leftSelect.find('option[value=' + selectedOption.attr('value') + ']').removeClass(this.options.disabledOptionClass);

            selectedOption.remove();
            this._afterListChange();
        },

        // moves currently selected page to upper position
        upRight: function () {
            var selectedOption = this.rightSelect.find('option:selected');
            selectedOption.insertBefore(selectedOption.prev());

            this._afterListChange();
        },

        // moves currently selected page to lower position
        downRight: function () {
            var selectedOption = this.rightSelect.find('option:selected');
            selectedOption.insertAfter(selectedOption.next());

            this._afterListChange();
        },

        getSelectedPagesCount: function () {
            return this.rightSelect.find('option').length;
        },

        _afterListChange: function () {
            this._changeButtonsState();
            this._updateHidden();
        },

        // updates buttons state according to selected items 
        _changeButtonsState: function () {
            var selectedLeft = this.leftSelect.find('option:selected');
            var selectedPages = this.rightSelect.find('option');
            if (selectedLeft.length == 0 || selectedPages.length >= this.options.maximumPages) {
                this._disableButton(this.addRightButton);
            }
            else {
                this._enableButton(this.addRightButton);
            }

            var selectedRight = this.rightSelect.find('option:selected');
            if (selectedRight.length == 0) {
                this._disableButton(this.addLeftButton);
            }
            else {
                this._enableButton(this.addLeftButton);
            }

            if (selectedRight.length == 1) {

                if (selectedRight.prev().length == 0) {
                    this._disableButton(this.upButton);
                }
                else {
                    this._enableButton(this.upButton);
                }

                if (selectedRight.next().length == 0) {
                    this._disableButton(this.downButton);
                }
                else {
                    this._enableButton(this.downButton);
                }
            }
            else {
                this._disableButton(this.upButton);
                this._disableButton(this.downButton);
            }
        },

        _disableButton: function (button) {
            button.attr('disabled', 'disabled');
            button.parent().addClass('epi-cmsButtondisabled');
            button.parent().removeClass('epitoolbuttonmousedown');
        },

        _enableButton: function (button) {
            button.removeAttr('disabled');
            button.parent().removeClass('epi-cmsButtondisabled');
        },

        _updateHidden: function () {
            var result = '';
            this.rightSelect.find('option').each(function (index, element) {
                result += $(element).attr('value') + ',';
            });
            this.rightHidden.val(result);
        },

        _clearForm: function () {
            this.pathNameTextBox.val('');
            this.rightSelect.empty();
            this.leftSelect.find('option').removeClass(this.options.disabledOptionClass);
            this._afterListChange();
        }

    });

    $.extend($.ui.conversionPathEditor, {
        getter: "getSelectedPagesCount",
        defaults: {
            messages: {
                pageExistMessageText: 'Page already selected',
                cantAddMorePagesMessageText: 'Can not add more than 4 pages'
            },
            maximumPages: 4,
            minimumPages: 2,
            leftListId: '',
            rightListId: '',
            rightListHiddenId: '',
            addRightButtonId: '',
            addLeftButtonId: '',
            upButtonId: '',
            downButtonId: '',
            pathNameTextBoxId: '',
            disabledOptionClass: 'CP-settings-disabledItem',
            validationSummaryId: '',
            validationGroupName: ''
        }
    });

    $.widget("ui.conversionPathNameEditor", {

        _init: function () {
            var self = this, o = this.options;
            this.convertionNameOriginalHidden = $('#' + o.convertionNameOriginalHiddenId);
            this.isVisibleHidden = $('#' + o.isVisibleHiddenId);
            this.buttonOk = $('#' + o.buttonOkId);
            this.buttonRename = $('#' + o.buttonRenameId);
            this.buttonCancel = $('#' + o.buttonCancelId);

            this.textBoxName = $('#' + o.textBoxNameId);
            this.validationSummary = $('#' + o.validationSummaryId);
            this.requiredFieldValidator = $('#' + o.requiredFieldValidatorId);
            this.nameUniqueValidator = $('#' + o.nameUniqueValidatorId);
            this.label = $('#' + o.labelId);

            if (this.isVisibleHidden.val() == "true") {
                this.showEditor();
            }
            else {
                this.hideEditor();
            }
        },

        showEditor: function () {
            this._hideButton(this.buttonRename);
            this._showButton(this.buttonOk);
            this._showButton(this.buttonCancel);
            this._showElement(this.textBoxName);
            this._showElement(this.label);
        },

        cancelEditor: function () {
            this.hideEditor();
            this.textBoxName.val(this.convertionNameOriginalHidden.val());
        },

        hideEditor: function () {
            this._showButton(this.buttonRename);
            this._hideButton(this.buttonOk);
            this._hideButton(this.buttonCancel);
            this._hideElement(this.textBoxName);
            this._hideElement(this.label);
            this._hideElement(this.validationSummary);
            this._hideElement(this.requiredFieldValidator);
            this._hideElement(this.nameUniqueValidator);
        },

        _hideButton: function (button) {
            button.parent().hide();
        },

        _showButton: function (button) {
            button.parent().show();
        },

        _hideElement: function (element) {
            element.hide();
        },

        _showElement: function (element) {
            element.show();
        }
    });
})(jQuery);