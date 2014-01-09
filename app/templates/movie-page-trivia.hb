<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-trivia">
  <div class="row">
    <div class="panel panel-default">
      {{#ifBS md lg}}
      <div class="panel-heading">
        <h4 class="panel-title">Trivia</h4>
      </div>
      {{/ifBS}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	{{#if hasSpoilers}}
	<div class="panel-heading"><button class="btn btn-default" {{action toggleSpoilers}}>Toggle spoilers</button></div>
	{{/if}}
	<ul class="list-group no-margin">
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

