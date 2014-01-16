<script type="text/x-handlebars" data-template-name="Nmdb-person/_person-infobox">
	<div class="row">
	  <div class="panel panel-default">
	    <div class="panel-heading">
	      <h3 class="panel-title">{{model.person.first_name}}&nbsp;{{model.person.last_name}}</h3>
	    </div>
	    <div class="panel-body">
	      <div class="col-xs-12 col-md-9 no-padding">
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
	      </div>
	      {{#if cover.visible}}
	      <div class="pull-right visible-md visible-lg col-md-3 no-padding">
		<img {{bind-attr src=cover.url}} id="cover-image"/>
	      </div>
	      {{/if}}
	    </div>
	  </div>
	</div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-person">
  <div class="container">
    <div class="row container">
      <div class="col-md-3 hidden-sm hidden-xs">
	{{outlet menu}}
      </div>
      <div class="col-md-9 col-xs-12">
	{{partial "person/person-infobox"}}
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

