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
	links: 'externals',
	episodes: 'episodes',
	images: 'images'
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
	controller.set('cover.visible', false);
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
			Ember.set(linkSection[0], 'disabled', false);
		    }
		});
	    }
	    if(model.page != 'images' && $.inArray('images', model.movie.active_pages) == -1) {
		Nmdb.AjaxPromise(this.get('apiUrl')+'/'+model.movie.id+'/images').then(function(data) {
		    if(data.tmdb) {
			var linkSection = controller.get('sections').filter(function(item) {
			    return (item.name == 'images');
			});
			Ember.set(linkSection[0], 'disabled', false);
		    }
		});
	    }
	}
	if(model.page == 'trivia') {
	    controller.set('hasSpoilers', false);
	    model.pageData.forEach(function(item) {
		if(item.spoiler) {
		    controller.set('hasSpoilers', true);
		}
	    });
	}
	if(model.page == "goofs") {
	    controller.set('hasSpoiler', false);
	    model.pageData.forEach(function(category) {
		category.goofs.forEach(function(item) {
		    if(item.spoiler) {
			controller.set('hasSpoilers', true);
		    }
		});
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
	    if(model.pageData.freebase_topic) {
		linkSections.push({
		    name: "Freebase",
		    links: [{
			linkHref: 'http://www.freebase.com/'+model.pageData.freebase_topic,
			linkText: 'Freebase - '+model.movie.full_title
		    }]
		});
	    }
	    var wikiLinks = [];
	    for(var prop in model.pageData.wikipedia) {
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
	if(!model.movie.image_url) {
	    Nmdb.AjaxPromise(this.get('apiUrl')+'/'+model.movie.id+'/cover').then(function(data) {
		if(data.image) {
		    controller.set('cover.url', data.image);
		    controller.set('cover.visible', true);
		}
	    });
	} else {
	    controller.set('cover.url', model.movie.image_url);
	    controller.set('cover.visible', true);
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
		sectionMenuTitle: 'Sections',
		cover: controller.get('cover'),
	    }
	});
    },
});

Nmdb.MoviePageController = Ember.Controller.extend({
    model: {},
    cover: {
	visible: false,
	url: null
    },
    section: 'cast',
    sections: [
        {name: 'cast',
         display: 'Cast',
         disabled: false},
        {name: 'episodes',
         display: 'Episodes',
         disabled: true},
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
        {name: 'images',
         display: 'Images',
         disabled: false},
        {name: 'links',
         display: 'Links',
         disabled: true}
    ],
    actions: {
	toggleSpoilers: function() {
	    $('.spoiler').visibilityToggle();
	}
    },
    hasImageBackdrop: function() {
	var images = this.get('model.pageData.tmdb.backdrops');
	console.log(images && images.length > 0);
	return images && images.backdrops && images.backdrops.length > 0;
    }.property('model.pageData')
});

Nmdb.MoviePageDataView = Ember.View.extend({
    templateName: function() {
	return 'movie-page-'+this.get('controller.section');
    }.property('controller.section'),
    _templateChanged: function() {
	this.rerender();
    }.observes('templateName'),
});
