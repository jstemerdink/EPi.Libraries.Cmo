var conversionPath = {};

conversionPath.listFunctional = function(name, index, item, items)
{
    switch (name)
    {
        case "nameClass":
            return item.deleted ? "deleted" : "";
        case "removeLinkClass":
            return item.readonly ? "hidden" : "pageNameLink";
        case "selectedClass":
            return item.selected && !item.readonly ? "selectedPage" : "";
    }
    return "";
}

conversionPath.replaceImgSrc = function()
{
    this.src = this.title;
    this.title = this.alt;
}

conversionPath.selectItem = function(control, index)
{
    var element = conversionPath.getElement(control);
    if (!element || !element.items[index])
    {
        return false;
    }

    for (var item in element.items)
    {
        element.items[item].selected = false;
    }
    element.items[index].selected = true;

    conversionPath.update(element, false);

    return true;
}

conversionPath.removeItem = function(control, index) {
    var element = conversionPath.getElement(control);
    if (!element || !element.items[index]) {
        return false;
    }
    
    var selected = element.items[index].selected;
    element.items[index] =  conversionPath.getDefaultConversionPathItem(element);
    conversionPath.selectItem(element.divMain[0], index);

    conversionPath.update(element, true);

    return true;
}

conversionPath.swapItems = function(control, index)
{
    var element = conversionPath.getElement(control);
    if (!element || !element.items[index] || !element.items[index + 1])
    {
        return false;
    }

    var item = element.items[index];
    element.items[index] = element.items[index + 1];
    element.items[index + 1] = item;

    conversionPath.update(element, true);

    return true;
}

conversionPath.updateItem = function(element, item)
{
    var index = -1;

    for (var temp in element.items)
    {
        if (element.items[temp].reference == item.reference)
        {
            index = -1;
            break;
        }

        if (element.items[temp].selected && !element.items[temp].readonly)
        {
            index = temp;
        }
    }

    if (!element.items[index])
    {
        return false;
    }

    element.items[index] = item;
    element.items[index].selected = true;

    conversionPath.update(element, true);

    return true;
}

conversionPath.show = function(control)
{
    var element = conversionPath.getElement(control);
    if (!element)
    {
        return;
    }

    element.divContent.show();
    element.spanHider.removeClass("collapsed");
    conversionPath.update(element, false);

    if ($.isFunction(element.divMain[0].onShow))
    {
        element.divMain[0].onShow();
    }
}

conversionPath.hide = function(control)
{
    var element = conversionPath.getElement(control);
    if (!element)
    {
        return;
    }

    element.divContent.hide();
    element.spanHider.addClass("collapsed");

    if ($.isFunction(element.divMain[0].onHide))
    {
        element.divMain[0].onHide();
    }
}

conversionPath.updateElement = function(control, item)
{
    var element = conversionPath.getElement(control);
    if (!element)
    {
        return false;
    }

    var temp = conversionPath.updateItem(element, item);

    if (temp && $.isFunction(element.divMain[0].onUpdateElement))
    {
        element.divMain[0].onUpdateElement();
    }

    return temp;
}

conversionPath.setChangedState = function(event)
{
    var element = conversionPath.getElement(event.target);
    if (!element)
    {
        return;
    }

    if ((event.type == "change") || (event.keyCode == 8)
        || (event.keyCode >= 46 && event.keyCode <= 111)
        || (event.keyCode >= 186 && event.keyCode <= 222))
    {
        element.divMain[0].changed = true;
        element.buttonUpdate[0].disabled = "";        
    }
}

conversionPath.getElement = function(control)
{
    var temp = $(control);
    while (temp && temp.length)
    {
        if (temp[0].element)
        {
            return temp[0].element;
        }
        temp = temp.parent();
    }
    return null;
}

conversionPath.validate = function(control, args)
{
    args.IsValid = false;
    var element = conversionPath.getElement(control);
    if (!element)
    {
        return;
    }

    var count = 0;
    for (var item in element.items)
    {
        if (element.items[item].reference)
        {
            count++;
        }
    }

    args.IsValid = count > 1;
}

conversionPath.update = function(element, changed)
{
    element.divList.list("refresh");
    element.divList.find("img").each(conversionPath.replaceImgSrc);
    element.divMain[0].changed = element.divMain[0].changed || changed;
    element.buttonUpdate[0].disabled = element.divMain[0].changed ? "" : "disabled";

    var result = '';
    for (var item in element.items)
    {
        result += ',' + element.items[item].reference;
    }

    element.hiddenValue.val(result.substr(1));
}

conversionPath.removePath = function (script, text) {
    Cmo.DisablePageLeaveCheck();
    var func = function () { eval(script); };
    Cmo.ShowConfirmation(text, func);
}

conversionPath.getDefaultConversionPathItem = function(element) {
    var defaultItem = {};
    for (var property in element.defaultItem) {
        defaultItem[property] = element.defaultItem[property];

    }
    return defaultItem;
}

function isEmptyConversionPathPage(index, item)
{
    return !(item && item.reference);
}