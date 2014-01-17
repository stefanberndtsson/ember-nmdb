<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-technicals">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">
	  Technical Details
	</h4>
      </div>
      {{/unless}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	{{#each section in model.pageData}}
	<h4 class="panel-heading">{{section.category}}</h4>
	<ul class="list-group no-margin">
          {{#each section.values}}
	  <li class="list-group-item">
	    <span>{{value}}{{#if info}} {{info}}{{/if}}</span>
	  </li>
          {{/each}}
	</ul>
	{{/each}}
      </div>
    </div>
  </div>
</script>

