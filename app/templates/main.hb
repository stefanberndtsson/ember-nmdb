<script type="text/x-handlebars" data-template-name="Nmdb-application">
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
          {{input type="text" value=queryString action="search" classNames="form-control"}}
	</div>
	<button type="submit" {{action "search" queryString}} class="btn btn-default">Search</button>
      </form>
    </div>
    <div class="container visible-xs">
      <div class="navbar-header pull-left">
	{{#link-to 'index' classNames="navbar-brand"}}{{appName}}{{/link-to}}
      </div>
      <form class="navbar-form navbar-xs-form" role="search">
	<div class="form-group col-xs-7">
          {{input type="text" value=queryString action="search" classNames="form-control"}}
	</div>
	<button type="submit" {{action "search" queryString}} class="col-xs-3 btn btn-default">Search</button>
      </form>
    </div>
  </nav>
  <div class="spinner-loader spinner-loader-off">
  {{outlet}}
  </div>
  <div class="container" style="height: 150px;"></div>
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
