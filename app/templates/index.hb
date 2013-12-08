<script type="text/x-handlebars" data-template-name="Nmdb-search">
  <form class="form-horizontal" role="form">
    <div class="form-group">
      <div class="col-xs-8 col-xs-offset-1">
	{{input type="text" value=queryString action="search" classNames="form-control"}}
      </div>
      <button type="submit" {{action "search" queryString}} class="btn btn-default col-xs-2">Search</button>
    </div>
  </form>
  {{partial "search/results"}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-search/_results">
  <div class="row container col-sm-12">
    {{#if queried}}
    {{trigger "buttonsVisibleTrigger"}}
    <div class="btn-toolbar visible-xs visible-sm">
      <div class="btn-group col-xs-12 col-sm-12">
	<button class="btn btn-default col-xs-6 col-sm-6 action-button-movies">Movies</button>
	<button class="btn btn-default col-xs-6 col-sm-6 action-button-people">People</button>
      </div>
    </div>
    {{/if}}
  </div>
  <div class="row container col-sm-12 col-md-12 col-lg-12">
    <div class="col-md-6 action-list-movies">
      <ul class="list-group">
	{{#if movies}}
	<h2 class="list-group-item-heading">Movies</h2>
	{{/if}}
	{{#each movies}}
	<li class="list-group-item">{{#link-to 'movie' id}}{{full_title}}{{/link-to}}</li>
	{{/each}}
      </ul>
    </div>
    <div class="col-md-6 action-list-people">
      <ul class="list-group">
	{{#if people}}
	<h2 class="list-group-item-heading">People</h2>
	{{/if}}
	{{#each people}}
	<li class="list-group-item">
	  {{#link-to 'person' id}}
	  {{first_name}} {{last_name}} {{#if name_count}}({{name_count}}){{/if}}
	  {{/link-to}}
	</li>
	{{/each}}
      </ul>
    </div>
  </div>
</script>