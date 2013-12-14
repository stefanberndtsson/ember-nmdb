<script type="text/x-handlebars" data-template-name="Nmdb-application">
  <nav class="navbar navbar-default">
    <div class="container">
      <div class="navbar-header">
	{{#link-to 'index' classNames="navbar-brand"}}{{appName}}{{/link-to}}
	<ul class="nav navbar-nav">
	  {{bootstrap-indicator type='xs'}}
	  {{bootstrap-indicator type='sm'}}
	  {{bootstrap-indicator type='md'}}
	  {{bootstrap-indicator type='lg'}}
	</ul>
      </div>
    </div>
  </nav>
  {{outlet}}
  <div class="container" style="height: 150px;"></div>
</script>
