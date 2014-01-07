<script type="text/x-handlebars" data-template-name="Nmdb-index">
  <div class="container hidden">
    <form class="form-horizontal" role="form">
      <div class="form-group">
	<div class="col-xs-7 col-sm-8 col-xs-offset-1">
          {{input type="text" value=queryString action="search" classNames="form-control"}}
	</div>
	<button type="submit" {{action "search" queryString}} class="btn btn-default col-xs-3 col-sm-2">Search</button>
      </div>
    </form>
  </div>
  {{outlet}}
</script>
