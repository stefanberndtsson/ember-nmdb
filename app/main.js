var prevHeight = 0;
var prevWidth = 0;

function loadTemplate(url, callback) {
    console.log("DEBUG: Loading template");
    var contents = $.get(url, function(templateText) {
        Ember.Handlebars.bootstrap(templateText);
        if (callback) {
            callback();
        }
    });
}

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
	this.resource('movie', {path: '/movie/:id', queryParams: ['page']});
	this.resource('person', {path: '/person/:id', queryParams: ['role']});
    });

    if(environment != "production") {
	loadScriptSync(scriptHost+"/index.js");
	loadScriptSync(scriptHost+"/movie.js");
	loadScriptSync(scriptHost+"/person.js");
	loadScriptSync(scriptHost+"/helpers.js");
	loadTemplateSync(scriptHost+'/templates/main.hb');
	loadTemplateSync(scriptHost+'/templates/index.hb');
	loadTemplateSync(scriptHost+'/templates/movie.hb');
	loadTemplateSync(scriptHost+'/templates/person.hb');
    }
}

var scripts = document.getElementsByTagName( 'script' );
var thisScriptTag = scripts[ scripts.length - 1 ];
var rootElement = thisScriptTag.dataset.rootElement;
var appEnv = thisScriptTag.dataset.appEnv;
var scriptHost = thisScriptTag.dataset.srcDir;
$(function() {
    nmdbSetup(rootElement, appEnv);
    prevHeight = $(window).height();
    prevWidth = $(window).width();
});
