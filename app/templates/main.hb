<script type="text/x-handlebars" data-template-name="Nmdb-application">
  <nav class="navbar navbar-default">
    <div class="navbar-header">
      {{#link-to 'index' queryParams=false classNames="navbar-brand"}}{{appName}}{{/link-to}}
      <ul class="nav navbar-nav">
	<li class="visible-xs"><a href="#">XS</a></li>
	<li class="visible-sm"><a href="#">SM</a></li>
	<li class="visible-md"><a href="#">MD</a></li>
	<li class="visible-lg"><a href="#">LG</a></li>
      </ul>
    </div>
  </nav>
  {{outlet}}
  <div id="bs-xs-mark" class="visible-xs"></div>
  <div id="bs-sm-mark" class="visible-sm"></div>
  <div id="bs-md-mark" class="visible-md"></div>
  <div id="bs-lg-mark" class="visible-lg"></div>
</script>
