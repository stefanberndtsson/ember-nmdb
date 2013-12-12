Nmdb.IndexView = Ember.View.extend({
    templateName: "search",
});

Nmdb.IndexRoute = Ember.Route.extend({
    setupController: function(controller, context, queryParams) {
	controller.set('movies', []);
	controller.set('people', []);
	controller.set('queried', false);
	if(queryParams.query && queryParams.query.match && !queryParams.query.match(/^\s*$/)) {
	    controller.set('queryString', queryParams.query);
	    controller.send('query', queryParams.query);
	} else {
	    controller.set('queryString', '');
	}
    },
});

Nmdb.IndexController = Ember.Controller.extend({
    apiUrl: Nmdb.apiUrlBase+"/searches",
    movies: [],
    people: [],
    buttonsVisible: false,
    actions: {
	query: function(query) {
	    var controller = this;
	    $.ajax({
		url: this.get('apiUrl')+'/movies?'+$.param({query: query}),
		cache: false,
		type: 'GET',
		dataType: 'json',
		contentType: 'application/json',
		success: function(data) {
		    controller.set('movies', data);
		    controller.set('queried', true);
		}
	    });
	    $.ajax({
		url: this.get('apiUrl')+'/people?'+$.param({query: query}),
		cache: false,
		type: 'GET',
		dataType: 'json',
		contentType: 'application/json',
		success: function(data) {
		    controller.set('people', data);
		    controller.set('queried', true);
		}
	    });
	},
	search: function(queryString) {
	    this.transitionToRoute('index', {queryParams: {query: queryString}});
	}
    }
});

Nmdb.ButtonMovies = Ember.View.extend({
    tagName: 'button',
    elementId: 'button-movies',
    classNames: ['btn', 'btn-default', 'col-xs-6', 'col-sm-6'],
    classNameBindings: ['active'],
    didInsertElement: function() {
	var that = this;
	this.get('controller').set('buttonsVisible', $('#results-buttons').is(':visible'));
	this.get('controller').set('activeResultsView', 'movies');
	$(window).on('resize', function() {
	    var prevVisible = that.get('controller').get('buttonsVisible');
	    var currVisible = $('#results-buttons').is(':visible');
	    if(prevVisible !== currVisible) {
		that.get('controller').set('buttonsVisible', currVisible);
		if(currVisible) {
		    that.get('controller').set('activeResultsView', 'movies');
		}
	    }
	});
    },
    click: function() {
	this.get('controller').set('activeResultsView', 'movies');
    },
    active: function() {
	return (this.get('controller').get('activeResultsView') === 'movies');
    }.property('controller.activeResultsView')
});

Nmdb.ButtonPeople = Ember.View.extend({
    tagName: 'button',
    elementId: 'button-people',
    classNames: ['btn', 'btn-default', 'col-xs-6', 'col-sm-6'],
    classNameBindings: ['active'],
    click: function() {
	this.get('controller').set('activeResultsView', 'people');
    },
    active: function() {
	return (this.get('controller').get('activeResultsView') === 'people');
    }.property('controller.activeResultsView')
});

Nmdb.ResultsMovies = Ember.View.extend({
    tagName: 'div',
    templateName: 'results-movies',
    classNames: ['col-md-6'],
    classNameBindings: ['show:visible:hidden'],
    show: function() {
	if(!this.get('controller').get('buttonsVisible')) { return true; }
	return (this.get('controller').get('activeResultsView') === 'movies');
    }.property('controller.buttonsVisible', 'controller.activeResultsView')
});

Nmdb.ResultsPeople = Ember.View.extend({
    tagName: 'div',
    templateName: 'results-people',
    classNames: ['col-md-6'],
    classNameBindings: ['show:visible:hidden'],
    show: function() {
	if(!this.get('controller').get('buttonsVisible')) { return true; }
	return (this.get('controller').get('activeResultsView') === 'people');
    }.property('controller.buttonsVisible', 'controller.activeResultsView')
});
