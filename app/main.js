function loadTemplate(url, callback) {
    console.log("DEBUG: Loading template");
    var contents = $.get(url, function(templateText) {
        Ember.Handlebars.bootstrap(templateText);
        if (callback) {
            callback();
        }
    });
}

function nmdbSetup(rootElement) {
    var apiUrlBase = "http://nmdb-api.nocrew.org"

    Nmdb = Ember.Application.create({
	rootElement: '#'+rootElement,
	Resolver: Ember.DefaultResolver.extend({
            resolveTemplate: function(parsedName) {
		console.log("Resolver", parsedName.fullNameWithoutType);
		parsedName.fullNameWithoutType = "Nmdb-"+parsedName.fullNameWithoutType;
		return this._super(parsedName);
            }
	})
    });

    Nmdb.ApplicationController = Ember.Controller.extend({
	appName: "Nmdb",
    });

    Nmdb.Router.map(function() {
	this.resource('index', {path: '/', queryParams: ['query', 'limit']});
	this.resource('movie', {path: '/movie/:id'});
	this.resource('person', {path: '/person/:id', queryParams: ['role']});
    });

    Nmdb.IndexView = Ember.View.extend({
	templateName: "search",
	didInsertElement: function() {
	    this._super();
	    var movies_button = $('.action-button-movies');
	    this.get('hideLists')(movies_button.is(':visible'));
	    var that = this;
	    $(window).resize(function() {
		var movies_button = $('.action-button-movies');
		that.get('hideLists')(movies_button.is(':visible'));
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
	apiUrl: apiUrlBase+"/searches",
	setupController: function(controller, context, queryParams) {
	    controller.set('result', {});
	    controller.set('queried', false);
	    if(queryParams.query && queryParams.query.match && !queryParams.query.match(/^\s*$/)) {
		controller.set('queryString', queryParams.query);
		this.query(controller, queryParams.query);
	    } else {
		controller.set('queryString', '');
	    }
	},
	query: function(controller, query) {
	    $.ajax({
		url: this.get('apiUrl')+'?'+$.param({query: query}),
		cache: false,
		type: 'GET',
		dataType: 'json',
		contentType: 'application/json',
		success: function(data) {
		    controller.set('result', data);
		    controller.set('queried', true);
		    $(window).trigger('resize');
		}
	    });
	},
	actions: {
	    search: function(queryString) {
		this.transitionTo('index', {queryParams: {query: queryString}});
	    }
	}
    });

    Nmdb.IndexController = Ember.Controller.extend({
	result: {}
    });

    Nmdb.MovieRoute = Ember.Route.extend({
	apiUrl: apiUrlBase+"/movies",
	lastId: null,
	setupController: function(controller, context, queryParams) {
	    if(this.get('lastId') != context.id) {
		controller.set('model', {});
	    }
	    this.set('lastId', context.id);
	    $.ajax({
		url: this.get('apiUrl')+'/'+context.id,
		cache: false,
		type: 'GET',
		dataType: 'json',
		contentType: 'application/json',
	    }).then(function(data) {
		console.log("Fetched movie: ", data);
		controller.set('model', data);
	    });
	},
    });

    Nmdb.MovieController = Ember.ObjectController.extend({
	model: {},
    });

    Nmdb.PersonRoute = Ember.Route.extend({
	apiUrl: apiUrlBase+"/people",
	lastId: null,
	setupController: function(controller, context, queryParams) {
	    if(this.get('lastId') != context.id) {
		controller.set('model', {});
		controller.set('roleData', []);
	    }
	    this.set('lastId', context.id);
	    var roleName = queryParams.role || 'acting';
	    controller.get('setActiveRole')(controller, roleName);
	    $.ajax({
		url: this.get('apiUrl')+'/'+context.id+'?'+$.param({role: queryParams.role}),
		cache: false,
		type: 'GET',
		dataType: 'json',
		contentType: 'application/json',
	    }).then(function(data) {
		console.log("Fetched person: ", data);
		controller.set('model', data);
		controller.set('roleData', data['as_'+roleName]);
	    });
	},
    });

    Nmdb.PersonController = Ember.ObjectController.extend({
	model: {},
	activeRole: {},
	roleData: [],
	roles: [
	    {
		name: "acting",
		display: "Acting",
		roleClass: "role-nav role-nav-acting"
	    },
	    {
		name: "self",
		display: "Self",
		roleClass: "role-nav role-nav-self"
	    },
	    {
		name: "archive",
		display: "Archive footage",
		roleClass: "role-nav role-nav-archive"
	    }
	],
	setActiveRole: function(controller, roleName) {
	    if(!roleName) {
		roleName = controller.get('activeRole').role || 'acting';
	    }
	    controller.set('activeRole', { role: roleName });
	    $('.role-nav').removeClass('active');
	    $('.role-nav-'+roleName).addClass('active');
	}
    });

    Nmdb.PersonView = Ember.View.extend({
	didInsertElement: function() {
	    this.controller.get('setActiveRole')(this.controller);
	}
    });

    Ember.Handlebars.registerHelper('index', function(obj) {
        return obj.data.view.contentIndex+1;
    });

    Ember.Handlebars.registerHelper('trigger', function (evtName, options) {
	var options = arguments[arguments.length - 1],
        hash = options.hash,
        view = options.data.view,
        target;

	view = view.get('concreteView');

	if (hash.target) {
            target = Ember.Handlebars.get(this, hash.target, options);
	} else {
            target = view;
	}

	Ember.run.next(function () {
            target.trigger(evtName);
	});
    });
}

var scripts = document.getElementsByTagName( 'script' );
var thisScriptTag = scripts[ scripts.length - 1 ];
var rootElement = thisScriptTag.dataset.rootElement;
var scriptHost = thisScriptTag.dataset.srcDir;
$(function() {
    loadTemplate(scriptHost+"/main.hb", function() {
	nmdbSetup(rootElement);
    })
});
