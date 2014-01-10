Nmdb.IndexRoute = Nmdb.Route.extend({
    actions: {
	search: function(params) {
	    if(this.controller.get('isMobile')) {
		$('.search-field').blur();
	    }
	    this.transitionTo('search', params);
	}
    },
});

Nmdb.IndexController = Ember.Controller.extend({
    needs: ['application'],
    isIndex: function() {
	var currentPath = this.get('controllers.application.currentPath');
	if(currentPath === "index.index") {
	    this.set('controllers.application.pageTitle', "Search");
	}
	return (currentPath === "index.index" || currentPath === "index.search");
    }.property('controllers.application.currentPath'),
    isMobileBinding: 'controllers.application.isMobile',
});
