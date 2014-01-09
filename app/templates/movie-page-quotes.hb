<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-quotes">
  <div class="row">
    <div class="panel panel-default">
      {{#ifBS md lg}}
      <div class="panel-heading">
        <h4 class="panel-title">Quotes</h4>
      </div>
      {{/ifBS}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	<ul class="list-group no-margin">
	  {{#each model.pageData}}
          <li class="list-group-item">
	    {{#each quote}}
	    {{#if quoter}}
	    <span class="bold">
	      {{#if quoter.person}}
	      {{#link-to 'person' quoter.person.id title=quoter.person.full_name}}
	      {{quoter.character}}:
	      {{/link-to}}
	      {{else}}
	      {{quoter.character}}:
	      {{/if}}
	    </span> {{decodeLinks content links}}
	    {{else}}
	    {{decodeLinks content links}}
	    {{/if}}
	    <br/>
	    {{/each}}
	  </li>
	  {{/each}}
	</ul>
      </div>
    </div>
  </div>
</script>

