jQuery.fn.visible = function() {
    return this.css('visibility', 'visible');
};

jQuery.fn.invisible = function() {
    return this.css('visibility', 'hidden');
};

jQuery.fn.visibilityToggle = function() {
    return this.css('visibility', function(i, visibility) {
        return (visibility == 'visible') ? 'hidden' : 'visible';
    });
};

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

Nmdb.SectionLinkComponent = Ember.Component.extend({
    tagName: 'li',
    classNames: [],
    classNameBindings: ['isActive:active', 'isEnabled::disabled'],
    isEnabled: function() {
        return (this.get('section.disabled') === false);
    }.property('section.disabled'),
    isActive: function() {
        if(this.get('currentSection') === this.get('section.name')) {
            return true;
        }
        return false;
    }.property('currentSection')
});

Nmdb.SectionDropdownComponent = Ember.Component.extend({
    tagName: 'select',
    attributeBindings: ['name'],
    classNames: ['col-xs-12', 'nav', 'navbar', 'well', 'well-sm'],
    name: function() {
	return "section";
    }.property(),
    change: function(event) {
	var selected = $(event.target).val();
	var route = this.get('target');
	route.transitionTo(this.get('router'), this.get('modelId'), selected);
    }
});

Nmdb.SectionDropdownOptionComponent = Ember.Component.extend({
    tagName: 'option',
    classNames: [],
    classNameBindings: [],
    attributeBindings: ['value', 'isActive:selected', 'isDisabled:disabled'],
    isDisabled: function() {
        return (this.get('section.disabled') !== false);
    }.property('section.disabled'),
    isActive: function() {
        if(this.get('currentSection') === this.get('section.name')) {
            return true;
        }
        return false;
    }.property('currentSection'),
    value: function() {
	return this.get('section.name');
    }.property('section.name')
});