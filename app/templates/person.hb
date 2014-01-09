<script type="text/x-handlebars" data-template-name="Nmdb-person">
  <div class="container">
    <div class="row container">
      <div class="col-md-3 hidden-sm hidden-xs">
	{{outlet menu}}
      </div>
      <div class="col-md-9 col-xs-12">
	{{#ifBS md lg}}
	<div class="row">
	  <div class="well well-sm">
	    {{#if cover.visible}}
	    <div class="pull-right visible-xs visible-sm">
	      <img {{bind-attr src=cover.url}} id="cover-image-sm"/>
	    </div>
	    {{/if}}
	    <h3>{{model.person.first_name}}&nbsp;{{model.person.last_name}}</h3>
	    <dl>
	      {{displayInfo 'DB' model.info}}
	      {{displayInfo 'AG' model.info}}
	      {{displayInfo 'DD' model.info}}
	      {{displayInfo 'RN' model.info}}
	    </dl>
	    <div class="row"></div>
	  </div>
	</div>
	{{else}}
	<div class="row">
	  <div class="panel panel-default">
	    <div class="panel-heading">
	      <h3 class="panel-title">{{model.person.first_name}}&nbsp;{{model.person.last_name}}</h3>
	    </div>
	    <div class="panel-body">
	      {{#if cover.visible}}
	      <div class="pull-right visible-xs visible-sm">
		<img {{bind-attr src=cover.url}} id="cover-image-sm"/>
	      </div>
	      {{/if}}
	      <dl class="no-margin">
		{{displayInfo 'DB' model.info}}
		{{displayInfo 'AG' model.info}}
		{{displayInfo 'DD' model.info}}
		{{displayInfo 'RN' model.info}}
	      </dl>
	      <div class="row"></div>
	    </div>
	  </div>
	</div>
	{{/ifBS}}
	<div class="hidden-md hidden-lg visible-sm visible-xs menu-dropdown">
	  {{outlet menu-dropdown}}
	</div>
	{{outlet}}
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person-page">
  {{view Nmdb.PersonPageDataView}}
</script>

