<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-connections">
  <div class="row">
    <div class="panel panel-default">
      {{#ifBS lg md}}
      <div class="panel-heading">
        <h4 class="panel-title">
	  Movie Connections
	  {{#if showSpinner}}
	  <img class="spinner-img" src="{{unbound appRoot}}/img/spinner.gif"/>
	  {{/if}}
	</h4>
      </div>
      {{/ifBS}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
        {{#each model.pageData}}
	<h4 class="panel-heading">{{type}}</h4>
	<ul class="list-group no-margin">
          {{#each connections}}
	  <li class="list-group-item">
	    {{#link-to 'movie' linked_movie.id}}{{displayTitle linked_movie}}{{/link-to}}
	    {{#if text}}
	    <div>&nbsp;&nbsp;-&nbsp;&nbsp;{{text}}</div>
	    {{/if}}
	  </li>
          {{/each}}
	</ul>
	{{/each}}
      </div>
    </div>
  </div>
</script>

