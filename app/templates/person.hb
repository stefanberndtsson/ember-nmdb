<script type="text/x-handlebars" data-template-name="Nmdb-person">
  <div class="container">
    <div class="row container">
      <div class="col-md-3 hidden-sm hidden-xs">
	{{outlet menu}}
      </div>
      <div class="col-md-9 col-xs-12">
	<div class="row">
	  <div class="well well-sm">
	    {{#if cover.visible}}
	    <div class="pull-right visible-xs visible-sm">
	      <img {{bind-attr src=cover.url}} id="cover-image-sm"/>
	    </div>
	    {{/if}}
	    <h3>{{model.person.first_name}}&nbsp;{{model.person.last_name}}</h3>
	    <dl>
	      {{displayInfo 'DB' model.info}}
	      {{displayInfo 'AG' model.info}}
	      {{displayInfo 'DD' model.info}}
	      {{displayInfo 'RN' model.info}}
	    </dl>
	    <div class="row"></div>
	  </div>
	</div>
	<div class="hidden-md hidden-lg visible-sm visible-xs menu-dropdown">
	  {{outlet menu-dropdown}}
	</div>
	{{outlet}}
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page">
  {{view Nmdb.PersonPageDataView}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/person-role-link">
  {{#if role.disabled}}
  <a class="text-center" href="javascript:void(0);">{{role.display}}</a>
  {{else}}
  {{#link-to 'person-page' person.id 'as_role' role=role.name classNames='text-center'}}{{role.display}}{{/link-to}}
  {{/if}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-as_role">
  <div class="row">
    <ul class="nav nav-tabs">
      {{#each role in tabbedRoles}}
      {{person-role-link role=role person=model.person currentRole=controller.activeRole}}
      {{/each}}
      <li class="dropdown">
	<a {{bind-attr class=":dropdown-toggle activeRoleIsDropdown:dropdown-active"}} data-toggle="dropdown" href="#">
	  More <span class="caret"></span>
	</a>
	<ul class="dropdown-menu">
	  {{#each role in dropdownRoles}}
	  {{person-role-link role=role person=model.person currentRole=controller.activeRole}}
	  {{/each}}
	</ul>
      </li>
    </ul>
  </div>
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
	<h4 class="panel-title">Movies</h4>
      </div>
      {{#ifBS md lg}}
      <div class="panel-body">
        <table class="table table-condensed">
          <thead>
            <tr>
	      <th width="1%"></th>
	      <th width="60%">Cast</th>
	      <th width="39%">Character</th>
            </tr>
          </thead>
          <tbody>
            {{#each entry in pageData}}
            <tr>
	      <th>{{index}}</th>
	      <td>
                {{#link-to 'movie' entry.id}}{{displayTitle entry.movie}}{{/link-to}}
                {{episodeCount entry}}{{episode-hidden-show-link}}
	      </td>
	      <td>{{entry.character}} {{entry.extras}}</td>
            </tr>
            {{#each episode in entry.episodes}}
            <tr class="{{#ifIndexGt 5}}{{episode-hidden-class}}{{/ifIndexGt}}">
	      <th></th>
	      <td>
                {{#link-to 'movie' episode.id}} - {{displayEpisode episode}}{{/link-to}}
	      </td>
	      <td>{{episode.character}} {{episode.extras}}</td>
            </tr>
            {{/each}}
            {{/each}}
          </tbody>
        </table>
      </div>
      {{else}}
      <div class="panel-body no-padding">
	<div class="list-group no-margin">
	  {{#each entry in pageData}}
	  {{#link-to 'movie' entry.id classNames="list-group-item list-group-link-item"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	  <h4 class="list-group-item-heading truncate-text">
	    {{displayTitle entry.movie}}
            {{episodeCount entry}}
	  </h4>
	  <div class="list-group-item-text indent-left truncate-text">
	    {{entry.character}} {{entry.extras}}
	  </div>
	  {{/link-to}}
	  {{#if entry.episodes}}
	  <div class="list-group no-margin">
	  {{#each episode in entry.episodes}}
	  {{#link-to 'movie' episode.id classNames="list-group-item list-group-link-item pad-left"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	  <div class="list-group-item-heading truncate-text"> - {{displayEpisode episode}}</div>
	  <span class="list-group-item-text indent-left truncate-text">{{episode.character}} {{episode.extras}}</span>
	  {{/link-to}}
	  {{/each}}
	  </div>
	  {{/if}}
	  {{/each}}
	</div>
      </div>
      {{/ifBS}}
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-biography">
  {{#each group in pageData}}
  <h3>{{group.display}}</h3>
  {{#if group.value}}
  {{group.value}}
  {{else}}
  <ul>
    {{#each entry in group.values}}
    <li>{{decodeLinks entry.value entry.links}}</li>
    {{/each}}
  </ul>
  {{/if}}
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-trivia">
  {{#each group in pageData}}
  <h3>{{group.display}}</h3>
  {{#if group.value}}
  {{group.value}}
  {{else}}
  <ul>
    {{#each entry in group.values}}
    <li>{{decodeLinks entry.value entry.links}}</li>
    {{/each}}
  </ul>
  {{/if}}
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-quotes">
  {{#each group in pageData}}
  <h3>{{group.display}}</h3>
  {{#if group.value}}
  {{group.value}}
  {{else}}
  <ul>
    {{#each entry in group.values}}
    <li>{{decodeLinks entry.value entry.links}}</li>
    {{/each}}
  </ul>
  {{/if}}
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-other_works">
  {{#each group in pageData}}
  <h3>{{group.display}}</h3>
  {{#if group.value}}
  {{group.value}}
  {{else}}
  <ul>
    {{#each entry in group.values}}
    <li>{{decodeLinks entry.value entry.links}}</li>
    {{/each}}
  </ul>
  {{/if}}
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-publicity">
  {{#each group in pageData}}
  <h3>{{group.display}}</h3>
  {{#if group.value}}
  {{group.value}}
  {{else}}
  <ul>
    {{#each entry in group.values}}
    <li>{{decodeLinks entry.value entry.links}}</li>
    {{/each}}
  </ul>
  {{/if}}
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-links">
  {{#each linkSections}}
  <h4>{{name}}</h4>
  <ul>
    {{#each links}}
    <li><a target="_blank" href="{{unbound linkHref}}">{{linkText}}</a></li>
    {{/each}}
  </ul>
  {{/each}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-top_movies">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
	<h4 class="panel-title">Top Movies</h4>
      </div>
      {{#ifBS md lg}}
      <div class="panel-body">
        <table class="table table-condensed">
          <thead>
            <tr>
	      <th width="1%"></th>
	      <th width="60%">Cast</th>
	      <th width="39%">Character</th>
            </tr>
          </thead>
          <tbody>
            {{#each entry in pageData}}
            <tr>
	      <th>{{index}}</th>
	      <td>
                {{#link-to 'movie' entry.id}}{{displayTitle entry.movie}}{{/link-to}}
	      </td>
	      <td>{{entry.character}} {{entry.extras}}</td>
            </tr>
            {{/each}}
          </tbody>
        </table>
      </div>
      {{else}}
      <div class="panel-body no-padding">
	<div class="list-group no-margin">
	  {{#each entry in pageData}}
	  {{#link-to 'movie' entry.id classNames="list-group-item list-group-link-item"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	  <h4 class="list-group-item-heading truncate-text">
	    {{displayTitle entry.movie}}
            {{episodeCount entry}}
	  </h4>
	  <div class="list-group-item-text indent-left truncate-text">
	    {{entry.character}} {{entry.extras}}
	  </div>
	  {{/link-to}}
	  {{/each}}
	</div>
      </div>
      {{/ifBS}}
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page-images">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Images</h4>
      </div>
      <div class="panel-body">
	<div class="row" style="overflow: hidden">
	{{#if model.pageData.tmdb.profiles}}
	<h4 class="panel-heading">Profiles</h4>
        {{#each model.pageData.tmdb.profiles}}
        <span class="col-xs-6 col-sm-4 col-md-3 col-lg-3 panel">
	  <span class="profile-image">
	  <a target="_blank" href="{{unbound image_url}}" style="width: 100%;">
	    <img {{bind-attr src=image_url_medium}} />
	  </a>
	  </span>
	</span>
	{{#ifIndexMod 4}}<div class="clearfix visible-md visible-lg"></div>{{/ifIndexMod}}
	{{#ifIndexMod 3}}<div class="clearfix visible-sm"></div>{{/ifIndexMod}}
	{{#ifIndexMod 2}}<div class="clearfix visible-xs"></div>{{/ifIndexMod}}
        {{/each}}
	{{/if}}
	</div>
      </div>
    </div>
  </div>
</script>

