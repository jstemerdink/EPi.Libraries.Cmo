/**
* Get the current coordinates of the first element in the set of matched
* elements, relative to the closest positioned ancestor element that
* matches the selector.
* @param {Object} selector
*/
jQuery.fn.positionAncestor = function (selector) {
    var left = 0;
    var top = 0;
    this.each(function (index, element) {
        // check if current element has an ancestor matching a selector
        // and that ancestor is positioned
        var $ancestor = $(this).closest(selector);
        if ($ancestor.length && $ancestor.css("position") !== "static") {
            var $child = $(this);
            var childMarginEdgeLeft = $child.offset().left - parseInt($child.css("marginLeft"), 10);
            var childMarginEdgeTop = $child.offset().top - parseInt($child.css("marginTop"), 10);
            var ancestorPaddingEdgeLeft = $ancestor.offset().left + parseInt($ancestor.css("borderLeftWidth"), 10);
            var ancestorPaddingEdgeTop = $ancestor.offset().top + parseInt($ancestor.css("borderTopWidth"), 10);
            left = childMarginEdgeLeft - ancestorPaddingEdgeLeft;
            top = childMarginEdgeTop - ancestorPaddingEdgeTop;
            // we have found the ancestor and computed the position
            // stop iterating
            return false;
        }
    });
    return {
        left: left,
        top: top
    }
};



// Tracks navigation from page
/// <reference path="jQuery/jquery-1.3.2-vsdoc.js" />
var mouseX = 0;
var mouseY = 0;
$().mousemove(function(e) {
    mouseX = e.clientX;
    mouseY = e.clientY;
});

var Cmo;

if (!Cmo) {
	Cmo = {};
}

Cmo.ShowAlert = function (text) {
    alert(text);
}

Cmo.ShowConfirmation = function (message, okButtonFunc, cancelButtonFunc) {
    var result = confirm(message);
    if (result && okButtonFunc != undefined) {
        okButtonFunc.call(this);
    }
    else if (cancelButtonFunc != undefined) {
        cancelButtonFunc.call(this);
    }
    return result;
}

Cmo.CreateOverlay = function(htmlId) {
    var overlay = $('<div class="ui-widget-overlay">');
    if ($.browser.msie && $.browser.version < 7) {
        overlay.css({ 'height': Cmo.GetDocumentHeightForIE6(), 'z-index': Cmo.GetHeighestZIndex() });
    }
    else {
        overlay.css({ 'z-index': Cmo.GetHeighestZIndex(), 'position': 'fixed' });
    }
    overlay.attr('id', htmlId);
    return overlay;
}

Cmo.GetDocumentHeightForIE6 = function() {
    var scrollHeight = Math.max(
			    document.documentElement.scrollHeight,
			    document.body.scrollHeight
		    );
    var offsetHeight = Math.max(
			    document.documentElement.offsetHeight,
			    document.body.offsetHeight
		    );

    if (scrollHeight < offsetHeight) {
        return $(window).height() + 'px';
    } else {
        return scrollHeight + 'px';
    }
}

Cmo.GetHeighestZIndex = function() {
    var maxZ = Math.max.apply(null, $.map($('body > *'), function(e, n) {
        if ($(e).css('position') == 'absolute' && $(e).hasClass("ui-dialog"))
            return parseInt($(e).css('z-index')) + 1 || 2;
        else return 2;
        })
    );
    return maxZ;
};

Cmo.getParsedGet = function() {
    var tmp = new Array();
    var tmp2 = new Array();
    var param = new Array();

    var tmp_get = location.search;
    if (tmp_get != '') {
        tmp = (tmp_get.substr(1)).split('&');
        for (var i = 0; i < tmp.length; i++) {
            tmp2 = tmp[i].split('=');
            param[tmp2[0]] = tmp2[1];
        }
    }
    return param;
}

Cmo.PrintPage = function() {
    var newLocation = window.location.href;
    var section = '';
    if (newLocation.indexOf('#') != -1) {
        section = newLocation.substring(newLocation.indexOf('#'), newLocation.length);
        newLocation = newLocation.replace(/#\S*/, '');
    }    
    if (newLocation.indexOf('?') > -1)
        newLocation = newLocation + '&print=true';
    else
        newLocation = newLocation + '?print=true';
    newLocation += section;

    window.open(newLocation);
}

Cmo.SetupDatePicker = function (element, locale, format, mindate) {
    var temp = element.val(); // datepicker changes the date value and date format when we set the minDate option, 
    // so we need to store the initial value and restore it after the datePicker init
    if (locale) {
        element.datepicker($.datepicker.regional[locale]);
    }
    element.datepicker({ showOtherMonths: true, showOn: 'button', buttonImageOnly: false, showMonthAfterYear: false });
    element.datepicker('option', 'minDate', mindate);
    if (format) {
        element.datepicker('option', "dateFormat", format);
    }
    element.datepicker('option', 'duration', 0);
    if (element.attr('disabled')) {
        element.datepicker('disable');
    }
    element.val(temp);
    element.focus(function () {
        if (element.val() == '') element.datepicker('show');
    });
    element.change(function () {
        EPi.PageLeaveCheck.SetPageChanged(true);
    });
}

Cmo.ValidateDate = function (source, args) {
    args.IsValid = jQuery.trim(args.Value).length != 0;
}

Cmo.DisablePageLeaveCheck = function () {
    EPi.PageLeaveCheck.enabled = false;
}

Cmo.ReloadPage = function () {
    window.location.href = window.location.href;
}

Cmo.KpiReportUpdate = function (gaugeClientId, hiddenClientId) {
    var data = $('#' + hiddenClientId).val();
    var dataObj = eval('(' + data + ')');
    $.each(dataObj.textdata, function (index, value) {
        if ($('#' + index).length > 0) {
            $('#' + index).text(value);
        }
    });
    $.each(dataObj.cssdata, function (index, value) {
        if ($('#' + index).length > 0) {
            $('#' + index).removeClass();
            $('#' + index).addClass(value);
        }
    });
    var gauge = $('#' + gaugeClientId)[0];
    if (gauge && gauge.isLoaded) {
        gauge.Content.CMGauge.UpdateGaugeValues(dataObj.gaugedata.AchievedValue, dataObj.gaugedata.EstimatedValue, false);
    }
}

Cmo.IsPageSelectorItemDeleted = function (index, item) {
    return eval(item.deleted);
}

Cmo.ClearMessage = function () {
    $(".CMO-systemMessage", ".bodyMain").remove();
}