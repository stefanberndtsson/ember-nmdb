<script type="text/x-handlebars" data-template-name="Nmdb-application">
  {{#unless isMobile}}
  <nav class="navbar navbar-default">
    <div class="container hidden-xs">
      <div class="navbar-header">
	{{#link-to 'index' classNames="navbar-brand"}}{{appName}}{{/link-to}}
	<ul class="nav navbar-nav">
	  {{bootstrap-indicator type='sm'}}
	  {{bootstrap-indicator type='md'}}
	  {{bootstrap-indicator type='lg'}}
	</ul>
      </div>
      <form class="navbar-form" role="search">
	<div class="form-group col-sm-7">
          {{search-field type="text" value=queryString action="search" toMovie="toMovie" classNames="form-control search-field"}}
	</div>
	<button type="submit" {{action "search" queryString}} class="btn btn-default">Search</button>
      </form>
    </div>
  </nav>
  {{else}}
  <nav class="navbar navbar-compact navbar-default navbar-fixed-top">
    <button class="navbar-text btn btn-xs btn-default" {{action goSearch}}>Search</button>
    <h5 class="navbar-text fixed-center">{{pageTitle}}</h5>
    <button class="navbar-text navbar-right btn btn-xs btn-default" {{action goTop}}>Top</button>
  </nav>
  <div class="navbar-compact-fixed-offset"></div>
  {{/unless}}
  <div class="spinner-loader spinner-loader-off">
    {{outlet}}
  </div>
  <div class="container" style="height: 250px;"></div>
  <div class="spinner spinner-off">
    <div class="spinner-inner">
      Loading...
    </div>
  </div>
  <span id="bs-indicator-xs" class="visible-xs">&nbsp;</span>
  <span id="bs-indicator-sm" class="visible-sm">&nbsp;</span>
  <span id="bs-indicator-md" class="visible-md">&nbsp;</span>
  <span id="bs-indicator-lg" class="visible-lg">&nbsp;</span>
</script>
