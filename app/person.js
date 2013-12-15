Nmdb.PersonRoute = Nmdb.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/people",
    beforeModel: function(transition, x, y) {
	if(transition.targetName == 'person.index') {
	    this.transitionTo('person-page', transition.params.id, 'as_role', {queryParams: {role: 'acting'}});
	}
    },
    model: function(context) {
	return Ember.RSVP.hash({
	    person: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+context.id),
	});
    },
    setupController: function(controller, model, queryParams) {
	controller.set('model', model);
    }
});

Nmdb.PersonController = Ember.Controller.extend({
    model: {},
});

Nmdb.PersonPageRoute = Nmdb.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/people",
    pages: {
	as_role: 'as_role',
	biography: 'biography',
	trivia: 'trivia',
	quotes: 'quotes',
	other_works: 'other_works',
	publicity: 'publicity'
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
	controller.set('model', model);
	controller.set('section', model.page);
	controller.set('pageData', model.pageData);
	if(model.page == 'as_role') {
	    if(model.person.all_roles[0] != model.person.active_roles[0]) {
		if(queryParams.role != model.person.active_roles[0]) {
		    this.replaceWith('person-page', model.person.id, 
				     'as_role', {queryParams: {role: model.person.active_roles[0]}});
		}
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
		Ember.set(sections[i], 'disabled', ($.inArray(section.name, model.person.active_pages) == -1));
	    });
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
		sectionMenuTitle: 'Sections'
	    }
	});
    }
});

Nmdb.PersonPageController = Ember.Controller.extend({
    model: {},
    section: 'as_role',
    sections: [
        {name: 'as_role',
         display: 'As Role',
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
    ],
    activeRole: null,
    tabbedRoles: [],
    dropdownRoles: [],
    pageData: [],
    activeRoleIsDropdown: function() {
	var activeRole = this.get('activeRole');
	var isDropdown = false;
	this.get('dropdownRoles').forEach(function(item) {
	    if(activeRole == item.name) {
		isDropdown = true;
	    }
	});
	return isDropdown;
    }.property('activeRole')
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
