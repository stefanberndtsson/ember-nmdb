<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-goofs">
  <div class="row">
    <div class="panel panel-default">
      {{#ifBS lg md}}
      <div class="panel-heading">
        <h4 class="panel-title">Goofs</h4>
      </div>
      {{/ifBS}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	{{#if hasSpoilers}}
	<div class="panel-heading"><button class="btn btn-default" {{action toggleSpoilers}}>Toggle spoilers</button></div>
	{{/if}}
	<ul class="list-group no-margin">
	  {{#each model.pageData}}
	  <h4 class="panel-heading">{{category_display}}</h4>
	  {{#each goofs}}
          <li class="list-group-item">
	    {{#if spoiler}}
	    <span class="bold">[SPOILER]</span> <span class="spoiler">{{decodeLinks goof links}}</span>
	    {{else}}
	    {{decodeLinks goof links}}
	    {{/if}}
	  </li>
	  {{/each}}
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

