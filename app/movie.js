Nmdb.MovieRoute = Ember.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/movies",
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

