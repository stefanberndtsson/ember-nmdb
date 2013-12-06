String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function loadTemplate(url, callback) {
    console.log("DEBUG: Loading template");
    var contents = $.get(url, function(templateText) {
        Ember.Handlebars.bootstrap(templateText);
        if (callback) {
            callback();
        }
    });
}

function nmdbSetup(rootElement, environment) {
    var apiUrlBase = "http://nmdb-api.nocrew.org"
    if(environment == "devel") {
	var apiUrlBase = "http://localhost:3034"
    }

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
	this.resource('movie', {path: '/movie/:id', queryParams: ['page']});
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
	    controller.set('movies', []);
	    controller.set('people', []);
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
	actions: {
	    search: function(queryString) {
		this.transitionTo('index', {queryParams: {query: queryString}});
	    }
	}
    });

    Nmdb.IndexController = Ember.Controller.extend({
	movies: [],
	people: []
    });

    Nmdb.MovieRoute = Ember.Route.extend({
	apiUrl: apiUrlBase+"/movies",
	lastId: null,
	setupController: function(controller, context, queryParams) {
	    if(!queryParams.page) {
		queryParams.page = 'cast';
	    }
	    if(this.get('lastId') != context.id) {
		controller.set('movie', {});
		$.ajax({
		    url: this.get('apiUrl')+'/'+context.id,
		    cache: false,
		    type: 'GET',
		    dataType: 'json',
		    contentType: 'application/json',
		}).then(function(data) {
		    console.log("Fetched movie: ", data);
		    controller.set('movie', data);
		});
		$.ajax({
		    url: this.get('apiUrl')+'/'+context.id+'/genres',
		    cache: false,
		    type: 'GET',
		    dataType: 'json',
		    contentType: 'application/json',
		}).then(function(data) {
		    controller.set('genres', data);
		});
	    }

	    controller.set('section', queryParams.page);
	    if(!controller.get('section') || controller.get('section') == 'cast') {
		
		$.ajax({
		    url: this.get('apiUrl')+'/'+context.id+'/cast_members',
		    cache: false,
		    type: 'GET',
		    dataType: 'json',
		    contentType: 'application/json',
		}).then(function(data) {
		    console.log("Fetched cast");
		    controller.set('cast_members', data);
		    controller.setSection(controller, queryParams.page);
		});
	    }

	    if(controller.get('section') == 'keywords') {
		$.ajax({
		    url: this.get('apiUrl')+'/'+context.id+'/keywords',
		    cache: false,
		    type: 'GET',
		    dataType: 'json',
		    contentType: 'application/json',
		}).then(function(data) {
		    console.log("Fetched keywords");
		    controller.set('keywords', data);
		    controller.setSection(controller, queryParams.page);
		});
	    }

	    if(controller.get('section') == 'quotes') {
		controller.setSection(controller, queryParams.page);
	    }

	    this.set('lastId', context.id);
	},
    });

    Nmdb.MovieController = Ember.ObjectController.extend({
	movie: {},
	genres: [],
	keywords: [],
	cast_members: [],
	section: 'cast',
	sections: ['cast', 'keywords', 'quotes'],
	section_selected_cast: false,
	section_selected_keywords: false,
	section_selected_quotes: false,
	setSection: function(controller, sectionValue) {
	    controller.set('section', sectionValue);
	    controller.get('sections').forEach(function(item) {
		if(item == sectionValue) {
		    controller.set('section_selected_'+item, true);
		} else {
		    controller.set('section_selected_'+item, false);
		}
	    });
	},
	showCast: function() {
	    if(this.get('section') == 'cast') {
		return true;
	    }
	    return false;
	}.property('movie'),
	showKeywords: function() {
	    if(this.get('section') == 'keywords') {
		return true;
	    }
	    return false;
	}.property('movie'),
	showQuotes: function() {
	    if(this.get('section') == 'quotes') {
		return true;
	    }
	    return false;
	}.property('movie'),
    });

    Nmdb.PersonRoute = Ember.Route.extend({
	apiUrl: apiUrlBase+"/people",
	lastId: null,
	setupController: function(controller, context, queryParams) {
	    var roleName = queryParams.role || 'acting';
	    if(this.get('lastId') != context.id) {
		this.set('lastRole', null);
		controller.set('person', {});
		$.ajax({
		    url: this.get('apiUrl')+'/'+context.id+'?'+$.param({role: queryParams.role}),
		    cache: false,
		    type: 'GET',
		    dataType: 'json',
		    contentType: 'application/json',
		}).then(function(data) {
		    console.log("Fetched person: ", data);
		    var roleStructure = [];
		    data.all_roles.forEach(function(role) {
			var roleProperties = {};
			if(role == "archive") { 
			    roleProperties['display'] = 'Archive footage'; 
			} else {
			    roleProperties['display'] = role.capitalize().replace(/-/, ' ');
			}
			roleProperties['name'] = role;
			roleProperties['roleClass'] = 'col-md-2 col-sm-3 col-xs-4 role-nav role-nav-'+role;
			roleProperties['disabled'] = true;
			data.active_roles.forEach(function(active_role) {
			    if(active_role == role) {
				roleProperties['disabled'] = false;
			    }
			});
			if(roleProperties['disabled']) {
			    roleProperties['roleClass'] += ' disabled';
			}
			roleStructure.push(roleProperties);
		    });
		    controller.set('roles', roleStructure);
		    controller.set('person', data);
		});
	    }
	    if(this.get('lastRole') != roleName) {
		controller.set('roleData', []);
		$.ajax({
		    url: this.get('apiUrl')+'/'+context.id+'/as_role?'+$.param({role: queryParams.role}),
		    cache: false,
		    type: 'GET',
		    dataType: 'json',
		    contentType: 'application/json',
		}).then(function(data) {
		    controller.set('roleData', data);
		    controller.get('setActiveRole')(controller, roleName);
		});
	    }
	    this.set('lastId', context.id);
	    this.set('lastRole', roleName);
	},
    });

    Nmdb.PersonController = Ember.ObjectController.extend({
	person: {},
	activeRole: {},
	roleData: [],
	roles: [],
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

    Ember.Handlebars.registerHelper('ifpropeq', function(v1, v2, options) {
	if(options.contexts.objectAt(0)[v1] == v2) {
	    return options.fn(this);
	}
	return options.inverse(this);
    });

    Ember.Handlebars.registerBoundHelper('displayTitle', function(movie, options) {
	var string = "";
	if(movie.is_episode) {
	    string = movie.title + " ("+movie.title_year+")" +"<br/>&nbsp;-&nbsp;";
	    if(movie.episode_name) {
		string += movie.episode_name;
	    }
	    if(movie.episode_episode && movie.episode_season) {
		var episode_num = movie.episode_season+":"+movie.episode_episode;
		string += " (#"+episode_num+")";
	    }
	} else {
	    string = movie.full_title;
	}
	return new Ember.Handlebars.SafeString(string);
    });

    Ember.Handlebars.registerBoundHelper('displayEpisode', function(movie, options) {
	var string = "";
	if(movie.episode_name) {
	    string += movie.episode_name;
	}
	if(movie.episode_episode && movie.episode_season) {
	    var episode_num = movie.episode_season+":"+movie.episode_episode;
	    string += " (#"+episode_num+")";
	}
	return new Ember.Handlebars.SafeString(string);
    });

    Ember.Handlebars.registerBoundHelper('episodeCount', function(entry, options) {
	var string = "";
	if(entry.episodes) {
	    string = entry.episodes.length + ' episode';
	    if(entry.episodes.length > 1) { string += 's' };
	    string = ' ('+string+')';
	}
	return new Ember.Handlebars.SafeString(string);
    });

    Ember.Handlebars.registerHelper('ifIndexGt', function(v1, options) {
        var currentIndex = options.data.view.contentIndex+1;
	if(currentIndex > parseInt(v1)) {
	    return options.fn(this);
	}
	return options.inverse(this);
    });

    Ember.Handlebars.registerHelper('episode-hidden-class', function(options) {
	var parentId = options.data.view._parentView._parentView.content.id;
	return 'episode-hidden episode-hidden-'+parentId;
    });

    Ember.Handlebars.registerHelper('episode-hidden-show-link', function(options) {
	if(!options.data.view.content.episodes || options.data.view.content.episodes.length <= 5) { return '' }
	var currentId = options.data.view.content.id;
	var string = new Ember.Handlebars.SafeString(' <span>(<a id="episode-hidden-control-'+currentId+'">Show all</a>)</span>');
	$(document).on('click', '#episode-hidden-control-'+currentId, function() {
	    console.log("Clicked: ", this);
	    $('.episode-hidden-'+currentId).fadeIn(200);
	    $('#episode-hidden-control-'+currentId).parent().fadeOut(200);
	    return false;
	});
	return string;
    });
}

var scripts = document.getElementsByTagName( 'script' );
var thisScriptTag = scripts[ scripts.length - 1 ];
var rootElement = thisScriptTag.dataset.rootElement;
var appEnv = thisScriptTag.dataset.appEnv;
var scriptHost = thisScriptTag.dataset.srcDir;
$(function() {
    loadTemplate(scriptHost+"/main.hb", function() {
	nmdbSetup(rootElement, appEnv);
    })
});
