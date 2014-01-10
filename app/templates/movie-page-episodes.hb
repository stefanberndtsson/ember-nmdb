<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-episodes">
  <div class="row">
    <div class="panel panel-default">

      {{#unless isMobile}}

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

      {{else}}

      <div class="panel-body no-padding">
        {{#each model.pageData.seasons}}
	<h4 class="panel-heading">Season {{season}}</h4>
	<div class="list-group no-margin">
          {{#each episodes}}
	  {{#link-to 'movie' episode.id classNames="list-group-item list-group-link-item"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	  <h4 class="list-group-item-heading truncate-text">
	    {{episode.episode_episode}}.
	    {{episode_name}}
	  </h4>
	  {{#if release_date.release_date}}
	  <div class="list-group-item-text indent-left truncate-text">{{release_date.release_date}}</div>
	  {{/if}}
	  {{/link-to}}
          {{/each}}
	</div>
	{{/each}}
      </div>

      {{/unless}}

    </div>
  </div>
</script>
