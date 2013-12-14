Nmdb.AjaxPromise = function(url, options) {
    return Ember.RSVP.Promise(function(resolve, reject) {
	var options = options || {
	    type: 'GET',
	    cashe: false,
            dataType: 'json',
	    contentType: 'application/json'
	};

	options.success = function(data){
	    resolve(data);
	};

	options.error = function(jqXHR, status, error){
	    reject(arguments);
	};

	Ember.$.ajax(url, options);
    });
};

Nmdb.BootstrapIndicatorComponent = Ember.Component.extend({
    tagName: 'li',
    classNameBindings: ['bsClass'],
    bsClass: function() {
	return 'visible-'+this.get('type');
    }.property(),
    typeDisplay: function() {
	return this.get('type').toUpperCase();
    }.property('type')
});
