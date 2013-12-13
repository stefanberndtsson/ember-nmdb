Nmdb.MovieRoute = Ember.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/movies",
    lastId: null,
    setupController: function(controller, context, queryParams) {
	if(!queryParams.page) {
	    queryParams.page = 'cast';
	}
	var sectionInvalid = true;
	controller.get('sections').forEach(function(section) {
	    if(!sectionInvalid) { return; }
	    if(queryParams.page === section.name) { sectionInvalid = false; }
	});
	if(sectionInvalid) { queryParams.page = 'cast'; }
	controller.set('section', queryParams.page);
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
    setSection: function(controller, sectionValue) {
	controller.set('section', sectionValue);
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

Nmdb.SectionLink = Ember.View.extend({
    tagName: 'li',
    classNames: ['col-xs-4 col-sm-1'],
    classNameBindings: ['isActive:active', 'isEnabled::disabled'],
    templateName: 'sectionlink',
    isEnabled: function() {
	return (this.get('templateData.keywords.section.disabled') === false);
    }.property(),
    isActive: function() {
	if(this.get('controller.section') === this.get('templateData.keywords.section.name')) {
	    return true;
	}
	return false;
    }.property('controller.section')
});

Nmdb.CurrentView = Ember.View.extend({
    templateName: function() {
	return 'movie-'+this.get('controller.section');
    }.property('controller.section').cacheable(),
    _templateChanged: function() {
        this.rerender();
    }.observes('templateName')
});
