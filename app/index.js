Nmdb.IndexRoute = Nmdb.Route.extend({
    actions: {
	search: function(params) {
	    this.transitionTo('search', params);
	}
    }
});
