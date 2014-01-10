<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-cast">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
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
      {{else}}
      <div class="panel-body no-padding">
	<div class="list-group no-margin">
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
      </div>
      {{/unless}}
    </div>
  </div>
</script>

