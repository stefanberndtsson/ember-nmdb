<script type="text/x-handlebars" data-template-name="Nmdb-movie">
  <div class="container">
    <div class="row container">
      <div class="col-md-3 hidden-sm hidden-xs">
	{{outlet menu}}
      </div>
      <div class="col-md-9 col-xs-12">
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
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
              {{#each model.genres}}
              <span class="label label-default">{{genre}}</span>
              {{/each}}
            </div>
	    <div class="row"></div>
	  </div>
	</div>
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

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-cast">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Cast</h4>
      </div>
      <div class="panel-body">
	{{#if controllers.application.bsMdLg}}
        <table class="table table-condensed">
          <thead>
            <tr>
              <th width="1%"></th>
              <th width="39%">Cast</th>
              <th width="60%">Character</th>
            </tr>
          </thead>
          <tbody>
            {{#each model.pageData}}
            <tr>
              <th>{{sort_value}}</th>
              <td>{{#link-to 'person' id}}{{name}}{{/link-to}}</td>
              <td>
                {{character}} {{extras}}
                {{#if episode_count}}({{episode_count}} episodes){{/if}}
              </td>
            </tr>
            {{/each}}
          </tbody>
        </table>
	{{else}}
	<div class="list-group">
	  {{#each model.pageData}}
	  {{#link-to 'person' id classNames="list-group-item list-group-link-item"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	  <h4 class="list-group-item-heading truncate-text">{{name}}</h4>
	  <div class="list-group-item-text indent-left truncate-text">
	    {{character}} {{extras}}
            {{#if episode_count}}({{episode_count}} episodes){{/if}}
	  </div>
	  {{/link-to}}
	  {{/each}}
	</div>
	{{/if}}
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-keywords">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Keywords</h4>
      </div>
      <div class="panel-body">
        {{#each model.pageData}}
        <span class="col-xs-6 col-sm-6 col-md-4 col-lg-4 panel">
	  <span {{bind-attr class="strong:bold"}}>{{display}}</span>
	</span>
        {{/each}}
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-plots">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Plot summary</h4>
      </div>
      <div class="panel-body">
	<ul class="list-group">
	  {{#each model.pageData}}
          <li class="list-group-item plot-summary">
	    {{decodeLinks plot links}}
	    <div><em class="pull-right">{{author}}</em></div>
	  </li>
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-trivia">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Trivia</h4>
      </div>
      <div class="panel-body">
	{{#if hasSpoilers}}
	<div class="panel-heading"><button class="btn btn-default" {{action toggleSpoilers}}>Toggle spoilers</button></div>
	{{/if}}
	<ul class="list-group">
	  {{#each model.pageData}}
          <li class="list-group-item">
	    {{#if spoiler}}
	    <span class="bold">[SPOILER]</span> <span class="spoiler">{{decodeLinks trivia links}}</span>
	    {{else}}
	    {{decodeLinks trivia links}}
	    {{/if}}
	  </li>
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-goofs">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Goofs</h4>
      </div>
      <div class="panel-body">
	{{#if hasSpoilers}}
	<div class="panel-heading"><button class="btn btn-default" {{action toggleSpoilers}}>Toggle spoilers</button></div>
	{{/if}}
	<ul class="list-group">
	  {{#each model.pageData}}
	  <h4 class="panel-heading">{{category_display}}</h4>
	  {{#each goofs}}
          <li class="list-group-item">
	    {{#if spoiler}}
	    <span class="bold">[SPOILER]</span> <span class="spoiler">{{decodeLinks goof links}}</span>
	    {{else}}
	    {{decodeLinks goof links}}
	    {{/if}}
	  </li>
	  {{/each}}
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-quotes">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Quotes</h4>
      </div>
      <div class="panel-body">
	<ul class="list-group">
	  {{#each model.pageData}}
          <li class="list-group-item">
	    {{#each quote}}
	    {{#if quoter}}
	    <span class="bold">
	      {{#if quoter.person}}
	      {{#link-to 'person' quoter.person.id title=quoter.person.full_name}}
	      {{quoter.character}}:
	      {{/link-to}}
	      {{else}}
	      {{quoter.character}}:
	      {{/if}}
	    </span> {{decodeLinks content links}}
	    {{else}}
	    {{decodeLinks content links}}
	    {{/if}}
	    <br/>
	    {{/each}}
	  </li>
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-links">
  {{#each linkSections}}
  <h4>{{name}}</h4>
  <ul>
    {{#each links}}
    <li><a target="_blank" href="{{unbound linkHref}}">{{linkText}}</a></li>
    {{/each}}
  </ul>
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-images">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Images</h4>
      </div>
      <div class="panel-body">
	<div class="row">
	  {{#if model.pageData.tmdb.posters}}
	  <h4 class="panel-heading">Posters</h4>
          {{#each model.pageData.tmdb.posters}}
          <span class="col-xs-6 col-sm-4 col-md-3 col-lg-3 panel">
	    <span class="poster-image">
	      <a target="_blank" href="{{unbound image_url}}">
		<img {{bind-attr src=image_url_thumb}} />
	      </a>
	    </span>
	  </span>
	  {{#ifIndexMod 4}}<div class="clearfix visible-md visible-lg"></div>{{/ifIndexMod}}
	  {{#ifIndexMod 3}}<div class="clearfix visible-sm"></div>{{/ifIndexMod}}
	  {{#ifIndexMod 2}}<div class="clearfix visible-xs"></div>{{/ifIndexMod}}
          {{/each}}
	  {{/if}}
	</div>
	<div class="row">
	  {{#if model.pageData.tmdb.backdrops}}
	  <h4 class="panel-heading">Backdrops</h4>
          {{#each model.pageData.tmdb.backdrops}}
          <span class="col-xs-6 col-sm-6 col-md-4 col-lg-4 panel">
	    <span class="backdrop-image">
	      <a target="_blank" href="{{unbound image_url}}">
		<img {{bind-attr src=image_url_thumb}} />
	      </a>
	    </span>
	  </span>
	  {{#ifIndexMod 3}}<div class="clearfix visible-md visible-lg"></div>{{/ifIndexMod}}
	  {{#ifIndexMod 2}}<div class="clearfix visible-sm visible-xs"></div>{{/ifIndexMod}}
          {{/each}}
	  {{/if}}
	</div>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-episodes">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Episodes</h4>
      </div>
      <div class="panel-body">
	<div class="row">
	  <h4 class="panel-heading">
	    <ul class="nav nav-pills col-xs-2">
	      <li class="disabled"><a class="black" href="javascript:void(0)">Season</a></li>
	    </ul>
	    <ul class="nav nav-pills col-xs-10">
	      {{#each model.pageData.seasons}}
	      <li {{bind-attr class="active"}}>
		<a href="javascript:void(0);" {{action showSeason season}}>{{season_name}}</a>
	      </li>
	      {{/each}}
	    </ul>
	  </h4>
	</div>
	<div class="row">
          {{#each model.pageData.seasons}}
	  <div id="episode-season-{{unbound season_name}}">
	    <h4 class="panel-heading">Season {{season}}</h4>
	    <ul class="list-group">
              {{#each episodes}}
	      <li class="list-group-item">
		<h4 class="bold">
		  {{episode.episode_season}}:{{episode.episode_episode}}
		  {{#link-to 'movie' episode.id}}{{episode_name}}{{/link-to}}
		</h4>
		{{#if plot.plot}}
		<div>{{plot.plot}}</div>
		{{/if}}
		{{#if release_date.release_date}}
		<h5><span class="bold">Released: </span>{{release_date.release_date}}</h5>
		{{/if}}
	      </li>
              {{/each}}
	    </ul>
	  </div>
	  {{/each}}
	</div>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-connections">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
	  Movie Connections
	  {{#if showSpinner}}
	  <img class="spinner-img" src="{{unbound appRoot}}/img/spinner.gif"/>
	  {{/if}}
	</h4>
      </div>
      <div class="panel-body">
	<div class="row">
          {{#each model.pageData}}
	  <h4 class="panel-heading">{{type}}</h4>
	  <ul class="list-group">
            {{#each connections}}
	    <li class="list-group-item">
	      {{#link-to 'movie' linked_movie.id}}{{displayTitle linked_movie}}{{/link-to}}
	      {{#if text}}
	      <div>&nbsp;&nbsp;-&nbsp;&nbsp;{{text}}</div>
	      {{/if}}
	    </li>
            {{/each}}
	  </ul>
	  {{/each}}
	</div>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-additionals">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
	  Additional Information
	</h4>
      </div>
      <div class="panel-body">
	<div class="row">
          {{#if model.pageData.akas}}
	  <h4 class="panel-heading">Alternate titles</h4>
	  <ul class="list-group">
            {{#each model.pageData.akas}}
	    <li class="list-group-item">
	      <span>{{title}}</span>
	      {{#if info}}
	      <div>&nbsp;&nbsp;-&nbsp;&nbsp;{{info}}</div>
	      {{/if}}
	    </li>
            {{/each}}
	  </ul>
	  {{/if}}
	</div>
      </div>
    </div>
  </div>
</script>

