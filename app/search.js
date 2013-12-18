Nmdb.SearchRoute = Nmdb.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/searches",
    model: function(context,params) {
	return Ember.RSVP.hash({
	    query: context.query,
	    movies: Nmdb.AjaxPromise(this.get('apiUrl')+'/solr_movies?'+$.param({query: context.query})),
	    people: Nmdb.AjaxPromise(this.get('apiUrl')+'/solr_people?'+$.param({query: context.query}))
	});
    },
    setupController: function(controller, model, queryParams) {
	this.controllerFor('index').set('queryString', model.query);
	controller.set('model', model);
    }
});

Nmdb.SearchController = Ember.Controller.extend({
    model: {}
});

Nmdb.MoviesResultsComponent = Ember.Component.extend({
    tagName: 'div',
    classNames: ['col-md-6']
});

Nmdb.PeopleResultsComponent = Ember.Component.extend({
    tagName: 'div',
    classNames: ['col-md-6']
});
