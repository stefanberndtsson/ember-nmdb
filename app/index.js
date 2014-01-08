Nmdb.IndexRoute = Nmdb.Route.extend({
    actions: {
	search: function(params) {
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
    queryString: function() {
	return this.get('controllers.application.queryString');
    }.property('controllers.application.queryString')
});