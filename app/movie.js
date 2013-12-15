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
	quotes: 'quotes'
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
	if(model.movie.active_pages) {
	    var sections = controller.get('sections');
	    sections.forEach(function(section, i) {
		Ember.set(sections[i], 'disabled', ($.inArray(section.name, model.movie.active_pages) == -1));
	    });
	}
	if(model.page == 'trivia') {
	    controller.set('hasSpoilers', false);
	    model.pageData.forEach(function(item) {
		if(item.spoiler) {
		    controller.set('hasSpoilers', true);
		}
	    });
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
        {name: 'plots',
         display: 'Plot summary',
         disabled: false},
        {name: 'quotes',
         display: 'Quotes',
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
