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
      {{#unless isMobile}}
      <div class="panel-heading">
	<h4 class="panel-title">Movies</h4>
      </div>
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
      {{/unless}}
    </div>
  </div>
</script>

