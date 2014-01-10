String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

Ember.Handlebars.registerHelper('index', function(obj) {
    return obj.data.view.contentIndex+1;
});

Ember.Handlebars.registerBoundHelper('displayTitle', function(movie, options) {
    var string = "";
    if(movie.is_episode) {
        string = movie.title + " ("+movie.title_year+")" +"<br/>&nbsp;-&nbsp;";
        if(movie.episode_name) {
            string += movie.episode_name;
        }
        if(movie.episode_episode && movie.episode_season) {
            var episode_num = movie.episode_season+":"+movie.episode_episode;
            string += " (#"+episode_num+")";
        }
    } else {
        string = movie.full_title;
    }
    return new Ember.Handlebars.SafeString(string);
});

Ember.Handlebars.registerBoundHelper('displayEpisode', function(movie, options) {
    var string = "";
    if(movie.episode_name) {
        string += movie.episode_name;
    }
    if(movie.episode_episode && movie.episode_season) {
        var episode_num = movie.episode_season+":"+movie.episode_episode;
        string += " (#"+episode_num+")";
    }
    return new Ember.Handlebars.SafeString(string);
});

Ember.Handlebars.registerBoundHelper('displayEpisodeShort', function(movie, options) {
    var string = "";
    if(movie.episode_name) {
        string += movie.episode_name;
    }
    if(false && movie.episode_episode && movie.episode_season) {
        var episode_num = movie.episode_season+":"+movie.episode_episode;
        string = episode_num+"&nbsp;"+string;
    }
    return new Ember.Handlebars.SafeString(string);
});

Ember.Handlebars.registerBoundHelper('pluralize', function(value, string, pluralString) {
    var output = '';
    if(!pluralString || typeof pluralString != "string") {
	pluralString = string + 's';
    }
    if(value == 1) {
	output += value+' '+string;
    } else {
	output += value+' '+pluralString;
    }
    return new Ember.Handlebars.SafeString(output);
});

Ember.Handlebars.registerBoundHelper('episodeCount', function(entry, options) {
    var string = "";
    if(entry.episodes) {
        string = entry.episodes.length + ' episode';
        if(entry.episodes.length > 1) { string += 's' };
        string = ' ('+string+')';
    }
    return new Ember.Handlebars.SafeString(string);
});

Ember.Handlebars.registerHelper('ifIndexGt', function(v1, options) {
    var currentIndex = options.data.view.contentIndex+1;
    if(currentIndex > parseInt(v1)) {
        return options.fn(this);
    }
    return options.inverse(this);
});

Ember.Handlebars.registerHelper('ifIndexMod', function(v1, options) {
    var currentIndex = options.data.view.contentIndex+1;
    if(currentIndex%parseInt(v1) == 0) {
        return options.fn(this);
    }
    return options.inverse(this);
});

Ember.Handlebars.registerHelper('episode-hidden-class', function(options) {
    var parentId = options.data.view._parentView._parentView.content.id;
    return 'episode-hidden episode-hidden-'+parentId;
});

Ember.Handlebars.registerHelper('episode-hidden-show-link', function(options) {
    if(!options.data.view.content.episodes || options.data.view.content.episodes.length <= 5) { return '' }
    var currentId = options.data.view.content.id;
    var string = new Ember.Handlebars.SafeString(' <span>(<a id="episode-hidden-control-'+currentId+'">Show all</a>)</span>');
    $(document).on('click', '#episode-hidden-control-'+currentId, function() {
        $('.episode-hidden-'+currentId).fadeIn(200);
        $('#episode-hidden-control-'+currentId).parent().fadeOut(200);
        return false;
    });
    return string;
});

Ember.Handlebars.registerBoundHelper('decodeLinks', function(string, links, options) {
    string = string.replace(/@@(PID|MID)@(\d+)@@/g, function(match, type, matchId) {
	var router = (type == "PID") ? 'person' : 'movie';
	var linkText = "";
	var linkTitle = "";
	if(type == "PID") {
	    var linked = links.people[matchId][0];
	    linkText = linked.first_name+'&nbsp;'+linked.last_name;
	    linkTitle = linked.full_name.replace(/'/g,"\\'");
	} else {
	    var linked = links.movies[matchId][0];
	    linkText = linked.title;
	    linkTitle = linked.full_title.replace(/'/g,"\\'");;
	}
	return "{{#link-to '"+router+"' "+matchId+" title='"+linkTitle+"'}}"+linkText+"{{/link-to}}";
    });

    return Ember.Handlebars.compile(string)(options.context, options);
});

Ember.Handlebars.registerBoundHelper('displayInfo', function(code, infos, options) {
    var info = infos.find(function(item,i) {
	return item.code == code;
    });
    if(!info) { return ''; }
    var string ='<dt>'+info.display+'</dt><dd>'+info.value+'</dd>';
    return new Ember.Handlebars.SafeString(string);
});

Ember.Handlebars.registerHelper('ifBS', function(bs1, bs2, bs3, bs4, options) {
    // bs2, bs3 and bs4 are optional. Set options to be the last non-null/undefined one.
    if(!options) { options = bs4; bs4 = null; }
    if(!options) { options = bs3; bs3 = null; }
    if(!options) { options = bs2; bs2 = null; }
    var hash = "foo"; 

    // Get context. We'll put our function in this.
    var context = (options.contexts && options.contexts[0]) || this;

    // Reopen context (otherwise we'll lose the context inside the if area) and
    // create a function to check if condition is fulfilled.
    // Also add controllers and provided parameters for the function to be available
    var bsActive = function() {
	console.log("bsActive");
	var bsLevel = this.get('controllers.application.bsLevel');
	if(!bsLevel) { return false; }
	if(bsLevel === bs1 ||
	   bsLevel === bs2 ||
	   bsLevel === bs3 ||
	   bsLevel === bs4) {
	    console.log("bsActive", bsLevel, "===", bs1,bs2,bs3,bs4);
	    return true;
	}
	console.log("bsActive", bsLevel, "!==", bs1,bs2,bs3,bs4);
	return false;
    }
    
    var bsData = {}
    bsData[hash.slice(0,6)] = bsActive.property('controllers.application.bsLevel')

    var bsContext = context.reopen({
	bsActive: bsData
    });

    // Pass it on to boundIf to keep bindings working
    return Ember.Handlebars.helpers.boundIf.call(bsContext, 'bsActive.'+hash.slice(0,6), options);
});
