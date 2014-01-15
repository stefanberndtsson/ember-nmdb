<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-connections">
  <div class="row">
    <div {{bind-attr class="isMobile::panel isMobile::panel-default"}}>
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">
	  Movie Connections
	  {{#if showSpinner}}
	  <img class="spinner-img" src="{{unbound appRoot}}/img/spinner.gif"/>
	  {{/if}}
	</h4>
      </div>
      {{/unless}}
      {{#each section in model.pageData}}
      <div {{bind-attr class="isMobile:panel isMobile:panel-default isMobile:margin-bottom-large"}}>
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	<h4 class="panel-heading">{{section.type}}</h4>
	<div class="list-group no-margin">
          {{#each entry in section.connections}}
	  {{#link-to 'movie' entry.linked_movie.id classNames="list-group-item list-group-link-item-flexible"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	  <h4>
	    {{#if isMobile}}
	    {{displayTitle entry.linked_movie}}
	    {{else}}
	    {{displayTitle entry.linked_movie "oneline"}}
	    {{/if}}
	  </h4>
	    {{#if entry.text}}
	    <div class="shift-up">&nbsp;&nbsp;-&nbsp;&nbsp;{{entry.text}}</div>
	    {{/if}}
	  {{/link-to}}
          {{/each}}
	</div>
      </div>
      </div>
      {{/each}}
    </div>
  </div>
</script>

