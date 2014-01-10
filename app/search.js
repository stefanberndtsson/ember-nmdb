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
	this.controllerFor('application').spinnerOff();
	this.controllerFor('application').set('queryString', model.query);
	controller.set('model', model);
	this.controllerFor('application').set('pageTitle', "Search: "+model.query);
    }
});

Nmdb.SearchController = Ember.Controller.extend({
    needs: ['application'],
    model: {},
    moviesSelected: true,
    peopleSelected: true,
    buttonsVisible: false,
    actions: {
	selectMovies: function() {
	    if(!this.get('buttonsVisible')) { return; }
	    this.set('moviesSelected', true);
	    this.set('peopleSelected', false);
	},
	selectPeople: function() {
	    if(!this.get('buttonsVisible')) { return; }
	    this.set('moviesSelected', false);
	    this.set('peopleSelected', true);
	}
    },
    isMobileBinding: 'controllers.application.isMobile'
});

Nmdb.MoviesResultsComponent = Ember.Component.extend({
    tagName: 'div',
    classNames: ['col-md-6'],
});

Nmdb.PeopleResultsComponent = Ember.Component.extend({
    tagName: 'div',
    classNames: ['col-md-6']
});

Nmdb.SearchSelectButtonsComponent = Ember.View.extend({
    tagName: 'div',
    classNames: ['col-xs-12'],
    didInsertElement: function(x,y,z) {
	var controller = this.get('controller');
	$(window).on('resize', function() {
	    var prevVisible = controller.get('buttonsVisible');
	    var currVisible = $('#results-buttons').is(':visible');
	    if(prevVisible != currVisible) {
		controller.set('buttonsVisible', currVisible);
		if(currVisible) {
		    controller.set('moviesSelected', true);
		    controller.set('peopleSelected', false);
		} else {
		    controller.set('moviesSelected', true);
		    controller.set('peopleSelected', true);
		}
	    }
	});
	if($('#results-buttons').is(':visible')) {
	    controller.set('moviesSelected', true);
	    controller.set('peopleSelected', false);
	    controller.set('buttonsVisible', true);
	} else {
	    controller.set('moviesSelected', true);
	    controller.set('peopleSelected', true);
	    controller.set('buttonsVisible', false);
	}
    }
});