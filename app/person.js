Nmdb.PersonRoute = Ember.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/people",
    beforeModel: function(transition) {
	console.log("PersonRoute.beforeModel", transition.params.id);
	if(!transition.params.page) {
	    this.transitionTo('person-page', transition.params.id, 'as_role', {queryParams: {role: 'acting'}});
	}
    },
    model: function(context) {
	return Ember.RSVP.hash({
	    person: Nmdb.AjaxPromise(this.get('apiUrl')+'/'+context.id),
	});
    },
    setupController: function(controller, model, queryParams) {
	console.log("PersonRoute.setupController", model);
	controller.set('model', model);
    }
});

Nmdb.PersonController = Ember.Controller.extend({
    model: {},
});

Nmdb.PersonPageRoute = Ember.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/people",
    pages: {
	as_role: 'as_role',
    },
    model: function(context, queryParams, transition) {
	console.log("PersonPageRoute.model", context, transition.params, queryParams);
	var person_id = transition.params.id;
	return Ember.RSVP.hash({
	    page: context.page,
	    person: this.modelFor('person').person,
	    pageData: Nmdb.AjaxPromise(
		this.get('apiUrl')+'/'+person_id+
		    '/'+this.get('pages')[context.page]+
		    '?'+$.param({role: queryParams.role})),
	});
    },
    setupController: function(controller, model, queryParams) {
	console.log("PersonPageRoute.setupController", model);
	controller.set('model', model);
	controller.set('pageData', model.pageData);
	if(model.person.all_roles) {
            var roleStructure = [];
            model.person.all_roles.forEach(function(role, i) {
                var roleProperties = {};
                if(role == "archive") { 
                    roleProperties['display'] = 'Archive footage'; 
                } else {
                    roleProperties['display'] = role.capitalize().replace(/-/, ' ');
                }
                roleProperties['name'] = role;
                roleProperties['disabled'] = true;
                model.person.active_roles.forEach(function(active_role) {
                    if(active_role == role) {
                        roleProperties['disabled'] = false;
                    }
                });
                roleStructure.push(roleProperties);
            });
            controller.set('roles', roleStructure);
	    controller.set('activeRole', queryParams.role);
	}
	console.log(controller.get('section'));
    }
});

Nmdb.PersonPageController = Ember.Controller.extend({
    model: {},
    section: 'as_role',
    activeRole: null,
    roles: [],
    pageData: []
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
    classNames: ['col-xs-4', 'col-sm-2'],
    classNameBindings: ['isActive:active', 'isEnabled::disabled'],
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
