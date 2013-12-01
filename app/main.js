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
	    $(window).resize(function(x,y,z) {
		var movies_button = $('.action-button-movies');
		that.get('hideLists')(movies_button.is(':visible'));
	    });
	    $('.action-button-movies').on('click', function() { that.get('showMovies')(); });
	    $('.action-button-people').on('click', function() { that.get('showPeople')(); });
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
	}
    });

    Nmdb.IndexRoute = Ember.Route.extend({
	apiUrl: apiUrlBase+"/searches",
	setupController: function(controller, context, queryParams) {
	    if(queryParams.query && queryParams.query.match && !queryParams.query.match(/^\s*$/)) {
		controller.set('queryString', queryParams.query);
		console.log("setupController: ", queryParams, queryParams.query);
		this.query(controller, queryParams.query);
	    } else {
		controller.set('result', {});
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
		}
	    });
	},
	actions: {
	    search: function(queryString) {
		console.log("actions.search: ", queryString);
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
	    console.log(context, queryParams);
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
	    console.log("setupController");
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
	    console.log("didInsertElement");
	    this.controller.get('setActiveRole')(this.controller);
	}
    });

    Ember.Handlebars.registerHelper('index', function(obj) {
        return obj.data.view.contentIndex+1;
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
