var Cmo;
if (!Cmo) {
    Cmo = {};
}

//Common code for page selectors (switching views)
//items - items for list
//views - views to be swithced
//viewInitObject - object to initialize view
Cmo.CampaignPageSelector = function (items, views, viewInitObject) {
    var self = this;

    //cookie name to store active view index
    var cookieName = 'ListType';

    //get active view index from cookie
    var activeViewIndex = parseInt($.cookie(cookieName));
    if (isNaN(activeViewIndex)) {
        activeViewIndex = 0;
    }

    //object to initialize list when it is created
    var initObject = viewInitObject;

    //items to show in the list
    this.items = items;

    //view to be switched
    this.views = views;

    //active view (shown one)
    this.activeView = function () {
        if ((activeViewIndex < 0) || (activeViewIndex >= self.views.length)) {
            activeViewIndex = 0;
        }
        return self.views[activeViewIndex];
    }

    //iterate through view and show active one (hide all other)
    this.showView = function (index, value) {
        index == activeViewIndex ? value.show() : value.hide();
    }

    //setup view for the first run
    this.buildView = function (view) {
        var extend = $.extend(initObject, { items: self.items });
        view.list(extend);
        view.built = true;
    }

    //show list in selected view
    this.showList = function () {
        self.activeView().built
                ? self.activeView().list('items', self.items)
                : self.buildView(self.activeView());

        $.each(self.views, self.showView);
    }

    //swithc to the view with given index
    this.switchView = function (index) {
        if (index == activeViewIndex) {
            return;
        }

        activeViewIndex = index;
        self.showList();

        $.cookie(cookieName, index);
    }
}