<script type="text/x-handlebars" data-template-name="Nmdb-person-page-top_movies">
  <div class="row">
    <div class="panel panel-default">
      {{#ifBS md lg}}
      <div class="panel-heading">
	<h4 class="panel-title">Top Movies</h4>
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

