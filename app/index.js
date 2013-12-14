Nmdb.IndexRoute = Ember.Route.extend({
    actions: {
	search: function(params) {
	    this.transitionTo('search', params);
	}
    }
});
