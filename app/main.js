Ember.FEATURES["query-params"] = true;

function loadScriptSync(url) {
    console.log("loadScriptSync: ", url);
    $.ajaxSetup({async: false});
    $.getScript(url).fail(function(x,y,z) {
	console.log("error: ", x, y, z);
    });
    $.ajaxSetup({async: true});
}

function loadTemplateSync(url) {
    console.log("loadTemplateSync: ", url);
    $.ajaxSetup({async: false});
    $.get(url).done(function(templateText) {
	Ember.Handlebars.bootstrap('<div>'+templateText+'</div>');
    });
    $.ajaxSetup({async: true});
}

function nmdbSetup(rootElement, environment) {
    var apiUrlBase = "http://nmdb-api.nocrew.org"
    if(environment == "devel") {
	var apiUrlBase = "http://localhost:3034"
    }

    Nmdb = Ember.Application.create({
	apiUrlBase: apiUrlBase,
	rootElement: '#'+rootElement,
	Resolver: Ember.DefaultResolver.extend({
            resolveTemplate: function(parsedName) {
//		console.log("Resolver", parsedName.fullNameWithoutType);
		parsedName.fullNameWithoutType = "Nmdb-"+parsedName.fullNameWithoutType;
		return this._super(parsedName);
            }
	})
    });

    Nmdb.ApplicationController = Ember.Controller.extend({
	needs: ['application'],
	appName: "Nmdb",
	bsLevel: null,
	spinnerOff: function() {
	    $('.spinner').removeClass('spinner-on');
	    $('.spinner').addClass('spinner-off');
	    $('.spinner-loader').removeClass('spinner-loader-on');
	    $('.spinner-loader').addClass('spinner-loader-off');
	},
	spinnerOn: function() {
	    $('.spinner').removeClass('spinner-off');
	    $('.spinner').addClass('spinner-on');
	    $('.spinner-loader').removeClass('spinner-loader-off');
	    $('.spinner-loader').addClass('spinner-loader-on');
	},
	setPageTitle: function() {
	    document.title = this.get('pageTitle');
	}.observes('pageTitle'),
	actions: {
	    goSearch: function() {
		this.set('queryString', '');
		this.transitionToRoute('index');
	    },
	    goTop: function() {
		window.scrollTo(0,0);
	    }
	}
    });

    Nmdb.ApplicationView = Ember.View.extend({
       didInsertElement: function() {
           var controller = this.get('controller');
           var prevLevel = controller.get('bsLevel');
           var that = this;
           $(window).on('resize', function() {
               that.setBsLevel(controller);
           });
           if(!prevLevel) { that.setBsLevel(controller); }
       },
       setBsLevel: function(controller) {
           if($('#bs-indicator-xs').is(':visible')) {
               controller.set('bsLevel', 'xs')
           } else if($('#bs-indicator-sm').is(':visible')) {
               controller.set('bsLevel', 'sm')
           } else if($('#bs-indicator-md').is(':visible')) {
               controller.set('bsLevel', 'md')
           } else if($('#bs-indicator-lg').is(':visible')) {
               controller.set('bsLevel', 'lg')
           }
       }
    });

    Nmdb.Route = Ember.Route.extend({
	transitionTo: function() {
	    window.scrollTo(0,0);
	    return this._super.apply(this, arguments);
	},
	redirect: function() {
	    this.controllerFor('application').spinnerOn();
	    return this._super.apply(this, arguments);
	},
	activate: function() {
	    return this._super.apply(this, arguments);
	},
	setupController: function() {
	    this.controllerFor('application').spinnerOff();
	    return this._super.apply(this, arguments);
	},
	beforeModel: function() {
	    this.controllerFor('application').spinnerOn();
	    return this._super.apply(this, arguments);
	}
    });

    Nmdb.Router.map(function() {
	this.resource('index', {path: '/'}, function() {
	    this.resource('search', {path: 'search/:query', queryParams: ['limit']});
	    this.resource('movie', {path: 'movie/:id'}, function() {
		this.resource('movie-page', {path: '/:page'});
	    });	
	    this.resource('person', {path: 'person/:id'}, function() {
		this.resource('person-page', {path: '/:page', queryParams: ['role']});
	    });
	});
    });

    if(environment != "production") {
	loadScriptSync(scriptHost+"/index.js");
	loadScriptSync(scriptHost+"/common.js");
	loadScriptSync(scriptHost+"/helpers.js");
	loadScriptSync(scriptHost+"/search.js");
	loadScriptSync(scriptHost+"/movie.js");
	loadScriptSync(scriptHost+"/person.js");
	loadTemplateSync(scriptHost+'/templates/main.hb');
	loadTemplateSync(scriptHost+'/templates/common.hb');
	loadTemplateSync(scriptHost+'/templates/index.hb');
	loadTemplateSync(scriptHost+'/templates/search.hb');
	loadTemplateSync(scriptHost+'/templates/movie.hb');
	loadTemplateSync(scriptHost+'/templates/person.hb');
    }
}

var scripts = document.getElementsByTagName( 'script' );
var thisScriptTag = scripts[ scripts.length - 1 ];
var rootElement = thisScriptTag.dataset.rootElement;
var appEnv = thisScriptTag.dataset.appEnv;
var scriptHost = thisScriptTag.dataset.srcDir;
nmdbSetup(rootElement, appEnv);
