<div>
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
  </script>

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

  <script type="text/x-handlebars" data-template-name="Nmdb-movie">
    <div class="col-xs-12">
      <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<div class="jumbotron">
	  <h1 class="page-header">{{movie.full_title}}</h1>
	  <div class="row container col-xs-12 col-sm-12 col-md-12 col-lg-12">
	    {{#each genres}}
	    <span class="label label-default">{{genre}}</span>
	    {{/each}}
	  </div>
	  <div class="hidden row container col-xs-12 col-sm-12 col-md-12 col-lg-12">
	    {{#each keywords}}
	    <span class="label label-default">{{id}} {{keyword}}</span>
	    {{/each}}
	  </div>
	</div>
      </div>
      <div class="container row col-xs-12 col-sm-12">
	<table class="table">
	  <thead>
            <tr>
              <th></th>
              <th>Cast</th>
              <th>Character</th>
            </tr>
	  </thead>
	  <tbody>
            {{#each cast_members}}
            <tr>
              <th>{{sort_value}}</th>
              <td>{{#link-to 'person' id}}{{name}}{{/link-to}}</td>
              <td>
		{{character}} {{extras}}
		{{#if episode_count}}({{episode_count}} episodes){{/if}}
	      </td>
            </tr>
            {{/each}}
	  </tbody>

	</table>
      </div>
    </div>
  </script>

  <script type="text/x-handlebars" data-template-name="Nmdb-person">
    <div class="col-xs-12">
      <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<div class="jumbotron">
	  <h1 class="page-header">{{person.first_name}}&nbsp;{{person.last_name}}</h1>
	</div>
      </div>
      <div class="container row col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<ul class="nav nav-pills">
	  {{#each role in roles}}
	  <li {{bindAttr class="role.roleClass"}}>
	    {{#link-to 'person' person.id role=role.name}}{{role.display}}{{/link-to}}
	  </li>
	  {{/each}}
	</ul>
      </div>
      <div class="container row col-xs-12 col-sm-12">
	<table class="table">
	  <thead>
            <tr>
              <th></th>
              <th>Cast</th>
              <th>Character</th>
            </tr>
	  </thead>
	  <tbody>
            {{#each roleData}}
            <tr>
              <th>{{index}}</th>
              <td>{{#link-to 'movie' id}}{{movie}}{{/link-to}}</td>
              <td>{{character}} {{extras}}</td>
            </tr>
            {{/each}}
	  </tbody>
	</table>
      </div>
    </div>
  </script>
</div>
