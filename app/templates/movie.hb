<script type="text/x-handlebars" data-template-name="Nmdb-movie">
  <div class="container">
    <div class="row">
      <div class="col-xs-3">
	{{outlet menu}}
      </div>
      <div class="col-xs-9">
	<div class="row">
	  <div class="well well-sm">
            <h3>{{model.movie.full_title}}</h3>
            <div class="row container col-xs-12 col-sm-12 col-md-12 col-lg-12">
              {{#each model.genres}}
              <span class="label label-default">{{genre}}</span>
              {{/each}}
            </div>
	  </div>
	</div>
	<div class="row">
	  <div class="navbar navbar-custom">
	    <ul class="nav navbar-nav col-xs-12">
	  {{#if model.movie.is_episode}}
	  <li class="col-xs-4">
	  {{#if model.movie.prev_episode}}
	  {{#link-to 'movie' model.movie.prev_episode.id class="btn pull-left"}}
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
	  {{#link-to 'movie' model.movie.next_episode.id class="btn pull-right"}}
	  {{displayEpisodeShort model.movie.next_episode}}
	  <span class="glyphicon glyphicon-chevron-right"/>
	  {{/link-to}}
	  {{/if}}
	  </li>
	  {{/if}}
	    </ul>
	  </div>
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
        <li class="list-group-item">
	  {{#if spoiler}}
	  <span class="bold">[SPOILER]</span> <span class="spoiler">{{decodeLinks goof links}}</span>
	  {{else}}
	  {{decodeLinks goof links}}
	  {{/if}}
	</li>
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
        {{#each model.pageData.seasons}}
	<h4 class="panel-heading">Season {{season}}</h4>
	<ul class="list-group">
        {{#each episodes}}
	<li class="list-group-item">
	  <h4 class="bold">
	    {{episode.episode_season}}:{{episode.episode_episode}}
	    {{#link-to 'movie' episode.id}}{{episode.episode_name}}{{/link-to}}
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
	{{/each}}
	</div>
      </div>
    </div>
  </div>
</script>

