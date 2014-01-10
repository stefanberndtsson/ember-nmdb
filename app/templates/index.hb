<script type="text/x-handlebars" data-template-name="Nmdb-index">
  {{#if isIndex}}
  {{#if isMobile}}
  <div class="container">
    <form class="form-horizontal" role="form">
      <div class="form-group">
	<div class="col-xs-12">
	  <div class="col-xs-12 col-md-8 col-md-offset-1">
            {{input type="text" value=controllers.application.queryString action="search" classNames="form-control"}}
	  </div>
	</div>
	{{#unless isMobile}}
	<button type="submit" {{action "search" controllers.application.queryString}} class="btn btn-default col-xs-3 col-sm-2">Search</button>
	{{/unless}}
      </div>
    </form>
  </div>
  {{/if}}
  {{/if}}
  {{outlet}}
</script>
