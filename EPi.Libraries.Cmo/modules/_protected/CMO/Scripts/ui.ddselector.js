//stylable dropdown selecotr widget
//
//
/// <reference path="jQuery/jquery-1.3.2-vsdoc.js" />

$.widget("ui.ddselector", {
    _init: function () {
        this.values = [this.element.selectedValues()[0]];
        this.element.css({ 'visibility': 'hidden', 'position': 'absolute' });
        var $container = this._getContainer();
        var $input = this._getInputField();
        $container.append($input);
        this.element.before($container);
        var $button = this._getButton();
        var $limiter = this._getInputLimiter($input);
        var $selector = this._getStyledSelector($limiter);
        $input.append($limiter);
        $input.append($button);
        $('body').append($selector);
        this.oLimiter = $limiter;
        this.oSelector = $selector;
        this.oInput = $input;
        this.oButton = $button;
        this.oContainer = $container;
        this._adjustSelector();
        $('body').bind('click', this, function (e) { e.data._hideDD(e.data); })
    },
    _getContainer: function () {
        var $container = $('<span />').attr({ 'class': this.options.styleName });
        if (this.options.disabled) $container.addClass('disabled');
        return $container;
    },
    _getInputLimiter: function ($input) {
        var $limiter = $('<span />')
            .addClass('ddlimiter')
            .css({ 'width': $input.width() - 33 });
        return $limiter;
    },
    _getButton: function () {
        var $button = $("<a href='#' />").append($('<span />').attr({ 'class': 'ddicon' }));
        return $button.bind("keydown", this, function (e) {
            var curSelection = $('li.hover', $(e.data.oSelector));
            switch (e.keyCode) {
                case 40:  // down
                    e.preventDefault();
                    if (e.data.oSelector.is(':visible')) {
                        if (curSelection.length == 0) {
                            curSelection = $('li:first', $(e.data.oSelector)).addClass('hover');
                        }
                        else {
                            curSelection.removeClass('hover');
                            curSelection = curSelection.next();
                            curSelection.addClass('hover');
                        }
                    }
                    else {
                        e.data._showDD(e.data);
                    }
                    break;

                case 38:  // up
                    e.preventDefault();
                    if (e.data.oSelector.is(':visible')) {
                        if (curSelection.length == 0) {
                            curSelection = $('li:last', $(e.data.oSelector)).addClass('hover');
                        }
                        else {
                            curSelection.removeClass('hover');
                            curSelection = curSelection.prev();
                            curSelection.addClass('hover');
                        }
                    } else {
                        e.data._showDD(e.data);
                    }
                    break;

                case 27:  // Esc
                    e.preventDefault();
                    e.data._hideDD(e.data);
                    break;
                case 9:  // Tab
                    e.data._hideDD(e.data);
                    break;

                case 13: // Enter
                    e.preventDefault();
                    if (curSelection.length != 0) {
                        curSelection.click();
                    }
                    break;
            }
        }).bind('focus', this, function (e) {
            e.data.oContainer.addClass('ui-ddselector-focused');
        }).bind('blur', this, function (e) {
            e.data.oContainer.removeClass('ui-ddselector-focused');
        });
    },
    _getInputField: function () {
        var $input = $('<div />')
            .attr({ 'class': 'ddvaluebox_div' })
            .bind('click', this, function (e) { e.stopPropagation(); e.data.focus(); e.data._toggleDD(e.data); });
        return $input;
    },
    _adjustSelector: function () {
        var offset = this.oContainer.offset();
        this.oSelector.css({ 'top': offset.top + this.oContainer.height(), 'left': offset.left + 1 }).width(this.oContainer.width());
    },
    _showDD: function (o) {
        if (!this.options.disabled) {
            o._adjustSelector();
            o.oInput.blur();
            o.oButton.addClass('ddiconup');
            o.oSelector.show();
        }
    },
    _hideDD: function (o) {
        if (!this.options.disabled) {
            o.oInput.blur();
            o.oButton.removeClass('ddiconup');
            o.oSelector.hide();
        }
    },
    _toggleDD: function (o) {
        if (!this.options.disabled) {
            o._adjustSelector();
            o.oInput.blur();
            o.oButton.toggleClass('ddiconup');
            o.oSelector.toggle();
        }
    },
    _countCharNum: function (s, extr) {
        var $tester = this._getInputField().html(s).css({ 'width': 'auto' });
        var $counter = this._getContainer();
        $counter.css({ 'position': 'absolute', 'display': 'none' });
        $counter.append($tester);
        this.element.parent().before($counter);
        var limit = $tester.html().length;
        while (this.element.parent().width() - (extr ? extr : 0) <= $counter.width()) {
            $tester.html($tester.html().substring(0, limit) + '...');
            limit--;
        }
        $counter.remove();
        return limit;
    },
    _cutString: function (s, extr) {
        if (!extr) extr = 0;
        var chnum = this._countCharNum(s, extr);
        if (chnum < s.length) {
            return ($.trim(s.substring(0, chnum)) + '...');
        }
        else {
            return s;
        }
    },
    _getStyledSelector: function ($limiter) {
        var $selector = this.element;
        var $obj = this;
        var select_options = new Array();
        var ul = $('<ul />').hide().addClass('ui-ddselector-ul');
        this.element.children('option').each(function () {
            var id = $(this).val().split('|')[0];
            var flagPath = $(this).val().split('|')[1];
            var li = $('<li />').attr({ 'id': $selector.attr('id') + '_' + id, 'name': $(this).val(), 'title': $(this).html() });
            if (flagPath) {
                li.css('background', "url('" + flagPath + "') 2px 0px no-repeat");
            }
            else {
                li.css('padding-left', '1px');
            }
            var span = $('<span>').html($obj._cutString($(this).html())).appendTo(li);

            if ($(this).is(':selected')) {
                $limiter.html($obj._cutString($(this).html(), 20)).attr('title', $(this).html());
                if (flagPath) {
                    $limiter.css('background', "url('" + flagPath + "') 2px 0px no-repeat");
                }
                else {
                    $limiter.css('padding-left', '1px');
                }

                if ($obj.options.changeOnInit && typeof $obj.options.onChange == 'function') {
                    $obj.options.onChange(id);
                }
            }
            if ($(this).is(':last-child')) {
                li.addClass('last');
            }
            ul.append(li);

            $(li)
			.mouseover(function (e) {
			    $('li', ul).removeClass('hover');
			    li.addClass('hover');
			})
			.mouseout(function (e) {
			    li.removeClass('hover');
			})
			.bind('click', $selector, function (e) {
			    var oldValue = $obj.values[$obj.values.length - 1];
			    var newValue = $(this).attr('name')
			    var langValue = newValue.split('|')[0];

			    e.stopPropagation();
			    $obj._hideDD($obj);

			    if (typeof $obj.options.onClick == 'function') {
			        $obj.options.onClick();
			    }

			    if ((typeof $obj.options.onChange == 'function') && (oldValue != newValue) && ($obj.options.onChange(langValue) != false)) {

			        $limiter.html($obj._cutString($(this).text(), 20));
			        $limiter.css('background', $(this).css('background') || 'none');
			        $limiter.css('padding-left', $(this).css('padding-left'));
			        e.data.selectOptions(newValue);
			        $obj.values[$obj.values.length] = newValue;
			    }
			    $obj.oButton.focus();
			});
        });
        return ul;
    },
    rollback: function () {

        if (this.values.length < 2) {
            return;
        }
        var value = this.values[this.values.length - 1];
        this.element.selectOptions(value);
    },
    destroy: function () {
        $.widget.prototype.apply(this, arguments);
    },
    focus: function () {
        this.oButton.focus();
    }
});
$.extend($.ui.ddselector, {
    defaults:
    {
        styleName: 'ui-ddselector',
        onClick: null,
        onChange: null,
        disabled: false,
        changeOnInit: false
    }
});
