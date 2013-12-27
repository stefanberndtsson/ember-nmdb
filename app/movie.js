Nmdb.MovieRoute = Nmdb.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/movies",
    beforeModel: function(transition) {
	if(transition.targetName == 'movie.index') {
	    this.transitionTo('movie-page', transition.params.id, 'cast');
	}
    },
    model: function(context) {
	return Ember.RSVP.hash({
	    movie: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+context.id),
	    genres: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+context.id+'/genres'),
	});
    },
    setupController: function(controller, model, queryParams) {
	controller.set('model', model);
    }
});

Nmdb.MovieController = Ember.Controller.extend({
    model: {},
});

Nmdb.MoviePageRoute = Nmdb.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/movies",
    pages: {
	cast: 'cast_members',
	keywords: 'keywords',
	plots: 'plots',
	trivia: 'trivia',
	goofs: 'goofs',
	quotes: 'quotes',
	links: 'externals'
    },
    model: function(context, transition) {
	var movie_id = transition.params.id;
	return Ember.RSVP.hash({
	    page: context.page,
	    movie: this.modelFor('movie').movie,
	    genres: this.modelFor('movie').genres,
	    pageData: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+movie_id+'/'+this.get('pages')[context.page]),
	});
    },
    setupController: function(controller, model, queryParams) {
	controller.set('model', model);
	controller.set('section', model.page);
	console.log("setupController", this);
	if(model.movie.active_pages) {
	    var sections = controller.get('sections');
	    sections.forEach(function(section, i) {
		Ember.set(sections[i], 'disabled', ($.inArray(section.name, model.movie.active_pages) == -1));
	    });
	    if(model.page != 'links') {
		Nmdb.AjaxPromise(this.get('apiUrl')+'/'+model.movie.id+'/externals').then(function(data) {
		    if(data.imdb_id) {
			var linkSection = controller.get('sections').filter(function(item) {
			    return (item.name == 'links');
			});
			console.log("Enabling", linkSection[0].name);
			Ember.set(linkSection[0], 'disabled', false);
			console.log("Status", controller.get('sections')[5].disabled);
		    }
		});
	    }
	}
	if(model.page == 'trivia' || model.page == "goofs") {
	    controller.set('hasSpoilers', false);
	    model.pageData.forEach(function(item) {
		if(item.spoiler) {
		    controller.set('hasSpoilers', true);
		}
	    });
	}
	if(model.page == 'links') {
	    var linkSections = [{
		name: "IMDb",
		links: [{
		    linkHref: 'http://www.imdb.com/title/'+model.pageData.imdb_id,
		    linkText: 'IMDb - '+model.movie.full_title
		}]
	    }];
	    var wikiLinks = [];
	    for(var prop in model.pageData.wikipedia) {
		console.log("Links", prop, model.pageData.wikipedia[prop]);
		wikiLinks.push({
		    linkHref: 'http://'+prop+'.wikipedia.org/wiki/'+model.pageData.wikipedia[prop],
		    linkText: prop.toUpperCase()+' - '+model.pageData.wikipedia[prop]
		});
	    }
	    if(wikiLinks.length != 0) {
		linkSections.push({
		    name: "Wikipedia",
		    links: wikiLinks
		});
	    }
	    controller.set('linkSections', linkSections);
	}
    },
    renderTemplate: function(x) {
	var controller = this.get('controller');
	this.render();
	this.render('components/section-menu', {
	    outlet: 'menu',
	    controller: {
		router: 'movie-page',
		modelId: controller.get('model.movie.id'),
		sections: controller.get('sections'),
		currentSection: controller.get('section'),
		sectionMenuTitle: 'Sections'
	    }
	});
    },
	fetchExternalData: function() {
	    var controller = this.get('controller');
	    console.log("fetchExternalData - controller", controller);
	    var tmp = Nmdb.AjaxPromise(this.get('apiUrl')+'/'+controller.get('model.movie.id')+'/externals');
	    console.log("fetchExternalData - promise", controller);
	}
});

Nmdb.MoviePageController = Ember.Controller.extend({
    model: {},
    section: 'cast',
    sections: [
        {name: 'cast',
         display: 'Cast',
         disabled: false},
        {name: 'keywords',
         display: 'Keywords',
         disabled: false},
        {name: 'trivia',
         display: 'Trivia',
         disabled: false},
        {name: 'goofs',
         display: 'Goofs',
         disabled: false},
        {name: 'plots',
         display: 'Plot summary',
         disabled: false},
        {name: 'quotes',
         display: 'Quotes',
         disabled: false},
        {name: 'links',
         display: 'Links',
         disabled: true}
    ],
    actions: {
	toggleSpoilers: function() {
	    $('.spoiler').visibilityToggle();
	}
    }
});

Nmdb.MoviePageDataView = Ember.View.extend({
    templateName: function() {
	return 'movie-page-'+this.get('controller.section');
    }.property('controller.section'),
    _templateChanged: function() {
	this.rerender();
    }.observes('templateName'),
});
