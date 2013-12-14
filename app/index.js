Nmdb.IndexRoute = Ember.Route.extend({
    beforeModel: function() {
	console.log("IndexRoute.beforeModel");
    },
    actions: {
	search: function(params) {
	    console.log("IndexRoute.actions.search", params);
	    this.transitionTo('search', params);
	}
    }
});
