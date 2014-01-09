<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-additionals">
  <div class="row">
    <div class="panel panel-default">
      {{#ifBS md lg}}
      <div class="panel-heading">
        <h4 class="panel-title">
	  Additional Information
	</h4>
      </div>
      <div class="panel-body">
	{{#if model.pageData.akas}}
	<h4 class="panel-heading">Alternate titles</h4>
	<ul class="list-group no-margin">
          {{#each model.pageData.akas}}
	  <li class="list-group-item">
	    <span>{{title}}</span>
	    {{#if info}}
	    <div>&nbsp;&nbsp;-&nbsp;&nbsp;{{info}}</div>
	    {{/if}}
	  </li>
          {{/each}}
	</ul>
	{{/if}}
      </div>
      {{else}}
      <div class="panel-body no-padding">
	{{#if model.pageData.akas}}
	<h4 class="panel-heading">Alternate titles</h4>
	<ul class="list-group no-margin">
          {{#each model.pageData.akas}}
	  <li class="list-group-item">
	    <span>{{title}}</span>
	    {{#if info}}
	    <div>&nbsp;&nbsp;-&nbsp;&nbsp;{{info}}</div>
	    {{/if}}
	  </li>
          {{/each}}
	</ul>
	{{/if}}
      </div>
      {{/ifBS}}
    </div>
  </div>
</script>

