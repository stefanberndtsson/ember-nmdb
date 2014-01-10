<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-links">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">Links</h4>
      </div>
      {{/unless}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	{{#each linkSections}}
	<h4 class="panel-heading">{{name}}</h4>
	<div class="list-group no-margin">
	  {{#each links}}
	  <a target="_blank" class="list-group-item list-group-link-item list-group-link-item-single"
	     href="{{unbound linkHref}}">
	    <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
	    <h5>{{linkText}}</h5>
	  </a>
	  {{/each}}
	</div>
	{{/each}}
      </div>
    </div>
  </div>
</script>

