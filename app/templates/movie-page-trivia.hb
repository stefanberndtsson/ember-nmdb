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

