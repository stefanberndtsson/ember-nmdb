Nmdb.PersonRoute = Nmdb.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/people",
    beforeModel: function(transition, x, y) {
	this.controllerFor('application').spinnerOn();
	if(transition.targetName == 'person.index') {
	    this.transitionTo('person-page', transition.params.id, 'top_movies');
	}
    },
    model: function(context) {
	return Ember.RSVP.hash({
	    person: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+context.id),
	    info: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+context.id+'/info'),
	});
    },
    setupController: function(controller, model, queryParams) {
	this.controllerFor('application').spinnerOff();
	controller.set('model', model);
	this.controllerFor('application').set('pageTitle', 
					      [model.person.first_name, model.person.last_name].compact().join(" "));
    }
});

Nmdb.PersonController = Ember.Controller.extend({
    needs: ['application', 'person-page'],
    model: {},
    cover: function() {
	return this.get('controllers.person-page.cover');
    }.property('controllers.person-page.cover')
});

Nmdb.PersonPageRoute = Nmdb.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/people",
    pages: {
	as_role: 'as_role',
	top_movies: 'top_movies',
	biography: 'biography',
	trivia: 'trivia',
	quotes: 'quotes',
	other_works: 'other_works',
	publicity: 'publicity',
	by_genre: 'by_genre',
	by_keyword: 'by_keyword',
	images: 'images',
	links: 'externals'
    },
    beforeModel: function(queryParams,transition) {
	if(transition.params.page == 'as_role' && !queryParams.role) {
	    this.transitionTo('person-page', transition.params.id, 'as_role', {queryParams: {role: 'acting'}})
	}
    },
    model: function(context, queryParams, transition) {
	var person_id = transition.params.id;
	var params = (context.page == 'as_role') ? "?"+$.param({role: queryParams.role}) : "";
	return Ember.RSVP.hash({
	    page: context.page,
	    person: this.modelFor('person').person,
	    pageData: Nmdb.AjaxPromise(
		this.get('apiUrl')+'/'+person_id+
		    '/'+this.get('pages')[context.page]+params)
	});
    },
    setupController: function(controller, model, queryParams) {
	this.controllerFor('application').spinnerOff();
	controller.set('model', model);
	controller.set('section', model.page);
	controller.set('pageData', model.pageData);
	controller.set('cover.visible', false);
	if(false && model.page == 'top_movies') {  // Disabled for now...
	    var movies = controller.get('model.pageData');
	    var lookupNewTitles = [];
	    movies.forEach(function(movieEntry) {
		if(!movieEntry.movie.display_title_fresh) {
		    lookupNewTitles.push(movieEntry.movie.id);
		}
	    });
	    if(lookupNewTitles.length > 0) {
		Nmdb.AjaxPromise(Nmdb.apiUrlBase+'/movies/new_title?'+$.param({ids: lookupNewTitles.join(",")}))
		    .then(function(data) {
			movies.forEach(function(movieEntry) {
			    if(!movieEntry.movie.display_title_fresh) {
//				console.log("Replaced", movieEntry.movie.display_full_title, "with", data[movieEntry.movie.id].display_full_title);
				Ember.set(movieEntry.movie, 'display_full_title', data[movieEntry.movie.id].display_full_title);
				Ember.set(movieEntry.movie, 'display_title', data[movieEntry.movie.id].display_title);
			    }
			});
		    });
	    }
	}
	if(model.page == 'as_role') {
	    var hasRole = false;
	    model.person.active_roles.forEach(function(active_role) {
		if(queryParams.role === active_role) {
		    hasRole = true;
		}
	    });
	    if(!hasRole) {
		this.replaceWith('person-page', model.person.id,
				 'as_role', {queryParams: {role: model.person.active_roles[0]}});
	    }
            var roleStructureTabbed = [];
            var roleStructureDropdown = [];
            model.person.all_roles.forEach(function(role, i) {
                var roleProperties = {};
                if(role == "archive") { 
                    roleProperties['display'] = 'Archive footage'; 
                } else {
                    roleProperties['display'] = role.capitalize().replace(/-/, ' ');
                }
                roleProperties['name'] = role;
                roleProperties['disabled'] = true;
		roleProperties['tabbed'] = (i < 3);
                model.person.active_roles.forEach(function(active_role) {
                    if(active_role == role) {
                        roleProperties['disabled'] = false;
                    }
                });
		if(i < 3) {
                    roleStructureTabbed.push(roleProperties);
		} else {
                    roleStructureDropdown.push(roleProperties);
		}
            });
            controller.set('tabbedRoles', roleStructureTabbed);
            controller.set('dropdownRoles', roleStructureDropdown);
	    controller.set('activeRole', queryParams.role);
	}
	if(model.person.active_pages) {
	    var sections = controller.get('sections');
	    sections.forEach(function(section, i) {
		if(section.name == 'links') { return; }
		Ember.set(sections[i], 'disabled', ($.inArray(section.name, model.person.active_pages) == -1));
	    });
//	    if(model.page != 'links') {
//		Nmdb.AjaxPromise(this.get('apiUrl')+'/'+model.person.id+'/externals').then(function(data) {
//		    if(data.imdb_id) {
//			var linkSection = controller.get('sections').filter(function(item) {
//			    return (item.name == 'links');
//			});
//			Ember.set(linkSection[0], 'disabled', false);
//		    }
//		});
//	    }
	    if(model.page != 'images' && $.inArray('images', model.person.active_pages) == -1) {
		Nmdb.AjaxPromise(this.get('apiUrl')+'/'+model.person.id+'/images').then(function(data) {
		    if(data.tmdb) {
			var linkSection = controller.get('sections').filter(function(item) {
			    return (item.name == 'images');
			});
			Ember.set(linkSection[0], 'disabled', false);
		    }
		});
	    }
	}
	if(model.page == 'links') {
	    var linkSections = [{
		name: "Google",
		links: [{
		    linkHref: 'http://www.google.com/search?q='+encodeURIComponent([model.person.first_name, model.person.last_name].compact().join(" ")),
		    linkText: 'Search'
		},{
		    linkHref: 'http://www.google.com/images?q='+encodeURIComponent([model.person.first_name, model.person.last_name].compact().join(" ")),
		    linkText: 'Images'
		},{
		    linkHref: 'http://www.youtube.com/results?search_query='+encodeURIComponent([model.person.first_name, model.person.last_name].compact().join(" ")),
		    linkText: 'Youtube'
		}]
	    }]
	    if(model.pageData.imdb_id) {
		linkSections.push({
		    name: "IMDb",
		    links: [{
			linkHref: 'http://www.imdb.com/name/'+model.pageData.imdb_id,
			linkText: 'IMDb - '+model.person.full_name
		    }]
		});
	    }
	    if(model.pageData.twitter) {
		linkSections.push({
		    name: "Twitter",
		    links: [{
			linkHref: 'http://twitter.com/'+model.pageData.twitter,
			linkText: 'Twitter - '+model.pageData.twitter
		    }]
		});
	    }
	    if(model.pageData.freebase_topic) {
		linkSections.push({
		    name: "Freebase",
		    links: [{
			linkHref: 'http://www.freebase.com/'+model.pageData.freebase_topic,
			linkText: 'Freebase - '+model.person.full_name
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
	if(!model.person.image_url || model.person.image_url_expired) {
	    Nmdb.AjaxPromise(this.get('apiUrl')+'/'+model.person.id+'/cover').then(function(data) {
		if(data.image) {
		    controller.set('cover.url', data.image);
		    controller.set('cover.visible', true);
		}
	    });
	}
	if(model.person.image_url) {
	    controller.set('cover.url', model.person.image_url);
	    controller.set('cover.visible', true);
	}
	if(model.page == 'by_keyword') {
	    controller.set('pageDataSelection', null);
	}
    },
    renderTemplate: function(x) {
	var controller = this.get('controller');
	this.render();
	this.render('components/section-menu', {
	    outlet: 'menu',
	    controller: {
		router: 'person-page',
		modelId: controller.get('model.person.id'),
		sections: controller.get('sections'),
		currentSection: controller.get('section'),
		sectionMenuTitle: 'Sections',
		cover: controller.get('cover')
	    }
	});
	this.render('components/section-menu-dropdown', {
	    outlet: 'menu-dropdown',
	    controller: {
		target: controller.get('target'),
		router: 'person-page',
		modelId: controller.get('model.person.id'),
		sections: controller.get('sections'),
		currentSection: controller.get('section'),
		sectionMenuTitle: 'Sections',
		cover: controller.get('cover')
	    }
	});
    }
});

Nmdb.PersonPageController = Ember.Controller.extend({
    needs: ['application'],
    model: {},
    cover: {
	url: null,
	visible: false
    },
    section: 'top_movies',
    sections: [
	{name: 'top_movies',
	 display: 'Top Movies',
	 disabled: false},
        {name: 'as_role',
         display: 'As Role',
         disabled: false},
        {name: 'by_genre',
         display: 'Movies by Genre',
         disabled: false},
        {name: 'by_keyword',
         display: 'Movies by Keyword',
         disabled: false},
	{name: 'biography',
	 display: 'Biography',
	 disabled: false},
	{name: 'trivia',
	 display: 'Trivia',
	 disabled: false},
	{name: 'quotes',
	 display: 'Quotes',
	 disabled: false},
	{name: 'other_works',
	 display: 'Other works',
	 disabled: false},
	{name: 'publicity',
	 display: 'Publicity',
	 disabled: false},
	{name: 'images',
	 display: 'Images',
	 disabled: true},
	{name: 'links',
	 display: 'Links',
	 disabled: false},
    ],
    activeRole: null,
    tabbedRoles: [],
    dropdownRoles: [],
    pageData: [],
    pageDataSelection: null,
    pageDataSelected: function() {
	var selected = this.get('pageDataSelection');
	var selectionData = [];
	this.get('pageData').forEach(function(keyword) {
	    if(selected == keyword.keyword) {
		selectionData = [keyword];
	    }
	});
	return selectionData;
    }.property('pageDataSelection'),
    activeRoleIsDropdown: function() {
	var activeRole = this.get('activeRole');
	var isDropdown = false;
	this.get('dropdownRoles').forEach(function(item) {
	    if(activeRole == item.name) {
		isDropdown = true;
	    }
	});
	return isDropdown;
    }.property('activeRole'),
    isMobileBinding: 'controllers.application.isMobile',
    actions: {
	scrollTo: function(genre) {
	    $('#'+genre)[0].scrollIntoView();
	},
	selectEntry: function(keyword) {
	    this.set('pageDataSelection', keyword);
	    $('#keyword-header')[0].scrollIntoView();
	}
    }
});

Nmdb.PersonPageDataView = Ember.View.extend({
    templateName: function() {
	return 'person-page-'+this.get('controller.section');
    }.property('controller.section'),
    _templateChanged: function() {
	this.rerender();
    }.observes('templateName'),
});

Nmdb.PersonRoleLinkComponent = Ember.Component.extend({
    tagName: 'li',
    classNames: [],
    classNameBindings: ['isActive:active', 'isEnabled::disabled'],
    tabbed: function() {
	return this.get('role.tabbed');
    }.property(),
    isEnabled: function() {
        return (this.get('role.disabled') === false);
    }.property(),
    isActive: function() {
        if(this.get('currentRole') === this.get('role.name')) {
            return true;
        }
        return false;
    }.property('currentRole')
});

Nmdb.PersonPageByGenreDropdownView = Ember.View.extend({
    tagName: 'select',
    classNames: ['col-xs-12', 'nav', 'navbar', 'well', 'well-sm'],
    templateName: 'person-page-by_genre-dropdown',
    change: function(event) {
	var selected = $(event.target).val();
	if(selected) {
	    var offset = $('#'+selected).offset();
	    $(document.body).scrollTop(offset.top-50);
	}
    }
});

Nmdb.PersonPageByKeywordDropdownView = Ember.View.extend({
    tagName: 'select',
    classNames: ['col-xs-12', 'nav', 'navbar', 'well', 'well-sm'],
    templateName: 'person-page-by_keyword-dropdown',
    change: function(event) {
	var selected = $(event.target).val();
	this.get('controller').set('pageDataSelection', selected);
    }
});
