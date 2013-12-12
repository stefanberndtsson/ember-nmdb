Nmdb.PersonRoute = Ember.Route.extend({
    apiUrl: Nmdb.apiUrlBase+"/people",
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
		data.all_roles.forEach(function(role, i) {
		    var roleProperties = {};
		    if(role == "archive") { 
			roleProperties['display'] = 'Archive footage'; 
		    } else {
			roleProperties['display'] = role.capitalize().replace(/-/, ' ');
		    }
		    roleProperties['name'] = role;
		    roleProperties['disabled'] = true;
		    data.active_roles.forEach(function(active_role) {
			if(active_role == role) {
			    roleProperties['disabled'] = false;
			}
		    });
		    roleStructure.push(roleProperties);
		});
		controller.set('roles', roleStructure);
		controller.set('person', data);
		controller.set('activeRole', roleName);
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
		controller.set('activeRole', roleName);
	    });
	}
	this.set('lastId', context.id);
	this.set('lastRole', roleName);
    },
});

Nmdb.PersonController = Ember.ObjectController.extend({
    person: {},
    activeRole: null,
    roleData: [],
    roles: []
});

Nmdb.RoleLink = Ember.View.extend({
    tagName: 'li',
    classNames: ['col-md-2', 'col-sm-3', 'col-xs-4'],
    classNameBindings: ['isActive:active', 'isEnabled::disabled'],
    templateName: 'rolelink',
    isEnabled: function() {
	console.log(this.get('templateData.keywords.role.disabled'));
	return this.get('templateData.keywords.role.disabled') == false;
    }.property(),
    isActive: function() {
	var role = this.get('templateData.keywords.role.name');
	var active = this.get('controller').get('activeRole');
	return (active === role);
    }.property('controller.activeRole')
});