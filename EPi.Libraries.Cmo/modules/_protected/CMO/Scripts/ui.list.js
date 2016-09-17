$.widget("ui.list", {

    //first creation of slisder
    _init: function () {
        this._getTemplates();
        this._createList();
    },

    //all instant children divs treated as templates, all other elements are ignored and not shown
    _getTemplates: function () {
        var templates = this.element.children("div");
        this.templates = templates.map(this._getTemplate).get();
    },

    //get template from div element
    _getTemplate: function () {
        var temp = $(this);
        return {
            //inner htm of template wil be used to show items collection
            html: temp.html(),

            //conditional function name is stored it title attribute
            func: temp.attr("title"),

            //grab style attribute
            style: temp.attr("style"),

            //grab class attribute
            css: temp.attr("class")
        };
    },

    //create list
    _createList: function () {
        this.element.empty();
        var self = this;
        $.each(this.options.items, function (index, value) { self._createItem(index, value); });
    },

    //create item by index
    _createItem: function (index, value) {
        //try finding template for this item
        var template = this._findTemplate(index, value);
        if (!template) {
            return;
        }

        //create element for item
        var div = $("<div>").appendTo(this.element);

        //add css attribute from template
        var css = template.css;
        if (css) {
            css = this._replaceProperties(css, index, value);
            css = this._replaceFunctional(css, index, value);
            div.addClass(css);
        }

        //add style attribute from template
        var style = template.style;
        if (style) {
            style = this._replaceProperties(style, index, value);
            style = this._replaceFunctional(style, index, value);
            div.attr("style", style);
        }

        //add html for this item
        var html = template.html;
        html = this._replaceProperties(html, index, value, true);
        html = this._replaceFunctional(html, index, value);
        div.html(html);
    },

    //find template for current item by condition
    _findTemplate: function (index, value) {
        //try finding template by condition
        for (var i = 0; i < this.templates.length; i++) {
            if (this.templates[i].func) {
                var func = eval(this.templates[i].func);
                if ($.isFunction(func) && func(index, value, this.options.items)) {
                    return this.templates[i];
                }
            }
        }

        //try finding first template without a condition
        for (var i = 0; i < this.templates.length; i++) {
            if (!this.templates[i].func) {
                return this.templates[i];
            }
        }

        return null;
    },

    //converts string into escape sequence
    _normalizeString: function (value) {
        var result = '';
        for (var index = 0; index < value.length; index++) {
            result += "&#" + value.charCodeAt(index) + ";";
        }
        return result;
    },

    //replace [[property]] expression by its value from items (for item properties)
    _replaceProperties: function (html, index, value, normalize) {
        var reg = new RegExp("\\[\\[index\\]\\]", "ig");
        html = html.replace(reg, index);

        var self = this;

        var func = function (property) {
            var reg = new RegExp("\\[\\[" + property + "\\]\\]", "ig");
            var result = normalize ? self._normalizeString(this.toString()) : this.toString();
            html = html.replace(reg, result);
        };

        $.each(value, func);

        return html;
    },

    //replace all other [[...]] expression by value got from functional
    _replaceFunctional: function (html, index, value) {
        if (!$.isFunction(this.options.functional)) {
            return html;
        }

        var reg = new RegExp("\\[\\[[^(\\[\\[)(\\]\\])]*\\]\\]", "ig");
        var array = html.match(reg);

        if (!array) {
            return html;
        }

        var self = this;

        var func = function () {
            //replace [[ and ]] with \\[\\[ and \\]\\] to be used with RegExp
            var pattern = this.replace("[[", "\\[\\[").replace("]]", "\\]\\]");
            var temp = new RegExp(pattern, "ig");
            var str = this.slice(2, -2);
            var arg = self.options.functional(str, index, value, self.options.items);
            html = html.replace(temp, arg);
        };

        $.each(array, func);
        return html;
    },

    //set up item collection and update list
    _setData: function (key, value) {
        $.widget.prototype._setData.apply(this, arguments);

        if (key != "items") {
            return;
        }

        this._createList();
        this._trigger("onChange", null, null);
    },

    //get or set item collection and update list if nessesary
    items: function (array) {
        if (arguments.length) {
            this._setData("items", array);
        }

        return this.options.items;
    },

    //insert item to the collection and update list
    insert: function (item, index) {
        if (isNaN(index) || (index < 0) || (index > this.options.items.length)) {
            index = this.options.items.length;
        }

        this.options.items.splice(index, 0, item);

        this._createList();
        this._trigger("onInsert", null, item);
        this._trigger("onChange", null, item);
    },

    //remove item from the collection by index and update list
    remove: function (index) {
        if (isNaN(index) || (index < 0) || (index >= this.options.items.length)) {
            return;
        }

        var item = this.options.items[index];
        this.options.items.splice(index, 1);

        this._createList();
        this._trigger("onRemove", null, item);
        this._trigger("onChange", null, item);
    },

    //move up item from the collection by index and update list
    moveUp: function (index) {
        if (isNaN(index) || (index < 0) || (index >= this.options.items.length - 1)) {
            return;
        }

        var item = this.options.items[index];
        this.options.items.splice(index, 2, this.options.items[index + 1], this.options.items[index]);

        this._createList();
        this._trigger("onMoveUp", null, item);
        this._trigger("onChange", null, item);
    },

    //move down item from the collection by index and update list
    moveDown: function (index) {
        if (isNaN(index) || (index <= 0) || (index >= this.options.items.length)) {
            return;
        }

        var item = this.options.items[index];
        this.options.items.splice(index - 1, 2, this.options.items[index], this.options.items[index - 1]);

        this._createList();
        this._trigger("onMoveDown", null, item);
        this._trigger("onChange", null, item);
    },

    //rebuilds control
    refresh: function () {
        this._createList();
    }
});

//default values
$.extend($.ui.list, {
    getter: "items",
    eventPrefix: "list",
    defaults: {
        //collection of the items to show
        items: [],

        //function which will be used to replace [[name]] patterns in templates
        functional: function (name, index, item, items) { return },

        //fires after removing item from the collection
        onRemove: function (event, ui) { return },

        //fires after moving item up in the collection
        onMoveUp: function (event, ui) { return },

        //fires after moving item down in the collection
        onMoveDown: function (event, ui) { return },

        //fires after adding item to the collection
        onInsert: function (event, ui) { return },

        //fires on each collection change
        onChange: function (event, ui) { return }
    }
});