Nmdb.MovieRoute = Ember.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/movies",
    beforeModel: function(transition) {
	if(!transition.params.page) {
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
	console.log("MovieRoute.setupController", model);
	controller.set('model', model);
    }
});

Nmdb.MovieController = Ember.Controller.extend({
    model: {},
});

Nmdb.MoviePageRoute = Ember.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/movies",
    pages: {
	cast: 'cast_members',
	keywords: 'keywords',
	quotes: 'quotes'
    },
    model: function(context, transition) {
	console.log("MoviePageRoute.model", context, transition.params);
	var movie_id = transition.params.id;
	return Ember.RSVP.hash({
	    page: context.page,
	    movie: this.modelFor('movie').movie,
	    genres: this.modelFor('movie').genres,
	    pageData: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+movie_id+'/'+this.get('pages')[context.page]),
	});
    },
    setupController: function(controller, model, queryParams) {
	console.log("MoviePageRoute.setupController", model);
	controller.set('model', model);
	controller.set('section', model.page);
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
        {name: 'quotes',
         display: 'Quotes',
         disabled: true}
    ],
});

Nmdb.MovieSectionLinkComponent = Ember.Component.extend({
    tagName: 'li',
    classNames: ['col-xs-4', 'col-sm-1'],
    classNameBindings: ['isActive:active', 'isEnabled::disabled'],
    isEnabled: function() {
        return (this.get('section.disabled') === false);
    }.property(),
    isActive: function() {
        if(this.get('currentSection') === this.get('section.name')) {
            return true;
        }
        return false;
    }.property('currentSection')
});

Nmdb.MoviePageDataView = Ember.View.extend({
    templateName: function() {
	return 'movie-page-'+this.get('controller.section');
    }.property('controller.section'),
    _templateChanged: function() {
	this.rerender();
    }.observes('templateName'),
});
