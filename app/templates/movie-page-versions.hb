<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-versions">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Alternate Versions</h4>
      </div>
      {{/unless}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	{{#if hasSpoilers}}
	<div class="panel-heading"><button class="btn btn-default" {{action toggleSpoilers}}>Toggle spoilers</button></div>
	{{/if}}
	<ul class="list-group no-margin">
	  {{#each model.pageData}}
          <li class="list-group-item">
	    {{#if spoiler}}
	    <span class="bold">[SPOILER]</span> <span class="spoiler">{{decodeLinks version links}}</span>
	    {{else}}
	    {{decodeLinks version links}}
	    {{/if}}
	    {{#if versions}}
	    <ul>
	    {{#each versions}}
	    <li>
	    {{#if spoiler}}
	    <span class="bold">[SPOILER]</span> <span class="spoiler">{{decodeLinks version links}}</span>
	    {{else}}
	    {{decodeLinks version links}}
	    {{/if}}
	    </li>
	    {{/each}}
	    </ul>
	    {{/if}}
	  </li>
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

