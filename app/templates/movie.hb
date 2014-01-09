<script type="text/x-handlebars" data-template-name="Nmdb-movie">
  <div class="container">
    <div class="row container">
      <div class="col-md-3 hidden-sm hidden-xs">
	{{outlet menu}}
      </div>
      <div class="col-md-9 col-xs-12">
	{{#ifBS md lg}}
	{{#if model.movie.is_linked}}
	<div class="row">
	  <div class="navbar navbar-custom">
	    <ul class="nav navbar-nav col-xs-12">
	      <li class="col-xs-6">
		{{#if model.movie.prev_followed}}
		{{#link-to 'movie' model.movie.prev_followed.id class="btn wrap pull-left"}}
		<span class="glyphicon glyphicon-chevron-left"/>
		{{model.movie.prev_followed.title}}
		{{/link-to}}
		{{/if}}
	      </li>
	      <li class="col-xs-6" style="padding-right: 0px;">
		{{#if model.movie.next_followed}}
		{{#link-to 'movie' model.movie.next_followed.id class="btn wrap pull-right"}}
		{{model.movie.next_followed.title}}
		<span class="glyphicon glyphicon-chevron-right"/>
		{{/link-to}}
		{{/if}}
	      </li>
	    </ul>
	  </div>
	</div>
	{{/if}}
	{{else}}
	{{#if model.movie.is_linked}}
	{{#unless model.movie.is_episode}}
	<div class="row">
	  <div class="navbar navbar-compact">
	    <ul class="nav navbar-compact-nav col-xs-12">
	      <li class="col-xs-6">
		{{#if model.movie.prev_followed}}
		{{#link-to 'movie' model.movie.prev_followed.id class="btn wrap pull-left"}}
		<span class="glyphicon glyphicon-chevron-left"/>
		{{model.movie.prev_followed.title}}
		{{/link-to}}
		{{/if}}
	      </li>
	      <li class="col-xs-6" style="padding-right: 0px;">
		{{#if model.movie.next_followed}}
		{{#link-to 'movie' model.movie.next_followed.id class="btn wrap pull-right"}}
		{{model.movie.next_followed.title}}
		<span class="glyphicon glyphicon-chevron-right"/>
		{{/link-to}}
		{{/if}}
	      </li>
	    </ul>
	  </div>
	</div>
	{{/unless}}
	{{/if}}
	{{#if model.movie.is_episode}}
	<div class="row">
	  <div class="navbar navbar-compact">
	    <ul class="nav navbar-compact-nav col-xs-12">
	      <li class="col-xs-6">
		{{#if model.movie.prev_episode}}
		{{#link-to 'movie' model.movie.prev_episode.id class="btn wrap pull-left"}}
		<span class="glyphicon glyphicon-chevron-left"/>
		{{displayEpisodeShort model.movie.prev_episode}}
		{{/link-to}}
		{{/if}}
	      </li>
	      <li class="col-xs-6" style="padding-right: 0px;">
		{{#if model.movie.next_episode}}
		{{#link-to 'movie' model.movie.next_episode.id class="btn wrap pull-right"}}
		{{displayEpisodeShort model.movie.next_episode}}
		<span class="glyphicon glyphicon-chevron-right"/>
		{{/link-to}}
		{{/if}}
	      </li>
	    </ul>
	  </div>
	</div>
	{{/if}}
	{{/ifBS}}
	{{#ifBS md lg}}
	<div class="row">
	  <div class="well well-sm">
	    {{#if cover.visible}}
	    <div class="pull-right visible-xs visible-sm">
	      <img {{bind-attr src=cover.url}} id="cover-image-sm"/>
	    </div>
	    {{/if}}
            <h3 class="col-xs-12">{{model.movie.full_title}}</h3>
	    {{#if model.movie.rating}}
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
              <h5>
		<span class="bold">Rating:</span> {{model.movie.rating.rating}}/10 ({{pluralize model.movie.rating.votes 'vote'}})
	      </h5>
            </div>
	    {{/if}}
	    {{#if model.movie.first_release_date}}
            <div class="col-xs-12">
	      <h5>
		<span class="bold">Release date:</span>
		{{model.movie.first_release_date.release_date}}
		{{#if model.movie.first_release_date.country}}
		({{model.movie.first_release_date.country}})
		{{/if}}
	      </h5>
            </div>
	    {{/if}}
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
              {{#each model.genres}}
              <span class="label label-default">{{genre}}</span>
              {{/each}}
            </div>
	    <div class="row"></div>
	  </div>
	</div>
	{{else}}
	<div class="row">
	  <div class="panel panel-default">
	    <div class="panel-heading">
	      {{#if model.movie.is_episode}}
              <h3 class="panel-title">{{displayEpisode model.movie}}</h3>
	      {{else}}
              <h3 class="panel-title">{{model.movie.full_title}}</h3>
	      {{/if}}
	    </div>
	    <div class="panel-body">
	      {{#if cover.visible}}
	      <div class="pull-right visible-xs visible-sm">
		<img {{bind-attr src=cover.url}} id="cover-image-sm"/>
	      </div>
	      {{/if}}
	      <dl class="no-margin">
	      {{#if model.movie.rating}}
	      <dt>Rating</dt>
	      <dd>{{model.movie.rating.rating}}/10 ({{pluralize model.movie.rating.votes 'vote'}})</dd>
	      {{/if}}
	      {{#if model.movie.first_release_date}}
	      <dt>Release date</dt>
	      <dd>
		{{model.movie.first_release_date.release_date}}
		{{#if model.movie.first_release_date.country}}
		({{model.movie.first_release_date.country}})
		{{/if}}
	      </dd>
	      {{/if}}
	      {{#if model.genres}}
	      <dt>Genre</dt>
              <dd>
		{{#each model.genres}}
		<span class="label label-default">{{genre}}</span>
		{{/each}}
              </dd>
	      {{/if}}
	    </div>
	    <div class="row"></div>
	  </div>
	</div>
	{{/ifBS}}
	{{#ifBS md lg}}
	{{#if model.movie.is_episode}}
	<div class="row">
	  <div class="navbar navbar-custom">
	    <ul class="nav navbar-nav col-xs-12">
	      <li class="col-xs-4">
		{{#if model.movie.prev_episode}}
		{{#link-to 'movie' model.movie.prev_episode.id class="btn wrap pull-left"}}
		<span class="glyphicon glyphicon-chevron-left"/>
		{{displayEpisodeShort model.movie.prev_episode}}
		{{/link-to}}
		{{/if}}
	      </li>
	      <li class="col-xs-4 disabled">
		<a href="javascript:void(0)" class="navbar-brand col-xs-12 text-center">
		  {{displayEpisodeShort model.movie}}
		</a>
	      </li>
	      <li class="col-xs-4" style="padding-right: 0px;">
		{{#if model.movie.next_episode}}
		{{#link-to 'movie' model.movie.next_episode.id class="btn wrap pull-right"}}
		{{displayEpisodeShort model.movie.next_episode}}
		<span class="glyphicon glyphicon-chevron-right"/>
		{{/link-to}}
		{{/if}}
	      </li>
	    </ul>
	  </div>
	</div>
	{{/if}}
	{{/ifBS}}
	<div class="hidden-md hidden-lg visible-sm visible-xs menu-dropdown">
	  {{outlet menu-dropdown}}
	</div>
	{{outlet}}
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page">
  {{view Nmdb.MoviePageDataView}}
</script>

