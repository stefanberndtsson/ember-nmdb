<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-additionals">
  <div class="row">
    <div class="panel panel-default">
      {{#unless isMobile}}
      <div class="panel-heading">
        <h4 class="panel-title">
	  Additional Information
	</h4>
      </div>
      {{/unless}}
      <div {{bind-attr class=":panel-body isMobile:no-padding"}}>
	{{#if model.pageData.original_title}}
	<h4 class="panel-heading">Original title</h4>
	<ul class="list-group no-margin">
	  <li class="list-group-item">
	    <span>{{model.pageData.original_title}}</span>
	  </li>
	</ul>
	{{/if}}
	{{#if model.pageData.akas}}
	<h4 class="panel-heading">Alternate titles</h4>
	<ul class="list-group no-margin">
          {{#each model.pageData.akas}}
	  <li class="list-group-item">
	    <span>{{title}}{{#if info}} {{info}}{{/if}}</span>
	  </li>
          {{/each}}
	</ul>
	{{/if}}
	{{#if model.pageData.producers}}
	<h4 class="panel-heading">Producers</h4>
	<div class="list-group no-margin">
          {{#each model.pageData.producers}}
	  {{#link-to 'person' id classNames="list-group-item list-group-link-item-flexible"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow-low"/>
	  {{name}}{{#if extras}} {{extras}}{{/if}}
	  {{/link-to}}
          {{/each}}
	</div>
	{{/if}}
	{{#if model.pageData.directors}}
	<h4 class="panel-heading">Directors</h4>
	<div class="list-group no-margin">
          {{#each model.pageData.directors}}
	  {{#link-to 'person' id classNames="list-group-item list-group-link-item-flexible"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow-low"/>
	  {{name}}{{#if extras}} {{extras}}{{/if}}
	  {{/link-to}}
          {{/each}}
	</div>
	{{/if}}
	{{#if model.pageData.writers}}
	<h4 class="panel-heading">Writers</h4>
	<div class="list-group no-margin">
          {{#each model.pageData.writers}}
	  {{#link-to 'person' id classNames="list-group-item list-group-link-item-flexible"}}
	  <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow-low"/>
	  {{name}}{{#if extras}} {{extras}}{{/if}}
	  {{/link-to}}
          {{/each}}
	</div>
	{{/if}}
	{{#if model.pageData.color_infos}}
	<h4 class="panel-heading">Color Information</h4>
	<ul class="list-group no-margin">
          {{#each model.pageData.color_infos}}
	  <li class="list-group-item">
	    <span>{{color}}{{#if info}} {{info}}{{/if}}</span>
	  </li>
          {{/each}}
	</ul>
	{{/if}}
	{{#if model.pageData.certificates}}
	<h4 class="panel-heading">Certificates</h4>
	<ul class="list-group no-margin">
          {{#each model.pageData.certificates}}
	  <li class="list-group-item">
	    <span class="col-xs-4 col-sm-3 col-md-2 no-padding">{{country}}</span>
	    <span class="col-xs-8 col-sm-9 col-md-10 no-padding">
	      {{certificate}}&nbsp;&nbsp;&nbsp; {{#if info}} {{info}}{{/if}}
	    </span>
	    <span class="clearfix">
	  </li>
          {{/each}}
	</ul>
	{{/if}}
      </div>
    </div>
  </div>
</script>

