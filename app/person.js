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
		data.all_roles.forEach(function(role) {
		    var roleProperties = {};
		    if(role == "archive") { 
			roleProperties['display'] = 'Archive footage'; 
		    } else {
			roleProperties['display'] = role.capitalize().replace(/-/, ' ');
		    }
		    roleProperties['name'] = role;
		    roleProperties['roleClass'] = 'col-md-2 col-sm-3 col-xs-4 role-nav role-nav-'+role;
		    roleProperties['disabled'] = true;
		    data.active_roles.forEach(function(active_role) {
			if(active_role == role) {
			    roleProperties['disabled'] = false;
			}
		    });
		    if(roleProperties['disabled']) {
			roleProperties['roleClass'] += ' disabled';
		    }
		    roleStructure.push(roleProperties);
		});
		controller.set('roles', roleStructure);
		controller.set('person', data);
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
		controller.get('setActiveRole')(controller, roleName);
	    });
	}
	this.set('lastId', context.id);
	this.set('lastRole', roleName);
    },
});

Nmdb.PersonController = Ember.ObjectController.extend({
    person: {},
    activeRole: {},
    roleData: [],
    roles: [],
    setActiveRole: function(controller, roleName) {
	if(!roleName) {
	    roleName = controller.get('activeRole').role || 'acting';
	}
	controller.set('activeRole', { role: roleName });
	$('.role-nav').removeClass('active');
	$('.role-nav-'+roleName).addClass('active');
    }
});

Nmdb.PersonView = Ember.View.extend({
    didInsertElement: function() {
	this.controller.get('setActiveRole')(this.controller);
    }
});
