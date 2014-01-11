<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-similar">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Similar Movies</h4>
      </div>
      <div class="panel-body">
        <table class="table table-condensed">
          <thead>
            <tr>
              <th width="4%">Match</th>
              <th width="92%">Movie</th>
              <th width="4%" align="center">Rating</th>
            </tr>
          </thead>
          <tbody>
            {{#each model.pageData}}
            <tr>
              <th align="right" class="text-right">{{similarity}}</th>
              <td>{{#link-to 'movie' movie.id}}{{displayTitle movie}}{{/link-to}}</td>
              <td align="center">{{movie.rating.rating}}</td>
            </tr>
            {{/each}}
          </tbody>
        </table>
      </div>
      {{else}}
      <div class="panel-body no-padding">
	<div class="list-group no-margin">
	  {{#each model.pageData}}
	  {{#link-to 'movie' movie.id classNames="list-group-item list-group-link-item"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	  <h4 class="list-group-item-heading truncate-text">{{displayTitle movie}}</h4>
	  <div class="list-group-item-text indent-left truncate-text">
	    {{similarity}} (Rating: {{movie.rating.rating}})
	  </div>
	  {{/link-to}}
	  {{/each}}
	</div>
      </div>
      {{/unless}}
    </div>
  </div>
</script>

