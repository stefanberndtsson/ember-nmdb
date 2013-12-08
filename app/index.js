Nmdb.IndexView = Ember.View.extend({
    templateName: "search",
    didInsertElement: function() {
	this._super();
	var movies_button = $('.action-button-movies');
	this.get('hideLists')(movies_button.is(':visible'));
	var that = this;
	$(window).resize(function(x,y,z) {
	    var currentHeight = $(window).height();
	    var currentWidth = $(window).width();
	    if(currentWidth != prevWidth) {
		var movies_button = $('.action-button-movies');
		that.get('hideLists')(movies_button.is(':visible'));
	    }
	    prevHeight = currentHeight;
	    prevWidth = currentWidth;
	});
	$('.action-button-movies').on('click', function() { that.get('showMovies')(); });
	$('.action-button-people').on('click', function() { that.get('showPeople')(); });
    },
    hideButtons: function() {
	$('.action-button-movies').hide();
	$('.action-button-people').hide();
    },
    showButtons: function() {
	$('.action-button-movies').show();
	$('.action-button-people').show();
    },
    showMovies: function() {
	$('.action-button-movies').addClass('active');
	$('.action-button-people').removeClass('active');
	$('.action-list-movies').show();
	$('.action-list-people').hide();
    },
    showPeople: function() {
	$('.action-button-movies').removeClass('active');
	$('.action-button-people').addClass('active');
	$('.action-list-movies').hide();
	$('.action-list-people').show();
    },
    hideLists: function(shouldHide) {
	$('.action-button-movies').addClass('active');
	$('.action-button-people').removeClass('active');
	if(shouldHide) {
	    $('.action-list-movies').show();
	    $('.action-list-people').hide();
	} else {
	    $('.action-list-movies').show();
	    $('.action-list-people').show();
	}
    },
    buttonsVisibleTrigger: function() {
	var that = this;
	$('.action-button-movies').on('click', function() { that.get('showMovies')(); });
	$('.action-button-people').on('click', function() { that.get('showPeople')(); });
	$(window).trigger('resize');
    }
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
		    $(window).trigger('resize');
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
		    $(window).trigger('resize');
		}
	    });
	},
	search: function(queryString) {
	    this.transitionToRoute('index', {queryParams: {query: queryString}});
	}
    }
});

