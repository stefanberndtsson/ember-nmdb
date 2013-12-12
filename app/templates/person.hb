<script type="text/x-handlebars" data-template-name="Nmdb-rolelink">
  {{#if role.disabled}}
  <a href="javascript:void(0);">{{role.display}}</a>
  {{else}}
  {{#link-to 'person' person.id role=role.name}}{{role.display}}{{/link-to}}
  {{/if}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person/_rolelinks">
  <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <ul class="nav nav-pills">
      {{#each role in roles}}
      {{view Nmdb.RoleLink}}
      {{/each}}
    </ul>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person/_summary">
  <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div class="well well-sm">
      <h3 class="page-header">{{person.first_name}}&nbsp;{{person.last_name}}</h3>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person">
  <div class="col-xs-12">
    {{partial "person/summary"}}
    {{partial "person/rolelinks"}}
    <div class="container row">&nbsp;</div>
    <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
	<div class="panel-heading">
	  <h4 class="panel-title">Movies</h4>
	</div>
	<div class="panel-body">
	  <div class="container row col-xs-12 col-sm-12">
	    <table class="table table-condensed">
	      <thead>
		<tr>
		  <th width="1%"></th>
		  <th width="60%">Cast</th>
		  <th width="39%">Character</th>
		</tr>
	      </thead>
	      <tbody>
		{{#each entry in roleData}}
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
	</div>
      </div>
    </div>
  </div>
</script>
